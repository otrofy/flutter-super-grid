# Flutter SuperGrid

A customizable Flutter package for displaying grid views of sections.

## SimpleGridView

### Usage

```dart
import 'package:supergrid/supergrid.dart';

SimpleGridView(
  data: yourDataList,
  renderItem: (itemData) {
    // Customize how each item is rendered
    return YourCustomItemWidget(itemData);
  },
  itemWidth: 150.0,
  itemHeight: 200.0,
  color: Colors.blue,
  padding: EdgeInsets.all(16.0),
  gridViewPadding: EdgeInsets.all(8.0),
  verticalSpacing: 10.0,
  horizontalSpacing: 10.0,
  horizontal: false,
  invertedRow: false,
  onPressed: (index) {
    // Handle item tap
  },
)
```

#### Configuration

- `data`: The data to display in the grid.
- `renderItem`: The function that renders each item in the grid.
- `itemWidth`: The width of each grid item.
- `itemHeight`: The height of each grid item.
- `color`: Background color of the grid container.
- `padding`: Padding around the grid container.
- `gridViewPadding`: Padding for the internal GridView.
- `verticalSpacing`: Spacing between grid items vertically.
- `horizontalSpacing`: Spacing between grid items horizontally.
- `horizontal`: Whether the grid view is horizontal.
- `invertedRow`: Whether to invert the row.
- `onPressed`: Callback when an item is tapped.

## FlatGridView

### Usage

```dart
import 'package:supergrid/supergrid.dart';

FlatGridView(
  data: yourDataList,
  renderItem: (itemData) {
    // Customize how each item is rendered
    return YourCustomItemWidget(itemData);
  },
  itemsPerRow: 3,
  itemSize: 150.0,
  color: Colors.blue,
  padding: EdgeInsets.all(16.0),
  gridViewPadding: EdgeInsets.all(8.0),
  verticalSpacing: 10.0,
  horizontalSpacing: 10.0,
  horizontal: false,
  invertedRow: false,
  onPressed: (index) {
    // Handle item tap
  },
)
```

#### Configuration

- `data`: The data to display in the grid.
- `renderItem`: The function that renders each item in the grid.
- `itemsPerRow`: Number of items per row or column.
- `itemSize`: The size of items in the main axis.
- `color`: Background color of the grid container.
- `padding`: Padding around the grid container.
- `gridViewPadding`: Padding for the internal GridView.
- `verticalSpacing`: Spacing between grid items vertically.
- `horizontalSpacing`: Spacing between grid items horizontally.
- `horizontal`: Whether the grid view is horizontal.
- `invertedRow`: Whether to invert the row.
- `onPressed`: Callback when an item is tapped.

## SectionGridView

### Usage

```dart
import 'package:supergrid/supergrid.dart';

SectionGridView(
  sections: yourSectionsList,
  renderItem: (itemData) {
    // Customize how each item is rendered
    return YourCustomItemWidget(itemData);
  },
  itemsPerRow: 3,
  itemSize: 150.0,
  color: Colors.blue,
  padding: EdgeInsets.all(16.0),
  gridViewPadding: EdgeInsets.all(8.0),
  verticalSpacing: 10.0,
  horizontalSpacing: 10.0,
  invertedRow: false,
  onPressed: (sectionIndex, index) {
    // Handle item tap
  },
  titleAlignment: TitleAlignment.start,
  titleBackgroundColor: Colors.transparent,
  titlePadding: EdgeInsets.all(8.0),
  titleTextStyle: TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: Colors.black,
  ),
)
```

#### Configuration

- `sections`: The sections to display in the grid.
- `renderItem`: The function that renders each item in the grid.
- `itemsPerRow`: Number of items per row or column.
- `itemSize`: The size of items in the main axis.
- `color`: Background color of the grid container.
- `padding`: Padding around the grid container.
- `gridViewPadding`: Padding for the internal GridView.
- `verticalSpacing`: Spacing between grid items vertically.
- `horizontalSpacing`: Spacing between grid items horizontally.
- `invertedRow`: Whether to invert the row.
- `onPressed`: Callback when an item is tapped.
- `titleAlignment`: Alignment of the title.
- `titleBackgroundColor`: Background color of the title container.
- `titlePadding`: Padding around the title.
- `titleTextStyle`: Style of the title.

## Documentation

For detailed documentation, see [API Documentation](https://github.com/otrofy/flutter-super-grid/).


## License

This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/otrofy/flutter-super-grid/blob/main/LICENSE) file for details.



## Issues and Contributions 
If you encounter any issues or have suggestions for improvements, please open an issue on the GitHub repository. Contributions and pull requests are welcome!
