part of '../../../../one_day_auth.dart';

/// Twitter sign in view builder with state listener.
/// States: [OAuthInitial], [OAuthLoading], [OAuthAuthorized], [OneDayAuthException]
class TwitterSignInView extends StatelessWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [OAuthBuilder] builder
  final OAuthBuilder builder;

  const TwitterSignInView({
    required this.listener,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TwitterSignInController>(
      create: (BuildContext context) => TwitterSignInController(),
      child: _TwitterSignInView(
        listener: listener,
        builder: builder,
      ),
    );
  }
}

class _TwitterSignInView extends StatefulWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [OAuthBuilder] builder
  final OAuthBuilder builder;

  const _TwitterSignInView({
    required this.listener,
    required this.builder,
  });

  @override
  State<_TwitterSignInView> createState() => _TwitterSignInViewState();
}

class _TwitterSignInViewState extends State<_TwitterSignInView> {
  late final TwitterSignInController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<TwitterSignInController>();
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
    return Consumer<TwitterSignInController>(
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
