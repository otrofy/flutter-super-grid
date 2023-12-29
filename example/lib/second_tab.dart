import 'package:example/data.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_super_grid/flutter_super_grid.dart';

class SecondTab extends StatelessWidget {
  const SecondTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget("Today's Artist"),
          FlatGridWidget(artist1),
          const TextWidget("Your favorite Artists"),
          FlatGridWidget(artist2),
          const TextWidget("Recommended for you"),
          FlatGridWidget(artist3),
          const TextWidget("Our selection"),
          FlatGridWidget(artist1),
          const TextWidget("Most listened"),
          FlatGridWidget(artist2),
          const TextWidget("Best sellers"),
          FlatGridWidget(artist3),
          const TextWidget("90's are back"),
          FlatGridWidget(artist2),
          const TextWidget("Your favorite Artist"),
          FlatGridWidget(artist3),
        ],
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  final String text;

  const TextWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}

class FlatGridWidget extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const FlatGridWidget(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return FlatGridView(
      data: data,
      renderItem: (itemData) {
        return Column(
          children: [
            Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    itemData['artistPhoto'],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                itemData['artistName'],
                style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Text(
              itemData['Subscriptors'],
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
          ],
        );
      },
      gridViewHeight: 220,
      itemSize: 150.0,
      itemsPerRow: 1,
      isFixed: false,
      style: const FlatGridViewStyle(
        color: Colors.transparent,
        padding: EdgeInsets.only(left: 8.0, top: 16),
        gridViewPadding: EdgeInsets.only(left: 8.0, top: 16),
      ),
      verticalSpacing: 50.0,
      horizontal: true,
      invertedRow: true,
      onPressed: (index) {
        // Handle item tap
      },
    );
  }
}
