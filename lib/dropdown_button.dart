part of 'custom_date_range_picker.dart';

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
  bool _isOpen = false;
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  void _toggleDropdown() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  void _selectItem(String value) {
    setState(() {
      _selectedValue = value;
      _isOpen = false;
    });
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggleDropdown,
          child: Container(
            width: widget.width ?? 154,
            height: widget.height ?? 40,
            margin: widget.margin,
            padding: widget.padding ?? EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
              border: Border.all(
                color: widget.borderColor ?? const Color(0xFFFF7622),
                width: widget.borderWidth ?? 1,
              ),
              color: widget.backgroundColor ?? Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _selectedValue ?? widget.hintText ?? 'Select a value',
                    style: widget.dropDownTextStyle ??
                        TextStyle(
                          color: const Color(0xFF2B3674),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                Icon(
                  _isOpen
                      ? CupertinoIcons.chevron_up
                      : CupertinoIcons.chevron_down,
                  color: const Color(0xFF2B3674),
                  size: 18,
                ),
              ],
            ),
          ),
        ),
        if (_isOpen) widget.gap ?? const SizedBox.shrink(),
        if (_isOpen)
          Container(
            width: widget.dropDownListWidth ?? 154,
            height: widget.dropDownListHeight ?? 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
              border: Border.all(
                color: widget.borderColor ?? const Color(0xFFFF7622),
                width: widget.borderWidth ?? 1,
              ),
              color: widget.backgroundColor ?? Colors.white,
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: widget.items.map((item) {
                return GestureDetector(
                  onTap: () => _selectItem(item),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Text(
                      item,
                      style: widget.dropDownTextStyle ??
                          TextStyle(
                            color: const Color(0xFF2B3674),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
