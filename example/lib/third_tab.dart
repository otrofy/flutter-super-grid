import 'package:example/data.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_super_grid/flutter_super_grid.dart';

class ThirdTab extends StatelessWidget {
  const ThirdTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SimpleGridView(
            data: data,
            renderItem: (itemData) {
              return Container(
                height: 10 * (data.indexOf(itemData) * 1 + 1),
                width: 10 * (data.indexOf(itemData) * 1 + 1),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      15.0), // Ajusta el radio según sea necesario
                  child: CachedNetworkImage(
                    imageUrl: itemData,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(), // Puedes personalizar el indicador de carga
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit
                        .cover, // Ajusta el modo de ajuste de la imagen según sea necesario
                  ),
                ),
              );
            },
            itemSize: 80.0,
            itemsPerRow: 3,
            isFixed: true,
            style: const SimpleGridViewStyle(
              color: Colors.green,
              padding: EdgeInsets.all(16.0),
              gridViewPadding: EdgeInsets.all(24.0),
            ),
            itemHeight: 100,
            itemWidth: 100,
            verticalSpacing: 10.0,
            horizontalSpacing: 10.0,
            horizontal: true,
            invertedRow: true,
            additionalRow: Container(
              height: 100,
              width: 420,
              color: Colors.red,
              child: const Row(
                children: [
                  Icon(
                    Icons.abc,
                    color: Colors.white,
                  ),
                  Text(
                    "Foot Render Widget",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            )));
  }
}
