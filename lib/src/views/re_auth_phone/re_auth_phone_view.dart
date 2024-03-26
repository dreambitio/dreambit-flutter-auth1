part of '../../../one_day_auth.dart';

/// Reauthorization with a phone code view builder with state listener (code field).
/// States: [ReAuthPhoneCodeInitial], [ReAuthPhoneCodeWebContextCancelled],
/// [ReAuthPhoneCodeAwaiting], [ReAuthPhoneCodeLoading], [ReAuthPhoneCodeCompleted],
/// [ReAuthPhoneCodeException], [OneDayAuthException]
class ReAuthPhoneCodeView extends StatelessWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [ReAuthPhoneCodeBuilder] builder
  final ReAuthPhoneCodeBuilder builder;

  const ReAuthPhoneCodeView({
    required this.listener,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReAuthPhoneCodeController>(
      create: (BuildContext context) => ReAuthPhoneCodeController(),
      child: _ReAuthPhoneView(
        listener: listener,
        builder: builder,
      ),
    );
  }
}

class _ReAuthPhoneView extends StatefulWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [ReAuthPhoneCodeBuilder] builder
  final ReAuthPhoneCodeBuilder builder;

  const _ReAuthPhoneView({
    required this.listener,
    required this.builder,
  });

  @override
  State<_ReAuthPhoneView> createState() => _ReAuthPhoneViewState();
}

class _ReAuthPhoneViewState extends State<_ReAuthPhoneView> {
  late final ReAuthPhoneCodeController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<ReAuthPhoneCodeController>();
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
    return Consumer<ReAuthPhoneCodeController>(
      builder: (context, controller, child) {
        return widget.builder(
          context: context,
          state: controller.state,
          isLoading: controller.state is ReAuthPhoneCodeLoading,
          codeAwaiting: controller.state is ReAuthPhoneCodeAwaiting,
          setInitialState: controller.setInitialState,
          reAuth: controller.reAuth,
          exception: AuthExceptions.getAuthException(controller.state),
        );
      },
    );
  }
}
