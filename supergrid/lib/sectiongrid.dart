library supergrid;

import 'package:flutter/material.dart';

enum TitleAlignment {
  start,
  center,
  end,
}

/// A widget that displays a grid of sections.
class SectionGridView extends StatefulWidget {
  /// Creates a `SectionGridView`.
  const SectionGridView({
    super.key,
    required this.sections,
    required this.itemsPerRow,
    required this.renderItem,
    required this.itemSize,
    this.gridViewHeight = 500,
    this.gridViewWidth = double.infinity,
    this.color = Colors.transparent,
    this.padding = const EdgeInsets.all(0),
    this.gridViewPadding = const EdgeInsets.all(8.0),
    this.horizontal = false,
    this.verticalSpacing = 10,
    this.horizontalSpacing = 10,
    this.invertedRow = false,
    this.onPressed,
    this.titleAlignment = TitleAlignment.start,
    this.titleBackgroundColor = Colors.transparent,
    this.titlePadding = const EdgeInsets.all(8.0),
    this.titleTextStyle = const TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      color: Colors.black,
    ),
  });

  /// The background color of the grid container.
  final Color color;

  /// The number of items per row if gridview grows vertically or items per column if gridview grows horizontally.
  final int itemsPerRow;

  /// The size of the grid item in the main axis direction [The grid will occupy the whole space available in the cross axis].
  final double itemSize;

  /// The height of the gridview.
  final double gridViewHeight;

  /// The width of the gridview.
  final double gridViewWidth;

  /// Whether the gridview grows horizontally or vertically.
  final bool horizontal;

  /// The spacing between grid items vertically.
  final double verticalSpacing;

  /// The spacing between grid items horizontally.
  final double horizontalSpacing;

  /// The padding around the grid view.
  final EdgeInsets gridViewPadding;

  /// The padding around each section.
  final EdgeInsets padding;

  /// The sections to display in the grid.
  final List<Map<String, dynamic>> sections;

  /// The function that renders each item in the grid.
  final Widget Function(dynamic data) renderItem;

  /// The callback function when an item is pressed.
  final void Function(int sectionIndex, int index)? onPressed;

  /// The padding around the title.
  final EdgeInsets titlePadding;

  /// The alignment of the title.
  final TitleAlignment titleAlignment;

  /// The background color of the title container.
  final Color titleBackgroundColor;

  /// The style of the title.
  final TextStyle titleTextStyle;

  /// Whether to invert the row.
  final bool invertedRow;

  @override
  State<SectionGridView> createState() => _SectionGridViewState();
}

class _SectionGridViewState extends State<SectionGridView> {
  @override
  void initState() {
    super.initState();
  }

  Widget getTitleWidget(String title) {
    return Container(
      color: widget.titleBackgroundColor,
      width: double.infinity, // Full width
      padding: widget.titlePadding,
      child: Align(
        alignment: {
          TitleAlignment.start: Alignment.centerLeft,
          TitleAlignment.center: Alignment.center,
          TitleAlignment.end: Alignment.centerRight,
        }[widget.titleAlignment]!,
        child: Text(
          title,
          style: widget.titleTextStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Container(
        color: widget.color,
        child: Stack(
          children: [
            Visibility(
              visible: widget.sections.isEmpty,
              child: const Center(child: Text('No items')),
            ),
            Visibility(
              visible: widget.sections.isNotEmpty,
              child: ListView.builder(
                itemCount: widget.sections.length,
                itemBuilder: (context, sectionIndex) {
                  final section = widget.sections[sectionIndex];
                  final title = section['title'] as String;
                  final data = section['data'] as List;
                  final dataInverted = data.reversed.toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getTitleWidget(title),
                      SizedBox(
                        height: widget.gridViewHeight,
                        width: widget.gridViewWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            scrollDirection: widget.horizontal
                                ? Axis.horizontal
                                : Axis.vertical,
                            padding: widget.gridViewPadding,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: widget.itemsPerRow,
                              mainAxisExtent: widget.itemSize,
                              crossAxisSpacing: widget.horizontalSpacing,
                              mainAxisSpacing: widget.verticalSpacing,
                            ),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final itemData = widget.invertedRow
                                  ? dataInverted[index]
                                  : data[index];
                              return InkWell(
                                onTap: () {
                                  if (widget.onPressed != null) {
                                    widget.onPressed!(sectionIndex, index);
                                  }
                                },
                                child: widget.renderItem(itemData),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
