import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_cs.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('cs'),
    Locale('en'),
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Democracy Simulator'**
  String get appTitle;

  /// Label for design mode button/toggle
  ///
  /// In en, this message translates to:
  /// **'Design Mode'**
  String get designMode;

  /// Label for play mode button/toggle
  ///
  /// In en, this message translates to:
  /// **'Play Mode'**
  String get playMode;

  /// Thermometer label showing human orientation scale
  ///
  /// In en, this message translates to:
  /// **'Human Orientation'**
  String get humanOrientation;

  /// Tooltip for reset/refresh button
  ///
  /// In en, this message translates to:
  /// **'Reset Story'**
  String get resetStory;

  /// Error message when current card is null
  ///
  /// In en, this message translates to:
  /// **'Error: No card found'**
  String get errorNoCardFound;

  /// Success message after saving a story chain
  ///
  /// In en, this message translates to:
  /// **'Story chain saved!'**
  String get storyChainSaved;

  /// Fallback text when card image fails to load
  ///
  /// In en, this message translates to:
  /// **'Image not found'**
  String get imageNotFound;

  /// Title of the story chain editor section
  ///
  /// In en, this message translates to:
  /// **'Story Chain Editor'**
  String get storyChainEditor;

  /// Label for chain ID input field
  ///
  /// In en, this message translates to:
  /// **'Chain ID'**
  String get chainId;

  /// Label for start card ID input field
  ///
  /// In en, this message translates to:
  /// **'Start Card ID'**
  String get startCardId;

  /// Button to add a new card to the story chain
  ///
  /// In en, this message translates to:
  /// **'Add Card'**
  String get addCard;

  /// Empty state message when story chain has no cards
  ///
  /// In en, this message translates to:
  /// **'No cards yet. Tap \"Add Card\" to create one.'**
  String get noCardsYet;

  /// Menu item to edit a card
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Menu item or button to delete
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Button to save the story chain
  ///
  /// In en, this message translates to:
  /// **'Save Chain'**
  String get saveChain;

  /// Validation error when saving empty story chain
  ///
  /// In en, this message translates to:
  /// **'Story chain must have at least 1 card'**
  String get storyChainMustHaveCard;

  /// Validation error when start card ID doesn't match any card
  ///
  /// In en, this message translates to:
  /// **'Start card ID must exist in cards'**
  String get startCardMustExist;

  /// Heading for the story chains selector section
  ///
  /// In en, this message translates to:
  /// **'Story Chains'**
  String get storyChains;

  /// Empty state message when no story chains exist
  ///
  /// In en, this message translates to:
  /// **'No story chains yet'**
  String get noStoryChainsYet;

  /// Button to create a new story chain
  ///
  /// In en, this message translates to:
  /// **'New Chain'**
  String get newChain;

  /// Dialog title for creating a new story chain
  ///
  /// In en, this message translates to:
  /// **'New Story Chain'**
  String get newStoryChain;

  /// Hint text for chain ID input field
  ///
  /// In en, this message translates to:
  /// **'e.g., story_2, refugee_crisis_2'**
  String get chainIdHint;

  /// Button to cancel a dialog or action
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Button to create new item
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// Dialog title for deleting a story chain
  ///
  /// In en, this message translates to:
  /// **'Delete Story Chain?'**
  String get deleteStoryChain;

  /// Title of the card editor section
  ///
  /// In en, this message translates to:
  /// **'Edit Card'**
  String get editCard;

  /// Label for card ID input field
  ///
  /// In en, this message translates to:
  /// **'Card ID'**
  String get cardId;

  /// Label for card question input field
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get question;

  /// Label for card image path input field
  ///
  /// In en, this message translates to:
  /// **'Image Path'**
  String get imagePath;

  /// Section heading for card choices
  ///
  /// In en, this message translates to:
  /// **'Choices (2-4)'**
  String get choices24;

  /// Button to add a choice to a card
  ///
  /// In en, this message translates to:
  /// **'Add Choice'**
  String get addChoice;

  /// Button to save a card
  ///
  /// In en, this message translates to:
  /// **'Save Card'**
  String get saveCard;

  /// Validation error when card has wrong number of choices
  ///
  /// In en, this message translates to:
  /// **'Card must have 2-4 choices'**
  String get cardMustHave24Choices;

  /// Label for choice text input field
  ///
  /// In en, this message translates to:
  /// **'Choice Text'**
  String get choiceText;

  /// Label for thermometer delta input field
  ///
  /// In en, this message translates to:
  /// **'Thermometer Delta (-100 to +100)'**
  String get thermometerDelta;

  /// Label for next card ID input field
  ///
  /// In en, this message translates to:
  /// **'Next Card ID'**
  String get nextCardId;

  /// Section heading showing number of cards
  ///
  /// In en, this message translates to:
  /// **'Cards ({count})'**
  String cardsCount(int count);

  /// Confirmation dialog body for deleting a story chain
  ///
  /// In en, this message translates to:
  /// **'Delete \"{chainId}\"? This cannot be undone.'**
  String deleteChainConfirm(String chainId);

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String error(String error);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['cs', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'cs':
      return AppLocalizationsCs();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
