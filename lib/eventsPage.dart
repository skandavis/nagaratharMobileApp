import 'package:flutter/material.dart';
import 'package:nagarathar/selectableCategoryLabel.dart';
import 'package:nagarathar/event.dart';
import 'package:nagarathar/globals.dart' as globals;
import 'dart:typed_data';
import 'utils.dart' as utils;

class eventsPage extends StatefulWidget {
  const eventsPage({super.key});

  @override
  State<eventsPage> createState() => _eventsPageState();
}

@override
@override
class _eventsPageState extends State<eventsPage> {
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();
  List<selectableCategoryLabel> categoryWidgets = [];
  List<int> imageIDs = [];

  @override
  void initState() {
    super.initState();
    loadInitialData();
    if (globals.categoriesChosen.isEmpty) {
      setState(() {
        loadCategories();
      });
    }

    _scrollController.addListener(_onScroll);
  }

  void loadCategories() async {
    utils.getRoute('categories').then((response) {
      for (var category in response["categories"]) {
        globals.totalCategories.add(category["category"]);
      }

      for (int i = 0; i < globals.totalCategories.length; i++) {
        categoryWidgets.add(selectableCategoryLabel(
            label: globals.totalCategories[i],
            chooseCategory: updateCategories,
            chosen:
                globals.categoriesChosen.contains(globals.totalCategories[i])));
      }
    });
  }

  Future<void> loadInitialData() async {
    await utils.getRoute('events').then((onValue) {
      globals.totalEvents = onValue["events"];
    });
    if (globals.categoriesChosen.isEmpty) {
      globals.shownEvents = globals.totalEvents.toList();
    } else {
      showEventsBasedOnCategories();
    }
    loadImages();
    setState(() {});
  }

  void loadImages() async {
    for (int i = globals.shownImages.length;
        i < globals.shownEvents.length && i < globals.shownEvents.length + 5;
        i++) {
      if (imageIDs.contains(globals.shownEvents[i]["id"])) {
        globals.shownImages.add(globals
            .totalImages[imageIDs.indexOf(globals.shownEvents[i]["id"])]);
        continue;
      }

      List<Uint8List> newImages = [];
      var images = [];
      await utils
          .getRoute('events/${globals.shownEvents[i]["id"]}')
          .then((onValue) {
        images = onValue["event"]["images"];
      });
      for (var imageUrl in images) {
        utils.getImage(imageUrl["url"]).then((image) {
          if(image.isEmpty) {
            debugPrint("Failed to load an image for event ${i + 1}");
          }else{
            newImages.add(image);
          }
        });
      }

      globals.totalImages.add(newImages);
      imageIDs.add(globals.shownEvents[i]["id"]);
      globals.shownImages.add(newImages);
    }

    setState(() {});
  }

  Future<void> loadMoreData(bool refresh) async {
    if (_isLoading || globals.shownImages.length >= globals.shownEvents.length)
      return;
    if (refresh) {
      globals.shownImages.clear();
    }
    setState(() {
      _isLoading = true;
    });

    loadImages();
    setState(() {
      _isLoading = false;
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading) {
      loadMoreData(false);
    }
  }

  void showEventsBasedOnCategories() {
    globals.shownEvents.clear();
    for (int i = 0; i < globals.totalEvents.length; i++) {
      for (int j = 0; j < globals.categoriesChosen.length; j++) {
        if (globals.totalEvents[i]["category"] != null &&
            globals.totalEvents[i]["category"]["category"] ==
                globals.categoriesChosen[j]) {
          globals.shownEvents.add(globals.totalEvents[i]);
        }
      }
    }
  }

  void updateCategories(bool chosen, String category) {
    if (chosen) {
      globals.categoriesChosen.add(category);
    } else {
      globals.categoriesChosen.remove(category);
    }

    if (globals.categoriesChosen.isEmpty) {
      globals.shownEvents = globals.totalEvents.toList();
    } else {
      showEventsBasedOnCategories();
    }
    loadMoreData(true);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .05,
        ),
        const Text(
          "Events",
          style: TextStyle(fontSize: 32, color: Colors.white),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .1,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            itemCount: globals.totalCategories.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  categoryWidgets[index],
                ],
              );
            },
          ),
        ),
        Expanded(
          child: globals.shownEvents.isEmpty || globals.shownImages.isEmpty
              ? const Center(
                  child: Text("No events found.",
                      style: TextStyle(color: Colors.white)))
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: globals.shownEvents.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < globals.shownEvents.length) {
                      return Column(
                        children: [
                          Event(
                            index: index,
                            images: globals.shownImages[index],
                          ),
                          const SizedBox(height: 25),
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
        ),
      ],
    );
  }
}
