import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supergrid/flatgrid.dart';

void main() {
  group('FlatGridView Tests', () {
    testWidgets('displays "No items" when data is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: FlatGridView(
            data: [],
            itemsPerRow: 2,
            renderItem: (_) => const Placeholder(),
            itemSize: 100,
          ),
        ),
      ));

      expect(find.text('No items'), findsOneWidget);
    });

    testWidgets('renders items when data is not empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: FlatGridView(
            data: const [1, 2],
            itemsPerRow: 2,
            renderItem: (data) => Text('Item $data'),
            itemSize: 100,
          ),
        ),
      ));

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
    });

    testWidgets('onPressed callback is triggered with correct index',
        (WidgetTester tester) async {
      int pressedIndex = -1;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: FlatGridView(
            data: [1, 2],
            itemsPerRow: 2,
            renderItem: (data) => Text('Item $data'),
            itemSize: 100,
            onPressed: (index) {
              pressedIndex = index;
            },
          ),
        ),
      ));

      await tester.tap(find.text('Item 1'));
      await tester.pump();

      expect(pressedIndex, 0);
    });

    testWidgets('invertedRow inverts the order of items',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: FlatGridView(
            data: [1, 2, 3],
            itemsPerRow: 3,
            renderItem: (data) => Text('Item $data'),
            itemSize: 100,
            invertedRow: true,
          ),
        ),
      ));

      expect(find.text('Item 3'), findsWidgets);
    });

    testWidgets('horizontal flag changes scroll direction',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: FlatGridView(
            data: const [1],
            itemsPerRow: 1,
            renderItem: (_) => const Placeholder(),
            itemSize: 100,
            horizontal: true,
          ),
        ),
      ));

      final scrollViewFinder = find.byType(SingleChildScrollView);
      final SingleChildScrollView scrollView = tester.widget(scrollViewFinder);
      expect(scrollView.scrollDirection, Axis.horizontal);
    });
  });
}
