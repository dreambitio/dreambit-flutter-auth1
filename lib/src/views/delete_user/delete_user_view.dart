part of '../../../one_day_auth.dart';

/// Delete user view builder with state listener.
/// States: [DeleteUserInitial], [DeleteUserReAuthAwaiting],
/// [DeleteUserLoading], [OneDayAuthException]
class DeleteUserView extends StatelessWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [DeleteUserBuilder] builder
  final DeleteUserBuilder builder;

  /// [Function] before deletion
  final AuthActionCallback preDeleteAction;

  /// [Function] after deletion
  final FutureVoidCallback? afterDeleteAction;

  /// default confirmation dialog (show cancel/yes action dialog)
  final bool useConfirmDialog;

  /// default re auth case (show password/code confirmation dialog)
  final bool useDefaultReAuth;

  /// use only material style for default confirmation dialogs
  final bool useMaterialStyleDefaultDialog;

  /// styles for material fields
  final InputDecorationTheme? materialFieldStyleDefaultDialog;

  /// password validator for confirmation dialog
  final String? Function(String? password)? passwordValidatorDefaultDialog;

  /// code validator for confirmation dialog
  final String? Function(String? code)? codeValidatorDefaultDialog;

  /// password input formatters
  final List<TextInputFormatter>? passwordFormattersDefaultDialog;

  /// code input formatters
  final List<TextInputFormatter>? codeFormattersDefaultDialog;

  /// Facebook app id
  final String? facebookAppId;

  /// Google web client id
  final String? googleWebClientId;

  const DeleteUserView({
    required this.listener,
    required this.builder,
    this.preDeleteAction,
    this.afterDeleteAction,
    this.useConfirmDialog = true,
    this.useDefaultReAuth = true,
    this.useMaterialStyleDefaultDialog = false,
    this.materialFieldStyleDefaultDialog,
    this.passwordValidatorDefaultDialog,
    this.codeValidatorDefaultDialog,
    this.passwordFormattersDefaultDialog,
    this.codeFormattersDefaultDialog,
    this.facebookAppId,
    this.googleWebClientId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DeleteUserController>(
      create: (BuildContext context) => DeleteUserController(),
      child: _DeleteUserView(
        listener: listener,
        builder: builder,
        preDeleteAction: preDeleteAction,
        afterDeleteAction: afterDeleteAction,
        useConfirmDialog: useConfirmDialog,
        useDefaultReAuth: useDefaultReAuth,
        useMaterialStyleDefaultDialog: useMaterialStyleDefaultDialog,
        materialFieldStyleDefaultDialog: materialFieldStyleDefaultDialog,
        passwordValidatorDefaultDialog: passwordValidatorDefaultDialog,
        codeValidatorDefaultDialog: codeValidatorDefaultDialog,
        passwordFormattersDefaultDialog: passwordFormattersDefaultDialog,
        codeFormattersDefaultDialog: codeFormattersDefaultDialog,
        facebookAppId: facebookAppId,
        googleWebClientId: googleWebClientId,
      ),
    );
  }
}

class _DeleteUserView extends StatefulWidget {
  /// [OneDayAuthState] listener
  final void Function(OneDayAuthState state)? listener;

  /// [DeleteUserBuilder] builder
  final DeleteUserBuilder builder;

  /// [Function] before deletion
  final AuthActionCallback preDeleteAction;

  /// [Function] after deletion
  final FutureVoidCallback? afterDeleteAction;

  /// default confirmation dialog (show cancel/yes action dialog)
  final bool useConfirmDialog;

  /// default re auth case (show password/code confirmation dialog)
  final bool useDefaultReAuth;

  /// use only material style for default confirmation dialogs
  final bool useMaterialStyleDefaultDialog;

  /// styles for material fields
  final InputDecorationTheme? materialFieldStyleDefaultDialog;

  /// password validator for confirmation dialog
  final String? Function(String? password)? passwordValidatorDefaultDialog;

  /// code validator for confirmation dialog
  final String? Function(String? code)? codeValidatorDefaultDialog;

  /// password input formatters
  final List<TextInputFormatter>? passwordFormattersDefaultDialog;

  /// code input formatters
  final List<TextInputFormatter>? codeFormattersDefaultDialog;

