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
    this.itemsPerRow = 3,
    this.itemSize = 120,
    this.minItemDimension = 120.0, // default value set to 120 px
    this.style = const FlatGridViewStyle(),
    this.itemContainerStyle = const ContainerStyle(),
    this.verticalSpacing = 10,
    this.horizontalSpacing = 10,
    this.isFixed = false,
    this.horizontal = false,
    this.invertedRow = false,
    this.adjustGridToStyles = false,
    this.gridViewHeight = 300,
    this.gridViewWidth = double.infinity,
    this.containerWidth = double.infinity,
    this.containerHeight = 300,
    this.footerWidget = const SizedBox(),
    this.physics,
    this.onPressed,
    this.onNewItemAdded,
  });

  /// The callback function when a new item is added to the data list.
  final void Function()? onNewItemAdded;

  /// is true will use the original size instead of adjusting to grid
  final bool isFixed;

  /// Set to true when you want the library to automatically adjust the total dimensions of the grid based on style and container size
  final bool adjustGridToStyles;

  /// The style of the grid view.
  final FlatGridViewStyle style;

  /// The style of the container of the widget in the grid view, this is only when [isFixed] is false.
  final ContainerStyle itemContainerStyle;

  /// The data to display in the grid.
  final List data;

  /// The widget rendered at the bottom of the grid view.
  final Widget footerWidget;

  /// The number of items per row if gridview grows vertically or items per column if gridview grows horizontally, this is only when [isFixed] is false..
  final int itemsPerRow;

  /// The height of the gridview.
  final double gridViewHeight;

  /// The width of the gridview.
  final double gridViewWidth;

  /// The width of the main container, only matters if it's greater than [gridViewWidth] .
  final double containerWidth;

  /// The Height of the main container, only matters if it's greater than [gridViewHeight] .
  final double containerHeight;

  /// The size of the grid item in the main axis direction (The grid will occupy the whole space available in the cross axis), this is only when [isFixed] is false.
  final double itemSize;

  /// The spacing between grid items vertically.
  final double verticalSpacing;

  /// The spacing between grid items horizontally.
  final double horizontalSpacing;

  /// The function that renders each item in the grid.
  final Widget Function(dynamic data) renderItem;

  /// The callback function when an item is pressed.
  final void Function(int index)? onPressed;

  /// Whether to invert the row.
  final bool invertedRow;

  /// Whether the grid view is horizontal.
  final bool horizontal;

  /// The minimum dimension (width or height) of each grid item, this is only when [isFixed] is false.
  final double minItemDimension;

  /// The physics of the grid view.
  final ScrollPhysics? physics;

  @override
  State<FlatGridView> createState() => _FlatGridViewState();
}

// The _FlatGridViewState class manages the state for the FlatGridView widget.
// It extends the generic State class specialized for the FlatGridView.
class _FlatGridViewState extends State<FlatGridView> {
  @override
  void didUpdateWidget(FlatGridView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if new items have been added to the list
    if (widget.data.length > oldWidget.data.length) {
      // Invoke the callback function
      widget.onNewItemAdded?.call();
    }
  }

  @override
  void initState() {
    super
        .initState(); // Always call super.initState() first in initState() method.
  }

