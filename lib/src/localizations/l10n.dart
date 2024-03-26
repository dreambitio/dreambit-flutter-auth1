part of '../../../one_day_auth.dart';

/// {@template ui.i10n.localizations}
/// Could be used to obtain Firebase UI localization labels
/// via [BuildContext] (using [labelsOf] )and to override default localizations
/// (using [withDefaultOverrides]).
/// {@endtemplate}
class AuthLocalizations<T extends AuthLocalizationLabels> {
  final Locale locale;
  final T labels;

  /// {@macro ui.i10n.localizations}
  const AuthLocalizations(this.locale, this.labels);

  /// Looks up an instance of the [AuthLocalizations] on the
  /// [BuildContext].
  ///
  /// To obtain labels, use [labelsOf].
  static AuthLocalizations of(BuildContext context) {
    final l = Localizations.of<AuthLocalizations>(
      context,
      AuthLocalizations,
    );

    if (l != null) {
      return l;
    }

    final defaultTranslation = AuthAllLanguages.getTranslation(
      AuthAllLanguages.defaultLocale,
    );
    return AuthLocalizations(
      AuthAllLanguages.defaultLocale,
      defaultTranslation,
    );
  }

  /// Returns localization labels.
  static AuthLocalizationLabels labelsOf(BuildContext context) {
    return AuthLocalizations.of(context).labels;
  }

  /// Localization delegate that could be provided to the
  /// [MaterialApp.localizationsDelegates].
  static const AuthLocalizationDelegate delegate = AuthLocalizationDelegate();

  /// Should be used to override labels provided by the library.
  ///
  /// See [AuthLocalizationLabels].
  static AuthLocalizationDelegate
      withDefaultOverrides<T extends DefaultLocalizations>(T overrides) {
    return AuthLocalizationDelegate<T>(overrides);
  }
}

/// See [LocalizationsDelegate]
class AuthLocalizationDelegate<T extends AuthLocalizationLabels>
    extends LocalizationsDelegate<AuthLocalizations> {
  /// An instance of the class that overrides some labels.
  /// See [AuthLocalizationLabels].
  final T? overrides;
  final bool _forceSupportAllLocales;

  /// See [LocalizationsDelegate].
  const AuthLocalizationDelegate([
    this.overrides,
    // ignore: avoid_positional_boolean_parameters
    this._forceSupportAllLocales = false,
  ]);

  @override
  bool isSupported(Locale locale) =>
      _forceSupportAllLocales ||
      AuthAllLanguages.supportedLanguages.contains(locale.languageCode);

  @override
  Future<AuthLocalizations> load(Locale locale) {
    final translation = AuthAllLanguages.getTranslation(
      locale,
      AuthAllLanguages.defaultLocale,
    );

    final localizations = AuthLocalizations(
      locale,
      overrides ?? translation,
    );

    return SynchronousFuture<AuthLocalizations>(localizations);
  }

  @override
  bool shouldReload(
    covariant LocalizationsDelegate<AuthLocalizations> old,
  ) {
    return false;
  }
}
