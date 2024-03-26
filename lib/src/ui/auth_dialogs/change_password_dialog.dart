part of '../../../one_day_auth.dart';

/// Default change password action platform dialog
class ChangePasswordDialog extends StatefulWidget {
  /// state listener
  final void Function(OneDayAuthState state)? listener;

  /// validator for password field
  final String? Function(String? password)? passwordValidator;

  /// validator for new password field
  final String? Function(
    String? newPassword,
    String? confirmNewPassword,
  )? newPasswordValidator;

  /// validator for confirm new password field
  final String? Function(
    String? confirmNewPassword,
    String? newPassword,
  )? confirmNewPasswordValidator;

  /// password fields formatters
  final List<TextInputFormatter>? inputFormatters;

  /// material field style
  final InputDecorationTheme? materialFieldStyle;

  /// use only material style [Widget]
  final bool useMaterialStyle;

  const ChangePasswordDialog({
    this.listener,
    this.passwordValidator,
    this.newPasswordValidator,
    this.confirmNewPasswordValidator,
    this.inputFormatters,
    this.materialFieldStyle,
    this.useMaterialStyle = false,
    super.key,
  });

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  late final bool cupertinoStyle;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTC = TextEditingController();
  final TextEditingController _newPasswordTC = TextEditingController();
  final TextEditingController _confirmNewPasswordTC = TextEditingController();

  @override
  void initState() {
    super.initState();
    cupertinoStyle = widget.useMaterialStyle ? false : AuthUtils.isApple;
  }

  @override
  Widget build(BuildContext context) {
    return ChangePasswordView(
      listener: (OneDayAuthState state) {
        if (state is ChangePasswordCompleted) {
          Navigator.of(context).pop();
        }
        widget.listener?.call(state);
      },
      builder: ({
        required BuildContext context,
        required OneDayAuthState state,
        required bool isLoading,
        required ChangePasswordCallback changePassword,
        required VoidCallback setInitialState,
        required Object? exception,
      }) {
        if (cupertinoStyle) {
          return AuthDialogs.cupertinoActionDialog(
            title: AuthLocalizations.labelsOf(context).changePassword,
            content: _content(
              context: context,
              state: state,
              isLoading: isLoading,
              changePassword: changePassword,
              exception: exception,
            ),
            firstDestructive: false,
            secondDestructive: false,
            secondLoading: isLoading,
            firstTitle: AuthLocalizations.labelsOf(context).cancel,
            secondTitle: AuthLocalizations.labelsOf(context).confirm,
            firstAction: Navigator.of(context).pop,
            secondAction: () {
              setInitialState();
              if (!(_formKey.currentState?.validate() ?? false)) return;
              changePassword(
                password: _passwordTC.text,
                newPassword: _newPasswordTC.text,
              );
            },
          );
        }
        return AuthDialogs.materialActionDialog(
          title: AuthLocalizations.labelsOf(context).changePassword,
          content: _content(
            context: context,
            state: state,
            isLoading: isLoading,
            changePassword: changePassword,
            exception: exception,
          ),
          firstDestructive: false,
          secondDestructive: false,
          secondLoading: isLoading,
          firstTitle: AuthLocalizations.labelsOf(context).cancel,
          secondTitle: AuthLocalizations.labelsOf(context).confirm,
          firstAction: Navigator.of(context).pop,
          secondAction: () {
            setInitialState();
            if (!(_formKey.currentState?.validate() ?? false)) return;
            changePassword(
              password: _passwordTC.text,
              newPassword: _newPasswordTC.text,
            );
          },
        );
      },
    );
  }

