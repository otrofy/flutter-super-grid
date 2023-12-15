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

class _SimpleGridViewState extends State<SimpleGridView> {
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
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: widget.itemWidth,
                    childAspectRatio: widget.itemWidth / widget.itemHeight,
                    crossAxisSpacing: widget.horizontalSpacing,
                    mainAxisSpacing: widget.verticalSpacing,
                  ),
                  itemCount: widget.data.length,
                  itemBuilder: (context, index) {
                    final itemData = widget.invertedRow
                        ? widget.data.reversed.toList()[index]
                        : widget.data[index];

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