  // The build method is called each time Flutter needs to render the widget on
  // the screen. It returns a widget tree that Flutter will display.
  @override
  Widget build(BuildContext context) {
    final data =
        widget.invertedRow ? widget.data.reversed.toList() : widget.data;
    // Padding widget adds space around the grid view.
    return Padding(
      padding:
          widget.style.padding, // Uses padding from the widget’s properties.
      child: Container(
        width: widget.containerWidth,
        decoration: widget.style
            .decoration, // Applies the decoration from the widget’s properties.
        color: widget.style.decoration != null
            ? null
            : widget.style
                .color, // Sets the background color for the entire container of the grid view.
        // Stack allows for overlapping of widgets.
        child: Column(
          children: [
            SizedBox(
              height: widget.adjustGridToStyles
                  ? widget.containerHeight
                  : widget
                      .gridViewHeight, // The height of the grid view container.
              width: widget.adjustGridToStyles
                  ? widget.containerWidth
                  : widget
                      .gridViewWidth, // The width of the grid view container.
              child: Stack(
                children: [
                  // The Visibility widget conditionally renders its child widget based on the visible property.
                  // This particular Visibility widget displays a message when there are no items to show.
                  Visibility(
                    visible: widget.data
                        .isEmpty, // Determines visibility based on if the data list is empty.
                    child: const Center(
                        child: Text(
                            "No items")), // Centered text to display when no items are present.
                  ),
                  // Another Visibility widget to only show the grid when there is data.
                  Visibility(
                    visible: widget.data
                        .isNotEmpty, // Visibility depends on if there’s data in the list.
                    // SingleChildScrollView allows the grid to be scrollable.
                    child: SingleChildScrollView(
                      physics: widget.physics,
                      scrollDirection: widget.horizontal
                          ? Axis.horizontal
                          : Axis
                              .vertical, // Sets the scroll direction based on the horizontal property.
                      // GridView.builder creates a grid of items.
                      child: widget.isFixed
                          ? wrapWidget(
                              null,
                              data,
                              widget.renderItem,
                              widget.style,
                              widget.horizontal,
                              widget.horizontalSpacing,
                              widget.verticalSpacing,
                              widget.onPressed,
                              false)
                          : buildGridView(
                              data: data,
                              renderItem: widget.renderItem,
                              horizontal: widget.horizontal,
                              itemsPerRow: widget.itemsPerRow,
                              horizontalSpacing: widget.horizontalSpacing,
                              verticalSpacing: widget.verticalSpacing,
                              minItemDimension: widget.minItemDimension,
                              itemSize: widget.itemSize,
                              invertItems: widget.invertedRow,
                              onTapFlat: widget.onPressed,
                              padding: widget.style.gridViewPadding,
                              itemDecoration:
                                  widget.itemContainerStyle.decoration),
                    ),
                  ),
                ],
              ),
            ),
            widget.footerWidget,
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
    required this.renderItem, // required property
    this.itemsPerRow = 3, // default value set to 3
    this.itemSize = 100, // default value set to 100 px
    this.physics, // default value set to null
    this.minItemDimension = 120.0, // default value set to 120 px
    this.gridViewHeight = 300, // default value set to 300 px
    this.gridViewWidth = double.infinity, // default value set to infinity
    this.horizontal = false, // default value set to false
    this.verticalSpacing = 10, // default value set to 10 px
    this.horizontalSpacing = 10, // default value set to 10 px
    this.adjustGridToStyles = false, // default value set to false
    this.invertedRow = false, // default value set to false
    this.onPressed, // default value set to null
    this.isFixed = false, // default value set to false
    this.style =
        const SectionGridViewStyle(), // default value set to SectionGridViewStyle()
    this.onNewItemAdded, // default value set to null
    this.containerWidth = double.infinity, // default value set to infinity
    this.containerHeight = 300, // default value set to 300 px
    this.footerWidget = const SizedBox(), // default value set to SizedBox()
    this.itemContainerStyle =
        const ContainerStyle(), // default value set to ContainerStyle()
  });

  /// The style of the container of the widget in the grid view, this is only when [isFixed] is false.
  final ContainerStyle itemContainerStyle;

  /// The width of the main container, only matters if it's greater than [gridViewWidth] .
  final double containerWidth;

  /// The Height of the main container, only matters if it's greater than [gridViewHeight] .
  final double containerHeight;

  /// The size of the grid item in the main axis direction (The grid will occupy the whole space available in the cross axis), this is only when [isFixed] is false.
  final double itemSize;

  /// The footer width.
  final Widget footerWidget;

  /// The callback function when a new item is added to the sections list.
  final void Function()? onNewItemAdded;

  /// The style to to apply on the section grid.
  final SectionGridViewStyle style;

  /// whether to adjust the grid to the styles or not.
  final bool adjustGridToStyles;

  /// is true will use the original size instead of adjusting to grid
  final bool isFixed;

  /// The number of items per row if gridview grows vertically or items per column if gridview grows horizontally, this is only when [isFixed] is false..
  final int itemsPerRow;

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

  /// The sections to display in the grid.
  final List<Map<String, dynamic>> sections;

  /// The function that renders each item in the grid.
  final Widget Function(dynamic data) renderItem;

  /// The callback function when an item is pressed.
  final void Function(int sectionIndex, int index)? onPressed;

  /// Whether to invert the row.
  final bool invertedRow;

  /// The minimum dimension (width or height) of each grid item, this is only when [isFixed] is false.
  final double minItemDimension;

  /// The physics of the grid view.
  final ScrollPhysics? physics;

  @override
  State<SectionGridView> createState() => _SectionGridViewState();
}

// This is the state class for SectionGridView which extends Stateful widget.
// It defines the state and behavior of the SectionGridView.
class _SectionGridViewState extends State<SectionGridView> {
  @override
  void didUpdateWidget(SectionGridView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if new items have been added to the sections list
    if (widget.sections.length > oldWidget.sections.length) {
      // Invoke the callback function
      widget.onNewItemAdded?.call();
    }
  }

  // initState is the first method called when the widget is created (after the constructor).
  // Here it calls super.initState() to ensure the parent class is initialized properly.
  @override
  void initState() {
    super
        .initState(); // Always call super.initState() first in initState() method.
  }

  Widget getTitleWidget(String title) {
    return Container(
      color: widget.style
          .titleBackgroundColor, // Sets the background color of the title container.
      width: double
          .infinity, // Ensures the container fills the width of its parent.
      padding:
          widget.style.titlePadding, // Applies padding around the title text.
      child: Align(
        // Align widget allows alignment of the child within itself.
        alignment: {
          // A map that returns the correct alignment based on the titleAlignment enum.
          TitleAlignment.start: Alignment.centerLeft,
          TitleAlignment.center: Alignment.center,
          TitleAlignment.end: Alignment.centerRight,
        }[widget.style
            .titleAlignment]!, // The '!' asserts that the value will not be null.
        child: Text(
          title, // The actual title text.
          style: widget.style
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
      padding:
          widget.style.padding, // Uses padding from the widget's properties.
      child: Container(
        height: widget.adjustGridToStyles
            ? widget.containerHeight
            : widget.gridViewHeight, // The height of the grid view container.
        width: widget.adjustGridToStyles
            ? widget.containerWidth
            : widget.gridViewWidth,
        decoration: widget.style
            .decoration, // Applies the decoration from the widget's properties.
        color: widget.style.decoration != null
            ? null
            : widget.style
                .color, // Sets the background color for the grid container.
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
                          child: widget.isFixed
                              ? wrapWidget(
                                  sectionIndex,
                                  data,
                                  widget.renderItem,
                                  widget.style,
                                  widget.horizontal,
                                  widget.horizontalSpacing,
                                  widget.verticalSpacing,
                                  widget.onPressed,
                                  false)
                              : buildGridView(
                                  data: data,
                                  sectionIndex: sectionIndex,
                                  renderItem: widget.renderItem,
                                  horizontal: widget.horizontal,
                                  itemsPerRow: widget.itemsPerRow,
                                  horizontalSpacing: widget.horizontalSpacing,
                                  verticalSpacing: widget.verticalSpacing,
                                  minItemDimension: widget.minItemDimension,
                                  itemSize: widget.itemSize,
                                  invertItems: widget.invertedRow,
                                  onTapSection: widget.onPressed,
                                  padding: widget.style.gridViewPadding,
                                  itemDecoration:
                                      widget.itemContainerStyle.decoration,
                                ),
                        ),
                      ),
                      widget.footerWidget,
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
    this.itemsPerRow = 0,
    this.itemSize = 120,
    this.style = const SimpleGridViewStyle(),
    this.verticalSpacing = 10,
    this.horizontalSpacing = 10,
    this.horizontal = false,
    this.invertedRow = false,
    this.minItemDimension = 120.0,
    this.footerWidget = const SizedBox(),
    this.itemContainerStyle = const SimpleGridViewContainerStyle(),
    this.containerHeight = 300,
    this.containerWidth = double.infinity,
    this.gridViewHeight = 300,
    this.gridViewWidth = double.infinity,
    this.isFixed = false,
    this.physics,
    this.adjustGridToStyles = false,
  });

  /// The style of the grid view.
  final SimpleGridViewStyle style;

  /// The physics of the grid view.
  final ScrollPhysics? physics;

  /// The height of the containerHeight.
  final double containerHeight;

  /// The width of the containerHeight.
  final double containerWidth;

  /// Set to true when you want the library to automatically adjust the total dimensions of the grid based on style and container size
  final bool adjustGridToStyles;

  /// The height of the gridview.
  final double gridViewHeight;

  /// The width of the gridview.
  final double gridViewWidth;

  /// The number of items per row if gridview grows vertically or items per column if gridview grows horizontally.
  final int itemsPerRow;

  /// The size of the grid item in the main axis direction (The grid will occupy the whole space available in the cross axis).
  final double itemSize;

  /// The spacing between grid items vertically.
  final double verticalSpacing;

  /// The spacing between grid items horizontally.
  final double horizontalSpacing;

  /// The sections to display in the grid.
  final List data;

  /// The function that renders each item in the grid.
  final Widget Function(dynamic data) renderItem;

  /// Whether to invert the row.
  final bool invertedRow;

  /// Whether the grid view is horizontal.
  final bool horizontal;

  /// is true will use a wrap instead of a gridView to render the item
  final bool isFixed;

  /// The minimum dimension (width or height) of each grid item.
  final double minItemDimension;

  /// Specifies an additional row to be displayed at the bottom of the grid.
  final Widget footerWidget;

  /// The style of the container of the widget in the grid view.
  final SimpleGridViewContainerStyle itemContainerStyle;

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
    final data =
        widget.invertedRow ? widget.data.reversed.toList() : widget.data;
    // Padding widget adds space around the entire grid view.
    return Padding(
      padding: widget
          .style.padding, // Applies the specified padding around the grid view.
      child: Container(
        decoration: widget.style
            .decoration, // Applies the decoration from the widget's properties.
        color: widget.style.decoration != null
            ? null
            : widget.style
                .color, // Sets the background color for the grid view container.
        width: widget.gridViewWidth,
        // Stack allows placing widgets on top of each other.
        child: Column(
          children: [
            SizedBox(
              height: widget.adjustGridToStyles
                  ? widget.containerHeight
                  : widget
                      .gridViewHeight, // The height of the grid view container.
              width: widget.adjustGridToStyles
                  ? widget.containerWidth
                  : widget
                      .gridViewWidth, // The width of the grid view container.
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
                      physics: widget.physics,
                      scrollDirection: widget.horizontal
                          ? Axis.horizontal
                          : Axis
                              .vertical, // Sets the scroll direction based on the horizontal flag.
                      // GridView.builder creates a grid of items.
                      child: widget.isFixed
                          ? wrapWidget(
                              null,
                              data,
                              widget.renderItem,
                              widget.style,
                              widget.horizontal,
                              widget.horizontalSpacing,
                              widget.verticalSpacing,
                              null,
                              true)
                          : buildGridView(
                              data: data,
                              renderItem: widget.renderItem,
                              horizontal: widget.horizontal,
                              itemsPerRow: widget.itemsPerRow,
                              horizontalSpacing: widget.horizontalSpacing,
                              verticalSpacing: widget.verticalSpacing,
                              minItemDimension: widget.minItemDimension,
                              itemSize: widget.itemSize,
                              invertItems: widget.invertedRow,
                              padding: widget.style.gridViewPadding,
                              itemDecoration:
                                  widget.itemContainerStyle.decoration),
                    ),
                  ),
                ],
              ),
            ),
            widget.footerWidget,
          ],
        ),
      ),
    );
  }
}

