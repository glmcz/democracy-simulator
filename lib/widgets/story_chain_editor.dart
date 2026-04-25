import 'package:flutter/material.dart';
import 'package:democracy_simulator/generated_l10n/app_localizations.dart';
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
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void _deleteCard(String cardId) {
    setState(() {
      _cards.remove(cardId);
      if (_selectedCardId == cardId) {
        _selectedCardId = _cards.isNotEmpty ? _cards.keys.first : null;
      }
    });
  }

  void _openCardEditor({card_model.Card? card}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: CardEditor(
          initialCard: card,
          onSave: _addCard,
          onCancel: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _saveChain() {
    final l10n = AppLocalizations.of(context)!;

    if (_cards.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.storyChainMustHaveCard)),
      );
      return;
    }

    if (!_cards.containsKey(_startCardIdController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.startCardMustExist)),
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
        SnackBar(content: Text(l10n.error(e.toString()))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.storyChainEditor,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 16),
          TextField(
            controller: _chainIdController,
            decoration: InputDecoration(
              labelText: l10n.chainId,
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _startCardIdController,
            decoration: InputDecoration(
              labelText: l10n.startCardId,
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.cardsCount(_cards.length),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ElevatedButton.icon(
                onPressed: () => _openCardEditor(),
                icon: Icon(Icons.add),
                label: Text(l10n.addCard),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            constraints: BoxConstraints(
              maxHeight: isMobile ? 300 : 400,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _cards.isEmpty
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(l10n.noCardsYet),
                    ),
                  )
                : ListView(
                    children: _cards.entries.map((entry) {
                      return ListTile(
                        title: Text(entry.value.id),
                        subtitle: Text(
                          entry.value.question,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        selected: _selectedCardId == entry.value.id,
                        onTap: () {
                          setState(() => _selectedCardId = entry.value.id);
                          _openCardEditor(card: entry.value);
                        },
                        trailing: PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              onTap: () => _openCardEditor(card: entry.value),
                              child: Row(
                                children: [
                                  Icon(Icons.edit, size: 20),
                                  SizedBox(width: 8),
                                  Text(l10n.edit),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () => _deleteCard(entry.value.id),
                              child: Row(
                                children: [
                                  Icon(Icons.delete, size: 20, color: Colors.red),
                                  SizedBox(width: 8),
                                  Text(l10n.delete, style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          ),
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveChain,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(l10n.saveChain),
            ),
          ),
        ],
      ),
    );
  }
}
