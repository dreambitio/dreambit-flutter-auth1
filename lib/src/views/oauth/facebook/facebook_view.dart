part of '../../../../one_day_auth.dart';

/// Facebook sign in view builder with state listener.
/// States: [OAuthInitial], [OAuthLoading], [OAuthAuthorized], [OneDayAuthException]
class FacebookSignInView extends StatelessWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [OAuthBuilder] builder
  final OAuthBuilder builder;

  /// Facebook app id
  final String appId;

  const FacebookSignInView({
    required this.listener,
    required this.builder,
    required this.appId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FacebookSignInController>(
      create: (BuildContext context) => FacebookSignInController(appId),
      child: _FacebookSignInView(
        listener: listener,
        builder: builder,
      ),
    );
  }
}

class _FacebookSignInView extends StatefulWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [OAuthBuilder] builder
  final OAuthBuilder builder;

  const _FacebookSignInView({
    required this.listener,
    required this.builder,
  });

  @override
  State<_FacebookSignInView> createState() => _FacebookSignInViewState();
}

class _FacebookSignInViewState extends State<_FacebookSignInView> {
  late final FacebookSignInController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<FacebookSignInController>();
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
    return Consumer<FacebookSignInController>(
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
