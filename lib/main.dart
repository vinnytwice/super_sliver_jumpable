import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:super_sliver_jumpable/sliver.dart';
import 'package:super_sliver_jumpable/sliver_item.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'SuperSliverList jumpable'),
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
  final ScrollController scrollController = ScrollController();
  int selectedSliverIndex = 0;
  int sliversAmount = 10;
  // int itemPerSliver = 15; // Not jumping correctly
  int itemPerSliver = 50; // jumping correctly
  late List<ListController> listControllers;
  late List<List<int>> sliversData;

  @override
  void initState() {
    super.initState();
    listControllers = populateListControllers();
    sliversData = generateMockedData();
  }

  List<ListController> populateListControllers() {
    List<ListController> listControllers = [];
    for (var i = 0; i < 10; i++) {
      listControllers.add(ListController());
    }
    return listControllers;
  }

  List<List<int>> generateMockedData() {
    List<List<int>> sliversData = [];
    int startDate = 0;
    for (int i = 0; i < sliversAmount; i++) {
      List<int> day = [];
      for (var i = 0; i < itemPerSliver; i++) {
        day.add(startDate);
        startDate++;
      }
      sliversData.add(day);
    }
    return sliversData;
  }

  @override
  Widget build(BuildContext context) {
    log('buiild()');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          for (int i = 0; i < sliversData.length; i++)
            Sliver(
              headerText: i,
              sliver: SuperSliverList.builder(
                extentEstimation: (index, crossAxisExtent) {
                  log('extentEstimation index: $index, crossAxisExtent: $crossAxisExtent');
                  return 60;
                },
                extentPrecalculationPolicy: MyExtentPrecalculationPolicy(),
                listController: listControllers[i],
                itemCount: sliversData[i].length,
                itemBuilder: (context, index) => SliverItem(
                  itemText: sliversData[i][index].toString(),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () => _goToFirstSliver(),
              child: const Text('Go to first')),
          TextButton(
              onPressed: () => _goToNextSliver(),
              child: const Text('Go to next')),
        ],
      ),
    );
  }

  _goToFirstSliver() {
    try {
      setState(() {
        selectedSliverIndex = 0;
      });
      listControllers.first.jumpToItem(
        index: 0,
        scrollController: scrollController,
        alignment: 0,
      );
    } catch (e) {
      log('Jumping to 0 error: $e');
    }
  }

  _goToNextSliver() {
    setState(() {
      selectedSliverIndex++;
    });
    try {
      listControllers[selectedSliverIndex].jumpToItem(
        index: 0,
        scrollController: scrollController,
        alignment: 0,
      );
    } catch (e) {
      log('Jumping to $selectedSliverIndex error: $e');
    }
  }
}

class MyExtentPrecalculationPolicy extends ExtentPrecalculationPolicy {
  @override
  bool shouldPrecalculateExtents(ExtentPrecalculationContext context) {
    return true;
  }
}
