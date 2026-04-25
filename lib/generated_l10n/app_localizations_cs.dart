// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get appTitle => 'Simulátor demokracie';

  @override
  String get designMode => 'Režim návrhu';

  @override
  String get playMode => 'Herní režim';

  @override
  String get humanOrientation => 'Lidská orientace';

  @override
  String get resetStory => 'Resetovat příběh';

  @override
  String get errorNoCardFound => 'Chyba: Karta nenalezena';

  @override
  String get storyChainSaved => 'Řetěz příběhů uložen!';

  @override
  String get imageNotFound => 'Obrázek nenalezen';

  @override
  String get storyChainEditor => 'Editor řetězu příběhů';

  @override
  String get chainId => 'ID řetězu';

  @override
  String get startCardId => 'ID počáteční karty';

  @override
  String get addCard => 'Přidat kartu';

  @override
  String get noCardsYet => 'Zatím žádné karty. Klepněte na \"Přidat kartu\".';

  @override
  String get edit => 'Upravit';

  @override
  String get delete => 'Smazat';

  @override
  String get saveChain => 'Uložit řetěz';

  @override
  String get storyChainMustHaveCard => 'Řetěz musí mít alespoň 1 kartu';

  @override
  String get startCardMustExist => 'ID počáteční karty musí existovat';

  @override
  String get storyChains => 'Řetězy příběhů';

  @override
  String get noStoryChainsYet => 'Zatím žádné řetězy';

  @override
  String get newChain => 'Nový řetěz';

  @override
  String get newStoryChain => 'Nový řetěz příběhů';

  @override
  String get chainIdHint => 'např. pribehy_2, uprchlicka_krize_2';

  @override
  String get cancel => 'Zrušit';

  @override
  String get create => 'Vytvořit';

  @override
  String get deleteStoryChain => 'Smazat řetěz příběhů?';

  @override
  String get editCard => 'Upravit kartu';

  @override
  String get cardId => 'ID karty';

  @override
  String get question => 'Otázka';

  @override
  String get imagePath => 'Cesta k obrázku';

  @override
  String get choices24 => 'Volby (2-4)';

  @override
  String get addChoice => 'Přidat volbu';

  @override
  String get saveCard => 'Uložit kartu';

  @override
  String get cardMustHave24Choices => 'Karta musí mít 2-4 volby';

  @override
  String get choiceText => 'Text volby';

  @override
  String get thermometerDelta => 'Delta teploměru (-100 až +100)';

  @override
  String get nextCardId => 'ID další karty';

  @override
  String cardsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    return 'Karty ($countString)';
  }

  @override
  String deleteChainConfirm(String chainId) {
    return 'Smazat \"$chainId\"? Tuto akci nelze vrátit.';
  }

  @override
  String error(String error) {
    return 'Chyba: $error';
  }
}
