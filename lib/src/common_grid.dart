part of flutter_super_grid;

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
    this.gridViewHeight,
    this.gridViewWidth = double.infinity,
    this.containerWidth = double.infinity,
    this.containerHeight,
    this.footerWidget = const SizedBox(),
    this.physics,
  });

  final bool isFixed;
  final bool adjustGridToStyles;
  final ContainerStyle itemContainerStyle;
  final Widget footerWidget;
  final int itemsPerRow;
  final double? gridViewHeight;
  final double gridViewWidth;
  final double containerWidth;
  final double? containerHeight;
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
