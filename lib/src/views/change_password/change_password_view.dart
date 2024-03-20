part of '../../../one_day_auth.dart';

/// Change password view builder with state listener.
/// States: [ChangePasswordInitial], [ChangePasswordInvalidCurrentPassword],
/// [ChangePasswordLoading], [ChangePasswordCompleted], [OneDayAuthException]
class ChangePasswordView extends StatelessWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [ChangePasswordBuilder] builder
  final ChangePasswordBuilder builder;

  const ChangePasswordView({
    required this.listener,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangePasswordController>(
      create: (BuildContext context) => ChangePasswordController(),
      child: _ChangePasswordView(
        listener: listener,
        builder: builder,
      ),
    );
  }
}

class _ChangePasswordView extends StatefulWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [ChangePasswordBuilder] builder
  final ChangePasswordBuilder builder;

  const _ChangePasswordView({
    required this.listener,
    required this.builder,
  });

  @override
  State<_ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<_ChangePasswordView> {
  late final ChangePasswordController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<ChangePasswordController>();
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
    return Consumer<ChangePasswordController>(
      builder: (context, controller, child) {
        return widget.builder(
          context: context,
          state: controller.state,
          isLoading: controller.state is ChangePasswordLoading,
          changePassword: controller.changePassword,
          setInitialState: controller.setInitialState,
          exception: AuthExceptions.getAuthException(controller.state),
        );
      },
    );
  }
}
