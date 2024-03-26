part of '../../../../one_day_auth.dart';

/// Apple sign in view builder with state listener.
/// States: [OAuthInitial], [OAuthLoading], [OAuthAuthorized], [OneDayAuthException]
class AppleSignInView extends StatelessWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [OAuthBuilder] builder
  final OAuthBuilder builder;

  const AppleSignInView({
    required this.listener,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppleSignInController>(
      create: (BuildContext context) => AppleSignInController(),
      child: _AppleSignInView(
        listener: listener,
        builder: builder,
      ),
    );
  }
}

class _AppleSignInView extends StatefulWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [OAuthBuilder] builder
  final OAuthBuilder builder;

  const _AppleSignInView({
    required this.listener,
    required this.builder,
  });

  @override
  State<_AppleSignInView> createState() => _AppleSignInViewState();
}

class _AppleSignInViewState extends State<_AppleSignInView> {
  late final AppleSignInController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<AppleSignInController>();
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
    return Consumer<AppleSignInController>(
      builder: (context, controller, child) {
        return widget.builder(
          context: context,
          state: controller.state,
          isLoading: controller.state is OAuthLoading,
          signIn: controller.signIn,
          exception: AuthExceptions.getAuthException(controller.state),
        );
      },
    );
  }
}
