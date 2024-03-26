part of '../../../one_day_auth.dart';

/// Forgotten password view builder with state listener.
/// States: [ForgottenPasswordInitial], [ForgottenPasswordLoading],
/// [ForgottenPasswordMailSent], [OneDayAuthException]
class ForgottenPasswordView extends StatelessWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [ForgottenPasswordBuilder] builder
  final ForgottenPasswordBuilder builder;

  const ForgottenPasswordView({
    required this.listener,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgottenPasswordController>(
      create: (BuildContext context) => ForgottenPasswordController(),
      child: _ForgottenPasswordView(
        listener: listener,
        builder: builder,
      ),
    );
  }
}

class _ForgottenPasswordView extends StatefulWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [ForgottenPasswordBuilder] builder
  final ForgottenPasswordBuilder builder;

  const _ForgottenPasswordView({
    required this.listener,
    required this.builder,
  });

  @override
  State<_ForgottenPasswordView> createState() => _ForgottenPasswordViewState();
}

class _ForgottenPasswordViewState extends State<_ForgottenPasswordView> {
  late final ForgottenPasswordController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<ForgottenPasswordController>();
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
    return Consumer<ForgottenPasswordController>(
      builder: (context, controller, child) {
        return widget.builder(
          context: context,
          state: controller.state,
          isLoading: controller.state is ForgottenPasswordLoading,
          isMailSent: controller.state is ForgottenPasswordMailSent,
          sendMail: controller.sendMail,
          exception: AuthExceptions.getAuthException(controller.state),
        );
      },
    );
  }
}
