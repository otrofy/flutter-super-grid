part of '../styles.dart';

/// FlatGridViewStyle defines the styling for containers used in FlatGridViews.
///
/// This class offers customization for the appearance of containers within a FlatGridView.
///
/// Properties:
/// * [decoration]: The decoration to paint behind the main container. Suitable for complex backgrounds like gradients or images.
/// * [color]: The color to paint behind the child. Ideal for simple solid colors. Not used simultaneously with [decoration].
/// * [padding]: Empty space to inscribe inside the decoration. Adds to any inherent padding in the decoration and positions the child within.
/// * [gridViewPadding]: Space between the main container and the grid view. Influences the layout of the grid view within the container.
class FlatGridViewStyle {
  const FlatGridViewStyle({
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
