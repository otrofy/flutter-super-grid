import 'package:example/second_tab.dart';
import 'package:example/third_tab.dart';
import 'package:flutter/material.dart';
import 'package:example/first_tab.dart';

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
              Tab(text: 'SectionGrid'),
              Tab(text: 'FlatGrid'),
              Tab(text: 'SimpleGrid'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            FirstTab(),
            SecondTab(),
            ThirdTab(),
          ],
        ),
      ),
    );
  }
}
