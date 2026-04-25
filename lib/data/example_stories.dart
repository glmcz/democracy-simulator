import 'package:democracy_simulator/models/card.dart' as card_model;
import 'package:democracy_simulator/models/story_chain.dart';

final exampleStoryChain = StoryChain(
  id: 'refugee_crisis',
  startCardId: 'card_welcome',
  cards: {
    'card_welcome': card_model.Card(
      id: 'card_welcome',
      question: 'A refugee crisis arrives at your town gates. As mayor, what do you do?',
      imagePath: 'assets/images/refugee_crisis.png',
      choices: [
        card_model.Choice(
          text: 'Welcome them, prepare shelter',
          thermometerDelta: 25,
          nextCardId: 'card_welcome_chosen',
        ),
        card_model.Choice(
          text: 'Turn them away for safety',
          thermometerDelta: -20,
          nextCardId: 'card_refuse_chosen',
        ),
        card_model.Choice(
          text: 'Ask regional government for help',
          thermometerDelta: 5,
          nextCardId: 'card_ask_help',
        ),
      ],
    ),
    'card_welcome_chosen': card_model.Card(
      id: 'card_welcome_chosen',
      question: 'You chose to welcome them. Local citizens are split. What\'s your next move?',
      imagePath: 'assets/images/welcome_chosen.png',
      choices: [
        card_model.Choice(
          text: 'Fund community integration programs',
          thermometerDelta: 20,
          nextCardId: 'card_integration',
        ),
        card_model.Choice(
          text: 'Protect your citizens\' interests first',
          thermometerDelta: -10,
          nextCardId: 'card_citizens_first',
        ),
        card_model.Choice(
          text: 'Host a town meeting to discuss',
          thermometerDelta: 10,
          nextCardId: 'card_meeting',
        ),
      ],
    ),
    'card_refuse_chosen': card_model.Card(
      id: 'card_refuse_chosen',
      question: 'You turned them away. Reports show they suffered. Do you regret this?',
      imagePath: 'assets/images/refuse_chosen.png',
      choices: [
        card_model.Choice(
          text: 'Yes, send aid packages',
          thermometerDelta: 20,
          nextCardId: 'card_aid_packages',
        ),
        card_model.Choice(
          text: 'No, it was the right choice',
          thermometerDelta: -15,
          nextCardId: 'card_no_regret',
        ),
        card_model.Choice(
          text: 'Propose border controls to prevent future crisis',
          thermometerDelta: 0,
          nextCardId: 'card_controls',
        ),
      ],
    ),
    'card_ask_help': card_model.Card(
      id: 'card_ask_help',
      question: 'Regional government delays response. What do you do?',
      imagePath: 'assets/images/ask_help.png',
      choices: [
        card_model.Choice(
          text: 'Act independently, shelter refugees',
          thermometerDelta: 15,
          nextCardId: 'card_integration',
        ),
        card_model.Choice(
          text: 'Wait for official directive',
          thermometerDelta: -5,
          nextCardId: 'card_waiting',
        ),
        card_model.Choice(
          text: 'Negotiate for faster aid',
          thermometerDelta: 8,
          nextCardId: 'card_negotiate',
        ),
      ],
    ),
    'card_integration': card_model.Card(
      id: 'card_integration',
      question: 'Integration programs succeed! Refugees find work, homes. Your citizens see prosperity.',
      imagePath: 'assets/images/success.png',
      choices: [
        card_model.Choice(
          text: 'Celebrate and expand programs',
          thermometerDelta: 15,
          nextCardId: 'card_end_positive',
        ),
        card_model.Choice(
          text: 'Cut programs to save budget',
          thermometerDelta: -10,
          nextCardId: 'card_end_mixed',
        ),
        card_model.Choice(
          text: 'Propose to regional government as model',
          thermometerDelta: 10,
          nextCardId: 'card_end_positive',
        ),
      ],
    ),
    'card_citizens_first': card_model.Card(
      id: 'card_citizens_first',
      question: 'You prioritize citizens. Refugees struggle, resentment builds.',
      imagePath: 'assets/images/citizens_first.png',
      choices: [
        card_model.Choice(
          text: 'Ease restrictions, show compassion',
          thermometerDelta: 15,
          nextCardId: 'card_end_mixed',
        ),
        card_model.Choice(
          text: 'Stay firm on your policy',
          thermometerDelta: -5,
          nextCardId: 'card_end_negative',
        ),
        card_model.Choice(
          text: 'Find compromise position',
          thermometerDelta: 5,
          nextCardId: 'card_end_mixed',
        ),
      ],
    ),
    'card_meeting': card_model.Card(
      id: 'card_meeting',
      question: 'Town meeting reveals diverse opinions. Consensus is unclear.',
      imagePath: 'assets/images/meeting.png',
      choices: [
        card_model.Choice(
          text: 'Lead with moral clarity: welcome them',
          thermometerDelta: 18,
          nextCardId: 'card_integration',
        ),
        card_model.Choice(
          text: 'Defer to majority vote',
          thermometerDelta: 2,
          nextCardId: 'card_end_mixed',
        ),
        card_model.Choice(
          text: 'Find middle ground: limited shelter',
          thermometerDelta: 0,
          nextCardId: 'card_end_mixed',
        ),
      ],
    ),
    'card_aid_packages': card_model.Card(
      id: 'card_aid_packages',
      question: 'Your aid packages reach the refugees. They call you compassionate. You feel redeemed.',
      imagePath: 'assets/images/aid.png',
      choices: [
        card_model.Choice(
          text: 'Learn from mistakes, welcome next wave',
          thermometerDelta: 20,
          nextCardId: 'card_end_positive',
        ),
        card_model.Choice(
          text: 'Donate more, lead regional compassion',
          thermometerDelta: 18,
          nextCardId: 'card_end_positive',
        ),
        card_model.Choice(
          text: 'Rest, hope it doesn\'t happen again',
          thermometerDelta: 5,
          nextCardId: 'card_end_mixed',
        ),
      ],
    ),
    'card_no_regret': card_model.Card(
      id: 'card_no_regret',
      question: 'You stand firm. Your town is stable but your conscience wavers in quiet moments.',
      imagePath: 'assets/images/no_regret.png',
      choices: [
        card_model.Choice(
          text: 'Strengthen borders, cement your decision',
          thermometerDelta: -10,
          nextCardId: 'card_end_negative',
        ),
        card_model.Choice(
          text: 'Support refugees from afar, ease guilt',
          thermometerDelta: 8,
          nextCardId: 'card_end_mixed',
        ),
        card_model.Choice(
          text: 'Move on, don\'t dwell on it',
          thermometerDelta: 0,
          nextCardId: 'card_end_negative',
        ),
      ],
    ),
    'card_controls': card_model.Card(
      id: 'card_controls',
      question: 'Your border control proposal gains regional approval. Crisis averted for now.',
      imagePath: 'assets/images/controls.png',
      choices: [
        card_model.Choice(
          text: 'Ensure controls are humane',
          thermometerDelta: 8,
          nextCardId: 'card_end_mixed',
        ),
        card_model.Choice(
          text: 'Prioritize absolute prevention',
          thermometerDelta: -8,
          nextCardId: 'card_end_negative',
        ),
        card_model.Choice(
          text: 'Sponsor internal resettlement instead',
          thermometerDelta: 10,
          nextCardId: 'card_end_mixed',
        ),
      ],
    ),
    'card_waiting': card_model.Card(
      id: 'card_waiting',
      question: 'Waiting exhausts the refugees and your resources. You feel powerless.',
      imagePath: 'assets/images/waiting.png',
      choices: [
        card_model.Choice(
          text: 'Act now despite lack of direction',
          thermometerDelta: 12,
          nextCardId: 'card_integration',
        ),
        card_model.Choice(
          text: 'Continue waiting, bureaucracy delays resolution',
          thermometerDelta: -15,
          nextCardId: 'card_end_negative',
        ),
        card_model.Choice(
          text: 'Provide minimal aid, hope help arrives soon',
          thermometerDelta: 2,
          nextCardId: 'card_end_mixed',
        ),
      ],
    ),
    'card_negotiate': card_model.Card(
      id: 'card_negotiate',
      question: 'Your negotiation wins partial funding. You host refugees with limited resources.',
      imagePath: 'assets/images/negotiate.png',
      choices: [
        card_model.Choice(
          text: 'Make it work with ingenuity and community',
          thermometerDelta: 15,
          nextCardId: 'card_end_mixed',
        ),
        card_model.Choice(
          text: 'Push for more resources, become advocate',
          thermometerDelta: 18,
          nextCardId: 'card_integration',
        ),
        card_model.Choice(
          text: 'Accept limitation, do what you can',
          thermometerDelta: 5,
          nextCardId: 'card_end_mixed',
        ),
      ],
    ),
    'card_end_positive': card_model.Card(
      id: 'card_end_positive',
      question: 'END: You\'ve shown true leadership. Your town and the refugees flourish together. History remembers your compassion.',
      imagePath: 'assets/images/end_positive.png',
      choices: [
        card_model.Choice(
          text: 'Play Again',
          thermometerDelta: 0,
          nextCardId: 'card_welcome',
        ),
        card_model.Choice(
          text: 'See Final Score',
          thermometerDelta: 0,
          nextCardId: 'card_end_positive',
        ),
      ],
    ),
    'card_end_negative': card_model.Card(
      id: 'card_end_negative',
      question: 'END: Your choices left suffering in their wake. The town is stable but humanity wavers in the balance.',
      imagePath: 'assets/images/end_negative.png',
      choices: [
        card_model.Choice(
          text: 'Play Again',
          thermometerDelta: 0,
          nextCardId: 'card_welcome',
        ),
        card_model.Choice(
          text: 'See Final Score',
          thermometerDelta: 0,
          nextCardId: 'card_end_negative',
        ),
      ],
    ),
    'card_end_mixed': card_model.Card(
      id: 'card_end_mixed',
      question: 'END: You navigated difficult choices. The outcome is neither triumph nor failure—life continues.',
      imagePath: 'assets/images/end_mixed.png',
      choices: [
        card_model.Choice(
          text: 'Play Again',
          thermometerDelta: 0,
          nextCardId: 'card_welcome',
        ),
        card_model.Choice(
          text: 'See Final Score',
          thermometerDelta: 0,
          nextCardId: 'card_end_mixed',
        ),
      ],
    ),
  },
);
