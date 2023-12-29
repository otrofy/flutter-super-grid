/// this is a library for creating grid views with different layouts and functionalities.
library supergrid;

import 'package:flutter/material.dart';

///This is the enum
enum TitleAlignment {
  start,
  center,
  end,
}

/// CommonGrid is an abstract base class for grid views.
///
/// It defines common properties and functionalities shared across different grid types.
///
/// Properties:
/// * [isFixed]: Determines if the original size is used instead of adjusting to grid.
/// * [adjustGridToStyles]: Set to true to automatically adjust grid dimensions based on style and container size.
/// * [itemContainerStyle]: Style of the container of the widget in the grid view, applicable when [isFixed] is false.
/// * [footerWidget]: The widget rendered at the bottom of the grid view.
/// * [itemsPerRow]: Number of items per row in a vertically growing grid or per column in a horizontally growing grid, applicable when [isFixed] is false.
/// * [gridViewHeight]: The height of the grid view.
/// * [gridViewWidth]: The width of the grid view.
/// * [containerWidth]: The width of the main container, relevant if it's greater than [gridViewWidth].
/// * [containerHeight]: The height of the main container, relevant if it's greater than [gridViewHeight].
/// * [itemSize]: Size of the grid item in the main axis direction, applicable when [isFixed] is false.
/// * [verticalSpacing]: Spacing between grid items vertically.
/// * [horizontalSpacing]: Spacing between grid items horizontally.
/// * [renderItem]: Function that renders each item in the grid.
/// * [invertedRow]: Determines whether to invert the row.
/// * [horizontal]: Specifies if the grid view is horizontal.
/// * [minItemDimension]: Minimum dimension of each grid item, applicable when [isFixed] is false.
/// * [physics]: The physics of the grid view.
abstract class CommonGrid extends StatefulWidget {
  const CommonGrid({
    super.key,
    required this.renderItem,
    this.itemSize = 120.0,
    this.minItemDimension = 120.0,
    this.verticalSpacing = 10,
    this.horizontalSpacing = 10,
    this.itemsPerRow = 3,
    this.itemContainerStyle = const ContainerStyle(),
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
  });

  final bool isFixed;
  final bool adjustGridToStyles;
  final ContainerStyle itemContainerStyle;
  final Widget footerWidget;
  final int itemsPerRow;
  final double gridViewHeight;
  final double gridViewWidth;
  final double containerWidth;
  final double containerHeight;
  final double itemSize;
  final double verticalSpacing;
  final double horizontalSpacing;
  final Widget Function(dynamic data) renderItem;
  final bool invertedRow;
  final bool horizontal;
  final double minItemDimension;
  final ScrollPhysics? physics;

  @override
  State<CommonGrid> createState(); // Abstract method
}

