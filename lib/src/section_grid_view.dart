part of '../flutter_super_grid.dart';

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
/// * [controller]:  ScrollController? to controll scroller in the grid view.
/// * [sectionController]:  List<ScrollController>? array of controllers to controll each section individually of the section grid view, this list of controllers must be the same length of the sections you want to have. 
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
    double? gridViewHeight,
    double gridViewWidth = double.infinity,
    double containerWidth = double.infinity,
    double? containerHeight,
    Widget footerWidget = const SizedBox(),
    ScrollPhysics? physics,
    ScrollController? controller,
    this.sectionController,
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
            controller: controller);

  final void Function()? onNewItemAdded;
  final List<Map<String, dynamic>> sections;
  final void Function(int sectionIndex, int index)? onPressed;
  final SectionGridViewStyle style;
  final List<ScrollController>? sectionController;

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
                controller: widget.controller,
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
                                  sectionIndex: null,
                                  data: data,
                                  renderItem: widget.renderItem,
                                  style: widget.style,
                                  horizontal: widget.horizontal,
                                  horizontalSpacing: widget.horizontalSpacing,
                                  verticalSpacing: widget.verticalSpacing,
                                  onPressed: widget.onPressed,
                                  simple: false,
                                  sectionController:
                                      widget.sectionController?[sectionIndex],
                                )
                              : buildGridView(
                                  controller:
                                      widget.sectionController?[sectionIndex],
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
