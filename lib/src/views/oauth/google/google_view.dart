part of '../../../../one_day_auth.dart';

/// Google sign in view builder with state listener.
/// States: [OAuthInitial], [OAuthLoading], [OAuthAuthorized], [OneDayAuthException]
class GoogleSignInView extends StatelessWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [OAuthBuilder] builder
  final OAuthBuilder builder;

  /// Google web client id
  final String? webClientId;

  const GoogleSignInView({
    required this.listener,
    required this.builder,
    this.webClientId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GoogleSignInController>(
      create: (BuildContext context) => GoogleSignInController(webClientId),
      child: _GoogleSignInView(
        listener: listener,
        builder: builder,
      ),
    );
  }
}

class _GoogleSignInView extends StatefulWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [OAuthBuilder] builder
  final OAuthBuilder builder;

  const _GoogleSignInView({
    required this.listener,
    required this.builder,
  });

  @override
  State<_GoogleSignInView> createState() => _GoogleSignInViewState();
}

class _GoogleSignInViewState extends State<_GoogleSignInView> {
  late final GoogleSignInController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<GoogleSignInController>();
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
    return Consumer<GoogleSignInController>(
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
