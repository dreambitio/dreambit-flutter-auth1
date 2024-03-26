part of '../../../one_day_auth.dart';

/// Phone with code authorization view builder with state listener (phone and code fields).
/// States: [PhoneCodeInitial], [PhoneLoading], [PhoneCodeSent], [PhoneCodeLoading],
/// [PhoneCodeException], [PhoneCodeCompleted], [OneDayAuthException]
class PhoneWithCodeView extends StatelessWidget {
  /// [OneDayAuthState] and [AuthActions] listener
  final void Function(OneDayAuthState state, AuthActions action)? listener;

  /// [PhoneWithCodeBuilder] builder
  final PhoneWithCodeBuilder builder;

  /// [AuthActions] initial
  final AuthActions initialAuthAction;

  const PhoneWithCodeView({
    required this.listener,
    required this.builder,
    this.initialAuthAction = AuthActions.signIn,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PhoneWithCodeController>(
      create: (BuildContext context) => PhoneWithCodeController(
        initialAuthAction,
      ),
      child: _PhoneWithCodeView(
        listener: listener,
        builder: builder,
      ),
    );
  }
}

class _PhoneWithCodeView extends StatefulWidget {
  /// [OneDayAuthState] and [AuthActions] listener
  final void Function(OneDayAuthState state, AuthActions action)? listener;

  /// [PhoneWithCodeBuilder] builder
  final PhoneWithCodeBuilder builder;

  const _PhoneWithCodeView({
    required this.listener,
    required this.builder,
  });

  @override
  State<_PhoneWithCodeView> createState() => _PhoneWithCodeViewState();
}

class _PhoneWithCodeViewState extends State<_PhoneWithCodeView> {
  late final PhoneWithCodeController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<PhoneWithCodeController>();
    controller.addListener(_listener);
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(_listener);
  }

  void _listener() {
    if (controller.oldState != controller.state) {
      widget.listener?.call(controller.state, controller.action);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PhoneWithCodeController>(
      builder: (context, controller, child) {
        return widget.builder(
          context: context,
          state: controller.state,
          action: controller.action,
          codeSentResult: controller.codeSentResult,
          phoneAwaiting: controller.state is PhoneLoading,
          codeAwaiting: controller.state is PhoneCodeLoading,
          isCodeSent: controller.codeSentResult != null,
          changeAction: controller.changeAction,
          setInitialState: controller.setInitialState,
          sendCode: controller.sendCode,
          confirm: controller.confirm,
          exception: AuthExceptions.getAuthException(controller.state),
        );
      },
    );
  }
}
