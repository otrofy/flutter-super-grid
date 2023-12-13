import 'package:flutter/material.dart';

class SectionGrid extends StatefulWidget {
  final List<dynamic> sections;
  final double itemDimension;
  final bool fixed;
  final double spacing;
  final dynamic style;
  final dynamic additionalRowStyle;
  final dynamic itemContainerStyle;
  final double staticDimension;
  final Function onLayout;
  final double maxDimension;
  final String listKey;
  final Function keyExtractor;
  final bool invertedRow;
  final int maxItemsPerRow;
  final bool adjustGridToStyles;
  final dynamic customSectionList;

  SectionGrid({
    required this.sections,
    this.itemDimension = 120,
    this.fixed = false,
    this.spacing = 10,
    this.style,
    this.additionalRowStyle,
    this.itemContainerStyle,
    this.staticDimension,
    this.onLayout,
    this.maxDimension,
    this.listKey,
    this.keyExtractor,
    this.invertedRow = false,
    this.maxItemsPerRow,
    this.adjustGridToStyles = false,
    this.customSectionList,
  });

  @override
  _SectionGridState createState() => _SectionGridState();
}

class _SectionGridState extends State<SectionGrid> {
  double totalDimension = 0;

  @override
  void initState() {
    super.initState();
    totalDimension = widget.staticDimension ?? MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (widget.staticDimension == null) {
          totalDimension = constraints.maxWidth;
        }

        if (widget.onLayout != null) {
          widget.onLayout!(constraints);
        }

        // Calculate the number of items per row and the item width based on the total width
        int itemsPerRow = (totalDimension / widget.itemDimension).floor();
        double itemWidth = totalDimension / itemsPerRow;

        return ListView.builder(
          itemCount: widget.sections.length,
          itemBuilder: (context, index) {
            var section = widget.sections[index];
            var items = section['data'];

            return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: itemsPerRow,
                childAspectRatio: itemWidth / widget.itemDimension,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Container(
                  child: widget.renderItem(items[index]),
                );
              },
            );
          },
        );
      },
    );
  }
}