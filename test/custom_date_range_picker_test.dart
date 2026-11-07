import 'package:custom_date_range_plus/custom_date_range_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> mount(WidgetTester tester, DateRangePicker picker,
    {double width = 360, double scale = 1, Locale? locale}) async {
  await tester.pumpWidget(MaterialApp(
    locale: locale,
    supportedLocales: const [Locale('en'), Locale('ar')],
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    home: Scaffold(
        body: Center(
            child: SizedBox(
      width: width,
      child: MediaQuery(
        data: MediaQueryData(textScaler: TextScaler.linear(scale)),
        child: picker,
      ),
    ))),
  ));
  await tester.pumpAndSettle();
}

DateRangePicker picker({
  DateTime? start,
  DateTime? end,
  ValueChanged<DateTime?>? onStart,
  ValueChanged<DateTime?>? onEnd,
  ValueChanged<DateTimeRange?>? onChange,
  ValueChanged<DateTimeRange?>? onSelection,
  VoidCallback? onReset,
}) =>
    DateRangePicker(
      minDate: DateTime(2024, 2, 10, 12),
      maxDate: DateTime(2024, 3, 20, 12),
      startDate: start,
      endDate: end,
      onStartDateChanged: onStart,
      onEndDateChanged: onEnd,
      onDateRangeChanged: onChange,
      onSelectionChanged: onSelection,
      onOutlinePressed: onReset,
    );

Future<void> tapDay(WidgetTester tester, int day) async {
  await tester.tap(find.byKey(Key('date_$day')));
  await tester.pump();
}

void main() {
  testWidgets('confirm is disabled for empty and partial ranges',
      (tester) async {
    var calls = 0;
    await mount(tester, picker(onChange: (_) => calls++));
    final confirm = find.descendant(
        of: find.byKey(const Key('filled_button')),
        matching: find.byType(TextButton));
    expect(tester.widget<TextButton>(confirm).onPressed, isNull);
    await tapDay(tester, 12);
    expect(tester.widget<TextButton>(confirm).onPressed, isNull);
    expect(calls, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets('bounds are inclusive and timestamps are normalized',
      (tester) async {
    DateTime? start;
    DateTimeRange? range;
    await mount(
        tester,
        picker(
            start: DateTime(2024, 2, 10, 18),
            onStart: (date) => start = date,
            onChange: (value) => range = value));
    expect(tester.widget<TextButton>(find.byKey(const Key('date_9'))).onPressed,
        isNull);
    await tapDay(tester, 10);
    await tester.tap(find.byKey(const Key('filled_button')));
    await tester.pump();
    expect(
        range,
        DateTimeRange(
            start: DateTime(2024, 2, 10), end: DateTime(2024, 2, 10)));
    await tapDay(tester, 29);
    expect(start, DateTime(2024, 2, 29));
  });

  testWidgets(
      'reverse selection restarts and complete selection can be replaced',
      (tester) async {
    final changes = <DateTimeRange?>[];
    DateTime? end;
    await mount(
        tester,
        picker(
            start: DateTime(2024, 2, 20),
            onEnd: (date) => end = date,
            onSelection: changes.add));
    await tapDay(tester, 15);
    expect(changes.last, isNull);
    await tapDay(tester, 18);
    expect(
        changes.last,
        DateTimeRange(
            start: DateTime(2024, 2, 15), end: DateTime(2024, 2, 18)));
    await tapDay(tester, 22);
    expect(changes.last, isNull);
    expect(end, isNull);
  });

  testWidgets('reset clears selection even with a custom callback',
      (tester) async {
    var resets = 0;
    final changes = <DateTimeRange?>[];
    await mount(
        tester,
        picker(
            start: DateTime(2024, 2, 15),
            end: DateTime(2024, 2, 18),
            onChange: changes.add,
            onReset: () => resets++));
    await tester.tap(find.byKey(const Key('outline_button')));
    await tester.pump();
    expect(resets, 1);
    expect(changes, [null]);
    await tapDay(tester, 22);
    await tapDay(tester, 23);
    await tester.tap(find.byKey(const Key('filled_button')));
    await tester.pump();
    expect(changes.last?.start, DateTime(2024, 2, 22));
    expect(find.byType(DateRangePicker), findsOneWidget);
  });

  testWidgets('parent updates synchronize dates and visible month',
      (tester) async {
    await mount(tester, picker(start: DateTime(2024, 2, 15)));
    await mount(tester,
        picker(start: DateTime(2024, 3, 12), end: DateTime(2024, 3, 14)));
    expect(find.text('March 2024'), findsOneWidget);
    expect(
        tester.widget<TextButton>(find.byKey(const Key('date_21'))).onPressed,
        isNull);
    await mount(tester, picker());
    final confirm = find.descendant(
        of: find.byKey(const Key('filled_button')),
        matching: find.byType(TextButton));
    expect(tester.widget<TextButton>(confirm).onPressed, isNull);
  });

  testWidgets('month observer does not replace navigation', (tester) async {
    String? observed;
    await mount(
        tester,
        DateRangePicker(
          minDate: DateTime(2024, 2),
          maxDate: DateTime(2024, 3, 31),
          startDate: DateTime(2024, 2, 15),
          dropDownOnChanged: (value) => observed = value,
        ));
    await tester.tap(find.text('February 2024'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('March 2024').last);
    await tester.pumpAndSettle();
    expect(observed, 'March 2024');
    expect(find.byKey(const Key('date_31')), findsOneWidget);
  });

  testWidgets('narrow layout supports large text and RTL', (tester) async {
    await mount(tester, picker(start: DateTime(2024, 2, 15)),
        width: 280, scale: 2, locale: const Locale('ar'));
    expect(tester.takeException(), isNull);
    expect(Directionality.of(tester.element(find.byType(DateRangePicker))),
        TextDirection.rtl);
  });

  testWidgets('day controls support keyboard activation and semantics',
      (tester) async {
    DateTime? selected;
    final semantics = tester.ensureSemantics();
    await mount(tester,
        picker(start: DateTime(2024, 2, 15), onEnd: (date) => selected = date));
    final day = find.byKey(const Key('date_16'));
    Focus.of(tester
            .element(find.descendant(of: day, matching: find.byType(Text))))
        .requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pump();
    expect(selected, DateTime(2024, 2, 16));
    expect(find.bySemanticsLabel(RegExp('Friday, February 16, 2024')),
        findsOneWidget);
    semantics.dispose();
  });

  testWidgets('invalid bounds fail with an actionable argument error',
      (tester) async {
    await mount(tester,
        DateRangePicker(minDate: DateTime(2025), maxDate: DateTime(2024)));
    expect(tester.takeException(), isArgumentError);
  });

  testWidgets('dialog returns a typed range and dismissal returns null',
      (tester) async {
    DateTimeRange? result;
    Future<void> open(BuildContext context) async {
      result = await showCustomDateRangePicker(
          context: context,
          initialDateRange: DateTimeRange(
              start: DateTime(2024, 2, 12), end: DateTime(2024, 2, 15)));
    }

    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: Builder(
      builder: (context) =>
          TextButton(onPressed: () => open(context), child: const Text('Open')),
    ))));
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('filled_button')));
    await tester.pumpAndSettle();
    expect(result?.end, DateTime(2024, 2, 15));
    expect(find.byType(DateRangePicker), findsNothing);
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(5, 5));
    await tester.pumpAndSettle();
    expect(result, isNull);
    expect(tester.takeException(), isNull);
  });
}
