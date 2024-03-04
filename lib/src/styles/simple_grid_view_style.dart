part of '../styles.dart';

/// SimpleGridViewStyle defines the styling for containers used in SimpleGridViews.
///
/// This class allows for customization of the container's appearance within a SimpleGridView.
///
/// Properties:
/// * [decoration]: The decoration to paint behind the main container, suitable for complex backgrounds like gradients or images.
/// * [color]: The color to paint behind the child, recommended for a simple solid color. Not to be used simultaneously with [decoration].
/// * [padding]: Empty space to inscribe inside the decoration. This padding positions the child within it, adding to any inherent padding in the decoration.
/// * [gridViewPadding]: Space between the main container and the grid view. Influences the layout of the grid view within its container.
class SimpleGridViewStyle {
  const SimpleGridViewStyle({
    this.decoration,
    this.color = Colors.transparent,
    this.padding = const EdgeInsets.all(0),
    this.gridViewPadding = const EdgeInsets.all(8.0),
  });

  final BoxDecoration? decoration;
  final Color color;
  final EdgeInsets padding;
  final EdgeInsets gridViewPadding;
}