  /// Facebook app id
  final String? facebookAppId;

  /// Google web client id
  final String? googleWebClientId;

  const _DeleteUserView({
    required this.listener,
    required this.builder,
    required this.preDeleteAction,
    required this.afterDeleteAction,
    required this.useConfirmDialog,
    required this.useDefaultReAuth,
    required this.useMaterialStyleDefaultDialog,
    required this.materialFieldStyleDefaultDialog,
    required this.passwordValidatorDefaultDialog,
    required this.codeValidatorDefaultDialog,
    required this.passwordFormattersDefaultDialog,
    required this.codeFormattersDefaultDialog,
    required this.facebookAppId,
    required this.googleWebClientId,
  });

  @override
  State<_DeleteUserView> createState() => _DeleteUserViewState();
}

class _DeleteUserViewState extends State<_DeleteUserView> {
  late final DeleteUserController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<DeleteUserController>();
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

  Future<void> _delete() async {
    bool res = true;
    if (widget.useConfirmDialog) {
      res = await AuthDialogs.showDefaultActionDialog(
        context: context,
        title: AuthLocalizations.labelsOf(context).deleteAccountQ,
        subtitle: AuthLocalizations.labelsOf(context).deleteAccountDescription,
      );
    }
    if (res) {
      if (widget.useDefaultReAuth) {
        controller.setAwaiting();
        if (!context.mounted) return;
        final BuildContext ctx = context;
        final AuthEnums providerType = FirebaseAuthService
                .instance.currentUser?.providerData
                .getAuthProvider() ??
            AuthEnums.undefined;
        switch (providerType) {
          case AuthEnums.password:
            res = await AuthDialogs.showReAuthPasswordDialog(
              context: ctx,
              inputFormatters: widget.passwordFormattersDefaultDialog,
              passwordValidator: widget.passwordValidatorDefaultDialog,
              materialFieldStyle: widget.materialFieldStyleDefaultDialog,
              useMaterialStyle: widget.useMaterialStyleDefaultDialog,
            );
            break;
          case AuthEnums.phone:
            res = await AuthDialogs.showReAuthPhoneCodeDialog(
              context: ctx,
              inputFormatters: widget.codeFormattersDefaultDialog,
              codeValidator: widget.codeValidatorDefaultDialog,
              materialFieldStyle: widget.materialFieldStyleDefaultDialog,
              useMaterialStyle: widget.useMaterialStyleDefaultDialog,
            );
            break;
          case AuthEnums.google:
            final reAuth = await FirebaseAuthService.instance.googleSignIn(
              webClientId: widget.googleWebClientId,
              action: AuthenticateActions.reAuthenticate,
            );
            reAuth.fold(
              (l) => res = false,
              (r) => res = true,
            );
            res = true;
            break;
          case AuthEnums.facebook:
            if (widget.facebookAppId == null) break;
            final reAuth = await FirebaseAuthService.instance.facebookSignIn(
              appId: widget.facebookAppId!,
              action: AuthenticateActions.reAuthenticate,
            );
            reAuth.fold(
              (l) => res = false,
              (r) => res = true,
            );
            res = true;
            break;
          case AuthEnums.apple:
          case AuthEnums.github:
          case AuthEnums.twitter:
          case AuthEnums.microsoft:
            final AuthProvider? authProvider = providerType.commonProvider;
            if (authProvider == null) break;
            final reAuth = await FirebaseAuthService.instance.reAuthWithOAuth(
              type: providerType,
              provider: authProvider,
            );
            reAuth.fold(
              (l) => res = false,
              (r) => res = true,
            );
            res = true;
            break;
          default:
            break;
        }
        controller.setInitial();
      }
      if (res) {
        await controller.delete(
          preDeleteAction: widget.preDeleteAction,
          afterDeleteAction: widget.afterDeleteAction,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DeleteUserController>(
      builder: (context, controller, child) {
        return widget.builder(
          context: context,
          state: controller.state,
          setInitial: controller.setInitial,
          setAwaiting: controller.setAwaiting,
          isLoading: controller.state is DeleteUserLoading ||
              controller.state is DeleteUserReAuthAwaiting,
          deleteUser: _delete,
          exception: AuthExceptions.getAuthException(controller.state),
        );
      },
    );
  }
}
