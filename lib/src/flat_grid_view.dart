part of '../flutter_super_grid.dart';

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
    double? gridViewHeight, // default value set to 300 px
    double gridViewWidth = double.infinity, // default value set to infinity
    double containerWidth = double.infinity, // default value set to infinity
    double? containerHeight, // default value set to 300 px
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
            Expanded(
              child: SizedBox(
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
            ),
            widget.footerWidget,
          ],
        ),
      ),
    );
  }
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
  ScrollPhysics? physics,
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
    physics: physics,
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
