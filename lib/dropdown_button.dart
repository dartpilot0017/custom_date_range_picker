import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart' hide DropdownButton;

/// A styled Material dropdown retained for compatibility.

class DropdownButton extends StatefulWidget {
  final String? hintText;
  final String? value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final Widget? gap;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? backgroundColorOnFocus;
  final double? borderWidth;
  final double? borderRadius;
  final double? width;
  final double? height;
  final double? dropDownListWidth;
  final double? dropDownListHeight;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final TextStyle? dropDownTextStyle;

  const DropdownButton({
    super.key,
    this.hintText,
    this.value,
    required this.items,
    this.onChanged,
    this.gap,
    this.borderColor,
    this.backgroundColor,
    this.backgroundColorOnFocus,
    this.borderWidth,
    this.borderRadius,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.dropDownTextStyle,
    this.dropDownListWidth,
    this.dropDownListHeight,
  });

  @override
  State<DropdownButton> createState() => _DropdownButtonState();
}

class _DropdownButtonState extends State<DropdownButton> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant DropdownButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) _selectedValue = widget.value;
    if (!widget.items.contains(_selectedValue)) _selectedValue = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      constraints: BoxConstraints(minHeight: widget.height ?? 48),
      margin: widget.margin,
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
        border: Border.all(
          color: widget.borderColor ?? Theme.of(context).colorScheme.outline,
          width: widget.borderWidth ?? 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: material.DropdownButton<String>(
          value: widget.items.contains(_selectedValue) ? _selectedValue : null,
          isExpanded: true,
          menuMaxHeight: widget.dropDownListHeight ?? 320,
          menuWidth: widget.dropDownListWidth,
          dropdownColor: widget.backgroundColor,
          focusColor: widget.backgroundColorOnFocus,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          style:
              widget.dropDownTextStyle ?? Theme.of(context).textTheme.bodyLarge,
          hint: Text(widget.hintText ?? 'Select'),
          items: [
            for (final item in widget.items)
              DropdownMenuItem(
                  value: item,
                  child: Text(item, overflow: TextOverflow.ellipsis))
          ],
          onChanged: widget.onChanged == null
              ? null
              : (value) {
                  setState(() => _selectedValue = value);
                  widget.onChanged?.call(value);
                },
        ),
      ),
    );
  }
}
