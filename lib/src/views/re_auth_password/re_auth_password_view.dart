part of '../../../one_day_auth.dart';

/// Reauthorization with a password view builder with state listener (password field).
/// States: [ReAuthPasswordInitial], [ReAuthPasswordLoading], [ReAuthPasswordCompleted], [OneDayAuthException]
class ReAuthPasswordView extends StatelessWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [ReAuthPasswordBuilder] builder
  final ReAuthPasswordBuilder builder;

  const ReAuthPasswordView({
    required this.listener,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReAuthPasswordController>(
      create: (BuildContext context) => ReAuthPasswordController(),
      child: _ReAuthPasswordView(
        listener: listener,
        builder: builder,
      ),
    );
  }
}

class _ReAuthPasswordView extends StatefulWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [ReAuthPasswordBuilder] builder
  final ReAuthPasswordBuilder builder;

  const _ReAuthPasswordView({
    required this.listener,
    required this.builder,
  });

  @override
  State<_ReAuthPasswordView> createState() => _ReAuthPasswordViewState();
}

class _ReAuthPasswordViewState extends State<_ReAuthPasswordView> {
  late final ReAuthPasswordController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<ReAuthPasswordController>();
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
    return Consumer<ReAuthPasswordController>(
      builder: (context, controller, child) {
        return widget.builder(
          context: context,
          state: controller.state,
          isLoading: controller.state is ReAuthPasswordLoading,
          reAuth: controller.reAuth,
          exception: AuthExceptions.getAuthException(controller.state),
        );
      },
    );
  }
}
