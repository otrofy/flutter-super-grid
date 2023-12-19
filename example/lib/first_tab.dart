import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_super_grid/sectiongrid.dart';

class FirstTab extends StatelessWidget {
  const FirstTab({super.key});

  @override
  Widget build(BuildContext context) {
    var quickPickData = [
      {
        'recomendedMusicAlbums':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcAW_-GLPerG7FYgKfPH6chkONDwu12pY8nYwGpzj2EjCOahUbxLwgZf9zsxvN3C6sQnA&usqp=CAU',
        'RecomendedMusic': 'Sueños Nocturnos',
        'recomendedMusicArtist': 'Los Viajeros del Tiempo',
      },
      {
        'recomendedMusicAlbums':
            'https://i.etsystatic.com/42347499/r/il/7f2979/4843696398/il_300x300.4843696398_jfto.jpg',
        'RecomendedMusic': 'Caminos Perdidos',
        'recomendedMusicArtist': 'Luna Azul',
      },
      {
        'recomendedMusicAlbums':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTqbspo7cUK5uJn8X9-bGlS7YSTmy_V4MzBBUBThIDXjdYO9-zpLYB-wP3lmaprIBXTfk&usqp=CAU',
        'RecomendedMusic': 'Entre Sombras',
        'recomendedMusicArtist': 'Estrella Fugaz',
      },
      {
        'recomendedMusicAlbums':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3u0qIUD7nu18fEJTxPBeyGFRyIa9sPzT95ndLMHChAeCXwpKQswTZTd9mxa5ipEFHIxI&usqp=CAU',
        'RecomendedMusic': 'Amanecer Estelar',
        'recomendedMusicArtist': 'Orquesta Nebular'
      },
      {
        'recomendedMusicAlbums':
            'https://i.pinimg.com/originals/a4/b6/fc/a4b6fc000e66d3e07ebea1d9a9bffa33.jpg',
        'RecomendedMusic': 'Melodías del Abismo',
        'recomendedMusicArtist': 'Orquesta Nebular'
      },
      {
        'recomendedMusicAlbums':
            'https://media.gq-magazine.co.uk/photos/63341fa5885571856e6edb7d/master/pass/Best-pop-albums-of-the-21st-century-hp-b.jpg',
        'RecomendedMusic': 'Melodías del Abismo',
        'recomendedMusicArtist': 'Orquesta Nebular'
      },
      {
        'recomendedMusicAlbums':
            'https://m.media-amazon.com/images/I/61Wmtp9w7WL._AC_.jpg',
        'RecomendedMusic': 'Lunar Harmony',
        'recomendedMusicArtist': 'Starry Night',
      },
      {
        'recomendedMusicAlbums':
            'https://m.media-amazon.com/images/W/MEDIAX_792452-T2/images/I/61vF8OLMupL._AC_.jpg',
        'RecomendedMusic': 'Aurora in Chords',
        'recomendedMusicArtist': 'Aurora Harmony',
      },
      {
        'recomendedMusicAlbums':
            'https://i.etsystatic.com/35092126/r/il/cb2be4/3863487335/il_fullxfull.3863487335_7n3w.jpg',
        'RecomendedMusic': 'Symphony of Elements',
        'recomendedMusicArtist': 'Elemental Soundscapes',
      },
      {
        'recomendedMusicAlbums':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQ1Xh3RqpdthF2BzDVvUeoWMMcTY87r56sSoP3_e0haNhyWlF77ClEeTKh1oNLaPxwlRU&usqp=CAU',
        'RecomendedMusic': 'Echoes from the Past',
        'recomendedMusicArtist': 'Temporal Symphony'
      },
      {
        'recomendedMusicAlbums':
            'https://m.media-amazon.com/images/I/A1hIzwbPW0L.jpg',
        'RecomendedMusic': 'Notes in Zero Gravity',
        'recomendedMusicArtist': 'Floating in Space'
      },
      {
        'recomendedMusicAlbums':
            'https://i.etsystatic.com/42347499/r/il/7f2979/4843696398/il_300x300.4843696398_jfto.jpg',
        'RecomendedMusic': 'Stellar Dawn',
        'recomendedMusicArtist': 'Shooting Star'
      },
      {
        'recomendedMusicAlbums':
            'https://i.pinimg.com/1200x/90/03/3d/90033d794599f52c6e57d65282dae33a.jpg',
        'RecomendedMusic': 'Musical Destiny',
        'recomendedMusicArtist': 'Astral Journey'
      },
      {
        'recomendedMusicAlbums':
            'https://m.media-amazon.com/images/I/61Wmtp9w7WL._AC_.jpg',
        'RecomendedMusic': 'Lunar Harmony',
        'recomendedMusicArtist': 'Starry Night',
      },
      {
        'recomendedMusicAlbums':
            'https://m.media-amazon.com/images/W/MEDIAX_792452-T2/images/I/61vF8OLMupL._AC_.jpg',
        'RecomendedMusic': 'Aurora in Chords',
        'recomendedMusicArtist': 'Aurora Harmony',
      },
      {
        'recomendedMusicAlbums':
            'https://i.etsystatic.com/35092126/r/il/cb2be4/3863487335/il_fullxfull.3863487335_7n3w.jpg',
        'RecomendedMusic': 'Symphony of Elements',
        'recomendedMusicArtist': 'Elemental Soundscapes',
      },
      {
        'recomendedMusicAlbums':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQ1Xh3RqpdthF2BzDVvUeoWMMcTY87r56sSoP3_e0haNhyWlF77ClEeTKh1oNLaPxwlRU&usqp=CAU',
        'RecomendedMusic': 'Echoes from the Past',
        'recomendedMusicArtist': 'Temporal Symphony'
      },
      {
        'recomendedMusicAlbums':
            'https://m.media-amazon.com/images/I/A1hIzwbPW0L.jpg',
        'RecomendedMusic': 'Notes in Zero Gravity',
        'recomendedMusicArtist': 'Floating in Space'
      },
      {
        'recomendedMusicAlbums':
            'https://i.etsystatic.com/42347499/r/il/7f2979/4843696398/il_300x300.4843696398_jfto.jpg',
        'RecomendedMusic': 'Stellar Dawn',
        'recomendedMusicArtist': 'Shooting Star'
      },
      {
        'recomendedMusicAlbums':
            'https://i.pinimg.com/1200x/90/03/3d/90033d794599f52c6e57d65282dae33a.jpg',
        'RecomendedMusic': 'Musical Destiny',
        'recomendedMusicArtist': 'Astral Journey'
      }
    ];
    var recomendedArtistData = [
      {
        'recomendedMusicAlbums':
            'https://m.media-amazon.com/images/I/61Wmtp9w7WL._AC_.jpg',
        'RecomendedMusic': 'Lunar Harmony',
        'recomendedMusicArtist': 'Starry Night',
      },
      {
        'recomendedMusicAlbums':
            'https://m.media-amazon.com/images/W/MEDIAX_792452-T2/images/I/61vF8OLMupL._AC_.jpg',
        'RecomendedMusic': 'Aurora in Chords',
        'recomendedMusicArtist': 'Aurora Harmony',
      },
      {
        'recomendedMusicAlbums':
            'https://i.etsystatic.com/35092126/r/il/cb2be4/3863487335/il_fullxfull.3863487335_7n3w.jpg',
        'RecomendedMusic': 'Symphony of Elements',
        'recomendedMusicArtist': 'Elemental Soundscapes',
      },
      {
        'recomendedMusicAlbums':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQ1Xh3RqpdthF2BzDVvUeoWMMcTY87r56sSoP3_e0haNhyWlF77ClEeTKh1oNLaPxwlRU&usqp=CAU',
        'RecomendedMusic': 'Echoes from the Past',
        'recomendedMusicArtist': 'Temporal Symphony'
      },
      {
        'recomendedMusicAlbums':
            'https://m.media-amazon.com/images/I/A1hIzwbPW0L.jpg',
        'RecomendedMusic': 'Notes in Zero Gravity',
        'recomendedMusicArtist': 'Floating in Space'
      },
      {
        'recomendedMusicAlbums':
            'https://i.etsystatic.com/42347499/r/il/7f2979/4843696398/il_300x300.4843696398_jfto.jpg',
        'RecomendedMusic': 'Stellar Dawn',
        'recomendedMusicArtist': 'Shooting Star'
      },
      {
        'recomendedMusicAlbums':
            'https://i.pinimg.com/1200x/90/03/3d/90033d794599f52c6e57d65282dae33a.jpg',
        'RecomendedMusic': 'Musical Destiny',
        'recomendedMusicArtist': 'Astral Journey'
      }
    ];
    var recomendedMusic = [
      {
        'recomendedMusicAlbums':
            'https://blog.pearlacademy.com/wp-content/uploads/2022/06/erik-mclean-9y1cTVKe1IY-unsplash-1080x675.jpg',
        'RecomendedMusic': 'Reflections in Water',
        'recomendedMusicArtist': 'Musical Aurora',
      },
      {
        'recomendedMusicAlbums':
            'https://m.media-amazon.com/images/I/71rHAeo7BnL._UF1000,1000_QL80_.jpg',
        'RecomendedMusic': 'Celestial Rhythm',
        'recomendedMusicArtist': 'Funk Galaxy',
      },
      {
        'recomendedMusicAlbums':
            'https://i.etsystatic.com/33708229/r/il/fb8057/3744612133/il_570xN.3744612133_2bv4.jpg',
        'RecomendedMusic': 'Echoes from the Past',
        'recomendedMusicArtist': 'Temporal Symphony',
      },
      {
        'recomendedMusicAlbums':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQ1Xh3RqpdthF2BzDVvUeoWMMcTY87r56sSoP3_e0haNhyWlF77ClEeTKh1oNLaPxwlRU&usqp=CAU',
        'RecomendedMusic': 'Echoes from the Past',
        'recomendedMusicArtist': 'Temporal Symphony'
      },
      {
        'recomendedMusicAlbums':
            'https://m.media-amazon.com/images/I/A1hIzwbPW0L.jpg',
        'RecomendedMusic': 'Notes in Zero Gravity',
        'recomendedMusicArtist': 'Floating in Space'
      },
      {
        'recomendedMusicAlbums':
            'https://i.pinimg.com/1200x/90/03/3d/90033d794599f52c6e57d65282dae33a.jpg',
        'RecomendedMusic': 'Musical Destiny',
        'recomendedMusicArtist': 'Astral Journey'
      }
    ];
    var forYouData = [
      {
        'recomendedMusicAlbums':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcAW_-GLPerG7FYgKfPH6chkONDwu12pY8nYwGpzj2EjCOahUbxLwgZf9zsxvN3C6sQnA&usqp=CAU',
        'RecomendedMusic': 'Sueños Nocturnos',
        'recomendedMusicArtist': 'Los Viajeros del Tiempo',
      },
      {
        'recomendedMusicAlbums':
            'https://i.etsystatic.com/42347499/r/il/7f2979/4843696398/il_300x300.4843696398_jfto.jpg',
        'RecomendedMusic': 'Caminos Perdidos',
        'recomendedMusicArtist': 'Luna Azul',
      },
      {
        'recomendedMusicAlbums':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTqbspo7cUK5uJn8X9-bGlS7YSTmy_V4MzBBUBThIDXjdYO9-zpLYB-wP3lmaprIBXTfk&usqp=CAU',
        'RecomendedMusic': 'Entre Sombras',
        'recomendedMusicArtist': 'Estrella Fugaz',
      },
      {
        'recomendedMusicAlbums':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3u0qIUD7nu18fEJTxPBeyGFRyIa9sPzT95ndLMHChAeCXwpKQswTZTd9mxa5ipEFHIxI&usqp=CAU',
        'RecomendedMusic': 'Amanecer Estelar',
        'recomendedMusicArtist': 'Orquesta Nebular'
      },
      {
        'recomendedMusicAlbums':
            'https://i.pinimg.com/originals/a4/b6/fc/a4b6fc000e66d3e07ebea1d9a9bffa33.jpg',
        'RecomendedMusic': 'Melodías del Abismo',
        'recomendedMusicArtist': 'Orquesta Nebular'
      },
      {
        'recomendedMusicAlbums':
            'https://media.gq-magazine.co.uk/photos/63341fa5885571856e6edb7d/master/pass/Best-pop-albums-of-the-21st-century-hp-b.jpg',
        'RecomendedMusic': 'Melodías del Abismo',
        'recomendedMusicArtist': 'Orquesta Nebular'
      }
    ];
    var sections = [
      {'title': 'Recomended Music', 'data': recomendedMusic},
      {'title': 'Recomended Artist', 'data': recomendedArtistData},
      {'title': 'For you', 'data': forYouData}
    ];
    var sectionsSmall = [
      {'title': 'Quick Picks', 'data': quickPickData},
    ];
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
                      height: 120,
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
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10),
                          textAlign: TextAlign.left,
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
              gridViewWidth: 600,
              verticalSpacing: 160,
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
                      width: 75,
                      child: Column(
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
                          Text(
                            itemData['recomendedMusicArtist'].toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
                            textAlign: TextAlign.left,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
              itemSize: 120,
            ),
          ),
        ],
      ),
    );
  }
}