class SectionGridViewStyle {
  const SectionGridViewStyle({
    this.decoration,
    this.color = Colors.transparent,
    this.padding = const EdgeInsets.all(0),
    this.gridViewPadding = const EdgeInsets.all(8.0),
    this.titlePadding = const EdgeInsets.all(8.0),
    this.titleAlignment = TitleAlignment.start,
    this.titleBackgroundColor = Colors.transparent,
    this.titleTextStyle = const TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      color: Colors.black,
    ),
  });

  /// The decoration to paint behind the main container.
  ///
  /// Use the (color) property to specify a simple solid color.
  ///
  /// The (child) is not clipped to the decoration. To clip a child to the shape
  /// of a particular [ShapeDecoration], consider using a [ClipPath] widget.
  final BoxDecoration? decoration;

  /// The color to paint behind the (child).
  ///
  /// This property should be preferred when the background is a simple color.
  /// For other cases, such as gradients or images, use the (decoration)
  /// property.
  ///
  /// If the (decoration) is used, this property must be null. A background
  /// color may still be painted by the (decoration) even if this property is
  /// null.
  final Color color;

  /// Empty space to inscribe inside the [decoration]. The (child), if any, is
  /// placed inside this padding.
  ///
  /// This padding is in addition to any padding inherent in the (decoration);
  /// see (Decoration.padding).
  final EdgeInsets padding;

  /// Empty space to inscribe between the main container and grid view. The (child), if any, is
  /// placed inside this padding.
  ///
  final EdgeInsets gridViewPadding;

  /// Empty space to inscribe inside the Title.
  final EdgeInsets titlePadding;

  /// The alignment of the title.
  final TitleAlignment titleAlignment;

  /// The background color of the title.
  final Color titleBackgroundColor;

  /// The style of the title text.
  final TextStyle titleTextStyle;
}

