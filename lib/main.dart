import 'package:flutter/material.dart';
import 'package:democracy_simulator/generated_l10n/app_localizations.dart';
import 'package:democracy_simulator/models/story_chain.dart';
import 'package:democracy_simulator/services/story_engine.dart';
import 'package:democracy_simulator/services/design_mode.dart';
import 'package:democracy_simulator/services/story_chain_manager.dart';
import 'package:democracy_simulator/widgets/card_widget.dart';
import 'package:democracy_simulator/widgets/thermometer.dart';
import 'package:democracy_simulator/widgets/design_mode_toggle.dart';
import 'package:democracy_simulator/widgets/story_chain_editor.dart';
import 'package:democracy_simulator/widgets/story_chain_selector.dart';

void main() {
  runApp(const DemocracySimulatorApp());
}

class DemocracySimulatorApp extends StatefulWidget {
  const DemocracySimulatorApp({super.key});

  @override
  State<DemocracySimulatorApp> createState() => _DemocracySimulatorAppState();
}

class _DemocracySimulatorAppState extends State<DemocracySimulatorApp> {
  Locale _locale = const Locale('en');

  void _toggleLocale() {
    setState(() {
      _locale = _locale.languageCode == 'en' ? const Locale('cs') : const Locale('en');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Democracy Simulator',
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: GameScreen(onLocaleChanged: _toggleLocale),
    );
  }
}

class GameScreen extends StatefulWidget {
  final VoidCallback onLocaleChanged;

  const GameScreen({
    super.key,
    required this.onLocaleChanged,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late StoryEngine storyEngine;
  final designModeManager = DesignModeManager();
  final chainManager = StoryChainManager();

  @override
  void initState() {
    super.initState();
    storyEngine = StoryEngine(storyChain: chainManager.activeChain!);
  }

  void _onChoiceSelected(int choiceIndex) {
    setState(() {
      storyEngine.makeChoice(choiceIndex);
    });
  }

  void _onStoryChainSaved(StoryChain storyChain) {
    setState(() {
      chainManager.updateChain(storyChain);
      storyEngine = StoryEngine(storyChain: storyChain);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.storyChainSaved)),
    );
  }

  void _onChainChanged() {
    setState(() {
      storyEngine = StoryEngine(storyChain: chainManager.activeChain!);
    });
  }

  void _onChainDeleted() {
    setState(() {
      storyEngine = StoryEngine(storyChain: chainManager.activeChain!);
    });
  }

  void _resetGame() {
    setState(() {
      storyEngine.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentCard = storyEngine.currentCard;
    final l10n = AppLocalizations.of(context)!;

    if (currentCard == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.appTitle)),
        body: Center(
          child: Text(l10n.errorNoCardFound),
        ),
      );
    }

    if (designModeManager.isDesignMode) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.designMode),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Text(
                      Localizations.localeOf(context).languageCode == 'en' ? '🇨🇿' : '🇬🇧',
                      style: const TextStyle(fontSize: 20),
                    ),
                    onPressed: widget.onLocaleChanged,
                    tooltip: l10n.playMode,
                  ),
                  DesignModeToggle(
                    manager: designModeManager,
                    onModeChanged: () => setState(() {}),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              StoryChainSelector(
                manager: chainManager,
                onChainChanged: _onChainChanged,
                onChainDeleted: _onChainDeleted,
              ),
              const SizedBox(height: 24),
              StoryChainEditor(
                initialChain: chainManager.activeChain,
                onSave: _onStoryChainSaved,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Text(
                    Localizations.localeOf(context).languageCode == 'en' ? '🇨🇿' : '🇬🇧',
                    style: const TextStyle(fontSize: 20),
                  ),
                  onPressed: widget.onLocaleChanged,
                  tooltip: l10n.designMode,
                ),
                DesignModeToggle(
                  manager: designModeManager,
                  onModeChanged: () => setState(() {}),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Thermometer(
                value: storyEngine.thermometerValue,
                label: l10n.humanOrientation,
              ),
            ),
            Expanded(
              child: CardWidget(
                card: currentCard,
                onChoiceSelected: _onChoiceSelected,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _resetGame,
        tooltip: l10n.resetStory,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
