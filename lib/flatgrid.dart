library supergrid;

import 'package:flutter/material.dart';

enum TitleAlignment {
  start,
  center,
  end,
}

/// A widget that displays a grid of sections.
class FlatGridView extends StatefulWidget {
  /// Creates a `FlatGridView`.
  const FlatGridView({
    super.key,
    required this.data,
    required this.renderItem,
    required this.itemsPerRow,
    required this.itemSize,
    this.minItemDimension = 120.0, // default value set to 120 px
    this.color = Colors.transparent,
    this.padding = const EdgeInsets.all(16),
    this.gridViewPadding = const EdgeInsets.all(8.0),
    this.verticalSpacing = 10,
    this.horizontalSpacing = 10,
    this.horizontal = false,
    this.invertedRow = false,
    this.onPressed,
  });

  /// The sections to display in the grid.
  final List data;

  /// The number of items per row if gridview grows vertically or items per column if gridview grows horizontally.
  final int itemsPerRow;

  /// The background color of the grid container.
  final Color color;

  /// The size of the grid item in the main axis direction [The grid will occupy the whole space available in the cross axis].
  final double itemSize;

  /// The spacing between grid items vertically.
  final double verticalSpacing;

  /// The spacing between grid items horizontally.
  final double horizontalSpacing;

  /// The padding for the container.
  final EdgeInsets padding;

  /// The padding for the gridView.
  final EdgeInsets gridViewPadding;

  /// The function that renders each item in the grid.
  final Widget Function(dynamic data) renderItem;

  /// The callback function when an item is pressed.
  final void Function(int index)? onPressed;

  /// Whether to invert the row.
  final bool invertedRow;

  /// Whether the grid view is horizontal.
  final bool horizontal;

  /// The minimum dimension (width or height) of each grid item.
  final double minItemDimension;

  @override
  State<FlatGridView> createState() => _FlatGridViewState();
}

// The _FlatGridViewState class manages the state for the FlatGridView widget.
// It extends the generic State class specialized for the FlatGridView.
class _FlatGridViewState extends State<FlatGridView> {
  // The initState method is the first method called when this object is
  // inserted into the tree. The Flutter framework will call this method exactly
  // once for each State object it creates.
  @override
  void initState() {
    super
        .initState(); // Always call super.initState() first in initState() method.
  }

  // The build method is called each time Flutter needs to render the widget on
  // the screen. It returns a widget tree that Flutter will display.
  @override
  Widget build(BuildContext context) {
    // Padding widget adds space around the grid view.
    return Padding(
      padding: widget.padding, // Uses padding from the widget's properties.
      child: Container(
        color: widget
            .color, // Sets the background color for the entire container of the grid view.
        // Stack allows for overlapping of widgets.
        child: Stack(
          children: [
            // The Visibility widget conditionally renders its child widget based on the visible property.
            // This particular Visibility widget displays a message when there are no items to show.
            Visibility(
              visible: widget.data
                  .isEmpty, // Determines visibility based on if the data list is empty.
              child: const Center(
                  child: Text(
                      'No items')), // Centered text to display when no items are present.
            ),
            // Another Visibility widget to only show the grid when there is data.
            Visibility(
              visible: widget.data
                  .isNotEmpty, // Visibility depends on if there's data in the list.
              // SingleChildScrollView allows the grid to be scrollable.
              child: SingleChildScrollView(
                scrollDirection: widget.horizontal
                    ? Axis.horizontal
                    : Axis
                        .vertical, // Sets the scroll direction based on the horizontal property.
                // GridView.builder creates a grid of items.
                child: GridView.builder(
                  physics:
                      const NeverScrollableScrollPhysics(), // Disables scrolling within the GridView itself.
                  scrollDirection: widget.horizontal
                      ? Axis.horizontal
                      : Axis
                          .vertical, // Sets the scroll direction of the GridView.
                  padding:
                      widget.gridViewPadding, // Padding within the GridView.
                  shrinkWrap:
                      true, // Ensures that the GridView only occupies space for its children.
                  // The gridDelegate manages the layout of the grid.
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget
                        .itemsPerRow, // Number of items per row or column.
                    mainAxisExtent: (widget.minItemDimension > widget.itemSize
                        ? widget.minItemDimension
                        : widget
                            .itemSize), // The size of items on the main axis.
                    crossAxisSpacing: widget
                        .horizontalSpacing, // Spacing between items horizontally.
                    mainAxisSpacing: widget
                        .verticalSpacing, // Spacing between items vertically.
                  ),
                  itemCount:
                      widget.data.length, // The number of items to display.
                  itemBuilder: (context, index) {
                    // Builder function that creates each item.
                    // Determines the data for the current item, inverting if necessary.
                    final itemData = widget.invertedRow
                        ? widget.data.reversed.toList()[index]
                        : widget.data[index];
                    // InkWell is used to detect taps on individual grid items.
                    return InkWell(
                      onTap: () {
                        // Calls the onPressed callback when an item is tapped.
                        if (widget.onPressed != null) {
                          widget.onPressed!(index);
                        }
                      },
                      // The renderItem function is called to build the UI for each item.
                      child: widget.renderItem(itemData),
                    );
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
