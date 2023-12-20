import 'package:flutter/material.dart';
import 'package:flutter_super_grid/flutter_super_grid.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SectionGridView Tests', () {
    testWidgets('displays "No items" when sections are empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SectionGridView(
            sections: const [],
            itemsPerRow: 2,
            renderItem: (_) => const Placeholder(),
            itemSize: 100,
          ),
        ),
      ));

      expect(find.text('No items'), findsOneWidget);
    });

    testWidgets('does not display "No items" when sections are not empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SectionGridView(
            sections: const [
              {
                'title': 'Section 1',
                'data': [1, 2]
              }
            ],
            itemsPerRow: 2,
            renderItem: (_) => const Placeholder(),
            itemSize: 100,
          ),
        ),
      ));

      expect(find.text('No items'), findsNothing);
    });

    testWidgets('renders a section with the correct title and items',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SectionGridView(
            sections: const [
              {
                'title': 'Section 1',
                'data': [1, 2]
              }
            ],
            itemsPerRow: 2,
            renderItem: (data) => Text('Item $data'),
            itemSize: 100,
          ),
        ),
      ));

      expect(find.text('Section 1'), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
    });

    testWidgets('onPressed callback is triggered correctly',
        (WidgetTester tester) async {
      int pressedSectionIndex = -1;
      int pressedItemIndex = -1;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SectionGridView(
            sections: const [
              {
                'title': 'Section 1',
                'data': [1, 2]
              }
            ],
            itemsPerRow: 2,
            renderItem: (data) => Text('Item $data'),
            itemSize: 100,
            onPressed: (sectionIndex, itemIndex) {
              pressedSectionIndex = sectionIndex;
              pressedItemIndex = itemIndex;
            },
          ),
        ),
      ));

      await tester.tap(find.text('Item 1'));
      await tester.pump();

      expect(pressedSectionIndex, 0);
      expect(pressedItemIndex, 0);
    });

    testWidgets('invertedRow inverts the order of items',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SectionGridView(
            sections: const [
              {
                'title': 'Section 1',
                'data': [1, 2, 3]
              }
            ],
            itemsPerRow: 3,
            renderItem: (data) => Text('Item $data'),
            itemSize: 100,
            invertedRow: true,
          ),
        ),
      ));

      final firstItemFinder = find.text('Item 3');
      final lastItemFinder = find.text('Item 1');

      expect(firstItemFinder, findsOneWidget);
      expect(lastItemFinder, findsOneWidget);
    });

    testWidgets(
        'checks alignment of the title based on titleAlignment property',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SectionGridView(
            sections: const [
              {
                'title': 'Section 1',
                'data': [1]
              }
            ],
            itemsPerRow: 1,
            renderItem: (_) => const Placeholder(),
            itemSize: 100,
          ),
        ),
      ));

      final titleAlign = tester.widget<Align>(find.byType(Align).first);
      expect(titleAlign.alignment, Alignment.centerRight);
    });
  });
}
