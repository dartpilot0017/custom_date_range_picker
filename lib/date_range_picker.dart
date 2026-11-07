import 'package:flutter/material.dart';

import 'action_buttons.dart';
import 'dropdown_button.dart' as controls;

/// An embeddable calendar for selecting an inclusive, date-only range.
///
/// Selection is local until confirmed. The widget never navigates on its own.
/// Parent changes to dates or bounds synchronize the selection.

class DateRangePicker extends StatefulWidget {
  /// Initial selection. Time components are discarded without timezone conversion.
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  final ValueChanged<DateTime?>? onStartDateChanged;
  final ValueChanged<DateTime?>? onEndDateChanged;

  /// Called on confirmation with a complete range, or with null on reset.
  final ValueChanged<DateTimeRange?>? onDateRangeChanged;

  /// Called after each selection change; null means the range is incomplete.
  final ValueChanged<DateTimeRange?>? onSelectionChanged;

  /// Called with the confirmed range before [onFilledPressed].
  final ValueChanged<DateTimeRange>? onConfirm;

  /// First weekday, using DateTime.monday through DateTime.sunday.
  /// Defaults to the application's Material locale.
  final int? firstDayOfWeek;

  /// Whether to render the reset and confirmation buttons.
  final bool showActionButtons;
  final Color? selectedDateColor;
  final Color? selectedDateTextColor;
  final Color? highlightColor;
  final Color? highlightTextColor;
  final Color? unselectedDateColor;
  final Color? unselectedDateTextColor;
  final TextStyle? weekDayTextStyle;

  /// Action Button Requirements
  final VoidCallback? onOutlinePressed;
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
  final TextStyle? buttonTextStyle;
  final String? outlinedButtonText;
  final String? filledButtonText;

  /// Dropdown Requirements
  final String? dropDownHintText;

  /// Retained for source compatibility; the visible month follows startDate.
  @Deprecated('Use startDate to set the initial visible month.')
  final String? dropDownValue;
  final List<String>? dropDownItems;
  final ValueChanged<String?>? dropDownOnChanged;

  /// Material menus use an overlay and do not need a layout gap.
  @Deprecated('Material dropdown menus no longer use an inline gap.')
  final Widget? dropDownGap;
  final Color? dropDownBorderColor;
  final Color? dropDownBackgroundColor;
  final double? dropDownBorderWidth;
  final double? dropDownBorderRadius;
  final double? dropDownWidth;
  final double? dropDownHeight;
  final double? dropDownListWidth;
  final double? dropDownListHeight;
  final EdgeInsets? dropDownPadding;
  final EdgeInsets? dropDownMargin;
  final TextStyle? dropDownTextStyle;

  const DateRangePicker({
    super.key,
    this.startDate,
    this.endDate,
    this.minDate,
    this.maxDate,
    this.onStartDateChanged,
    this.onEndDateChanged,
    this.onDateRangeChanged,
    this.onSelectionChanged,
    this.onConfirm,
    this.firstDayOfWeek,
    this.showActionButtons = true,
    this.selectedDateColor,
    this.selectedDateTextColor,
    this.highlightColor,
    this.highlightTextColor,
    this.unselectedDateColor,
    this.unselectedDateTextColor,
    this.weekDayTextStyle,

    /// Action Button Requirements
    this.onOutlinePressed,
    this.onFilledPressed,
    this.filledColor,
    this.outlinedColor,
    this.filledButtonBorderColor,
    this.outlinedButtonBorderColor,
    this.filledButtonBackgroundColor,
    this.outlinedButtonBackgroundColor,
    this.filledButtonWidth,
    this.outlinedButtonWidth,
    this.filledButtonHeight,
    this.outlinedButtonHeight,
    this.filledButtonBorderRadius,
    this.outlinedButtonBorderRadius,
    this.filledButtonChild,
    this.outlinedButtonChild,
    this.buttonTextStyle,
    this.outlinedButtonText,
    this.filledButtonText,

    /// Dropdown Requirements
    this.dropDownHintText,
    this.dropDownValue,
    this.dropDownItems,
    this.dropDownOnChanged,
    this.dropDownGap,
    this.dropDownBorderColor,
    this.dropDownBackgroundColor,
    this.dropDownBorderWidth,
    this.dropDownBorderRadius,
    this.dropDownWidth,
    this.dropDownHeight,
    this.dropDownListWidth,
    this.dropDownListHeight,
    this.dropDownPadding,
    this.dropDownMargin,
    this.dropDownTextStyle,
  }) : assert(firstDayOfWeek == null ||
            (firstDayOfWeek >= 1 && firstDayOfWeek <= 7));

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DateTime? _startDate;
  DateTime? _endDate;
  late DateTime _month;
  late DateTime _min;
  late DateTime _max;

