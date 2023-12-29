part of styles;

// SectionGridViewStyle defines the style for the SectionGridView.
///
/// It allows customization of various aspects of the grid's appearance.
///
/// Properties:
/// * [decoration]: The decoration to paint behind the main container. Use the [color] property for a simple solid color.
/// * [color]: The color to paint behind the child. Use this property for a simple color background.
/// * [padding]: Empty space to inscribe inside the decoration. The child, if any, is placed inside this padding.
/// * [gridViewPadding]: Empty space to inscribe between the main container and the grid view.
/// * [titlePadding]: Empty space to inscribe inside the title.
/// * [titleAlignment]: The alignment of the title within its container.
/// * [titleBackgroundColor]: The background color of the title.
/// * [titleTextStyle]: The style of the title text, including font size, weight, and color.
class SectionGridViewStyle {
  const SectionGridViewStyle({
    this.decoration,
    this.color = Colors.transparent,
    this.padding = const EdgeInsets.all(0),
    this.gridViewPadding = const EdgeInsets.all(8.0),
    this.titlePadding = const EdgeInsets.all(8.0),
    this.titleAlignment = TitleAlignment.start,
    this.titleBackgroundColor = Colors.transparent,
    this.titleTextStyle = const TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      color: Colors.black,
    ),
  });

  final BoxDecoration? decoration;
  final Color color;
  final EdgeInsets padding;
  final EdgeInsets gridViewPadding;
  final EdgeInsets titlePadding;
  final TitleAlignment titleAlignment;
  final Color titleBackgroundColor;
  final TextStyle titleTextStyle;
}