  Widget _content({
    required BuildContext context,
    required OneDayAuthState state,
    required bool isLoading,
    required ChangePasswordCallback changePassword,
    required Object? exception,
  }) {
    final AuthLocalizationLabels l = AuthLocalizations.labelsOf(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: MediaQuery.sizeOf(context).width,
        minHeight: cupertinoStyle ? 138 : 190,
      ),
      child: Material(
        color: Colors.transparent,
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              Theme(
                data: cupertinoStyle
                    ? Theme.of(context)
                    : Theme.of(context).copyWith(
                        inputDecorationTheme: widget.materialFieldStyle ??
                            AuthStyles.materialFieldStyle(context),
                      ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: cupertinoStyle
                          ? const EdgeInsets.all(8)
                          : const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              bottom: 14,
                            ),
                      child: Center(
                        child: Text(
                          AuthLocalizations.labelsOf(context)
                              .confirmNewPasswordDescription,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    if (cupertinoStyle) ...[
                      CupertinoTextFormFieldRow(
                        padding: EdgeInsets.zero,
                        autofocus: true,
                        controller: _passwordTC,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        placeholder: l.password,
                        decoration: AuthStyles.cupertinoFieldStyle(context),
                        inputFormatters: widget.inputFormatters,
                        validator: widget.passwordValidator ??
                            (value) {
                              if (!value.isValidDefaultPassword) {
                                return l.invalidPassword;
                              }
                              return null;
                            },
                      ),
                      const SizedBox(height: 12),
                      CupertinoTextFormFieldRow(
                        padding: EdgeInsets.zero,
                        controller: _newPasswordTC,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        placeholder: l.newPassword,
                        decoration: AuthStyles.cupertinoFieldStyle(context),
                        inputFormatters: widget.inputFormatters,
                        validator: widget.newPasswordValidator != null
                            ? (newPassword) {
                                return widget.newPasswordValidator?.call(
                                  newPassword,
                                  _confirmNewPasswordTC.text,
                                );
                              }
                            : (value) {
                                if (!value.isValidDefaultPassword) {
                                  return l.invalidPassword;
                                }
                                return null;
                              },
                      ),
                      const SizedBox(height: 12),
                      CupertinoTextFormFieldRow(
                        padding: EdgeInsets.zero,
                        controller: _confirmNewPasswordTC,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        placeholder: l.confirmNewPassword,
                        decoration: AuthStyles.cupertinoFieldStyle(context),
                        inputFormatters: widget.inputFormatters,
                        validator: widget.confirmNewPasswordValidator != null
                            ? (confirmNewPassword) {
                                return widget.confirmNewPasswordValidator?.call(
                                  confirmNewPassword,
                                  _newPasswordTC.text,
                                );
                              }
                            : (value) {
                                if (!value.isValidDefaultPassword ||
                                    value != _newPasswordTC.text) {
                                  return l.invalidPassword;
                                }
                                return null;
                              },
                      ),
                    ] else ...[
                      TextFormField(
                        autofocus: true,
                        controller: _passwordTC,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: l.password,
                        ),
                        inputFormatters: widget.inputFormatters,
                        validator: widget.passwordValidator ??
                            (value) {
                              if (!value.isValidDefaultPassword) {
                                return l.invalidPassword;
                              }
                              return null;
                            },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _newPasswordTC,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: l.newPassword,
                        ),
                        inputFormatters: widget.inputFormatters,
                        validator: widget.newPasswordValidator != null
                            ? (newPassword) {
                                return widget.newPasswordValidator?.call(
                                  newPassword,
                                  _confirmNewPasswordTC.text,
                                );
                              }
                            : (value) {
                                if (!value.isValidDefaultPassword) {
                                  return l.invalidPassword;
                                }
                                return null;
                              },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _confirmNewPasswordTC,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: l.confirmNewPassword,
                        ),
                        inputFormatters: widget.inputFormatters,
                        validator: widget.confirmNewPasswordValidator != null
                            ? (confirmNewPassword) {
                                return widget.confirmNewPasswordValidator?.call(
                                  confirmNewPassword,
                                  _newPasswordTC.text,
                                );
                              }
                            : (value) {
                                if (!value.isValidDefaultPassword ||
                                    value != _newPasswordTC.text) {
                                  return l.invalidPassword;
                                }
                                return null;
                              },
                      ),
                    ],
                    if (state is OneDayAuthException)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          AuthExceptions.exceptionMessage(
                            context: context,
                            exception: state.exception,
                          ),
                          textAlign: TextAlign.start,
                          style: cupertinoStyle
                              ? const TextStyle(
                                  color: CupertinoColors.systemRed,
                                  fontWeight: FontWeight.w500,
                                )
                              : const TextStyle(
                                  color: Colors.red,
                                ),
                        ),
                      ),
                  ],
                ),
              ),
              if (isLoading)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                      ),
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: (Theme.of(context)
                                        .dialogTheme
                                        .backgroundColor ??
                                    Colors.white)
                                .withOpacity(cupertinoStyle ? .84 : 1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.008),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
