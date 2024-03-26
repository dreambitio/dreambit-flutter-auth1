part of '../../../one_day_auth.dart';

/// Default platform actions dialogs for auth functional
class AuthDialogs {
  /// Default action (cancel/yes) platform dialog
  static Future<bool> showDefaultActionDialog({
    required final BuildContext context,

    /// dialog title [String]
    required final String? title,

    /// dialog subtitle [String]
    required final String? subtitle,

    /// first action title
    final String? firstTitle,

    /// second action title
    final String? secondTitle,

    /// use destructive color for first action
    final bool firstDestructive = false,

    /// use destructive color for second action
    final bool secondDestructive = true,

    /// only second action
    final bool okType = false,

    /// use only material style [Widget]
    final bool useMaterialStyle = false,
  }) async {
    return await showAdaptiveDialog<bool?>(
          context: context,
          builder: (BuildContext context) {
            return DefaultActionDialog(
              title: title,
              subtitle: subtitle,
              firstTitle: firstTitle,
              secondTitle: secondTitle,
              firstDestructive: firstDestructive,
              secondDestructive: secondDestructive,
              okType: okType,
              useMaterialStyle: useMaterialStyle,
            );
          },
        ) ??
        false;
  }

  /// Default re auth with password platform dialog
  static Future<bool> showReAuthPasswordDialog({
    required final BuildContext context,

    /// validator for password field
    final String? Function(String? password)? passwordValidator,

    /// password field formatters
    final List<TextInputFormatter>? inputFormatters,

    /// material field style
    final InputDecorationTheme? materialFieldStyle,

    /// use only material style [Widget]
    final bool useMaterialStyle = false,
  }) async {
    return await showAdaptiveDialog<bool?>(
          context: context,
          builder: (BuildContext context) {
            return ReAuthPasswordDialog(
              passwordValidator: passwordValidator,
              inputFormatters: inputFormatters,
              materialFieldStyle: materialFieldStyle,
              useMaterialStyle: useMaterialStyle,
            );
          },
        ) ??
        false;
  }

  /// Default re auth with phone code platform dialog
  static Future<bool> showReAuthPhoneCodeDialog({
    required final BuildContext context,

    /// code field validator
    final String? Function(String? code)? codeValidator,

    /// code field formatters
    final List<TextInputFormatter>? inputFormatters,

    /// material field style
    final InputDecorationTheme? materialFieldStyle,

    /// use only material style [Widget]
    final bool useMaterialStyle = false,
  }) async {
    return await showAdaptiveDialog<bool?>(
          context: context,
          builder: (BuildContext context) {
            return ReAuthPhoneCodeDialog(
              codeValidator: codeValidator,
              inputFormatters: inputFormatters,
              materialFieldStyle: materialFieldStyle,
              useMaterialStyle: useMaterialStyle,
            );
          },
        ) ??
        false;
  }

  /// Default change password action platform dialog
  static Future<void> showChangePasswordDialog({
    required final BuildContext context,

    /// state listener
    final void Function(OneDayAuthState state)? listener,

    /// validator for password field
    final String? Function(String? password)? passwordValidator,

    /// validator for new password field
    final String? Function(
      String? newPassword,
      String? confirmNewPassword,
    )? newPasswordValidator,

    /// validator for confirm new password field
    final String? Function(
      String? confirmNewPassword,
      String? newPassword,
    )? confirmNewPasswordValidator,

    /// password fields formatters
    final List<TextInputFormatter>? inputFormatters,

    /// material field style
    final InputDecorationTheme? materialFieldStyle,

    /// use only material style [Widget]
    final bool useMaterialStyle = false,
  }) async {
    return showAdaptiveDialog(
      context: context,
      builder: (BuildContext context) {
        return ChangePasswordDialog(
          listener: listener,
          passwordValidator: passwordValidator,
          newPasswordValidator: newPasswordValidator,
          confirmNewPasswordValidator: confirmNewPasswordValidator,
          inputFormatters: inputFormatters,
          materialFieldStyle: materialFieldStyle,
          useMaterialStyle: useMaterialStyle,
        );
      },
    );
  }

  /// Default cupertino style action dialog
  static Widget cupertinoActionDialog({
    /// dialog title [String]
    required final String? title,

    /// dialog content [Widget]
    required final Widget? content,

    /// first action title
    final String? firstTitle,

    /// second action title
    final String? secondTitle,

    /// first action void Function()
    final VoidCallback? firstAction,

    /// second action void Function()
    final VoidCallback? secondAction,

    /// blocks the first action
    final bool firstLoading = false,

    /// blocks the second action
    final bool secondLoading = false,

    /// use destructive color for first action
    final bool firstDestructive = false,

    /// use destructive color for second action
    final bool secondDestructive = true,

    /// only second action
    final bool okType = false,
  }) {
    return _CupertinoActionDialog(
      title: title,
      content: content,
      firstTitle: firstTitle,
      secondTitle: secondTitle,
      firstAction: firstAction,
      secondAction: secondAction,
      firstLoading: firstLoading,
      secondLoading: secondLoading,
      firstDestructive: firstDestructive,
      secondDestructive: secondDestructive,
      okType: okType,
    );
  }

