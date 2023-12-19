import 'package:example/data.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_super_grid/flutter_super_grid.dart';

class FirstTab extends StatelessWidget {
  const FirstTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 700,
            child: SectionGridView(
              physics: const NeverScrollableScrollPhysics(),
              sections: sections,
              gridViewHeight: 185,
              itemsPerRow: 1,
              horizontal: true,
              titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              renderItem: (itemData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 115,
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2.0),
                        child: CachedNetworkImage(
                          imageUrl:
                              itemData['recomendedMusicAlbums'].toString(),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          itemData['RecomendedMusic'].toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          itemData['recomendedMusicArtist'].toString(),
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 8),
                          textAlign: TextAlign.left,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ],
                );
              },
              itemSize: 120,
            ),
          ),
          SizedBox(
            height: 250,
            child: SectionGridView(
              physics: const NeverScrollableScrollPhysics(),
              sections: sectionsSmall,
              gridViewHeight: 200,
              verticalSpacing: 40,
              itemsPerRow: 4,
              horizontal: true,
              titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              renderItem: (itemData) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2.0),
                        child: CachedNetworkImage(
                          imageUrl:
                              itemData['recomendedMusicAlbums'].toString(),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 250,
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                itemData['RecomendedMusic'].toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                textAlign: TextAlign.left,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.e_mobiledata_outlined,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    itemData['recomendedMusicArtist']
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                    textAlign: TextAlign.left,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.more_vert,
                            size: 24,
                            color: Colors.white,
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
              itemSize: 300,
            ),
          ),
          SizedBox(
            height: 330,
            child: SectionGridView(
              invertedRow: true,
              physics: const NeverScrollableScrollPhysics(),
              sections: sectionsVideos,
              gridViewHeight: 300,
              verticalSpacing: 50,
              itemsPerRow: 1,
              horizontal: true,
              titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              renderItem: (itemData) {
                return Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 220,
                          width: 400,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2.0),
                            child: CachedNetworkImage(
                              imageUrl:
                                  itemData['recomendedMusicAlbums'].toString(),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                itemData['RecomendedMusic'].toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                itemData['recomendedMusicArtist'].toString(),
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                                textAlign: TextAlign.left,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_circle_filled_rounded,
                            color: Colors.white,
                            size: 60,
                          ),
                          SizedBox(
                            height: 50,
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
              itemSize: 400,
            ),
          ),
          SizedBox(
            height: 450,
            child: SectionGridView(
              physics: const NeverScrollableScrollPhysics(),
              sections: sectionsLast,
              gridViewHeight: 185,
              itemsPerRow: 1,
              horizontal: true,
              titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              renderItem: (itemData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 115,
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2.0),
                        child: CachedNetworkImage(
                          imageUrl:
                              itemData['recomendedMusicAlbums'].toString(),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          itemData['RecomendedMusic'].toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          itemData['recomendedMusicArtist'].toString(),
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 8),
                          textAlign: TextAlign.left,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ],
                );
              },
              itemSize: 120,
            ),
          ),
          Container(
            height: 550,
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 42, 25, 18),
              borderRadius: BorderRadius.circular(
                  20.0), // Ajusta el radio según tus necesidades
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 8, top: 16),
                      height: 120,
                      width: 110,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          imageUrl: quickPickData.last['recomendedMusicAlbums']
                              .toString(),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 16, top: 20),
                      height: 120,
                      width: 160,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Billion Views Club - Rock",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                            softWrap: true,
                            maxLines: 2,
                          ),
                          const Spacer(),
                          const Text(
                            "Grid View Music",
                            style: TextStyle(
                                color: Color.fromARGB(255, 203, 114, 98),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                            softWrap: true,
                            maxLines: 1,
                          ),
                          Text(
                            "${quickPickData.length.toString()} songs",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 203, 114, 98),
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                            softWrap: true,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  height: 45,
                  padding: const EdgeInsets.only(left: 16, top: 8),
                  child: const Text(
                    "Rock hits with over 1 billion music video views on GridView",
                    style: TextStyle(
                        color: Color.fromARGB(255, 203, 114, 98),
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                    softWrap: true,
                    maxLines: 2,
                  ),
                ),
                SizedBox(
                  height: 280,
                  child: SectionGridView(
                    physics: const NeverScrollableScrollPhysics(),
                    sections: billionViews,
                    gridViewHeight: 250,
                    verticalSpacing: 40,
                    itemsPerRow: 3,
                    horizontal: true,
                    titleTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                    renderItem: (itemData) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2.0),
                              child: CachedNetworkImage(
                                imageUrl: itemData['recomendedMusicAlbums']
                                    .toString(),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: 250,
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      itemData['RecomendedMusic'].toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      textAlign: TextAlign.left,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.e_mobiledata_outlined,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          itemData['recomendedMusicArtist']
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 10),
                                          textAlign: TextAlign.left,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.more_vert,
                                  size: 24,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    },
                    itemSize: 300,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildCircularIcon(Icons.play_arrow, Colors.white),
                      buildCircularIcon(Icons.cast, Colors.white),
                      buildCircularIcon(Icons.playlist_add, Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 150,
            child: SectionGridView(
              physics: const NeverScrollableScrollPhysics(),
              sections: const [
                {
                  "title": "Explore",
                  "data": [
                    {"icon": Icons.music_note_outlined, "name": "New releases"},
                    {
                      "icon": Icons.keyboard_double_arrow_up_outlined,
                      "name": "Charts"
                    },
                    {"icon": Icons.face, "name": "Moods & genres"},
                  ]
                }
              ],
              gridViewHeight: 150,
              itemsPerRow: 1,
              horizontal: true,
              titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              renderItem: (itemData) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  color: const Color.fromARGB(255, 26, 25, 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        itemData["icon"],
                        color: Colors.white,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        width: 80,
                        child: Text(
                          itemData["name"].toString(),
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.left,
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                );
              },
              itemSize: 100,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCircularIcon(IconData icon, Color color) {
    return Container(
      width: 40,
      height: 40,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        border: Border.all(
          color: color, // Color del borde
          width: 1, // Ancho del borde
        ),
      ),
      child: Icon(
        icon,
        size: 30,
        color: color,
      ),
    );
  }
}
