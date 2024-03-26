part of '../../../one_day_auth.dart';

/// Email verification view builder with state listener.
/// States: [EmailVerification], [EmailVerified], [EmailVerificationUnavailable],
/// [EmailVerificationLoading], [EmailVerificationAwaiting],
/// [EmailVerificationCheckAwaiting], [OneDayAuthException]
class EmailVerificationView extends StatelessWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [EmailVerificationBuilder] builder
  final EmailVerificationBuilder builder;

  const EmailVerificationView({
    required this.listener,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EmailVerificationController>(
      create: (BuildContext context) => EmailVerificationController(),
      child: _EmailVerificationView(
        listener: listener,
        builder: builder,
      ),
    );
  }
}

class _EmailVerificationView extends StatefulWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [EmailVerificationBuilder] builder
  final EmailVerificationBuilder builder;

  const _EmailVerificationView({
    required this.listener,
    required this.builder,
  });

  @override
  State<_EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<_EmailVerificationView> {
  late final EmailVerificationController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<EmailVerificationController>();
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
    return Consumer<EmailVerificationController>(
      builder: (context, controller, child) {
        return widget.builder(
          context: context,
          state: controller.state,
          isLoading: controller.state is EmailVerificationLoading,
          sendMail: controller.sendMail,
          checkVerification: controller.checkVerification,
          exception: AuthExceptions.getAuthException(controller.state),
        );
      },
    );
  }
}