  /// Default material style action dialog
  static Widget materialActionDialog({
    /// dialog title [String]
    required final String? title,

    /// dialog content [Widget]
    required final Widget? content,

    /// first action title
    final String? firstTitle,

    /// second action title
    final String? secondTitle,

    /// first action void Function()
    final VoidCallback? firstAction,

    /// second action void Function()
    final VoidCallback? secondAction,

    /// blocks the first action
    final bool firstLoading = false,

    /// blocks the second action
    final bool secondLoading = false,

    /// use destructive color for first action
    final bool firstDestructive = false,

    /// use destructive color for second action
    final bool secondDestructive = true,

    /// only second action
    final bool okType = false,
  }) {
    return _MaterialActionDialog(
      title: title,
      content: content,
      firstTitle: firstTitle,
      secondTitle: secondTitle,
      firstAction: firstAction,
      secondAction: secondAction,
      firstLoading: firstLoading,
      secondLoading: secondLoading,
      firstDestructive: firstDestructive,
      secondDestructive: secondDestructive,
      okType: okType,
    );
  }
}

/// Default cupertino style action dialog [StatelessWidget]
class _CupertinoActionDialog extends StatelessWidget {
  /// dialog title [String]
  final String? title;

  /// dialog content [Widget]
  final Widget? content;

  /// first action title
  final String? firstTitle;

  /// second action title
  final String? secondTitle;

  /// first action void Function()
  final VoidCallback? firstAction;

  /// second action void Function()
  final VoidCallback? secondAction;

  /// blocks the first action
  final bool firstLoading;

  /// blocks the second action
  final bool secondLoading;

  /// use destructive color for first action
  final bool firstDestructive;

  /// use destructive color for second action
  final bool secondDestructive;

  /// only second action
  final bool okType;

  const _CupertinoActionDialog({
    required this.title,
    required this.content,
    this.firstTitle,
    this.secondTitle,
    this.firstAction,
    this.secondAction,
    this.firstLoading = false,
    this.secondLoading = false,
    this.firstDestructive = false,
    this.secondDestructive = true,
    this.okType = false,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: title == null
          ? null
          : Text(
              title ?? '',
            ),
      content: content,
      actions: [
        if (!okType)
          CupertinoDialogAction(
            isDestructiveAction: firstDestructive,
            onPressed: firstLoading ? null : firstAction,
            child: Text(
              firstTitle ?? AuthLocalizations.labelsOf(context).cancel,
            ),
          ),
        CupertinoDialogAction(
          isDestructiveAction: secondDestructive,
          onPressed: secondLoading ? null : secondAction,
          child: Text(
            secondTitle ?? AuthLocalizations.labelsOf(context).confirm,
          ),
        ),
      ],
    );
  }
}

/// Default material style action dialog [StatelessWidget]
class _MaterialActionDialog extends StatelessWidget {
  /// dialog title [String]
  final String? title;

  /// dialog content [Widget]
  final Widget? content;

  /// first action title
  final String? firstTitle;

  /// second action title
  final String? secondTitle;

  /// first action void Function()
  final VoidCallback? firstAction;

  /// second action void Function()
  final VoidCallback? secondAction;

  /// blocks the first action
  final bool firstLoading;

  /// blocks the second action
  final bool secondLoading;

  /// use destructive color for first action
  final bool firstDestructive;

  /// use destructive color for second action
  final bool secondDestructive;

  /// only second action
  final bool okType;

  const _MaterialActionDialog({
    required this.title,
    required this.content,
    this.firstTitle,
    this.secondTitle,
    this.firstAction,
    this.secondAction,
    this.firstLoading = false,
    this.secondLoading = false,
    this.firstDestructive = false,
    this.secondDestructive = true,
    this.okType = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title == null
          ? null
          : Center(
              child: Text(title ?? ''),
            ),
      contentPadding: const EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: 12,
      ),
      content: content,
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actionsPadding: const EdgeInsets.only(
        bottom: 12,
      ),
      actions: [
        if (!okType)
          TextButton(
            style: _materialStyle(
              context: context,
              isDestructive: firstDestructive,
            ),
            onPressed: firstLoading ? null : firstAction,
            child: Text(
              firstTitle ?? AuthLocalizations.labelsOf(context).cancel,
            ),
          ),
        TextButton(
          style: _materialStyle(
            context: context,
            isDestructive: secondDestructive,
          ),
          onPressed: secondLoading ? null : secondAction,
          child: Text(
            secondTitle ?? AuthLocalizations.labelsOf(context).confirm,
          ),
        ),
      ],
    );
  }

  ButtonStyle? _materialStyle({
    required final BuildContext context,
    required final bool isDestructive,
  }) {
    return isDestructive
        ? Theme.of(context).textButtonTheme.style?.copyWith(
              overlayColor: MaterialStateProperty.all<Color>(
                Colors.red.withOpacity(.08),
              ),
              foregroundColor: MaterialStateProperty.all<Color>(
                Colors.red,
              ),
            )
        : null;
  }
}
