# supergrid

[![Pub Version](https://img.shields.io/pub/v/supergrid)](https://pub.dev/packages/supergrid)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

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

### Features

- Customizable grid view with various configuration options.
- Support for item tap callbacks.
- Option to invert the row and display the grid horizontally.

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

### Features

- Customizable grid view with sections and various configuration options.
- Support for item tap callbacks with section and item indices.
- Option to invert the row and display the grid horizontally.
- Section titles with customizable styling and alignment.


## Contributing

If you would like to contribute to this project, please follow the steps outlined in [CONTRIBUTING.md](CONTRIBUTING.md).

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments

Special thanks to [contributors](link-to-contributors) who have helped make this package better.

## Issues and Contributions 
If you encounter any issues or have suggestions for improvements, please open an issue on the GitHub repository. Contributions and pull requests are welcome!