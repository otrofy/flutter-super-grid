import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supergrid/sectiongrid.dart';

void main() {
  group('SectionGridView', () {
    testWidgets('Renders correctly with empty sections',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SectionGridView(
              itemsPerRow: 3,
              sections: const [],
              renderItem: (data) =>
                  Container(), // Replace with your custom item widget
              itemSize: 100,
            ),
          ),
        ),
      );

      expect(find.text('No items'), findsOneWidget);
    });

    testWidgets('Renders correctly with non-empty sections',
        (WidgetTester tester) async {
      final sections = [
        {
          'title': 'Section 1',
          'data': [1, 2, 3, 4, 5, 6, 7],
        },
        {
          'title': 'Section 2',
          'data': [4, 5, 6, 7, 8, 9, 10],
        },
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SectionGridView(
              itemsPerRow: 2,
              sections: sections,
              renderItem: (data) =>
                  Container(), // Replace with your custom item widget
              itemSize: 100,
            ),
          ),
        ),
      );

      expect(find.text('Section 1'), findsOneWidget);
      expect(find.text('Section 2'), findsOneWidget);
      expect(
          find.byType(InkWell),
          findsNWidgets(
              6)); // Replace with the number of items in your sections
    });

    // Add more test cases as needed
  });
}