class ContainerStyle {
  const ContainerStyle({
    this.decoration,
    this.color = Colors.transparent,
    this.padding = const EdgeInsets.all(0),
    this.gridViewPadding = const EdgeInsets.all(8.0),
  });

  /// The decoration to paint behind the main container.
  ///
  /// Use the (color) property to specify a simple solid color.
  ///
  /// The (child) is not clipped to the decoration. To clip a child to the shape
  /// of a particular [ShapeDecoration], consider using a [ClipPath] widget.
  final BoxDecoration? decoration;

  /// The color to paint behind the (child).
  ///
  /// This property should be preferred when the background is a simple color.
  /// For other cases, such as gradients or images, use the (decoration)
  /// property.
  ///
  /// If the (decoration) is used, this property must be null. A background
  /// color may still be painted by the (decoration) even if this property is
  /// null.
  final Color color;

  /// Empty space to inscribe inside the [decoration]. The (child), if any, is
  /// placed inside this padding.
  ///
  /// This padding is in addition to any padding inherent in the (decoration);
  /// see (Decoration.padding).
  final EdgeInsets padding;

  /// Empty space to inscribe between the main container and grid view. The (child), if any, is
  /// placed inside this padding.
  ///
  final EdgeInsets gridViewPadding;
}

class SimpleGridViewContainerStyle {
  const SimpleGridViewContainerStyle({
    this.decoration,
    this.color = Colors.transparent,
    this.padding = const EdgeInsets.all(0),
    this.gridViewPadding = const EdgeInsets.all(8.0),
  });

