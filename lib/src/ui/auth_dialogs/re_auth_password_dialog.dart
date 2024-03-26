part of '../../../one_day_auth.dart';

/// Default re auth with password platform dialog
class ReAuthPasswordDialog extends StatefulWidget {
  /// validator for password field
  final String? Function(String? password)? passwordValidator;

  /// password field formatters
  final List<TextInputFormatter>? inputFormatters;

  /// material field style
  final InputDecorationTheme? materialFieldStyle;

  /// use only material style [Widget]
  final bool useMaterialStyle;

  const ReAuthPasswordDialog({
    this.passwordValidator,
    this.inputFormatters,
    this.materialFieldStyle,
    this.useMaterialStyle = false,
    super.key,
  });

  @override
  State<ReAuthPasswordDialog> createState() => _ReAuthPasswordDialogState();
}

class _ReAuthPasswordDialogState extends State<ReAuthPasswordDialog> {
  late final bool cupertinoStyle;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTC = TextEditingController();

  @override
  void initState() {
    super.initState();
    cupertinoStyle = widget.useMaterialStyle ? false : AuthUtils.isApple;
  }

  @override
  Widget build(BuildContext context) {
    return ReAuthPasswordView(
      listener: (OneDayAuthState state) {
        if (state is OneDayAuthException) {
          if (AuthExceptions.isInvalidCredential(state.exception)) {
            _passwordTC.clear();
            _formKey.currentState?.validate();
          }
        } else if (state is ReAuthPasswordCompleted) {
          Navigator.of(context).pop(true);
        }
      },
      builder: ({
        required BuildContext context,
        required OneDayAuthState state,
        required bool isLoading,
        required Future<void> Function(String password) reAuth,
        required Object? exception,
      }) {
        if (cupertinoStyle) {
          return AuthDialogs.cupertinoActionDialog(
            title: AuthLocalizations.labelsOf(context).deleteAccountQ,
            content: _content(
              context: context,
              state: state,
              isLoading: isLoading,
              reAuth: reAuth,
              exception: exception,
            ),
            secondDestructive: true,
            firstAction: () => Navigator.of(context).pop(false),
            secondAction: () {
              if (!(_formKey.currentState?.validate() ?? false)) return;
              reAuth(_passwordTC.text);
            },
            secondLoading: isLoading,
            firstTitle: AuthLocalizations.labelsOf(context).cancel,
            secondTitle: AuthLocalizations.labelsOf(context).confirm,
          );
        }
        return AuthDialogs.materialActionDialog(
          title: AuthLocalizations.labelsOf(context).deleteAccountQ,
          content: _content(
            context: context,
            state: state,
            isLoading: isLoading,
            reAuth: reAuth,
            exception: exception,
          ),
          secondDestructive: true,
          firstAction: () => Navigator.of(context).pop(false),
          secondAction: () {
            if (!(_formKey.currentState?.validate() ?? false)) return;
            reAuth(_passwordTC.text);
          },
          secondLoading: isLoading,
          firstTitle: AuthLocalizations.labelsOf(context).cancel,
          secondTitle: AuthLocalizations.labelsOf(context).confirm,
        );
      },
    );
  }

  Widget _content({
    required BuildContext context,
    required OneDayAuthState state,
    required bool isLoading,
    required Future<void> Function(String code) reAuth,
    required Object? exception,
  }) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Material(
        color: Colors.transparent,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: cupertinoStyle
                    ? const EdgeInsets.only(
                        bottom: 10,
                      )
                    : const EdgeInsets.only(
                        bottom: 16,
                      ),
                child: Text(
                  AuthLocalizations.labelsOf(context).confirmYourPassword,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              if (cupertinoStyle)
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 40,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CupertinoTextFormFieldRow(
                          autocorrect: false,
                          padding: EdgeInsets.zero,
                          autofocus: true,
                          controller: _passwordTC,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          placeholder:
                              AuthLocalizations.labelsOf(context).password,
                          decoration: AuthStyles.cupertinoFieldStyle(context),
                          inputFormatters: widget.inputFormatters,
                          validator: widget.passwordValidator ??
                              (value) {
                                if (!value.isValidDefaultPassword) {
                                  return AuthLocalizations.labelsOf(context)
                                      .invalidPassword;
                                }
                                return null;
                              },
                        ),
                      ),
                      isLoading
                          ? const Padding(
                              padding: EdgeInsets.only(
                                top: 8,
                                left: 6,
                              ),
                              child: CircularProgressIndicator.adaptive(
                                strokeWidth: 2.8,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                )
              else
                Theme(
                  data: Theme.of(context).copyWith(
                    inputDecorationTheme: widget.materialFieldStyle ??
                        AuthStyles.materialFieldStyle(context),
                  ),
                  child: TextFormField(
                    autocorrect: false,
                    autofocus: true,
                    controller: _passwordTC,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: AuthLocalizations.labelsOf(context).password,
                      suffixIconConstraints: const BoxConstraints(
                        maxWidth: 36,
                        maxHeight: 26,
                      ),
                      suffixIcon: isLoading
                          ? const Padding(
                              padding: EdgeInsets.only(
                                right: 10,
                              ),
                              child: CircularProgressIndicator.adaptive(),
                            )
                          : null,
                    ),
                    inputFormatters: widget.inputFormatters,
                    validator: widget.passwordValidator ??
                        (value) {
                          if (!value.isValidDefaultPassword) {
                            return AuthLocalizations.labelsOf(context)
                                .invalidPassword;
                          }
                          return null;
                        },
                  ),
                ),
              if (state is OneDayAuthException)
                if (!AuthExceptions.isInvalidCredential(state.exception))
                  Text(
                    AuthExceptions.exceptionMessage(
                      context: context,
                      exception: state.exception,
                    ),
                    style: cupertinoStyle
                        ? const TextStyle(
                            color: CupertinoColors.systemRed,
                            fontWeight: FontWeight.w500,
                          )
                        : const TextStyle(
                            color: Colors.red,
                          ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
