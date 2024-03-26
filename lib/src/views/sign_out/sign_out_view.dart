part of '../../../one_day_auth.dart';

/// Sign out view builder with state listener.
/// States: [SignOutInitial], [SignOutLoading], [OneDayAuthException]
class SignOutView extends StatelessWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [SignOutBuilder] builder
  final SignOutBuilder builder;

  /// [Function] before sign out
  final AuthActionCallback preSignOutAction;

  /// [Function] after sign out
  final FutureVoidCallback? afterSignOutAction;

  /// default confirmation dialog (show cancel/yes action dialog)
  final bool useConfirmDialog;

  /// use only material style for default confirmation dialog
  final bool useMaterialStyleDefaultDialog;

  const SignOutView({
    required this.listener,
    required this.builder,
    this.preSignOutAction,
    this.afterSignOutAction,
    this.useConfirmDialog = true,
    this.useMaterialStyleDefaultDialog = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignOutController>(
      create: (BuildContext context) => SignOutController(),
      child: _SignOutView(
        listener: listener,
        builder: builder,
        preSignOutAction: preSignOutAction,
        afterSignOutAction: afterSignOutAction,
        useConfirmDialog: useConfirmDialog,
        useMaterialStyleDefaultDialog: useMaterialStyleDefaultDialog,
      ),
    );
  }
}

class _SignOutView extends StatefulWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [SignOutBuilder] builder
  final SignOutBuilder builder;

  /// [Function] before sign out
  final AuthActionCallback preSignOutAction;

  /// [Function] after sign out
  final FutureVoidCallback? afterSignOutAction;

  /// default confirmation dialog (show cancel/yes action dialog)
  final bool useConfirmDialog;

  /// use only material style for default confirmation dialog
  final bool useMaterialStyleDefaultDialog;

  const _SignOutView({
    required this.listener,
    required this.builder,
    required this.preSignOutAction,
    required this.afterSignOutAction,
    required this.useConfirmDialog,
    required this.useMaterialStyleDefaultDialog,
  });

  @override
  State<_SignOutView> createState() => _SignOutViewState();
}

class _SignOutViewState extends State<_SignOutView> {
  late final SignOutController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<SignOutController>();
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

  Future<void> _signOut() async {
    bool res = true;
    if (widget.useConfirmDialog) {
      res = await AuthDialogs.showDefaultActionDialog(
        context: context,
        title: AuthLocalizations.labelsOf(context).signOutQ,
        subtitle: AuthLocalizations.labelsOf(context).signOutDescription,
        useMaterialStyle: widget.useMaterialStyleDefaultDialog,
      );
    }
    if (res)
      await controller.signOut(
        preSignOutAction: widget.preSignOutAction,
        afterSignOutAction: widget.afterSignOutAction,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignOutController>(
      builder: (context, controller, child) {
        return widget.builder(
          context: context,
          state: controller.state,
          isLoading: controller.state is SignOutLoading,
          signOut: _signOut,
          exception: AuthExceptions.getAuthException(controller.state),
        );
      },
    );
  }
}
