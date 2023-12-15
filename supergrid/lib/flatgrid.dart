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

  @override
  State<FlatGridView> createState() => _FlatGridViewState();
}

class _FlatGridViewState extends State<FlatGridView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Container(
        color: widget.color,
        child: Stack(
          children: [
            Visibility(
              visible: widget.data.isEmpty,
              child: const Center(child: Text('No items')),
            ),
            Visibility(
              visible: widget.data.isNotEmpty,
              child: SingleChildScrollView(
                scrollDirection:
                    widget.horizontal ? Axis.horizontal : Axis.vertical,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection:
                      widget.horizontal ? Axis.horizontal : Axis.vertical,
                  padding: widget.gridViewPadding,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.itemsPerRow,
                    mainAxisExtent: widget.itemSize,
                    crossAxisSpacing: widget.horizontalSpacing,
                    mainAxisSpacing: widget.verticalSpacing,
                  ),
                  itemCount: widget.data.length,
                  itemBuilder: (context, index) {
                    final itemData = widget.invertedRow
                        ? widget.data.reversed.toList()[index]
                        : widget.data[index];
                    return InkWell(
                      onTap: () {
                        if (widget.onPressed != null) {
                          widget.onPressed!(index);
                        }
                      },
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
