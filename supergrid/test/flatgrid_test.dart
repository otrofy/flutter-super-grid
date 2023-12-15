import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supergrid/flatgrid.dart';

void main() {
  group('FlatGridView', () {
    // Test data
    final List testData = ['Item 1', 'Item 2', 'Item 3'];

    // Test render function
    Widget testRenderItem(dynamic data) {
      return Text(data.toString());
    }

    testWidgets('Should display "No items" when data is empty', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlatGridView(
            data: [],
            itemsPerRow: 2,
            itemSize: 100,
            renderItem: testRenderItem,
          ),
        ),
      );

      expect(find.text('No items'), findsOneWidget);
    });

    testWidgets('Should display items when data is not empty', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlatGridView(
            data: testData,
            itemsPerRow: 2,
            itemSize: 100,
            renderItem: testRenderItem,
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);
    });

    testWidgets('Should call onPressed callback when item is pressed',
        (tester) async {
      int pressedIndex = -1;

      await tester.pumpWidget(
        MaterialApp(
          home: FlatGridView(
            data: testData,
            itemsPerRow: 2,
            itemSize: 100,
            renderItem: testRenderItem,
            onPressed: (index) {
              pressedIndex = index;
            },
          ),
        ),
      );

      await tester.tap(find.text('Item 2'));
      expect(pressedIndex, 1);
    });
  });
}
