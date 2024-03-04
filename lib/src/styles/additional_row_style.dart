part of '../styles.dart';

class AditionalRowStyle {
  const AditionalRowStyle({
    this.color = Colors.transparent,
    this.padding = const EdgeInsets.all(0),
  });

  /// The color to paint behind the (child).
  ///
  /// This property should be preferred when the background is a simple color.
  final Color color;

  /// see [Decoration.padding].
  final EdgeInsets padding;
}
