/// this is a library for creating grid views with different layouts and functionalities.
library supergrid;

import 'package:flutter/material.dart';

///This is the enum
enum TitleAlignment {
  start,
  center,
  end,
}

// A widget that displays a flat grid of items.
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

  /// The size of the grid item in the main axis direction (The grid will occupy the whole space available in the cross axis).
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

/// A widget that displays a grid of sections.
class SectionGridView extends StatefulWidget {
  /// Creates a `SectionGridView`.
  const SectionGridView({
    super.key,
    required this.sections, // required property
    required this.itemsPerRow, // required property
    required this.renderItem, // required property
    required this.itemSize, // required property
    this.physics,
    this.minItemDimension = 120.0, // default value set to 120 px
    this.gridViewHeight = 300, // default value set to 300 px
    this.gridViewWidth = double.infinity, // default value set to infinity
    this.color = Colors.transparent, // default value set to transparent
    this.padding = const EdgeInsets.all(0), // default value set to 0
    this.gridViewPadding =
        const EdgeInsets.all(8.0), // default value set to 8 px
    this.horizontal = false, // default value set to false
    this.verticalSpacing = 10, // default value set to 10 px
    this.horizontalSpacing = 10, // default value set to 10 px
    this.invertedRow = false, // default value set to false
    this.onPressed, // default value set to null
    this.titleAlignment = TitleAlignment.start, // default value set to start
    this.titleBackgroundColor =
        Colors.transparent, // default value set to transparent
    this.titlePadding = const EdgeInsets.all(8.0), // default value set to 8 px
    this.titleTextStyle = const TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      color: Colors.black,
    ), // default value set to normal, 16 px, black
  });

  /// The background color of the grid container.
  final Color color;

  /// The number of items per row if gridview grows vertically or items per column if gridview grows horizontally.
  final int itemsPerRow;

  /// The size of the grid item in the main axis direction (The grid will occupy the whole space available in the cross axis).
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

  /// The minimum dimension (width or height) of each grid item.
  final double minItemDimension;

  final ScrollPhysics? physics;

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
                physics: widget.physics,
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
                              mainAxisExtent: (widget.minItemDimension >
                                      widget.itemSize
                                  ? widget.minItemDimension
                                  : widget
                                      .itemSize), // The size of items on the main axis.
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

/// A widget that displays a simple grid view.
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
    this.minItemDimension = 80.0,
  });

  /// The background color of the grid container.
  final Color color;

  /// The width of each grid item.
  final double itemWidth;

  /// The number of items per row if gridview grows vertically or items per column if gridview grows horizontally.
  final int itemsPerRow;

  /// The size of the grid item in the main axis direction (The grid will occupy the whole space available in the cross axis).
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

  /// The minimum dimension (width or height) of each grid item.
  final double minItemDimension;

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
                      // If itemsPerRow 0 > , use SliverGridDelegateWithFixedCrossAxisCount. Otherwise, use SliverGridDelegateWithMaxCrossAxisExtent.
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
                          mainAxisExtent:
                              (widget.minItemDimension > widget.itemSize
                                  ? widget.minItemDimension
                                  : widget.itemSize),
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
