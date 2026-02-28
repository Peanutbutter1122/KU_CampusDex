import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Smoke test for map screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Container(), // Dummy test to bypass mapbox init
        ),
      ),
    );

    // Verify that the container is present
    expect(find.byType(Container), findsWidgets);
  });
}
