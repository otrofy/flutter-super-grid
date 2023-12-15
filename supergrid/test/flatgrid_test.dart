import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supergrid/flatgrid.dart';

void main() {
  group('FlatGridView', () {
    testWidgets('renders empty grid with "No items" text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlatGridView(
              data: const [],
              renderItem: (data) => Container(),
              itemWidth: 100,
              itemHeight: 100,
            ),
          ),
        ),
      );

      expect(find.text('No items'), findsOneWidget);
    });

    testWidgets('renders grid with items', (WidgetTester tester) async {
      final List<String> testData = ['Item 1', 'Item 2', 'Item 3'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlatGridView(
              data: testData,
              renderItem: (data) => Text(data),
              itemWidth: 100,
              itemHeight: 100,
            ),
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);
    });

    testWidgets('calls onPressed callback when item is pressed',
        (WidgetTester tester) async {
      int pressedIndex = -1;

      final List<String> testData = ['Item 1', 'Item 2', 'Item 3'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlatGridView(
              data: testData,
              renderItem: (data) => Text(data),
              itemWidth: 100,
              itemHeight: 100,
              onPressed: (index) {
                pressedIndex = index;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Item 2'));
      expect(pressedIndex, 1);
    });
  });
}
