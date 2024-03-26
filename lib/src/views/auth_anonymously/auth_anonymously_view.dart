part of '../../../../one_day_auth.dart';

/// Anonymously sign in view builder with state listener.
/// States: [AuthAnonymouslyInitial], [AuthAnonymouslyLoading],
/// [AuthAnonymouslyAuthorized], [OneDayAuthException]
class AuthAnonymouslyView extends StatelessWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [AuthAnonymouslyBuilder] builder
  final AuthAnonymouslyBuilder builder;

  const AuthAnonymouslyView({
    required this.listener,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthAnonymouslyController>(
      create: (BuildContext context) => AuthAnonymouslyController(),
      child: _AuthAnonymouslyView(
        listener: listener,
        builder: builder,
      ),
    );
  }
}

class _AuthAnonymouslyView extends StatefulWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [AuthAnonymouslyBuilder] builder
  final AuthAnonymouslyBuilder builder;

  const _AuthAnonymouslyView({
    required this.listener,
    required this.builder,
  });

  @override
  State<_AuthAnonymouslyView> createState() => _AuthAnonymouslyViewState();
}

class _AuthAnonymouslyViewState extends State<_AuthAnonymouslyView> {
  late final AuthAnonymouslyController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<AuthAnonymouslyController>();
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
    return Consumer<AuthAnonymouslyController>(
      builder: (context, controller, child) {
        return widget.builder(
          context: context,
          state: controller.state,
          isLoading: controller.state is AuthAnonymouslyLoading,
          signIn: controller.signIn,
          exception: AuthExceptions.getAuthException(controller.state),
        );
      },
    );
  }
}
