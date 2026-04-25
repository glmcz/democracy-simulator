import 'package:democracy_simulator/models/story_chain.dart';
import 'package:democracy_simulator/data/example_stories.dart';

class StoryChainManager {
  final Map<String, StoryChain> _chains = {};
  String? _activeChainId;

  StoryChainManager() {
    _chains[exampleStoryChain.id] = exampleStoryChain;
    _activeChainId = exampleStoryChain.id;
  }

  List<String> get chainIds => _chains.keys.toList();
  String? get activeChainId => _activeChainId;
  StoryChain? get activeChain => _activeChainId != null ? _chains[_activeChainId] : null;

  StoryChain? getChain(String id) => _chains[id];

  void addChain(StoryChain chain) {
    _chains[chain.id] = chain;
    _activeChainId = chain.id;
  }

  void updateChain(StoryChain chain) {
    if (_chains.containsKey(chain.id)) {
      _chains[chain.id] = chain;
    }
  }

  void deleteChain(String chainId) {
    if (_chains.containsKey(chainId)) {
      _chains.remove(chainId);
      if (_activeChainId == chainId) {
        _activeChainId = _chains.isNotEmpty ? _chains.keys.first : null;
      }
    }
  }

  void setActiveChain(String chainId) {
    if (_chains.containsKey(chainId)) {
      _activeChainId = chainId;
    }
  }

  void createNewChain(String chainId) {
    if (!_chains.containsKey(chainId)) {
      final newChain = StoryChain(
        id: chainId,
        startCardId: 'card_1',
        cards: {},
      );
      addChain(newChain);
    }
  }

  Map<String, StoryChain> getAllChains() => Map.from(_chains);
}
