import 'package:flutter/material.dart';
import 'package:democracy_simulator/models/card.dart' as card_model;
import 'package:democracy_simulator/models/story_chain.dart';
import 'card_editor.dart';

class StoryChainEditor extends StatefulWidget {
  final StoryChain? initialChain;
  final void Function(StoryChain) onSave;

  const StoryChainEditor({
    super.key,
    this.initialChain,
    required this.onSave,
  });

  @override
  State<StoryChainEditor> createState() => _StoryChainEditorState();
}

class _StoryChainEditorState extends State<StoryChainEditor> {
  late TextEditingController _chainIdController;
  late TextEditingController _startCardIdController;
  late Map<String, card_model.Card> _cards;
  String? _selectedCardId;

  @override
  void initState() {
    super.initState();
    if (widget.initialChain != null) {
      _chainIdController =
          TextEditingController(text: widget.initialChain!.id);
      _startCardIdController =
          TextEditingController(text: widget.initialChain!.startCardId);
      _cards = Map.from(widget.initialChain!.cards);
    } else {
      _chainIdController = TextEditingController();
      _startCardIdController = TextEditingController();
      _cards = {};
    }
    _selectedCardId = _cards.isNotEmpty ? _cards.keys.first : null;
  }

  @override
  void dispose() {
    _chainIdController.dispose();
    _startCardIdController.dispose();
    super.dispose();
  }

  void _addCard(card_model.Card card) {
    setState(() {
      _cards[card.id] = card;
      _selectedCardId = card.id;
    });
  }

  void _deleteCard(String cardId) {
    setState(() {
      _cards.remove(cardId);
      if (_selectedCardId == cardId) {
        _selectedCardId = _cards.isNotEmpty ? _cards.keys.first : null;
      }
    });
  }

  void _saveChain() {
    if (_cards.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Story chain must have at least 1 card')),
      );
      return;
    }

    if (!_cards.containsKey(_startCardIdController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Start card ID must exist in cards')),
      );
      return;
    }

    try {
      final chain = StoryChain(
        id: _chainIdController.text,
        startCardId: _startCardIdController.text,
        cards: _cards,
      );
      widget.onSave(chain);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left: Story metadata + card list
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Story Chain Editor',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _chainIdController,
                  decoration: InputDecoration(labelText: 'Chain ID'),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _startCardIdController,
                  decoration: InputDecoration(labelText: 'Start Card ID'),
                ),
                SizedBox(height: 24),
                Text(
                  'Cards (${_cards.length})',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 12),
                Container(
                  constraints: BoxConstraints(maxHeight: 300),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _cards.isEmpty
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('No cards yet'),
                          ),
                        )
                      : ListView(
                          children: _cards.entries.map((entry) {
                            return ListTile(
                              title: Text(entry.value.id),
                              subtitle: Text(entry.value.question),
                              selected:
                                  _selectedCardId == entry.value.id,
                              onTap: () => setState(
                                () => _selectedCardId = entry.value.id,
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteCard(entry.value.id),
                              ),
                            );
                          }).toList(),
                        ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _saveChain,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text('Save Chain'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Right: Card editor for selected card
        if (_selectedCardId != null)
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
              ),
              child: CardEditor(
                initialCard: _cards[_selectedCardId],
                onSave: _addCard,
              ),
            ),
          ),
      ],
    );
  }
}
