# Flutter Super Grid

A customizable Flutter package for displaying grid views of sections with additional features.

## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  supergrid: ^1.0.0
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


### Usage

### SimpleGridView

```dart
import 'package:supergrid/simplegrid.dart';



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
)
```

### FlatGridView
```dart
import 'package:supergrid/flatgrid.dart';


FlatGridView(
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

### SectionGridView

```dart
import 'package:supergrid/sectiongrid.dart';

SectionGridView(
  sections: yourSectionsList,
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

## Configuration

- `data`: The data to display in the flatgrid or simplegrid.
- `sections`: The sections to be displayed on the sectiongrid.
- `renderItem`: The function that renders each item in the grid.
- `itemWidth`: The width of each grid item.
- `itemHeight`: The height of each grid item.
- `color`: Background color of the grid container.
- `padding`: Padding around the grid container.
- `gridViewHeight`: Height of the internal GridView.
- `gridViewWidth`: Width of the internal GridView.
- `gridViewPadding`: Padding for the internal GridView.
- `verticalSpacing`: Spacing between grid items vertically.
- `horizontalSpacing`: Spacing between grid items horizontally.
- `horizontal`: Whether the grid view is horizontal.
- `invertedRow`: Whether to invert the row.
- `onPressed`: Callback when an item is tapped.
- `titleAlignment`: Alignment of the section title. (Default is `TitleAlignment.start`)
- `titleBackgroundColor`: Background color of the section title container. (Default is `Colors.transparent`)
- `titlePadding`: Padding around the section title. (Default is `EdgeInsets.all(8.0)`)
- `titleTextStyle`: Style of the section title text. (Default is a basic text style)


## Documentation

For detailed documentation, see [API Documentation](https://github.com/otrofy/flutter-super-grid/).


## License

This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/otrofy/flutter-super-grid/blob/main/LICENSE) file for details.



## Issues and Contributions 
If you encounter any issues or have suggestions for improvements, please open an issue on the GitHub repository. Contributions and pull requests are welcome!
