import 'dart:ui';

import './default_localizations.dart';
import 'langs/en.dart';
import 'langs/uk.dart';

class AuthAllLanguages {
  static const Locale defaultLocale = Locale('en');

  static final Set<String> supportedLanguages = {
    'en', // English
    'uk', // Ukrainian
  };

  static AuthLocalizationLabels getTranslation(
    Locale useLocale, [
    Locale? defaultLocale,
  ]) {
    final Locale locale;
    if (supportedLanguages.contains(useLocale.languageCode)) {
      locale = useLocale;
    } else {
      locale = defaultLocale ?? useLocale;
    }
    switch (locale.languageCode) {
      case 'uk':
        return const UkLocalizations();
      case 'en':
      default:
        return const EnLocalizations();
    }
  }
}
