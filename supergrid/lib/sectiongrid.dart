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
    required this.renderItem,
    required this.itemWidth,
    required this.itemHeight,
    this.color = Colors.transparent,
    this.padding = const EdgeInsets.all(0),
    this.gridViewPadding = const EdgeInsets.all(8.0),
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

  /// The width of each grid item.
  final double itemWidth;

  /// The height of each grid item.
  final double itemHeight;

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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          padding: widget.gridViewPadding,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: widget.itemWidth,
                            childAspectRatio:
                                widget.itemWidth / widget.itemHeight,
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
