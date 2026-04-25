// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Democracy Simulator';

  @override
  String get designMode => 'Design Mode';

  @override
  String get playMode => 'Play Mode';

  @override
  String get humanOrientation => 'Human Orientation';

  @override
  String get resetStory => 'Reset Story';

  @override
  String get errorNoCardFound => 'Error: No card found';

  @override
  String get storyChainSaved => 'Story chain saved!';

  @override
  String get imageNotFound => 'Image not found';

  @override
  String get storyChainEditor => 'Story Chain Editor';

  @override
  String get chainId => 'Chain ID';

  @override
  String get startCardId => 'Start Card ID';

  @override
  String get addCard => 'Add Card';

  @override
  String get noCardsYet => 'No cards yet. Tap \"Add Card\" to create one.';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get saveChain => 'Save Chain';

  @override
  String get storyChainMustHaveCard => 'Story chain must have at least 1 card';

  @override
  String get startCardMustExist => 'Start card ID must exist in cards';

  @override
  String get storyChains => 'Story Chains';

  @override
  String get noStoryChainsYet => 'No story chains yet';

  @override
  String get newChain => 'New Chain';

  @override
  String get newStoryChain => 'New Story Chain';

  @override
  String get chainIdHint => 'e.g., story_2, refugee_crisis_2';

  @override
  String get cancel => 'Cancel';

  @override
  String get create => 'Create';

  @override
  String get deleteStoryChain => 'Delete Story Chain?';

  @override
  String get editCard => 'Edit Card';

  @override
  String get cardId => 'Card ID';

  @override
  String get question => 'Question';

  @override
  String get imagePath => 'Image Path';

  @override
  String get choices24 => 'Choices (2-4)';

  @override
  String get addChoice => 'Add Choice';

  @override
  String get saveCard => 'Save Card';

  @override
  String get cardMustHave24Choices => 'Card must have 2-4 choices';

  @override
  String get choiceText => 'Choice Text';

  @override
  String get thermometerDelta => 'Thermometer Delta (-100 to +100)';

  @override
  String get nextCardId => 'Next Card ID';

  @override
  String cardsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    return 'Cards ($countString)';
  }

  @override
  String deleteChainConfirm(String chainId) {
    return 'Delete \"$chainId\"? This cannot be undone.';
  }

  @override
  String error(String error) {
    return 'Error: $error';
  }
}
