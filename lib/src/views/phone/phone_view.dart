part of '../../../one_day_auth.dart';

/// Phone authorization view builder with state listener (only phone field).
/// States: [PhoneInitial], [PhoneLoading], [PhoneCodeSent], [OneDayAuthException]
class PhoneView extends StatelessWidget {
  /// [OneDayAuthState] and [AuthActions] listener
  final void Function(OneDayAuthState state, AuthActions action)? listener;

  /// [PhoneBuilder] builder
  final PhoneBuilder builder;

  /// [AuthActions] initial
  final AuthActions initialAuthAction;

  const PhoneView({
    required this.listener,
    required this.builder,
    this.initialAuthAction = AuthActions.signIn,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PhoneController>(
      create: (BuildContext context) => PhoneController(initialAuthAction),
      child: _PhoneView(
        listener: listener,
        builder: builder,
      ),
    );
  }
}

class _PhoneView extends StatefulWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state, AuthActions action)? listener;

  /// [PhoneBuilder] builder
  final PhoneBuilder builder;

  const _PhoneView({
    required this.listener,
    required this.builder,
  });

  @override
  State<_PhoneView> createState() => _PhoneViewState();
}

class _PhoneViewState extends State<_PhoneView> {
  late final PhoneController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<PhoneController>();
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
    return Consumer<PhoneController>(
      builder: (context, controller, child) {
        return widget.builder(
          context: context,
          action: controller.action,
          state: controller.state,
          isLoading: controller.state is PhoneLoading,
          changeAction: controller.changeAction,
          sendCode: controller.sendCode,
          exception: AuthExceptions.getAuthException(controller.state),
        );
      },
    );
  }
}
