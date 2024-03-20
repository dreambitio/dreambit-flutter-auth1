part of '../../../one_day_auth.dart';

/// Phone code authorization view builder with state listener (only code field).
/// States: [PhoneCodeInitial], [PhoneCodeLoading], [PhoneCodeException],
/// [PhoneCodeCompleted], [OneDayAuthException]
class PhoneCodeView extends StatelessWidget {
  /// [OneDayAuthState] and [AuthActions] listener
  final void Function(OneDayAuthState state, AuthActions action)? listener;

  /// [PhoneCodeBuilder] builder
  final PhoneCodeBuilder builder;

  /// [CodeSentResult] after phone verification
  final CodeSentResult codeSentResult;

  /// [AuthActions] initial
  final AuthActions initialAuthAction;

  const PhoneCodeView({
    required this.listener,
    required this.builder,
    required this.codeSentResult,
    this.initialAuthAction = AuthActions.signIn,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PhoneCodeController>(
      create: (BuildContext context) => PhoneCodeController(
        PhoneCodeInitial(codeSentResult),
        initialAuthAction,
      ),
      child: _PhoneCodeView(
        listener: listener,
        builder: builder,
        codeSentResult: codeSentResult,
      ),
    );
  }
}

class _PhoneCodeView extends StatefulWidget {
  /// [OneDayAuthState] and [AuthActions] listener
  final void Function(OneDayAuthState state, AuthActions action)? listener;

  /// [PhoneCodeBuilder] builder
  final PhoneCodeBuilder builder;

  /// [CodeSentResult] after phone verification
  final CodeSentResult codeSentResult;

  const _PhoneCodeView({
    required this.listener,
    required this.builder,
    required this.codeSentResult,
  });

  @override
  State<_PhoneCodeView> createState() => _PhoneCodeViewState();
}

class _PhoneCodeViewState extends State<_PhoneCodeView> {
  late final PhoneCodeController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<PhoneCodeController>();
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
    return Consumer<PhoneCodeController>(
      builder: (context, controller, child) {
        return widget.builder(
          context: context,
          state: controller.state,
          action: controller.action,
          codeSentResult: controller.codeSentResult ?? widget.codeSentResult,
          isLoading: controller.state is PhoneCodeLoading,
          confirm: controller.confirm,
          sendCode: controller.sendCode,
          exception: AuthExceptions.getAuthException(controller.state),
        );
      },
    );
  }
}
