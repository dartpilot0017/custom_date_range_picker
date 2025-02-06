part of 'custom_date_range_picker.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
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
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? size * 154,
        height: height ?? size * 40,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? size * 10),
          border: Border.all(
            color: borderColor ?? const Color(0xFFFF7622),
            width: borderWidth ?? size * 1,
          ),
          color: backgroundColor ?? Colors.transparent,
        ),
        child: child
           
      ),
    );
  }
}
