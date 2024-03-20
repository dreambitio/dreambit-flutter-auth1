part of '../../../one_day_auth.dart';

/// UI component for Google sign in
class GoogleSignInButton extends StatelessWidget {
  /// Sing in [VoidCallback]
  final VoidCallback? onPressed;

  /// show loader and disable [onPressed]
  final bool isLoading;

  /// button color
  final Color buttonColor;

  final Color borderColor;

  /// title: Continue with Google
  final String? title;

  /// title [TextStyle]
  final TextStyle? titleStyle;

  /// use only material style [Widget]
  final bool useMaterialStyle;

  /// material progress indicator color
  final Color? materialProgressIndicatorColor;

  /// cupertino progress indicator color
  final Color? cupertinoProgressIndicatorColor;

  const GoogleSignInButton({
    required this.onPressed,
    this.isLoading = false,
    this.buttonColor = Colors.white,
    this.borderColor = const Color(0xFF303030),
    this.title,
    this.titleStyle,
    this.useMaterialStyle = false,
    this.cupertinoProgressIndicatorColor,
    this.materialProgressIndicatorColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AuthMainButton(
      color: Colors.white,
      onPressed: onPressed,
      loading: isLoading,
      border: true,
      borderColor: borderColor,
      useMaterialStyle: useMaterialStyle,
      cupertinoProgressIndicatorColor: cupertinoProgressIndicatorColor,
      materialProgressIndicatorColor:
          materialProgressIndicatorColor ?? Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.string(
            AuthStyles.iconGoogle,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 8),
          Text(
            title ?? AuthLocalizations.labelsOf(context).continueWithGoogle,
            style: titleStyle ??
                AuthStyles.mainButtonStyle(
                  size: 16,
                  color: const Color(0xFF303030),
                ),
          ),
        ],
      ),
    );
  }
}
