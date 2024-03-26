part of '../../../one_day_auth.dart';

/// Default action (cancel/yes) platform dialog
class DefaultActionDialog extends StatelessWidget {
  /// dialog title [String]
  final String? title;

  /// dialog subtitle [String]
  final String? subtitle;

  /// first action title
  final String? firstTitle;

  /// second action title
  final String? secondTitle;

  /// use destructive color for first action
  final bool firstDestructive;

  /// use destructive color for second action
  final bool secondDestructive;

  /// only second action
  final bool okType;

  /// use only material style [Widget]
  final bool useMaterialStyle;

  const DefaultActionDialog({
    this.title,
    this.subtitle,
    this.firstTitle,
    this.secondTitle,
    this.firstDestructive = false,
    this.secondDestructive = true,
    this.okType = false,
    this.useMaterialStyle = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool cupertinoStyle = useMaterialStyle ? false : AuthUtils.isApple;
    if (cupertinoStyle) {
      return AuthDialogs.cupertinoActionDialog(
        title: title,
        content: Text(
          subtitle ?? '',
        ),
        okType: okType,
        firstDestructive: firstDestructive,
        secondDestructive: secondDestructive,
        firstTitle: firstTitle ?? AuthLocalizations.labelsOf(context).cancel,
        secondTitle: secondTitle ?? AuthLocalizations.labelsOf(context).yes,
        firstAction: () => Navigator.of(context).pop(false),
        secondAction: () => Navigator.of(context).pop(true),
      );
    }
    return AuthDialogs.materialActionDialog(
      title: title,
      content: Padding(
        padding: const EdgeInsets.only(
          bottom: 12,
        ),
        child: Text(
          subtitle ?? '',
        ),
      ),
      okType: okType,
      firstDestructive: firstDestructive,
      secondDestructive: secondDestructive,
      firstTitle: firstTitle ?? AuthLocalizations.labelsOf(context).cancel,
      secondTitle: secondTitle ?? AuthLocalizations.labelsOf(context).yes,
      firstAction: () => Navigator.of(context).pop(false),
      secondAction: () => Navigator.of(context).pop(true),
    );
  }
}
