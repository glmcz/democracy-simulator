import 'package:flutter/material.dart';
import 'package:democracy_simulator/generated_l10n/app_localizations.dart';
import 'package:democracy_simulator/services/story_chain_manager.dart';

class StoryChainSelector extends StatefulWidget {
  final StoryChainManager manager;
  final VoidCallback onChainChanged;
  final VoidCallback onChainDeleted;

  const StoryChainSelector({
    super.key,
    required this.manager,
    required this.onChainChanged,
    required this.onChainDeleted,
  });

  @override
  State<StoryChainSelector> createState() => _StoryChainSelectorState();
}

class _StoryChainSelectorState extends State<StoryChainSelector> {
  late TextEditingController _newChainIdController;

  @override
  void initState() {
    super.initState();
    _newChainIdController = TextEditingController();
  }

  @override
  void dispose() {
    _newChainIdController.dispose();
    super.dispose();
  }

  void _showNewChainDialog() {
    final l10n = AppLocalizations.of(context)!;
    _newChainIdController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.newStoryChain),
        content: TextField(
          controller: _newChainIdController,
          decoration: InputDecoration(
            labelText: l10n.chainId,
            hintText: l10n.chainIdHint,
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              if (_newChainIdController.text.isNotEmpty) {
                widget.manager.createNewChain(_newChainIdController.text);
                widget.onChainChanged();
                Navigator.pop(context);
              }
            },
            child: Text(l10n.create),
          ),
        ],
      ),
    );
  }

  void _deleteCurrentChain() {
    if (widget.manager.activeChainId == null) return;

    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteStoryChain),
        content: Text(l10n.deleteChainConfirm(widget.manager.activeChainId!)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              widget.manager.deleteChain(widget.manager.activeChainId!);
              widget.onChainDeleted();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(l10n.delete, style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final chains = widget.manager.chainIds;
    final activeChain = widget.manager.activeChainId;
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.storyChains,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 12),
            if (chains.isEmpty)
              Text(
                l10n.noStoryChainsYet,
                style: Theme.of(context).textTheme.bodySmall,
              )
            else
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: activeChain,
                  isExpanded: true,
                  underline: SizedBox(),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  items: chains.map((chainId) {
                    return DropdownMenuItem(
                      value: chainId,
                      child: Text(chainId),
                    );
                  }).toList(),
                  onChanged: (newChain) {
                    if (newChain != null) {
                      widget.manager.setActiveChain(newChain);
                      widget.onChainChanged();
                      setState(() {});
                    }
                  },
                ),
              ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: _showNewChainDialog,
                  icon: Icon(Icons.add),
                  label: Text(l10n.newChain),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
                if (chains.length > 1)
                  ElevatedButton.icon(
                    onPressed: _deleteCurrentChain,
                    icon: Icon(Icons.delete),
                    label: Text(l10n.delete),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
