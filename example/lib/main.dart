import 'package:flutter/material.dart';
import 'package:example/first_tab.dart';
import 'package:supergrid/flatgrid.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
              .copyWith(background: Colors.black)),
      home: const MyHomePage(title: 'Super grid Sample App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    List data = [
      'https://hips.hearstapps.com/hmg-prod/images/hotel-transylvania-1670879477.jpeg?resize=980:*',
      'https://img.asmedia.epimg.net/resizer/b4Bar9lwlU_uRARRJRTycUzf6XQ=/1472x1104/cloudfront-eu-central-1.images.arcpublishing.com/diarioas/3372EDXE4NLDXLE6ABIUJBLSDU.jpg',
      'https://cdn.hobbyconsolas.com/sites/navi.axelspringer.es/public/media/image/2016/06/607612-proximas-peliculas-pixar-despues-buscando-dory.jpg?tf=3840x',
      'https://i.blogs.es/679f07/diseno-sin-titulo-5-/650_1200.jpeg',
      'https://hips.hearstapps.com/hmg-prod/images/demon-slayer-1657889450.jpeg',
      'https://i.blogs.es/30018b/25-mejores-animes/840_560.jpg',
      'https://hips.hearstapps.com/hmg-prod/images/pluto-5-653d534fe4511.jpg?crop=0.566xw:1.00xh;0.263xw,0&resize=1200:*',
      'https://hips.hearstapps.com/hmg-prod/images/abd9e1b06f340e7479ae4f2c1b132bda1601341053-main-1672918395.jpg?crop=0.526xw:0.938xh;0.228xw,0&resize=640:*',
      'https://lumiere-a.akamaihd.net/v1/images/image_5c76f0c6.jpeg?region=0%2C0%2C540%2C810&width=320',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYR4Qqn5hTjibWr6h2Jl0VKVNv1P400j7Tvw&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnn7747ZnvV2Qhg3JmVR-jZexYlEnbmzNlx-BCQtZXcZdAP3jCnCYdRiOkcGtrD1OWsFA&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgW3wbDTtLbNaV7p68vwJ1YnFZDykuhdYGpQ&usqp=CAU',
      'https://www.lavanguardia.com/files/image_449_220/uploads/2023/02/20/63f30ca39d330.jpeg',
      'https://lumiere-a.akamaihd.net/v1/images/bc0ee6e1acd3e61149bdce1d08de5c7a_2764x4096_354a7134.jpeg',
      'https://www.justwatch.com/images/poster/305307533/s332/dungeons-y-dragons',
      // 'https://files.lafm.com.co/assets/public/styles/img_node_706x392/public/2022-07/uncharted.jpg.webp?VersionId=89GRI5GE8vUyTOgK8KFAO_VQrh3RhGY_&itok=hu-W0paq'
      // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQebXKm_bcBfJWs4edHRcnCr5f3igYKpQSnZQ&usqp=CAU',
      // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjtuaYw3gDJ7qPlxUhcHqLT_vorHZ2arie-w&usqp=CAU',
      // 'https://pymstatic.com/25893/conversions/peliculas-ver-en-familia-wide.jpg',
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Super Grid App",
            style: TextStyle(color: Colors.red),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Section Grid'),
              Tab(text: 'FlatGrid'),
              Tab(text: 'SimpleGrid'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const FirstTab(),
            FlatGridView(
              data: data,
              renderItem: (itemData) {
                return ClipRRect(
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
                );
              },
              itemSize: 100.0,
              itemsPerRow: 3,
              color: Colors.transparent,
              padding: const EdgeInsets.all(16.0),
              gridViewPadding: const EdgeInsets.all(8.0),
              verticalSpacing: 10.0,
              horizontalSpacing: 10.0,
              horizontal: false,
              invertedRow: false,
              onPressed: (index) {
                // Handle item tap
              },
            ),
            const Text("22222")
          ],
        ),
      ),
    );
  }
}
