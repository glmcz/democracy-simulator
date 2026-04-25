import 'package:flutter/material.dart';
import 'package:democracy_simulator/data/example_stories.dart';
import 'package:democracy_simulator/models/story_chain.dart';
import 'package:democracy_simulator/services/story_engine.dart';
import 'package:democracy_simulator/services/design_mode.dart';
import 'package:democracy_simulator/widgets/card_widget.dart';
import 'package:democracy_simulator/widgets/thermometer.dart';
import 'package:democracy_simulator/widgets/design_mode_toggle.dart';
import 'package:democracy_simulator/widgets/story_chain_editor.dart';

void main() {
  runApp(const DemocracySimulatorApp());
}

class DemocracySimulatorApp extends StatelessWidget {
  const DemocracySimulatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Democracy Simulator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late StoryEngine storyEngine;
  final designModeManager = DesignModeManager();

  @override
  void initState() {
    super.initState();
    storyEngine = StoryEngine(storyChain: exampleStoryChain);
  }

  void _onChoiceSelected(int choiceIndex) {
    setState(() {
      storyEngine.makeChoice(choiceIndex);
    });
  }

  void _onStoryChainSaved(StoryChain storyChain) {
    setState(() {
      storyEngine = StoryEngine(storyChain: storyChain);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Story chain saved!')),
    );
  }

  void _resetGame() {
    setState(() {
      storyEngine.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentCard = storyEngine.currentCard;

    if (currentCard == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Democracy Simulator')),
        body: Center(
          child: Text('Error: No card found'),
        ),
      );
    }

    if (designModeManager.isDesignMode) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Design Mode'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: DesignModeToggle(
                manager: designModeManager,
                onModeChanged: () => setState(() {}),
              ),
            ),
          ],
        ),
        body: StoryChainEditor(
          initialChain: storyEngine.storyChain,
          onSave: _onStoryChainSaved,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Democracy Simulator'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DesignModeToggle(
              manager: designModeManager,
              onModeChanged: () => setState(() {}),
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
                label: 'Human Orientation',
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
        tooltip: 'Reset Story',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
