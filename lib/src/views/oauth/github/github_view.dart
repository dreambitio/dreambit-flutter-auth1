part of '../../../../one_day_auth.dart';

/// GitHub sign in view builder with state listener.
/// States: [OAuthInitial], [OAuthLoading], [OAuthAuthorized], [OneDayAuthException]
class GitHubSignInView extends StatelessWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [OAuthBuilder] builder
  final OAuthBuilder builder;

  const GitHubSignInView({
    required this.listener,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GitHubSignInController>(
      create: (BuildContext context) => GitHubSignInController(),
      child: _GitHubSignInView(
        listener: listener,
        builder: builder,
      ),
    );
  }
}

class _GitHubSignInView extends StatefulWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [OAuthBuilder] builder
  final OAuthBuilder builder;

  const _GitHubSignInView({
    required this.listener,
    required this.builder,
  });

  @override
  State<_GitHubSignInView> createState() => _GitHubSignInViewState();
}

class _GitHubSignInViewState extends State<_GitHubSignInView> {
  late final GitHubSignInController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<GitHubSignInController>();
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
    return Consumer<GitHubSignInController>(
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