// A widget that displays a flat grid of items.
class FlatGridView extends CommonGrid {
  /// FlatGridView is a widget for displaying a flat grid of items.
  ///
  /// It combines common grid functionalities with specific features for a flat layout.
  ///
  /// Properties:
  /// * [data]: The data to display in the grid.
  /// * [renderItem]: The function that renders each item in the grid.
  /// * [itemSize]: The size of the grid item. Defaults to 120.0, applicable when [isFixed] is false.
  /// * [minItemDimension]: The minimum dimension (width or height) of each grid item. Defaults to 120.0, applicable when [isFixed] is false.
  /// * [verticalSpacing]: The spacing between grid items vertically. Defaults to 10.
  /// * [horizontalSpacing]: The spacing between grid items horizontally. Defaults to 10.
  /// * [itemsPerRow]: The number of items per row in the grid. Defaults to 3, applicable when [isFixed] is false.
  /// * [itemContainerStyle]: Style of the container of each item in the grid. Defaults to [ContainerStyle], applicable when [isFixed] is false.
  /// * [isFixed]: If true, uses the original size instead of adjusting to grid. Defaults to false.
  /// * [horizontal]: If true, the grid view grows horizontally. Defaults to false.
  /// * [invertedRow]: If true, inverts the order of the row. Defaults to false.
  /// * [adjustGridToStyles]: If true, adjusts the total dimensions of the grid based on style and container size. Defaults to false.
  /// * [gridViewHeight]: The height of the grid view. Defaults to 300.
  /// * [gridViewWidth]: The width of the grid view. Defaults to infinity.
  /// * [containerWidth]: The width of the main container. Relevant if greater than [gridViewWidth]. Defaults to infinity.
  /// * [containerHeight]: The height of the main container. Relevant if greater than [gridViewHeight]. Defaults to 300.
  /// * [footerWidget]: The widget rendered at the bottom of the grid view. Defaults to [SizedBox].
  /// * [physics]: The physics of the grid view.
  const FlatGridView({
    super.key,
    required super.renderItem, // required property
    required this.data, // required property
    this.onNewItemAdded,
    this.onPressed,
    double itemSize = 120.0, // default value set to 120 px
    double minItemDimension = 120.0, // default value set to 120 px
    double verticalSpacing = 10, // default value set to 10 px
    double horizontalSpacing = 10, // default value set to 10 px
    int itemsPerRow = 3, // default value set to 3
    this.style = const FlatGridViewStyle(),
    ContainerStyle itemContainerStyle = const ContainerStyle(),
    bool isFixed = false, // default value set to false
    bool horizontal = false, // default value set to false
    bool invertedRow = false, // default value set to false
    bool adjustGridToStyles = false, // default value set to false
    double gridViewHeight = 300, // default value set to 300 px
    double gridViewWidth = double.infinity, // default value set to infinity
    double containerWidth = double.infinity, // default value set to infinity
    double containerHeight = 300, // default value set to 300 px
    Widget footerWidget = const SizedBox(), // default value set to SizedBox()
    ScrollPhysics? physics, // default value set to null
  }) : super(
          itemSize: itemSize,
          minItemDimension: minItemDimension,
          verticalSpacing: verticalSpacing,
          horizontalSpacing: horizontalSpacing,
          itemsPerRow: itemsPerRow,
          itemContainerStyle: itemContainerStyle,
          isFixed: isFixed,
          horizontal: horizontal,
          invertedRow: invertedRow,
          adjustGridToStyles: adjustGridToStyles,
          gridViewHeight: gridViewHeight,
          gridViewWidth: gridViewWidth,
          containerWidth: containerWidth,
          containerHeight: containerHeight,
          footerWidget: footerWidget,
          physics: physics,
        );
  final void Function()? onNewItemAdded;
  final List data;
  final void Function(int index)? onPressed;
  final FlatGridViewStyle style;

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

/// SectionGridView is a widget for displaying a sections with grids.
///
/// Combines common grid functionalities from [CommonGrid] with features specific for a sectional layout.
///
/// Properties:
/// * [sections]: The sections to display in the grid, each section containing its data and title.
/// * [renderItem]: The function that renders each item in the grid.
/// * [itemSize]: The size of the grid item. Defaults to 120.0, applicable when [isFixed] is false.
/// * [minItemDimension]: The minimum dimension (width or height) of each grid item. Defaults to 120.0, applicable when [isFixed] is false.
/// * [verticalSpacing]: The spacing between grid items vertically. Defaults to 10.
/// * [horizontalSpacing]: The spacing between grid items horizontally. Defaults to 10.
/// * [itemsPerRow]: The number of items per row in the grid. Defaults to 3, applicable when [isFixed] is false.
/// * [itemContainerStyle]: Style of the container of each item in the grid. Defaults to [ContainerStyle], applicable when [isFixed] is false.
/// * [isFixed]: If true, uses the original size instead of adjusting to grid. Defaults to false.
/// * [horizontal]: If true, the grid view grows horizontally. Defaults to false.
/// * [invertedRow]: If true, inverts the order of the row. Defaults to false.
/// * [adjustGridToStyles]: If true, adjusts the total dimensions of the grid based on style and container size. Defaults to false.
/// * [gridViewHeight]: The height of the grid view. Defaults to 300.
/// * [gridViewWidth]: The width of the grid view. Defaults to infinity.
/// * [containerWidth]: The width of the main container. Relevant if greater than [gridViewWidth]. Defaults to infinity.
/// * [containerHeight]: The height of the main container. Relevant if greater than [gridViewHeight]. Defaults to 300.
/// * [footerWidget]: The widget rendered at the bottom of the grid view. Defaults to [SizedBox].
/// * [physics]: The physics of the grid view.
///
/// Specific properties for `SectionGridView`:
/// * [onNewItemAdded]: Callback function when a new item is added to the sections list.
/// * [onPressed]: Callback function when an item in a section is pressed.
/// * [style]: The style to apply to the section grid.
class SectionGridView extends CommonGrid {
  const SectionGridView({
    super.key,
    required this.sections,
    required super.renderItem,
    this.onNewItemAdded,
    this.onPressed,
    double itemSize = 120.0,
    double minItemDimension = 120.0,
    double verticalSpacing = 10,
    double horizontalSpacing = 10,
    int itemsPerRow = 3,
    ContainerStyle itemContainerStyle = const ContainerStyle(),
    bool isFixed = false,
    bool horizontal = false,
    bool invertedRow = false,
    bool adjustGridToStyles = false,
    double gridViewHeight = 300,
    double gridViewWidth = double.infinity,
    double containerWidth = double.infinity,
    double containerHeight = 300,
    Widget footerWidget = const SizedBox(),
    ScrollPhysics? physics,
    this.style = const SectionGridViewStyle(),
  }) : super(
          itemSize: itemSize,
          minItemDimension: minItemDimension,
          verticalSpacing: verticalSpacing,
          horizontalSpacing: horizontalSpacing,
          itemsPerRow: itemsPerRow,
          itemContainerStyle: itemContainerStyle,
          isFixed: isFixed,
          horizontal: horizontal,
          invertedRow: invertedRow,
          adjustGridToStyles: adjustGridToStyles,
          gridViewHeight: gridViewHeight,
          gridViewWidth: gridViewWidth,
          containerWidth: containerWidth,
          containerHeight: containerHeight,
          footerWidget: footerWidget,
          physics: physics,
        );

