part of '../../../one_day_auth.dart';

/// Email password authorization view builder with state listener.
/// States: [EmailPasswordInitial], [EmailPasswordLoading],
/// [EmailPasswordSignedUp], [EmailPasswordSignedIn], [OneDayAuthException]
class EmailPasswordView extends StatelessWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [EmailPasswordBuilder] builder
  final EmailPasswordBuilder builder;

  /// [AuthActions] initial
  final AuthActions initialAuthAction;

  const EmailPasswordView({
    required this.listener,
    required this.builder,
    this.initialAuthAction = AuthActions.signIn,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EmailPasswordController>(
      create: (BuildContext context) => EmailPasswordController(
        initialAuthAction,
      ),
      child: _EmailPasswordView(
        listener: listener,
        builder: builder,
      ),
    );
  }
}

class _EmailPasswordView extends StatefulWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [EmailPasswordBuilder] builder
  final EmailPasswordBuilder builder;

  const _EmailPasswordView({
    required this.listener,
    required this.builder,
  });

  @override
  State<_EmailPasswordView> createState() => _EmailPasswordViewState();
}

class _EmailPasswordViewState extends State<_EmailPasswordView> {
  late final EmailPasswordController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<EmailPasswordController>();
    controller.addListener(_listener);
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(_listener);
  }

  void _listener() {
    if (controller.oldState != controller.state) {
      widget.listener?.call(controller.state);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EmailPasswordController>(
      builder: (context, controller, child) {
        return widget.builder(
          context: context,
          action: controller.action,
          state: controller.state,
          isLoading: controller.state is EmailPasswordLoading,
          changeAction: controller.changeAction,
          onSubmit: controller.action == AuthActions.signUp
              ? controller.signUp
              : controller.signIn,
          exception: AuthExceptions.getAuthException(controller.state),
        );
      },
    );
  }
}
