part of '../../../../one_day_auth.dart';

/// Microsoft sign in view builder with state listener.
/// States: [OAuthInitial], [OAuthLoading], [OAuthAuthorized], [OneDayAuthException]
class MicrosoftSignInView extends StatelessWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [OAuthBuilder] builder
  final OAuthBuilder builder;

  const MicrosoftSignInView({
    required this.listener,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MicrosoftSignInController>(
      create: (BuildContext context) => MicrosoftSignInController(),
      child: _MicrosoftSignInView(
        listener: listener,
        builder: builder,
      ),
    );
  }
}

class _MicrosoftSignInView extends StatefulWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [OAuthBuilder] builder
  final OAuthBuilder builder;

  const _MicrosoftSignInView({
    required this.listener,
    required this.builder,
  });

  @override
  State<_MicrosoftSignInView> createState() => _MicrosoftSignInViewState();
}

class _MicrosoftSignInViewState extends State<_MicrosoftSignInView> {
  late final MicrosoftSignInController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<MicrosoftSignInController>();
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
    return Consumer<MicrosoftSignInController>(
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