  /// The decoration to paint behind the main container.
  ///
  /// Use the (color) property to specify a simple solid color.
  ///
  /// The (child) is not clipped to the decoration. To clip a child to the shape
  /// of a particular [ShapeDecoration], consider using a [ClipPath] widget.
  final BoxDecoration? decoration;

  /// The color to paint behind the (child).
  ///
  /// This property should be preferred when the background is a simple color.
  /// For other cases, such as gradients or images, use the (decoration)
  /// property.
  ///
  /// If the (decoration) is used, this property must be null. A background
  /// color may still be painted by the (decoration) even if this property is
  /// null.
  final Color color;

  /// Empty space to inscribe inside the [decoration]. The (child), if any, is
  /// placed inside this padding.
  ///
  /// This padding is in addition to any padding inherent in the (decoration);
  /// see (Decoration.padding).
  final EdgeInsets padding;

  /// Empty space to inscribe between the main container and grid view. The (child), if any, is
  /// placed inside this padding.
  ///
  final EdgeInsets gridViewPadding;
}

class FlatGridViewStyle {
  const FlatGridViewStyle({
    this.decoration,
    this.color = Colors.transparent,
    this.padding = const EdgeInsets.all(0),
    this.gridViewPadding = const EdgeInsets.all(8.0),
  });

  /// The decoration to paint behind the main container.
  ///
  /// Use the (color) property to specify a simple solid color.
  ///
  /// The (child) is not clipped to the decoration. To clip a child to the shape
  /// of a particular [ShapeDecoration], consider using a [ClipPath] widget.
  final BoxDecoration? decoration;

  /// The color to paint behind the (child).
  ///
  /// This property should be preferred when the background is a simple color.
  /// For other cases, such as gradients or images, use the (decoration)
  /// property.
  ///
  /// If the (decoration) is used, this property must be null. A background
  /// color may still be painted by the (decoration) even if this property is
  /// null.
  final Color color;

  /// Empty space to inscribe inside the [decoration]. The (child), if any, is
  /// placed inside this padding.
  ///
  /// This padding is in addition to any padding inherent in the (decoration);
  /// see (Decoration.padding).
  final EdgeInsets padding;

  /// Empty space to inscribe between the main container and grid view. The (child), if any, is
  /// placed inside this padding.
  ///
  final EdgeInsets gridViewPadding;
}

