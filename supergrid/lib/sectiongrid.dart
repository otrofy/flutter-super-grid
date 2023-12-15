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

// This is the state class for SectionGridView which extends Stateful widget.
// It defines the state and behavior of the SectionGridView.
class _SectionGridViewState extends State<SectionGridView> {
  // initState is the first method called when the widget is created (after the constructor).
  // Here it calls super.initState() to ensure the parent class is initialized properly.
  @override
  void initState() {
    super
        .initState(); // Always call super.initState() first in initState() method.
  }

  // getTitleWidget is a helper method that creates a title widget with the provided title string.
  // It styles and aligns the title text based on the widget's properties.
  Widget getTitleWidget(String title) {
    return Container(
      color: widget
          .titleBackgroundColor, // Sets the background color of the title container.
      width: double
          .infinity, // Ensures the container fills the width of its parent.
      padding: widget.titlePadding, // Applies padding around the title text.
      child: Align(
        // Align widget allows alignment of the child within itself.
        alignment: {
          // A map that returns the correct alignment based on the titleAlignment enum.
          TitleAlignment.start: Alignment.centerLeft,
          TitleAlignment.center: Alignment.center,
          TitleAlignment.end: Alignment.centerRight,
        }[widget
            .titleAlignment]!, // The '!' asserts that the value will not be null.
        child: Text(
          title, // The actual title text.
          style: widget
              .titleTextStyle, // The style for the title text, defined in the parent widget.
        ),
      ),
    );
  }

  // The build method is where the UI is constructed.
  @override
  Widget build(BuildContext context) {
    // Padding widget to add space around the entire grid view.
    return Padding(
      padding: widget.padding, // Uses padding from the widget's properties.
      child: Container(
        color:
            widget.color, // Sets the background color for the grid container.
        child: Stack(
          // Stack widget allows stacking of widgets on top of each other.
          children: [
            // This Visibility widget conditionally displays the 'No items' text
            // when there are no sections to display.
            Visibility(
              visible: widget
                  .sections.isEmpty, // Checks if the sections list is empty.
              child: const Center(
                  child: Text(
                      'No items')), // Centered text to display when no items are present.
            ),
            // This Visibility widget conditionally displays the grid view
            // when there are sections to display.
            Visibility(
              visible: widget.sections
                  .isNotEmpty, // Checks if there are sections to display.
              // ListView.builder is used to create a list of sections dynamically.
              child: ListView.builder(
                itemCount: widget
                    .sections.length, // The number of sections to display.
                itemBuilder: (context, sectionIndex) {
                  // Retrieves the section data based on the index.
                  final section = widget.sections[sectionIndex];
                  final title =
                      section['title'] as String; // The title of the section.
                  final data = section['data']
                      as List; // The data items within the section.
                  final dataInverted = data.reversed
                      .toList(); // Reverses the data if invertedRow is true.

                  // Column widget to layout the title and the grid view vertically.
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Aligns the children to the start of the main-axis.
                    children: [
                      getTitleWidget(
                          title), // Calls getTitleWidget to get the title widget.
                      // SizedBox constrains the size of the grid view.
                      SizedBox(
                        height: widget
                            .gridViewHeight, // The height of the grid view.
                        width:
                            widget.gridViewWidth, // The width of the grid view.
                        // Padding around the grid view.
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          // GridView.builder creates a grid of items.
                          child: GridView.builder(
                            scrollDirection: widget
                                    .horizontal // Sets the scroll direction of the grid view.
                                ? Axis.horizontal
                                : Axis.vertical,
                            padding: widget
                                .gridViewPadding, // The padding inside the grid view.
                            shrinkWrap:
                                true, // Ensures the GridView takes minimum space.
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: widget
                                  .itemsPerRow, // The number of items per row/column.
                              mainAxisExtent: widget
                                  .itemSize, // The size of items on the main axis.
                              crossAxisSpacing: widget
                                  .horizontalSpacing, // Spacing between items horizontally.
                              mainAxisSpacing: widget
                                  .verticalSpacing, // Spacing between items vertically.
                            ),
                            itemCount: data
                                .length, // The number of items in the section.
                            itemBuilder: (context, index) {
                              // Builder function for each item.
                              // Decides if the row should be inverted based on the invertedRow property.
                              final itemData = widget.invertedRow
                                  ? dataInverted[index]
                                  : data[index];
                              // InkWell wraps each item to provide tap functionality.
                              return InkWell(
                                onTap: () {
                                  // Calls the onPressed callback when the item is tapped.
                                  if (widget.onPressed != null) {
                                    widget.onPressed!(sectionIndex, index);
                                  }
                                },
                                // Calls renderItem to build the UI for each item.
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
