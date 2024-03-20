part of '../../../one_day_auth.dart';

/// Main UI component for sign in buttons
class AuthMainButton extends StatelessWidget {
  /// on pressed button
  final VoidCallback? onPressed;

  /// use button height
  final bool useWidth;

  /// use button width
  final bool useHeight;

  /// button width
  final double width;

  /// button height
  final double height;

  /// button border radius
  final double borderRadius;

  /// button color
  final Color? color;

  /// child [Widget]
  final Widget? child;

  /// title
  final String? title;

  /// title text style
  final TextStyle? titleStyle;

  /// title size
  final double titleSize;

  /// title font weight
  final FontWeight titleFontWeight;

  /// title color
  final Color titleColor;

  /// is loading
  final bool loading;

  /// material & cupertino progress indicator color
  final Color? progressIndicatorColor;

  /// material progress indicator color
  final Color? materialProgressIndicatorColor;

  /// cupertino progress indicator color
  final Color? cupertinoProgressIndicatorColor;

  /// use button border
  final bool border;

  /// button border color
  final Color? borderColor;

  /// cupertino style pressed opacity
  final double pressedOpacity;

  /// use only material style [Widget]
  final bool useMaterialStyle;

  const AuthMainButton({
    required this.onPressed,
    this.useWidth = true,
    this.useHeight = true,
    this.width = double.infinity,
    this.height = 48,
    this.borderRadius = 8,
    this.color,
    this.child,
    this.title,
    this.titleStyle,
    this.titleSize = 18,
    this.titleFontWeight = FontWeight.w600,
    this.titleColor = Colors.white,
    this.loading = false,
    this.progressIndicatorColor,
    this.materialProgressIndicatorColor,
    this.cupertinoProgressIndicatorColor,
    this.border = false,
    this.borderColor,
    this.pressedOpacity = .6,
    this.useMaterialStyle = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool cupertinoStyle = useMaterialStyle ? false : AuthUtils.isApple;
    return SizedBox(
      width: useWidth ? width : null,
      height: useHeight ? height : null,
      child: cupertinoStyle ? _cupertino(context) : _material(context),
    );
  }

  Widget _material(final BuildContext context) {
    return MaterialButton(
      color: color ?? Theme.of(context).primaryColor,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      highlightElevation: 0,
      disabledColor: (color ?? Theme.of(context).primaryColor).withOpacity(.3),
      shape: RoundedRectangleBorder(
        side: border
            ? BorderSide(
                color: borderColor ?? Theme.of(context).dividerColor,
              )
            : BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      onPressed: loading ? null : onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 8,
        ),
        child: loading
            ? AuthButtonLoader(
                color: materialProgressIndicatorColor ?? progressIndicatorColor,
                buttonHeight: useHeight ? height : null,
                useMaterialStyle: useMaterialStyle,
              )
            : child ??
                Text(
                  title ?? '',
                  textAlign: TextAlign.center,
                  style: titleStyle ??
                      AuthStyles.mainButtonStyle(
                        size: titleSize,
                        color: titleColor,
                      ),
                ),
      ),
    );
  }

  Widget _cupertino(final BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 14,
      color: color ?? Theme.of(context).primaryColor,
      disabledColor: (color ?? Theme.of(context).primaryColor).withOpacity(.3),
      onPressed: loading ? null : onPressed,
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      pressedOpacity: pressedOpacity,
      child: SizedBox(
        height: useHeight ? height : null,
        child: DecoratedBox(
          decoration: border
              ? BoxDecoration(
                  border: Border.all(
                    color: borderColor ?? Theme.of(context).dividerColor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                )
              : const BoxDecoration(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 14,
              ),
              child: loading
                  ? AuthButtonLoader(
                      color: cupertinoProgressIndicatorColor ??
                          progressIndicatorColor,
                      buttonHeight: useHeight ? height : null,
                      useMaterialStyle: useMaterialStyle,
                    )
                  : child ??
                      Text(
                        title ?? '',
                        textAlign: TextAlign.center,
                        style: titleStyle ??
                            AuthStyles.mainButtonStyle(
                              size: titleSize,
                              color: titleColor,
                            ),
                      ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Button content loader
class AuthButtonLoader extends StatelessWidget {
  final double? buttonHeight;
  final double divide;
  final double strokeWidth;
  final Color? color;
  final bool useMaterialStyle;

  const AuthButtonLoader({
    this.buttonHeight,
    this.divide = 1.6,
    this.strokeWidth = 2.8,
    this.color,
    required this.useMaterialStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool cupertinoStyle = useMaterialStyle ? false : AuthUtils.isApple;
    return SizedBox(
      width: buttonHeight == null ? null : buttonHeight! / divide,
      height: buttonHeight == null ? null : buttonHeight! / divide,
      child: Center(
        child: cupertinoStyle
            ? CircularProgressIndicator.adaptive(
                strokeWidth: strokeWidth,
                backgroundColor: cupertinoStyle ? color : null,
                valueColor: color == null
                    ? null
                    : AlwaysStoppedAnimation<Color>(
                        color!,
                      ),
              )
            : CircularProgressIndicator(
                strokeWidth: strokeWidth,
                valueColor: color == null
                    ? null
                    : AlwaysStoppedAnimation<Color>(
                        color!,
                      ),
              ),
      ),
    );
  }
}
