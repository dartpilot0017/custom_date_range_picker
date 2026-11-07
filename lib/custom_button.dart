import 'package:flutter/material.dart';

/// A keyboard-accessible button retained for compatibility.

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? borderWidth;
  final double? borderRadius;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Widget child;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.borderColor,
    this.backgroundColor,
    this.borderWidth,
    this.borderRadius,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: SizedBox(
        width: width,
        height: height,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            minimumSize: const Size(48, 48),
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
            textStyle: textStyle,
            backgroundColor: backgroundColor,
            side: BorderSide(
              color: borderColor ?? Theme.of(context).colorScheme.primary,
              width: borderWidth ?? 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