  DateTime? _dateOnly(DateTime? date) =>
      date == null ? null : DateUtils.dateOnly(date);

  @override
  void initState() {
    super.initState();
    _synchronize();
  }

  @override
  void didUpdateWidget(covariant DateRangePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.startDate != widget.startDate ||
        oldWidget.endDate != widget.endDate ||
        oldWidget.minDate != widget.minDate ||
        oldWidget.maxDate != widget.maxDate) {
      _synchronize();
    }
  }

  void _synchronize() {
    _min = _dateOnly(widget.minDate) ?? DateTime(1900);
    _max = _dateOnly(widget.maxDate) ?? DateTime(2100, 12, 31);
    _startDate = _dateOnly(widget.startDate);
    _endDate = _dateOnly(widget.endDate);
    if (_max.isBefore(_min)) {
      throw ArgumentError('maxDate must be on or after minDate.');
    }
    if (_endDate != null && _startDate == null) {
      throw ArgumentError('endDate requires startDate.');
    }
    for (final date in [_startDate, _endDate]) {
      if (date != null && !_isEnabled(date)) {
        throw ArgumentError(
            'Selected dates must be within minDate and maxDate.');
      }
    }
    if (_endDate != null && _endDate!.isBefore(_startDate!)) {
      throw ArgumentError('endDate must be on or after startDate.');
    }
    var visible = _startDate ?? DateUtils.dateOnly(DateTime.now());
    if (visible.isBefore(_min)) visible = _min;
    if (visible.isAfter(_max)) visible = _max;
    _month = DateTime(visible.year, visible.month);
  }

  bool _isEnabled(DateTime date) => !date.isBefore(_min) && !date.isAfter(_max);

  DateTimeRange? get _range => _startDate != null && _endDate != null
      ? DateTimeRange(start: _startDate!, end: _endDate!)
      : null;

  void _select(DateTime date) {
    final oldStart = _startDate;
    final oldEnd = _endDate;
    setState(() {
      if (_startDate == null ||
          _endDate != null ||
          date.isBefore(_startDate!)) {
        _startDate = date;
        _endDate = null;
      } else {
        _endDate = date;
      }
    });
    // Notify outside setState: callbacks may rebuild or remove this widget.
    if (oldStart != _startDate) widget.onStartDateChanged?.call(_startDate);
    if (oldEnd != _endDate) widget.onEndDateChanged?.call(_endDate);
    widget.onSelectionChanged?.call(_range);
  }

  void _reset() {
    setState(() {
      _startDate = null;
      _endDate = null;
    });
    widget.onStartDateChanged?.call(null);
    widget.onEndDateChanged?.call(null);
    widget.onSelectionChanged?.call(null);
    widget.onDateRangeChanged?.call(null);
    widget.onOutlinePressed?.call();
  }

  void _confirm() {
    final range = _range;
    if (range == null) return;
    widget.onDateRangeChanged?.call(range);
    widget.onConfirm?.call(range);
    widget.onFilledPressed?.call();
  }

  List<int> _monthsFor(int year) => [
        for (var month = 1; month <= 12; month++)
          if (!DateTime(year, month + 1, 0).isBefore(_min) &&
              !DateTime(year, month).isAfter(_max))
            month,
      ];

  Widget _dropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) =>
      controls.DropdownButton(
        value: value,
        items: items,
        onChanged: onChanged,
        hintText: widget.dropDownHintText,
        width: widget.dropDownWidth,
        height: widget.dropDownHeight,
        dropDownListWidth: widget.dropDownListWidth,
        dropDownListHeight: widget.dropDownListHeight,
        backgroundColor: widget.dropDownBackgroundColor,
        borderColor: widget.dropDownBorderColor,
        borderWidth: widget.dropDownBorderWidth,
        borderRadius: widget.dropDownBorderRadius,
        padding: widget.dropDownPadding,
        margin: widget.dropDownMargin,
        dropDownTextStyle: widget.dropDownTextStyle,
      );

  Widget _header(MaterialLocalizations localizations) {
    final months = _monthsFor(_month.year);
    final labels = widget.dropDownItems;
    if (labels != null &&
        (labels.length != 12 || labels.toSet().length != 12)) {
      throw ArgumentError('dropDownItems must contain 12 unique month labels.');
    }
    String label(int month) =>
        labels?[month - 1] ??
        localizations.formatMonthYear(DateTime(_month.year, month));
    return Row(children: [
      Expanded(
          child: _dropdown(
        value: label(_month.month),
        items: months.map(label).toList(),
        onChanged: (value) {
          if (value == null) return;
          setState(() => _month = DateTime(_month.year,
              months.firstWhere((month) => label(month) == value)));
          widget.dropDownOnChanged?.call(value);
        },
      )),
      const SizedBox(width: 12),
      Expanded(
          child: _dropdown(
        value: '${_month.year}',
        items: [for (var year = _min.year; year <= _max.year; year++) '$year'],
        onChanged: (value) {
          if (value == null) return;
          final year = int.parse(value);
          final available = _monthsFor(year);
          setState(() => _month = DateTime(
              year, _month.month.clamp(available.first, available.last)));
          widget.dropDownOnChanged?.call(value);
        },
      )),
    ]);
  }

  Widget _calendar(MaterialLocalizations localizations) {
    final colors = Theme.of(context).colorScheme;
    final firstDay = widget.firstDayOfWeek == null
        ? localizations.firstDayOfWeekIndex
        : widget.firstDayOfWeek! % 7;
    final offset = (_month.weekday % 7 - firstDay + 7) % 7;
    final count = DateUtils.getDaysInMonth(_month.year, _month.month);
    final rows = (offset + count + 6) ~/ 7;
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(children: [
        for (var i = 0; i < 7; i++)
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              localizations.narrowWeekdays[(firstDay + i) % 7],
              textAlign: TextAlign.center,
              style: widget.weekDayTextStyle ??
                  Theme.of(context).textTheme.labelMedium,
            ),
          )),
      ]),
      for (var row = 0; row < rows; row++)
        Row(children: [
          for (var col = 0; col < 7; col++)
            Expanded(child: Builder(builder: (context) {
              final day = row * 7 + col - offset + 1;
              if (day < 1 || day > count) return const SizedBox(height: 48);
              final date = DateTime(_month.year, _month.month, day);
              final selected = date == _startDate || date == _endDate;
              final inRange = _range != null &&
                  !date.isBefore(_startDate!) &&
                  !date.isAfter(_endDate!);
              final enabled = _isEnabled(date);
              final background = selected
                  ? widget.selectedDateColor ?? colors.primary
                  : inRange
                      ? widget.highlightColor ?? colors.primaryContainer
                      : widget.unselectedDateColor ?? Colors.transparent;
              final foreground = !enabled
                  ? colors.onSurface.withValues(alpha: 0.38)
                  : selected
                      ? widget.selectedDateTextColor ?? colors.onPrimary
                      : inRange
                          ? widget.highlightTextColor ??
                              colors.onPrimaryContainer
                          : widget.unselectedDateTextColor ?? colors.onSurface;
              return MergeSemantics(
                  child: Semantics(
                label: localizations.formatFullDate(date),
                selected: selected,
                child: TextButton(
                  key: Key('date_$day'),
                  onPressed: enabled ? () => _select(date) : null,
                  style: TextButton.styleFrom(
                    minimumSize: const Size(0, 48),
                    padding: EdgeInsets.zero,
                    foregroundColor: foreground,
                    disabledForegroundColor: foreground,
                    backgroundColor: background,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            inRange && !selected ? 0 : 8)),
                  ),
                  child: ExcludeSemantics(
                      child: Text(localizations.formatDecimal(day))),
                ),
              ));
            })),
        ]),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 480),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _header(localizations),
          const SizedBox(height: 8),
          _calendar(localizations),
          if (widget.showActionButtons) ...[
            const SizedBox(height: 16),
            ActionButtons(
              onOutlinePressed: _reset,
              onFilledPressed: _range == null ? null : _confirm,
              filledButtonBackgroundColor: widget.filledButtonBackgroundColor,
              outlinedButtonBackgroundColor:
                  widget.outlinedButtonBackgroundColor,
              filledButtonWidth: widget.filledButtonWidth,
              outlinedButtonWidth: widget.outlinedButtonWidth,
              filledButtonHeight: widget.filledButtonHeight,
              outlinedButtonHeight: widget.outlinedButtonHeight,
              filledButtonChild: widget.filledButtonChild,
              outlinedButtonChild: widget.outlinedButtonChild,
              filledButtonText:
                  widget.filledButtonText ?? localizations.okButtonLabel,
              outlinedButtonText: widget.outlinedButtonText ?? 'Reset',
              textStyle: widget.buttonTextStyle,
              filledColor: widget.filledColor,
              outlinedColor: widget.outlinedColor,
              filledButtonBorderColor: widget.filledButtonBorderColor,
              outlinedButtonBorderColor: widget.outlinedButtonBorderColor,
              filledButtonBorderRadius: widget.filledButtonBorderRadius,
              outlinedButtonBorderRadius: widget.outlinedButtonBorderRadius,
            ),
          ],
        ]),
      ),
    );
  }
}
