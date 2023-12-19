library supergrid;

import 'package:flutter/material.dart';

enum TitleAlignment {
  start,
  center,
  end,
}

/// A widget that displays a grid of sections.
class SimpleGridView extends StatefulWidget {
  /// Creates a `SimpleGridView`.
  const SimpleGridView({
    super.key,
    required this.data,
    required this.renderItem,
    required this.itemWidth,
    required this.itemHeight,
    this.itemsPerRow = 0,
    this.itemSize = 100,
    this.color = Colors.transparent,
    this.padding = const EdgeInsets.all(16),
    this.gridViewPadding = const EdgeInsets.all(8.0),
    this.verticalSpacing = 10,
    this.horizontalSpacing = 10,
    this.horizontal = false,
    this.invertedRow = false,
  });

  /// The background color of the grid container.
  final Color color;

  /// The width of each grid item.
  final double itemWidth;

  /// The number of items per row if gridview grows vertically or items per column if gridview grows horizontally.
  final int itemsPerRow;

  /// The size of the grid item in the main axis direction [The grid will occupy the whole space available in the cross axis].
  final double itemSize;

  /// The height of each grid item.
  final double itemHeight;

  /// The spacing between grid items vertically.
  final double verticalSpacing;

  /// The spacing between grid items horizontally.
  final double horizontalSpacing;

  /// The padding for the container.
  final EdgeInsets padding;

  /// The padding for the gridView.
  final EdgeInsets gridViewPadding;

  /// The sections to display in the grid.
  final List data;

  /// The function that renders each item in the grid.
  final Widget Function(dynamic data) renderItem;

  /// Whether to invert the row.
  final bool invertedRow;

  /// Whether the grid view is horizontal.
  final bool horizontal;

  @override
  State<SimpleGridView> createState() => _SimpleGridViewState();
}

// _SimpleGridViewState manages the state for the SimpleGridView widget.
// It extends State, providing the logic and UI for SimpleGridView.
class _SimpleGridViewState extends State<SimpleGridView> {
  // The initState method is called when this widget is inserted into the tree.
  // This implementation calls super.initState to ensure the parent class is initialized properly.
  @override
  void initState() {
    super
        .initState(); // Always call super.initState() first in initState() method.
  }

  // The build method describes the part of the user interface represented by this widget.
  // It returns the widget tree which Flutter will render on the screen.
  @override
  Widget build(BuildContext context) {
    // Padding widget adds space around the entire grid view.
    return Padding(
      padding:
          widget.padding, // Applies the specified padding around the grid view.
      child: Container(
        color: widget
            .color, // Sets the background color for the grid view container.
        // Stack allows placing widgets on top of each other.
        child: Stack(
          children: [
            // Visibility widget conditionally renders its child based on the 'visible' property.
            // Here, it displays a message when the data list is empty.
            Visibility(
              visible: widget.data
                  .isEmpty, // Visibility depends on whether the data list is empty.
              child: const Center(
                  child: Text(
                      'No items')), // Text displayed when no data is available.
            ),
            // Visibility widget to show the grid view when there is data.
            Visibility(
              visible: widget.data
                  .isNotEmpty, // Visibility depends on whether there's data in the list.
              // SingleChildScrollView allows the grid to be scrollable.
              child: SingleChildScrollView(
                scrollDirection: widget.horizontal
                    ? Axis.horizontal
                    : Axis
                        .vertical, // Sets the scroll direction based on the horizontal flag.
                // GridView.builder creates a grid of items.
                child: GridView.builder(
                  physics:
                      const NeverScrollableScrollPhysics(), // Disables scrolling within the GridView itself.
                  scrollDirection: widget.horizontal
                      ? Axis.horizontal
                      : Axis
                          .vertical, // Sets the scroll direction of the GridView.
                  padding: widget
                      .gridViewPadding, // Sets the padding within the GridView.
                  shrinkWrap:
                      true, // Ensures the GridView only takes up necessary space.
                  // The gridDelegate manages the layout of the grid.
                  gridDelegate: widget.itemsPerRow == 0
                      // If itemsPerRow is 2, use SliverGridDelegateWithFixedCrossAxisCount. Otherwise, use SliverGridDelegateWithMaxCrossAxisExtent.
                      // This is because SliverGridDelegateWithFixedCrossAxisCount requires a fixed number of items per row.
                      // SliverGridDelegateWithMaxCrossAxisExtent allows for a variable number of items per row.
                      ? SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: widget
                              .itemWidth, // The maximum extent of items in the cross axis.
                          childAspectRatio: widget.itemWidth /
                              widget
                                  .itemHeight, // Aspect ratio for children in the grid.
                          crossAxisSpacing: widget
                              .horizontalSpacing, // Spacing between items along the cross axis.
                          mainAxisSpacing: widget
                              .verticalSpacing, // Spacing between items along the main axis.
                        )
                      : SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: widget
                              .itemsPerRow, // Number of items per row or column.
                          mainAxisExtent: widget
                              .itemSize, // The size of items in the main axis.
                          crossAxisSpacing: widget
                              .horizontalSpacing, // Spacing between items horizontally.
                          mainAxisSpacing: widget
                              .verticalSpacing, // Spacing between items vertically.
                        ),
                  itemCount: widget
                      .data.length, // The number of items in the data list.
                  itemBuilder: (context, index) {
                    // Builder function to construct each item in the grid.
                    // Chooses the appropriate data, inverting the order if invertedRow is true.
                    final itemData = widget.invertedRow
                        ? widget.data.reversed.toList()[index]
                        : widget.data[index];
                    // Calls renderItem to build the UI for each item.
                    return widget.renderItem(itemData);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
