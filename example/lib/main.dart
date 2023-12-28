import 'package:example/second_tab.dart';
import 'package:example/tird_tab.dart';
import 'package:flutter/material.dart';
import 'package:example/first_tab.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_super_grid/flutter_super_grid.dart';

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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          bottom: const TabBar(
            labelColor: Colors.white,
            dividerColor: Colors.white,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Section Grid'),
              Tab(text: 'FlatGrid'),
              Tab(text: 'SimpleGrid'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            FirstTab(),
            SizedBox(height: 52, width: 50, child: SecondTab()),
            SizedBox(height: 52, width: 50, child: TirdTab()),
          ],
        ),
      ),
    );
  }
}
