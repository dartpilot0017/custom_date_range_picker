import 'package:flutter/material.dart';

import 'custom_button.dart';

/// Reset and confirm controls for a date range picker.

class ActionButtons extends StatelessWidget {
  final VoidCallback onOutlinePressed;
  final VoidCallback? onFilledPressed;
  final Color? filledColor;
  final Color? outlinedColor;
  final Color? filledButtonBorderColor;
  final Color? outlinedButtonBorderColor;
  final Color? filledButtonBackgroundColor;
  final Color? outlinedButtonBackgroundColor;
  final double? filledButtonWidth;
  final double? outlinedButtonWidth;
  final double? filledButtonHeight;
  final double? outlinedButtonHeight;
  final double? filledButtonBorderRadius;
  final double? outlinedButtonBorderRadius;
  final Widget? filledButtonChild;
  final Widget? outlinedButtonChild;
  final TextStyle? textStyle;
  final String? outlinedButtonText;
  final String? filledButtonText;

  const ActionButtons({
    super.key,
    required this.onOutlinePressed,
    required this.onFilledPressed,
    this.filledColor,
    this.outlinedColor,
    this.filledButtonBackgroundColor,
    this.outlinedButtonBackgroundColor,
    this.filledButtonChild,
    this.outlinedButtonChild,
    this.textStyle,
    this.outlinedButtonText,
    this.filledButtonText,
    this.filledButtonBorderColor,
    this.outlinedButtonBorderColor,
    this.filledButtonWidth,
    this.outlinedButtonWidth,
    this.filledButtonHeight,
    this.outlinedButtonHeight,
    this.filledButtonBorderRadius,
    this.outlinedButtonBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: CustomButton(
              key: const Key('outline_button'),
              height: outlinedButtonHeight,
              width: outlinedButtonWidth,
              borderColor: outlinedButtonBorderColor ??
                  Theme.of(context).colorScheme.primary,
              backgroundColor:
                  outlinedButtonBackgroundColor ?? Colors.transparent,
              borderRadius: outlinedButtonBorderRadius ?? 10,
              onPressed: onOutlinePressed,
              child: outlinedButtonChild ??
                  Center(
                    child: Text(
                      outlinedButtonText ?? 'Reset',
                      style: textStyle ??
                          TextStyle(
                            color: outlinedColor ??
                                Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: CustomButton(
              key: const Key('filled_button'),
              height: filledButtonHeight,
              width: filledButtonWidth,
              borderColor: filledButtonBorderColor ?? Colors.transparent,
              backgroundColor: onFilledPressed == null
                  ? Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.12)
                  : filledButtonBackgroundColor ??
                      Theme.of(context).colorScheme.primary,
              borderRadius: filledButtonBorderRadius ?? 10,
              onPressed: onFilledPressed,
              child: filledButtonChild ??
                  Center(
                    child: Text(
                      filledButtonText ?? 'Done',
                      style: textStyle ??
                          TextStyle(
                            color: onFilledPressed == null
                                ? Theme.of(context).disabledColor
                                : filledColor ??
                                    Theme.of(context).colorScheme.onPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
