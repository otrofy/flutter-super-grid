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
          createText("Today's Artist"),
          createFlatGrid(artist1),
          createText("Your favorite Artists"),
          createFlatGrid(artist2),
          createText("Recommended for you"),
          createFlatGrid(artist3),
          createText("Our selection"),
          createFlatGrid(artist1),
          createText("Most listened"),
          createFlatGrid(artist2),
          createText("Best sellers"),
          createFlatGrid(artist3),
          createText("90's are back"),
          createFlatGrid(artist2),
          createText("Your favorite Artist"),
          createFlatGrid(artist3),
        ],
      ),
    );
  }
  Widget createText(text) {
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
  Widget createFlatGrid(data) {
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
        // Handle item tapER
      },
    );
  }
}
