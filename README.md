# Flutter Super Grid

A customizable Flutter package for displaying grid views of sections.

### Example App

![Example Image](https://github.com/otrofy/flutter-super-grid/blob/main/gif/supergrid.gif?raw=true)

## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_super_grid: ^1.0.0
```

Then, run:

```bash
$ flutter pub get
```


### Features

- Customizable grid view with sections and various configuration options.
- Support for item tap callbacks with section and item indices.
- Option to invert the row and display the grid horizontally.
- Section titles with customizable styling and alignment.

## SimpleGridView

### Usage

```dart
import 'package:flutter_super_grid/flutter_super_grid.dart';

SimpleGridView(
  data: yourDataList,
  renderItem: (itemData) {
    // Customize how each item is rendered
    return YourCustomItemWidget(itemData);
  },
  // ... (See Configuration Table below)
)
```

## FlatGridView

### Usage

```dart
import 'package:flutter_super_grid/flutter_super_grid.dart';

FlatGridView(
  data: yourDataList,
  renderItem: (itemData) {
    // Customize how each item is rendered
    return YourCustomItemWidget(itemData);
  },
  itemsPerRow: 3,
  // ... (See Configuration Table below)
)
```

## SectionGridView

### Usage

```dart
import 'package:flutter_super_grid/flutter_super_grid.dart';

SectionGridView(
  sections: yourSectionsList,
  renderItem: (itemData) {
    // Customize how each item is rendered
    return YourCustomItemWidget(itemData);
  },
  itemsPerRow: 3,
  // ... (See Configuration Table below)
)

```

## Configuration Table

| Configuration           | Type                     | Default Value           | Description                                               |
|-------------------------|--------------------------|-------------------------|-----------------------------------------------------------|
| `data`                  | List                     | -                       | The data to display in the grid.                           |
| `sections`              | List                     | -                       | The sections to display in the grid (for SectionGridView). |
| `renderItem`            | Function                 | -                       | Function that renders each item in the grid.               |
| `itemsPerRow`           | int                      | 0                       | Number of items per row or column.                         |
| `itemSize`              | double                   | 120.0                   | The size of items in the main axis.                        |
| `itemWidth`             | double                   | 100                     | The width of each grid item (for SimpleGridView).          |
| `itemHeight`            | double                   | 100                     | The height of each grid item (for SimpleGridView).         |
| `minItemDimension`      | double                   | 120.0                   | Minimum dimension (width or height) of each grid item.     |
| `staticDimension`       | double or null           | null                    | Static width or height for the container (for SimpleGridView). |
| `additionalRow`         | Widget                   | SizedBox                | Additional row to be displayed at the bottom of the grid (for SimpleGridView). |
| `additionalRowStyle`    | Style or null            | null                    | Style of the additional row (for SimpleGridView).          |
| `containerStyle`        | Style                    | SimpleGridViewContainerStyle | Style of the container of the widget in the grid view.     |
| `containerHeight`       | double                   | 300                     | Height of the container.                                   |
| `containerWidth`        | double                   | double.infinity         | Width of the container.                                    |
| `gridViewHeight`        | double                   | 300                     | Height of the gridview.                                    |
| `gridViewWidth`         | double                   | double.infinity         | Width of the gridview.                                     |
| `horizontal`            | bool                     | false                   | Whether the grid view is horizontal.                       |
| `invertedRow`           | bool                     | false                   | Whether to invert the row.                                 |
| `physics`               | ScrollPhysics or null    | null                    | The physics of the scroll view (for FlatGridView and SectionGridView). |
| `onPressed`             | Function or null         | null                    | Callback when an item is pressed (for SectionGridView and FlatGridView). |
| `style`                 | Style                    | See specific styles     | Style configuration for the grid view (for all three).     |
| `adjustGridToStyles`    | bool                     | false                   | Whether to adjust the grid to styles (for SimpleGridView). |
| `onNewItemAdded`        | Function or null         | null                    | Callback when a new item is added (for SectionGridView and FlatGridView). |
| `footerWidget`          | Widget                   | SizedBox                | Widget to be displayed as a footer (for SectionGridView and FlatGridView). |
| `itemContainerStyle`    | Style                    | ContainerStyle()        | Style for the container of each item (for FlatGridView).   |
| `verticalSpacing`       | double                   | 10                      | Vertical spacing between items (for all three).            |
| `horizontalSpacing`     | double                   | 10                      | Horizontal spacing between items (for all three).          |
| `isFixed`               | bool                     | false                   | Whether the grid item size is fixed (for SimpleGridView).  |


Note: ✔️ indicates that the configuration is available for the corresponding widget, and ❌ indicates that it is not applicable.




## Documentation

For detailed documentation, see [API Documentation](https://github.com/otrofy/flutter-super-grid/).


## License

This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/otrofy/flutter-super-grid/blob/main/LICENSE) file for details.



## Issues and Contributions 

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/otrofy/flutter-super-grid/issues).

If you fixed a bug or implemented a feature, please send a [pull request](https://github.com/otrofy/flutter-super-grid/pulls).