class SimpleGridViewStyle {
  const SimpleGridViewStyle({
    this.decoration,
    this.color = Colors.transparent,
    this.padding = const EdgeInsets.all(0),
    this.gridViewPadding = const EdgeInsets.all(8.0),
  });

  /// The decoration to paint behind the main container.
  ///
  /// Use the (color) property to specify a simple solid color.
  ///
  /// The (child) is not clipped to the decoration. To clip a child to the shape
  /// of a particular [ShapeDecoration], consider using a [ClipPath] widget.
  final BoxDecoration? decoration;

  /// The color to paint behind the (child).
  ///
  /// This property should be preferred when the background is a simple color.
  final Color color;

  /// Empty space to inscribe inside the [decoration]. The (child), if any, is
  /// placed inside this padding.
  ///
  /// This padding is in addition to any padding inherent in the (decoration);
  /// see (Decoration.padding).
  final EdgeInsets padding;

  /// Empty space to inscribe between the main container and grid view. The (child), if any, is
  /// placed inside this padding.
  ///
  final EdgeInsets gridViewPadding;
}

class AditionalRowStyle {
  const AditionalRowStyle({
    this.color = Colors.transparent,
    this.padding = const EdgeInsets.all(0),
  });

  /// The color to paint behind the (child).
  ///
  /// This property should be preferred when the background is a simple color.
  final Color color;

  /// see [Decoration.padding].
  final EdgeInsets padding;
}

Widget wrapWidget(
    int? sectionIndex,
    dynamic data,
    Widget Function(dynamic data) renderItem,
    dynamic style,
    bool horizontal,
    double horizontalSpacing,
    double verticalSpacing,
    Function? onPressed,
    bool? simple) {
  return Padding(
    padding: style.gridViewPadding,
    child: Wrap(
      direction: horizontal ? Axis.vertical : Axis.horizontal,
      spacing: horizontalSpacing,
      runSpacing: verticalSpacing,
      children: data.map<Widget>((itemData) {
        return simple != null && simple
            ? renderItem(itemData)
            : InkWell(
                onTap: () {
                  if (onPressed != null) {
                    sectionIndex != null
                        ? onPressed(
                            sectionIndex,
                            data.indexOf(itemData),
                          )
                        : onPressed(
                            data.indexOf(itemData),
                          ); // Calls the onPressed callback when the item is tapped.;
                  }
                },
                child: renderItem(itemData),
              );
      }).toList(),
    ),
  );
}

Widget buildGridView({
  required List data,
  required Widget Function(dynamic itemData) renderItem,
  required bool horizontal,
  required int itemsPerRow,
  required double horizontalSpacing,
  required double verticalSpacing,
  required double minItemDimension,
  required double itemSize,
  bool invertItems = false,
  void Function(int itemIndex)? onTapFlat,
  void Function(int sectionIndex, int itemIndex)? onTapSection,
  BoxDecoration? itemDecoration,
  EdgeInsets? padding,
  int? sectionIndex,
}) {
  final effectiveData = invertItems ? data.reversed.toList() : data;

  return GridView.builder(
    physics: const NeverScrollableScrollPhysics(),
    scrollDirection: horizontal ? Axis.horizontal : Axis.vertical,
    padding: padding ?? const EdgeInsets.all(8.0),
    shrinkWrap: true,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: itemsPerRow,
      mainAxisExtent: minItemDimension > itemSize ? minItemDimension : itemSize,
      crossAxisSpacing: horizontalSpacing,
      mainAxisSpacing: verticalSpacing,
    ),
    itemCount: effectiveData.length,
    itemBuilder: (context, index) {
      final itemData = effectiveData[index];
      return onTapFlat != null
          ? InkWell(
              onTap: () => onTapFlat(data.indexOf(itemData)),
              child: buildGridItem(itemData, itemDecoration, renderItem, index),
            )
          : onTapSection != null
              ? InkWell(
                  onTap: () =>
                      onTapSection(sectionIndex!, data.indexOf(itemData)),
                  child: buildGridItem(
                      itemData, itemDecoration, renderItem, index),
                )
              : buildGridItem(itemData, itemDecoration, renderItem, index);
    },
  );
}

Widget buildGridItem(dynamic itemData, BoxDecoration? itemDecoration,
    Widget Function(dynamic itemData) renderItem, int index) {
  return Container(
    decoration: itemDecoration,
    child: Align(
      alignment: Alignment.center,
      child: renderItem(itemData),
    ),
  );
}
