import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> show(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
}

Future<void> tap(WidgetTester tester, Finder finder) async {
  await show(tester, finder);
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('playground selects a range and opens both presentations',
      (tester) async {
    await tester.pumpWidget(const ExampleApp());
    await tap(tester, find.byKey(const Key('date_10')));
    await tap(tester, find.byKey(const Key('date_12')));
    await tap(tester, find.text('Apply range'));
    expect(tester.widget<Text>(find.byKey(const Key('range_summary'))).data,
        contains('Nov 12'));
    await tap(tester, find.text('Dialog'));
    await tap(tester, find.text('Open dialog'));
    expect(find.byType(Dialog), findsOneWidget);
    await tap(tester, find.text('Apply range'));
    expect(find.byType(Dialog), findsNothing);
    await tap(tester, find.text('Bottom sheet'));
    await tap(tester, find.text('Open bottom sheet'));
    expect(find.byType(BottomSheet), findsOneWidget);
    await tap(tester, find.text('Apply range'));
    expect(find.byType(BottomSheet), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('settings update preview and clipboard example', (tester) async {
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          copied = (call.arguments as Map)['text'] as String;
        }
        return null;
      },
    );
    addTearDown(() => tester.binding.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, null));
    await tester.pumpWidget(const ExampleApp());
    await tap(tester, find.text('Limit selectable dates'));
    expect(tester.widget<TextButton>(find.byKey(const Key('date_4'))).onPressed,
        isNull);
    await tap(tester, find.text('Monday first'));
    await tap(tester, find.text('Indigo'));
    await tap(tester, find.byKey(const Key('copy_code')));
    expect(copied, contains('DateTime.sunday'));
    expect(copied, contains('minDate: DateTime(2026, 11, 5)'));
    expect(copied, contains('0xFF465AC7'));
    await tap(tester, find.text('Built-in action buttons'));
    await tap(tester, find.byKey(const Key('date_13')));
    await tap(tester, find.byKey(const Key('date_16')));
    expect(tester.widget<Text>(find.byKey(const Key('range_summary'))).data,
        contains('Nov 16'));
    expect(tester.takeException(), isNull);
  });

  testWidgets('mobile layout and dark theme have no overflow', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const ExampleApp());
    await tap(tester, find.text('Dark appearance'));
    expect(Theme.of(tester.element(find.byType(Playground))).brightness,
        Brightness.dark);
    await tap(tester, find.text('Dialog'));
    await tap(tester, find.text('Open dialog'));
    expect(tester.takeException(), isNull);
  });
}
