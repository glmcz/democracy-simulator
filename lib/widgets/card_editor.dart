import 'package:flutter/material.dart';
import 'package:democracy_simulator/models/card.dart' as card_model;

class CardEditor extends StatefulWidget {
  final card_model.Card? initialCard;
  final void Function(card_model.Card) onSave;
  final VoidCallback? onCancel;

  const CardEditor({
    super.key,
    this.initialCard,
    required this.onSave,
    this.onCancel,
  });

  @override
  State<CardEditor> createState() => _CardEditorState();
}

class _CardEditorState extends State<CardEditor> {
  late TextEditingController _idController;
  late TextEditingController _questionController;
  late TextEditingController _imagePathController;
  late List<_ChoiceEditorState> _choices;

  @override
  void initState() {
    super.initState();
    if (widget.initialCard != null) {
      _idController = TextEditingController(text: widget.initialCard!.id);
      _questionController =
          TextEditingController(text: widget.initialCard!.question);
      _imagePathController =
          TextEditingController(text: widget.initialCard!.imagePath);
      _choices = widget.initialCard!.choices
          .map((c) => _ChoiceEditorState(
                text: c.text,
                delta: c.thermometerDelta,
                nextCardId: c.nextCardId,
              ))
          .toList();
    } else {
      _idController = TextEditingController();
      _questionController = TextEditingController();
      _imagePathController = TextEditingController();
      _choices = [
        _ChoiceEditorState(text: '', delta: 0, nextCardId: ''),
        _ChoiceEditorState(text: '', delta: 0, nextCardId: ''),
      ];
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _questionController.dispose();
    _imagePathController.dispose();
    super.dispose();
  }

  void _addChoice() {
    if (_choices.length < 4) {
      setState(() {
        _choices.add(_ChoiceEditorState(text: '', delta: 0, nextCardId: ''));
      });
    }
  }

  void _removeChoice(int index) {
    if (_choices.length > 2) {
      setState(() {
        _choices.removeAt(index);
      });
    }
  }

  void _saveCard() {
    final choices = _choices
        .where((c) => c.text.isNotEmpty && c.nextCardId.isNotEmpty)
        .map((c) => card_model.Choice(
              text: c.text,
              thermometerDelta: c.delta.clamp(-100, 100),
              nextCardId: c.nextCardId,
            ))
        .toList();

    if (choices.length < 2 || choices.length > 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Card must have 2-4 choices')),
      );
      return;
    }

    try {
      final card = card_model.Card(
        id: _idController.text,
        question: _questionController.text,
        imagePath: _imagePathController.text,
        choices: choices,
      );
      widget.onSave(card);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Edit Card',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 16),
          TextField(
            controller: _idController,
            decoration: InputDecoration(labelText: 'Card ID'),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _questionController,
            decoration: InputDecoration(labelText: 'Question'),
            maxLines: 3,
          ),
          SizedBox(height: 12),
          TextField(
            controller: _imagePathController,
            decoration: InputDecoration(labelText: 'Image Path'),
          ),
          SizedBox(height: 24),
          Text(
            'Choices (2-4)',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 12),
          ..._choices.asMap().entries.map((entry) {
            int idx = entry.key;
            _ChoiceEditorState choice = entry.value;
            return _ChoiceEditor(
              choice: choice,
              onRemove: _choices.length > 2 ? () => _removeChoice(idx) : null,
            );
          }),
          if (_choices.length < 4)
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: ElevatedButton.icon(
                onPressed: _addChoice,
                icon: Icon(Icons.add),
                label: Text('Add Choice'),
              ),
            ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (widget.onCancel != null)
                ElevatedButton(
                  onPressed: widget.onCancel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: Text('Cancel'),
                ),
              SizedBox(width: 12),
              ElevatedButton(
                onPressed: _saveCard,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text('Save Card'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChoiceEditorState {
  String text;
  int delta;
  String nextCardId;

  _ChoiceEditorState({
    required this.text,
    required this.delta,
    required this.nextCardId,
  });
}

class _ChoiceEditor extends StatefulWidget {
  final _ChoiceEditorState choice;
  final VoidCallback? onRemove;

  const _ChoiceEditor({
    super.key,
    required this.choice,
    this.onRemove,
  });

  @override
  State<_ChoiceEditor> createState() => _ChoiceEditorWidgetState();
}

class _ChoiceEditorWidgetState extends State<_ChoiceEditor> {
  late TextEditingController _textController;
  late TextEditingController _deltaController;
  late TextEditingController _nextCardIdController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.choice.text);
    _deltaController = TextEditingController(text: '${widget.choice.delta}');
    _nextCardIdController =
        TextEditingController(text: widget.choice.nextCardId);

    _textController.addListener(_updateChoice);
    _deltaController.addListener(_updateChoice);
    _nextCardIdController.addListener(_updateChoice);
  }

  @override
  void dispose() {
    _textController.dispose();
    _deltaController.dispose();
    _nextCardIdController.dispose();
    super.dispose();
  }

  void _updateChoice() {
    widget.choice.text = _textController.text;
    widget.choice.delta = int.tryParse(_deltaController.text) ?? 0;
    widget.choice.nextCardId = _nextCardIdController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              labelText: 'Choice Text',
              isDense: true,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _deltaController,
                  decoration: InputDecoration(
                    labelText: 'Thermometer Delta (-100 to +100)',
                    isDense: true,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: 12),
              if (widget.onRemove != null)
                IconButton(
                  onPressed: widget.onRemove,
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
            ],
          ),
          SizedBox(height: 8),
          TextField(
            controller: _nextCardIdController,
            decoration: InputDecoration(
              labelText: 'Next Card ID',
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }
}
