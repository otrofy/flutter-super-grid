import 'package:example/data.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_super_grid/flutter_super_grid.dart';

class ThirdTab extends StatelessWidget {
  const ThirdTab({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            "Top artists",
            style: TextStyle(
                fontSize: 32.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  controller.animateTo(
                    controller.offset - MediaQuery.of(context).size.width / 4,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
                child: const Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                )),
            InkWell(
                onTap: () {
                  controller.animateTo(
                    controller.offset + MediaQuery.of(context).size.width / 4,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
                child: const Icon(Icons.arrow_downward, color: Colors.white))
          ],
        ),
        SimpleGridView(
          controller: controller,
          data: artist,
          gridViewHeight: 550,
          renderItem: (itemData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        (artist.indexOf(itemData) * 1 + 1).toString(),
                        style:
                            const TextStyle(fontSize: 36.0, color: Colors.grey),
                        textAlign: TextAlign.left,
                      ),
                      itemData['growth']
                          ? Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.grey),
                              width: 10,
                              height: 10,
                            )
                          : Image.asset(
                              'assets/images/growth961.png', // Ajusta la ruta según tu estructura de carpetas
                              width:
                                  15.0, // Ajusta el ancho según tus necesidades
                              height:
                                  15.0, // Ajusta la altura según tus necesidades
                            ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 70,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, left: 16),
                        child: Container(
                          width: 60.0,
                          height: 60.0,
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
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 12.0, left: 16),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    itemData['artistName'],
                                    style: const TextStyle(
                                        fontSize: 18.0, color: Colors.white),
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
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
          itemsPerRow: 1,
          horizontal: false,
          invertedRow: false,
          minItemDimension: 70,
          itemSize: 70,
        ),
      ],
    ));
  }
}
