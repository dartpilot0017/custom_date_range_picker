import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';

// Dummy definitions for external variables used in DateRangePicker.
const double size = 1.0;
const double mediaQueryWidth = 100.0;


// Then also, I want you to give me a proper readme.md file that is explaining the package usefulness.
void main() {
  testWidgets('DateRangePicker selects start and end dates and calls callbacks',
      (WidgetTester tester) async {
    DateTime? selectedStart;
    DateTime? selectedEnd;
    DateTimeRange? selectedRange;

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(375, 667)),
        child: MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 600, // Ensure it fits on screen
              child: SingleChildScrollView(
                // Make scrollable
                child: DateRangePicker(
                  onStartDateChanged: (date) {
                    selectedStart = date;
                    debugPrint('Start date selected: $selectedStart');
                  },
                  onEndDateChanged: (date) {
                    selectedEnd = date;
                    debugPrint('End date selected: $selectedEnd');
                  },
                  onDateRangeChanged: (range) {
                    selectedRange = range;
                    debugPrint('Date range selected: $selectedRange');
                  },
                  onFilledPressed:
                      () {}, // Ensure this function triggers properly
                  dropDownItems: const [
                    'January',
                    'February',
                    'March',
                    'April',
                    'May',
                    'June',
                    'July',
                    'August',
                    'September',
                    'October',
                    'November',
                    'December'
                  ],
                  filledButtonChild: const Text('Done'),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Select start date
    final day15Finder = find.byKey(Key('date_15'));
    expect(day15Finder, findsOneWidget);
    await tester.tap(day15Finder);
    await tester.pumpAndSettle();

    expect(selectedStart, isNotNull);

    // Select end date
    final day20Finder = find.byKey(Key('date_20'));
    expect(day20Finder, findsOneWidget);
    await tester.tap(day20Finder);
    await tester.pumpAndSettle();

    expect(selectedEnd, isNotNull);

    // Ensure the "Done" button is visible and tap it
    final doneButtonFinder = find.text('Done');
    expect(doneButtonFinder, findsOneWidget);

    await tester.ensureVisible(doneButtonFinder); // Ensure it's in view
    await tester.tap(doneButtonFinder);
    await tester.pumpAndSettle();

    // Verify date range callback
    expect(selectedRange, isNotNull);
    expect(selectedRange!.start.day, equals(selectedStart!.day));
    expect(selectedRange!.end.day, equals(selectedEnd!.day));
  });
}
