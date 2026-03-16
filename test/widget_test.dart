import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:admin/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Give the app a large logical screen to avoid overflow in layout tests.
    final binding = tester.binding;
    binding.window.physicalSizeTestValue = const Size(1920, 1080);
    binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      binding.window.clearPhysicalSizeTestValue();
      binding.window.clearDevicePixelRatioTestValue();
    });

    // Build our app and trigger a frame.
    await tester.pumpWidget(AdminApp());

    // Allow any startup timers to complete before the test ends.
    await tester.pump(const Duration(milliseconds: 900));

    // Verify that the app builds without crashing.
    expect(find.byType(AdminApp), findsOneWidget);
  });
}
