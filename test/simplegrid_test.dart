import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_super_grid/simplegrid.dart';

void main() {
  group('SimpleGridView', () {
    testWidgets('renders empty grid with "No items" text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SimpleGridView(
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
            body: SimpleGridView(
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
  });
}
