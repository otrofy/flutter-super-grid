import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supergrid/sectiongrid.dart';

void main() {
  group('SectionGridView', () {
    testWidgets('Renders empty indicator when section is empty',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SectionGridView(
              color: Colors.white,
              maxItemWidth: 200,
              horizontalSpacing: 10,
              verticalSpacing: 10,
              padding: EdgeInsets.all(10),
              sections: const [],
              renderItem: (data) => Container(),
              itemCount: 0,
              boxDecoration: BoxDecoration(),
              verticalAlignment: ItemAlignment.start,
              horizontalAlignment: ItemAlignment.start,
              onPressed: null,
            ),
          ),
        ),
      );

      expect(find.text('No items'), findsOneWidget);
    });

    testWidgets('Renders section title and items when section is not empty',
        (tester) async {
      final sections = [
        {
          'title': 'Section 1',
          'data': [1, 2, 3]
        },
        {
          'title': 'Section 2',
          'data': [4, 5, 6]
        },
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SectionGridView(
              color: Colors.white,
              maxItemWidth: 200,
              horizontalSpacing: 10,
              verticalSpacing: 10,
              padding: EdgeInsets.all(10),
              sections: const [
                {
                  'title': 'title 1',
                  'data': [1, 2, 3]
                },
                {
                  'title': 'title 2',
                  'data': [4, 5, 6]
                },
              ],
              renderItem: (data) => Container(),
              itemCount: sections.length,
              boxDecoration: BoxDecoration(),
              verticalAlignment: ItemAlignment.start,
              horizontalAlignment: ItemAlignment.center,
              onPressed: null,
            ),
          ),
        ),
      );

      expect(find.text('Section 1'), findsOneWidget);
      expect(find.text('Section 2'), findsOneWidget);
      expect(find.byType(InkWell), findsNWidgets(6));
    });
  });
}
