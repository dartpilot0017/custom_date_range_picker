part of 'custom_date_range_picker.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onOutlinePressed;
  final VoidCallback onFilledPressed;
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
              height: outlinedButtonHeight ?? 40,
              width: outlinedButtonWidth,
              borderColor: outlinedButtonBorderColor ?? const Color(0xFFFF7622),
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
                            color: const Color(0xFFFF7622),
                            fontSize: size * 16,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
            ),
          ),
          SizedBox(width: 8), // Add some spacing between the buttons
          Flexible(
            child: CustomButton(
              key: const Key('filled_button'),
              height: filledButtonHeight ?? 40,
              width: filledButtonWidth,
              borderColor: filledButtonBorderColor ?? Colors.transparent,
              backgroundColor:
                  filledButtonBackgroundColor ?? const Color(0xFFFF7622),
              borderRadius: filledButtonBorderRadius ?? 10,
              onPressed: onFilledPressed,
              child: filledButtonChild ??
                  Center(
                    child: Text(
                      filledButtonText ?? 'Done',
                      style: textStyle ??
                          TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontSize: size * 16,
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
