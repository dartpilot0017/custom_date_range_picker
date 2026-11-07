import 'package:flutter/material.dart';

import '../date_range_picker.dart';

/// Shows a range picker and returns its confirmed date-only range.
///
/// Dismissing the dialog returns null. Reset clears the draft without closing.
/// Bounds are inclusive and default to January 1900 through December 2100.
/// Use [DateRangePicker] directly for inline or bottom-sheet presentations.
Future<DateTimeRange?> showCustomDateRangePicker({
  required BuildContext context,
  DateTimeRange? initialDateRange,
  DateTime? minDate,
  DateTime? maxDate,
  String? title,
  String? confirmText,
  String? resetText,
  bool barrierDismissible = true,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
}) {
  return showDialog<DateTimeRange>(
    context: context,
    barrierDismissible: barrierDismissible,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    builder: (dialogContext) => Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ??
                    MaterialLocalizations.of(dialogContext)
                        .dateRangePickerHelpText,
                style: Theme.of(dialogContext).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Flexible(
                child: DateRangePicker(
                  startDate: initialDateRange?.start,
                  endDate: initialDateRange?.end,
                  minDate: minDate,
                  maxDate: maxDate,
                  filledButtonText: confirmText,
                  outlinedButtonText: resetText,
                  onConfirm: (range) => Navigator.of(dialogContext).pop(range),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
