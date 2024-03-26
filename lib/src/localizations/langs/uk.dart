import '../default_localizations.dart';

class UkLocalizations extends AuthLocalizationLabels {
  const UkLocalizations();

  @override
  String get yes => 'Так';

  @override
  String get cancel => 'Скасувати';

  @override
  String get confirm => 'Підтвердити';

  @override
  String get signOutQ => 'Вийти?';

  @override
  String get signOutDescription => 'Ви дійсно хочете вийти?';

  @override
  String get deleteAccountQ => 'Видалити акаунт?';

  @override
  String get deleteAccountDescription => 'Ви дійсно хочете видалити акаунт?';

  @override
  String get changePassword => 'Змінити пароль';

  @override
  String get confirmYourPassword => 'Підтвердіть ваш пароль.';

  @override
  String get password => 'Пароль';

  @override
  String get newPassword => 'Новий пароль';

  @override
  String get invalidPassword => 'Невірний пароль';

  @override
  String get confirmNewPassword => 'Підтвердіть новий пароль';

  @override
  String get confirmNewPasswordDescription =>
      'Підтвердіть ваш пароль і введіть новий.';

  @override
  String get code => 'Код';

  @override
  String get invalidCode => 'Невірний код';

  @override
  String get enterVerificationCode => 'Ввдіть верифікаційний код';

  @override
  String get weSentCodeToYourPhone =>
      'Ми надіслали вам код на ваш номер телефону.';

  @override
  String get continueWithApple => 'Продовжити з Apple';

  @override
  String get continueWithFacebook => 'Продовжити з Facebook';

  @override
  String get continueWithGitHub => 'Продовжити з GitHub';

  @override
  String get continueWithGoogle => 'Продовжити з Google';

  @override
  String get continueWithMicrosoft => 'Продовжити з Microsoft';

  @override
  String get continueWithTwitterX => 'Продовжити з X';

  @override
  String get somethingWentWrong => 'Щось пішло не так';

  @override
  String get invalidEmail => 'Невірна пошта';

  @override
  String get invalidPhoneNumber => 'Невірний номер телефону';

  @override
  String get missingEmail => 'Пошта відсутня';

  @override
  String get invalidCredential =>
      'Дані користувача неправильні або термін їх дії минув';

  @override
  String get userNotFound => 'Користувача не існує';

  @override
  String get authorizationError => 'Помилка авторизації';

  @override
  String get emailAlreadyInUse =>
      'Користувач з цією електронною адресою вже існує';

  @override
  String get accountExistsWithDifferentCredential =>
      'Уже існує обліковий запис із тією самою адресою електронної пошти, але іншими обліковими даними для входу.';

  @override
  String get accessToAccountTemporarilyDisabled =>
      'Доступ до цього акаунту тимчасово вимкнено';

  @override
  String get passwordInvalidOrUserDoesNotHavePassword =>
      'Пароль недійсний або користувач не має пароля';

  @override
  String get providerIsAssociatedWithDifferentAccount =>
      'Цей провайдер пов’язаний з іншим обліковим записом користувача';

  @override
  String get codeIsInvalidTryAgain =>
      'Введений вами код недійсний, будь ласка спробуйте ще раз';

  @override
  String get passwordSixCharacters => 'Пароль має бути не менше 6 символів';

  @override
  String get pleaseLogInAgainBeforeRetrying =>
      'Будь ласка увійдіть знову перед повторною спробою';

  @override
  String get interactionWasCancelled => 'Скасовано';

  @override
  String get serviceIsCurrentlyUnavailable =>
      'Сервіс на даний момент недоступний';

  @override
  String get suppliedCredentialsDoNotCorrespondPreviouslyUser =>
      'Надані облікові дані не відповідають попередньому входу користувача';
}
