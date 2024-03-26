part of '../../../one_day_auth.dart';

/// Default re auth with phone code platform dialog
class ReAuthPhoneCodeDialog extends StatefulWidget {
  /// code field validator
  final String? Function(String? code)? codeValidator;

  /// code field formatters
  final List<TextInputFormatter>? inputFormatters;

  /// material field style
  final InputDecorationTheme? materialFieldStyle;

  /// use only material style [Widget]
  final bool useMaterialStyle;

  const ReAuthPhoneCodeDialog({
    this.codeValidator,
    this.inputFormatters,
    this.materialFieldStyle,
    this.useMaterialStyle = false,
    super.key,
  });

  @override
  State<ReAuthPhoneCodeDialog> createState() => _ReAuthPhoneCodeDialogState();
}

class _ReAuthPhoneCodeDialogState extends State<ReAuthPhoneCodeDialog> {
  late final bool cupertinoStyle;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _codeTC = TextEditingController();

  @override
  void initState() {
    super.initState();
    cupertinoStyle = widget.useMaterialStyle ? false : AuthUtils.isApple;
  }

  @override
  Widget build(BuildContext context) {
    return ReAuthPhoneCodeView(
      listener: (OneDayAuthState state) {
        if (state is OneDayAuthException) {
          if (AuthExceptions.isInvalidCredential(state.exception)) {
            _codeTC.clear();
            _formKey.currentState?.validate();
          }
        } else if (state is ReAuthPhoneCodeCompleted) {
          Navigator.of(context).pop(true);
        } else if (state is ReAuthPhoneCodeWebContextCancelled) {
          Navigator.of(context).pop(false);
        }
      },
      builder: ({
        required BuildContext context,
        required OneDayAuthState state,
        required bool isLoading,
        required bool codeAwaiting,
        required VoidCallback setInitialState,
        required Future<void> Function(String code) reAuth,
        required Object? exception,
      }) {
        if (AuthUtils.isApple) {
          return AuthDialogs.cupertinoActionDialog(
            title: AuthLocalizations.labelsOf(context).deleteAccountQ,
            content: _content(
              context: context,
              state: state,
              codeAwaiting: codeAwaiting,
              isLoading: isLoading,
              reAuth: reAuth,
              exception: exception,
            ),
            secondDestructive: true,
            firstAction: () => Navigator.of(context).pop(false),
            secondAction: () {
              setInitialState();
              if (!(_formKey.currentState?.validate() ?? false)) return;
              reAuth(_codeTC.text);
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
            codeAwaiting: codeAwaiting,
            reAuth: reAuth,
            exception: exception,
          ),
          secondDestructive: true,
          firstAction: () => Navigator.of(context).pop(false),
          secondAction: () {
            setInitialState();
            if (!(_formKey.currentState?.validate() ?? false)) return;
            reAuth(_codeTC.text);
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
    required bool codeAwaiting,
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
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: Text(
                  AuthLocalizations.labelsOf(context).weSentCodeToYourPhone,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              if (AuthUtils.isApple && !codeAwaiting)
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
                          controller: _codeTC,
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          placeholder: AuthLocalizations.labelsOf(context).code,
                          decoration: AuthStyles.cupertinoFieldStyle(context),
                          inputFormatters: widget.inputFormatters ??
                              ServiceRegExp.codeFormatter,
                          validator: widget.codeValidator ??
                              (value) {
                                if (!value.isValidDefaultCode) {
                                  return AuthLocalizations.labelsOf(context)
                                      .invalidCode;
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
              else if (!codeAwaiting)
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 60,
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      inputDecorationTheme: widget.materialFieldStyle ??
                          AuthStyles.materialFieldStyle(context),
                    ),
                    child: TextFormField(
                      autocorrect: false,
                      autofocus: true,
                      controller: _codeTC,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: AuthLocalizations.labelsOf(context).code,
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
                      inputFormatters:
                          widget.inputFormatters ?? ServiceRegExp.codeFormatter,
                      validator: widget.codeValidator ??
                          (value) {
                            if (!value.isValidDefaultCode) {
                              return AuthLocalizations.labelsOf(context)
                                  .invalidCode;
                            }
                            return null;
                          },
                    ),
                  ),
                )
              else
                Center(
                  child: SizedBox(
                    height: AuthUtils.isApple ? 40 : 60,
                    child: const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                ),
              if (state is OneDayAuthException)
                if (!AuthExceptions.isInvalidCredential(state.exception))
                  Text(
                    AuthExceptions.exceptionMessage(
                      context: context,
                      exception: state.exception,
                    ),
                    style: AuthUtils.isApple
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