  final void Function()? onNewItemAdded;
  final List<Map<String, dynamic>> sections;
  final void Function(int sectionIndex, int index)? onPressed;
  final SectionGridViewStyle style;

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

/// SimpleGridView is a widget for displaying a simple grid view.
///
/// Combines common grid functionalities from [CommonGrid] with specific features for a simpler layout.
///
/// Properties:
/// * [data]: The data to display in the grid.
/// * [renderItem]: The function that renders each item in the grid.
/// * [itemSize]: The size of the grid item. Defaults to 120.0, applicable when [isFixed] is false.
/// * [minItemDimension]: The minimum dimension (width or height) of each grid item. Defaults to 120.0, applicable when [isFixed] is false.
/// * [verticalSpacing]: The spacing between grid items vertically. Defaults to 10.
/// * [horizontalSpacing]: The spacing between grid items horizontally. Defaults to 10.
/// * [itemsPerRow]: The number of items per row in the grid. Defaults to 3, applicable when [isFixed] is false.
/// * [itemContainerStyle]: Style of the container of each item in the grid. Defaults to [ContainerStyle], applicable when [isFixed] is false.
/// * [isFixed]: If true, uses the original size instead of adjusting to grid. Defaults to false.
/// * [horizontal]: If true, the grid view grows horizontally. Defaults to false.
/// * [invertedRow]: If true, inverts the order of the row. Defaults to false.
/// * [adjustGridToStyles]: If true, adjusts the total dimensions of the grid based on style and container size. Defaults to false.
/// * [gridViewHeight]: The height of the grid view. Defaults to 300.
/// * [gridViewWidth]: The width of the grid view. Defaults to infinity.
/// * [containerWidth]: The width of the main container. Relevant if greater than [gridViewWidth]. Defaults to infinity.
/// * [containerHeight]: The height of the main container. Relevant if greater than [gridViewHeight]. Defaults to 300.
/// * [footerWidget]: The widget rendered at the bottom of the grid view. Defaults to [SizedBox].
/// * [physics]: The physics of the grid view.
///
/// Specific properties for `SimpleGridView`:
/// * [style]: The style to apply to the simple grid view.
class SimpleGridView extends CommonGrid {
  const SimpleGridView({
    super.key,
    required this.data,
    required super.renderItem,
    double itemSize = 120.0,
    double minItemDimension = 120.0,
    double verticalSpacing = 10,
    double horizontalSpacing = 10,
    int itemsPerRow = 3,
    ContainerStyle itemContainerStyle = const ContainerStyle(),
    bool isFixed = false,
    bool horizontal = false,
    bool invertedRow = false,
    bool adjustGridToStyles = false,
    double gridViewHeight = 300,
    double gridViewWidth = double.infinity,
    double containerWidth = double.infinity,
    double containerHeight = 300,
    Widget footerWidget = const SizedBox(),
    ScrollPhysics? physics,
    this.style = const SimpleGridViewStyle(),
  }) : super(
          itemSize: itemSize,
          minItemDimension: minItemDimension,
          verticalSpacing: verticalSpacing,
          horizontalSpacing: horizontalSpacing,
          itemsPerRow: itemsPerRow,
          itemContainerStyle: itemContainerStyle,
          isFixed: isFixed,
          horizontal: horizontal,
          invertedRow: invertedRow,
          adjustGridToStyles: adjustGridToStyles,
          gridViewHeight: gridViewHeight,
          gridViewWidth: gridViewWidth,
          containerWidth: containerWidth,
          containerHeight: containerHeight,
          footerWidget: footerWidget,
          physics: physics,
        );

  final SimpleGridViewStyle style;
  final List data;

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
