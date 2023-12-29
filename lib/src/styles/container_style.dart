part of styles;

/// ContainerStyle defines the styling for containers used in grid views.
///
/// This class provides a way to customize the appearance of containers in the grid.
///
/// Properties:
/// * [decoration]: The decoration to paint behind the main container. Use this for complex backgrounds like gradients or images.
/// * [color]: The color to paint behind the child. Prefer this property for a simple solid color. Cannot be used with [decoration].
/// * [padding]: Empty space to inscribe inside the decoration. The child is placed inside this padding. This is in addition to any padding inherent in the decoration.
/// * [gridViewPadding]: Empty space to inscribe between the main container and the grid view. This affects the layout of the grid view within the container.
class ContainerStyle {
  const ContainerStyle({
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
