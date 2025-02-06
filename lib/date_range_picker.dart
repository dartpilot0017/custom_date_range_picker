part of 'custom_date_range_picker.dart';

class DateRangePicker extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  final ValueChanged<DateTime?>? onStartDateChanged;
  final ValueChanged<DateTime?>? onEndDateChanged;
  final ValueChanged<DateTimeRange?>? onDateRangeChanged;
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
  final String? dropDownValue;
  final List<String>? dropDownItems;
  final ValueChanged<String?>? dropDownOnChanged;
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
  });

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DateTime? _startDate;
  DateTime? _endDate;
  String _selectedMonth = months[DateTime.now().month - 1];
  String _selectedYear = DateTime.now().year.toString();

  @override
  void initState() {
    super.initState();
    _startDate = widget.startDate;
    _endDate = widget.endDate;
  }

  Future<void> _resetDatePicker() async {
    if (widget.onOutlinePressed != null) {
      widget.onOutlinePressed!();
    } else {
      setState(() {
        _startDate = null;
        _endDate = null;
        widget.onStartDateChanged?.call(null);
        widget.onEndDateChanged?.call(null);
        widget.onDateRangeChanged?.call(null);
      });
    }
  }

  static const List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  static List<String> years = List.generate(20, (index) {
    int year = DateTime.now().year - 10 + index;
    return year.toString();
  });

  static const List<String> days = [
    "Mo",
    "Tu",
    "We",
    "Th",
    "Fr",
    "Sa",
    "Su",
  ];

  // Future<void> _donePickingDates() async {
  //   if (widget.onFilledPressed != null) {
  //     widget.onFilledPressed!();
  //     setState(() {
  //       widget.onDateRangeChanged
  //           ?.call(DateTimeRange(start: _startDate!, end: _endDate!));
  //     });
  //     log("The start date is $_startDate and the end date is $_endDate");
  //   } else {
  //     setState(() {
  //       widget.onDateRangeChanged
  //           ?.call(DateTimeRange(start: _startDate!, end: _endDate!));
  //     });
  //     log("The start date is $_startDate and the end date is $_endDate");

  //     Navigator.pop(context);
  //   }
  // }

  Future<void> _donePickingDates() async {
    if (widget.onFilledPressed != null) {
      widget.onFilledPressed!();
      setState(() {
        widget.onDateRangeChanged
            ?.call(DateTimeRange(start: _startDate!, end: _endDate!));
      });
      log("The start date is $_startDate and the end date is $_endDate");
    } else {
      setState(() {
        widget.onDateRangeChanged
            ?.call(DateTimeRange(start: _startDate!, end: _endDate!));
      });
      log("The start date is $_startDate and the end date is $_endDate");

      Navigator.pop(context);
    }
  }

  Widget _buildDropdownButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: DropdownButton(
            width: widget.dropDownWidth,
            height: widget.dropDownHeight,
            dropDownListWidth: widget.dropDownListWidth,
            dropDownListHeight: widget.dropDownListHeight,
            backgroundColor: widget.dropDownBackgroundColor,
            borderWidth: widget.dropDownBorderWidth,
            borderRadius: widget.dropDownBorderRadius,
            padding: widget.dropDownPadding,
            margin: widget.dropDownMargin,
            borderColor: widget.dropDownBorderColor,
            dropDownTextStyle: widget.dropDownTextStyle,
            items: months,
            hintText:
                widget.dropDownHintText ?? months[DateTime.now().month - 1],
            gap: widget.dropDownGap,
            onChanged: widget.dropDownOnChanged ??
                (value) {
                  setState(() {
                    _selectedMonth = value ?? "";
                    log("The selected Month is $value");
                  });
                },
          ),
        ),
        SizedBox(width: 8), // Optional spacing
        Expanded(
          child: DropdownButton(
            width: widget.dropDownWidth,
            height: widget.dropDownHeight,
            dropDownListWidth: widget.dropDownListWidth,
            dropDownListHeight: widget.dropDownListHeight,
            backgroundColor: widget.dropDownBackgroundColor,
            borderWidth: widget.dropDownBorderWidth,
            borderRadius: widget.dropDownBorderRadius,
            padding: widget.dropDownPadding,
            margin: widget.dropDownMargin,
            borderColor: widget.dropDownBorderColor,
            dropDownTextStyle: widget.dropDownTextStyle,
            items: years,
            hintText: widget.dropDownHintText ?? DateTime.now().year.toString(),
            gap: widget.dropDownGap,
            onChanged: widget.dropDownOnChanged ??
                (value) {
                  setState(() {
                    _selectedYear = value ?? "";
                    log("The selected Year is $value");
                  });
                },
          ),
        ),
      ],
    );
  }

  Widget _buildDaysAndDates() {
    // Convert selected month and year to numbers
    int monthIndex = months.indexOf(_selectedMonth) + 1;
    int year = int.parse(_selectedYear);

    // Calculate the total days in the month and the weekday of the 1st day
    int daysInMonth = DateTime(year, monthIndex + 1, 0).day;
    int firstWeekday = DateTime(year, monthIndex, 1).weekday;

    List<Row> dateRows = []; // Holds the rows for the calendar grid
    List<Widget> currentRow = []; // Holds the cells for the current row

    // Add empty cells before the first day of the month
    for (int i = 1; i < firstWeekday; i++) {
      currentRow.add(Expanded(child: SizedBox()));
    }

    // Loop through each day of the month
    for (int day = 1; day <= daysInMonth; day++) {
      // Create a DateTime object for the current day
      DateTime currentDate = DateTime(year, monthIndex, day);

      // Check if this date is the selected start date
      bool isStart =
          _startDate != null && currentDate.isAtSameMomentAs(_startDate!);
      // Check if this date is the selected end date
      bool isEnd = _endDate != null && currentDate.isAtSameMomentAs(_endDate!);
      // Check if the date falls within the selected range (if both start and end are chosen)
      bool isInRange = false;
      if (_startDate != null && _endDate != null) {
        isInRange =
            currentDate.isAfter(_startDate!) && currentDate.isBefore(_endDate!);
      }

      // Define the colors for each case (adjust these colors as needed)
      Color selectedDateColor = widget.selectedDateColor ??
          const Color(0xFFFF7622); // Color for the start date
      Color rangeColor = widget.highlightColor ??
          const Color(0xFFFF7622)
              // ignore: deprecated_member_use
              .withOpacity(0.1); // Color for the dates within the range

      // Create the cell for the current day
      currentRow.add(
        Expanded(
          child: GestureDetector(
            key: Key('date_$day'),
            onTap: () {
              log("The tapped date is $day");
              log("the date time of the tapped date is ${DateTime(year, monthIndex, day)}");
              DateTime tappedDate = DateTime(year, monthIndex, day);

              if (_startDate == null) {
                setState(() {
                  _startDate = tappedDate;
                  widget.onStartDateChanged?.call(_startDate);
                });
                log("The start date is $_startDate");
              } else if (_endDate == null) {
                if (tappedDate.isBefore(_startDate!)) {
                  log("End date cannot be before start date");
                  // Show an error message or handle this case as needed
                } else {
                  setState(() {
                    _endDate = tappedDate;
                    widget.onEndDateChanged?.call(_endDate);
                  });
                  log("The end date is $_endDate");
                }
              }
              log("The start date is $_startDate and the end date is $_endDate");
            },
            child: Container(
              height: size * 32,
              width: mediaQueryWidth,
              margin: EdgeInsets.symmetric(vertical: size * 8),
              child: ClipRRect(
                child: Stack(
                  children: [
                    //color expected to show for the dates withing range
                    Padding(
                      padding: isStart
                          ? EdgeInsets.only(left: size * 7)
                          : isEnd
                              ? EdgeInsets.only(right: size * 7)
                              : EdgeInsets.zero,
                      child: DecoratedBox(
                        // decoration: BoxDecoration(
                        //   color: const Color(0xFFFF7623),
                        //   shape: BoxShape.rectangle,
                        //   borderRadius: BorderRadius.circular(6),
                        // ),
                        decoration: BoxDecoration(
                          color: isStart
                              ? rangeColor
                              : isEnd
                                  ? rangeColor
                                  : isInRange
                                      ? rangeColor
                                      : Colors.transparent,
                          shape: BoxShape.rectangle,
                          borderRadius: isStart
                              ? BorderRadius.circular(6)
                              : isEnd
                                  ? BorderRadius.circular(6)
                                  : BorderRadius.circular(0),
                        ),
                        child: Center(
                          child: Text(""),
                        ),
                      ),
                    ),
                    //color meant to show for selected dates
                    Padding(
                      padding: isStart
                          ? EdgeInsets.symmetric(horizontal: size * 7)
                          : isEnd
                              ? EdgeInsets.symmetric(horizontal: size * 7)
                              : EdgeInsets.zero,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: isStart
                              ? selectedDateColor
                              : isEnd
                                  ? selectedDateColor
                                  : Colors.transparent,
                          shape: BoxShape.rectangle,
                          borderRadius: isStart
                              ? BorderRadius.circular(6)
                              : isEnd
                                  ? BorderRadius.circular(6)
                                  : BorderRadius.circular(0),
                        ),
                        child: Center(
                          child: Text(
                            day.toString(),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: isStart
                                  ? widget.selectedDateTextColor
                                  : isEnd
                                      ? widget.selectedDateTextColor
                                      : isInRange
                                          ? widget.highlightTextColor
                                          : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      // When the row has 7 items (days), add it to dateRows and start a new row
      if (currentRow.length == 7) {
        dateRows.add(Row(children: currentRow));
        currentRow = [];
      }
    }

    // If there are remaining days, fill the row with empty cells and add it
    if (currentRow.isNotEmpty) {
      while (currentRow.length < 7) {
        currentRow.add(Expanded(child: SizedBox()));
      }
      dateRows.add(Row(children: currentRow));
    }

    // Build the complete widget with a header row for day names and all date rows
    return Column(
      children: [
        // Days of the week header
        SizedBox(
          height: size * 32,
          child: Row(
            children: days
                .map<Widget>(
                  (day) => Expanded(
                    child: Text(
                      day,
                      style: widget.weekDayTextStyle ??
                          TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color:
                                widget.filledColor ?? const Color(0xFFFF7622),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        // Calendar date rows
        ...dateRows,
      ],
    );
  }

  Widget _buildActionButtons() {
    return ActionButtons(
      onOutlinePressed: _resetDatePicker,
      onFilledPressed: _donePickingDates,
      filledButtonBackgroundColor: widget.filledButtonBackgroundColor,
      outlinedButtonBackgroundColor: widget.outlinedButtonBackgroundColor,
      filledButtonWidth: widget.filledButtonWidth,
      outlinedButtonWidth: widget.outlinedButtonWidth,
      filledButtonHeight: widget.filledButtonHeight,
      outlinedButtonHeight: widget.outlinedButtonHeight,
      filledButtonChild: widget.filledButtonChild,
      outlinedButtonChild: widget.outlinedButtonChild,
      filledButtonText: widget.filledButtonText,
      outlinedButtonText: widget.outlinedButtonText,
      textStyle: widget.buttonTextStyle,
      filledColor: widget.filledColor,
      outlinedColor: widget.outlinedColor,
      filledButtonBorderColor: widget.filledButtonBorderColor,
      outlinedButtonBorderColor: widget.outlinedButtonBorderColor,
      filledButtonBorderRadius: widget.filledButtonBorderRadius,
      outlinedButtonBorderRadius: widget.outlinedButtonBorderRadius,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: size * 42),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: size * 10,
                ),
                _buildDaysAndDates(),
                SizedBox(
                  height: size * 10,
                ),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
        _buildDropdownButton(),
      ],
    );
  }
}
