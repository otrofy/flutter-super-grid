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
    required this.color,
    required this.maxItemWidth,
    this.itemAspectRatio = 1.0,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
    required this.padding,
    required this.sections,
    required this.renderItem,
    required this.itemCount,
    this.boxDecoration = const BoxDecoration(),
    required this.crossAxisAlignment,
    required this.mainAxisAlignment,
    required this.onPressed,
    required this.onLikePressed,
    required this.icon,
    this.gridViewPadding = const EdgeInsets.all(8.0),
    this.titleAlignment = TitleAlignment.start,
    this.titleBackgroundColor = Colors.transparent,
    this.titlePadding = const EdgeInsets.all(8.0),
    this.titleColor = Colors.white,
  });

  /// The background color of the grid.
  final Color color;

  /// The maximum width of each grid item.
  final double maxItemWidth;

  /// The aspect ratio of each grid item. The aspect ratio is width / height.
  final double itemAspectRatio;

  /// The spacing between grid items along the cross axis.
  final double crossAxisSpacing;

  /// The spacing between grid items along the main axis.
  final double mainAxisSpacing;

  /// The padding around the grid view.
  final EdgeInsets gridViewPadding;

  /// The padding around each section.
  final EdgeInsets padding;

  /// The list of sections to display.
  final List sections;

  /// The function that renders each item in the grid.
  final Widget Function(Object data) renderItem;

  /// The total number of items in the grid.
  final int itemCount;

  /// The decoration for each grid item.
  final BoxDecoration boxDecoration;

  /// The alignment of items along the cross axis.
  final CrossAxisAlignment crossAxisAlignment;

  /// The alignment of items along the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// The callback function when an item is pressed.
  final void Function(int index)? onPressed;

  /// The callback function when the like button is pressed.
  final void Function(int index, bool liked)? onLikePressed;

  /// The icon to display in the grid.
  final IconData icon;

  /// The padding around the title.
  final EdgeInsets titlePadding;

  /// The alignment of the title.
  final TitleAlignment titleAlignment;

  /// The color of the title.
  final Color titleColor;

  /// The background color of the title.
  final Color titleBackgroundColor;

  @override
  State<SectionGridView> createState() => _SectionGridViewState();
}

class _SectionGridViewState extends State<SectionGridView> {
  List<bool> likedStates = [];

  @override
  void initState() {
    super.initState();
    likedStates = List<bool>.filled(widget.itemCount, false);
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: widget.titleColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
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
                    final section = widget.sections[sectionIndex] as Map;
                    final title = section['title'] as String;
                    final data = section['data'] as List;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getTitleWidget(title),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: widget.maxItemWidth,
                              crossAxisSpacing: widget.crossAxisSpacing,
                              mainAxisSpacing: widget.mainAxisSpacing,
                            ),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final itemData = data[index];
                              return InkWell(
                                onTap: () {
                                  if (widget.onPressed != null) {
                                    widget.onPressed!(index);
                                  }
                                },
                                child: Container(
                                  decoration: widget.boxDecoration,
                                  child: Column(
                                    crossAxisAlignment:
                                        widget.crossAxisAlignment,
                                    mainAxisAlignment: widget.mainAxisAlignment,
                                    children: [
                                      widget.renderItem(itemData),
                                    ],
                                  ),
                                ),
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
      ),
    );
  }
}
