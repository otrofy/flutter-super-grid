part of '../flutter_super_grid.dart';

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
    ScrollController? controller,
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
            controller: controller);

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
                      controller: widget.controller,
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
                              physics: const NeverScrollableScrollPhysics(),
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
