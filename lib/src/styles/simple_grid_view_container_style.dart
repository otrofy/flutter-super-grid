part of styles;

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
