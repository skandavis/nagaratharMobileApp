import 'package:flutter/material.dart';
import 'package:nagarathar/selectableCategoryLabel.dart';
import 'package:nagarathar/event.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding
import 'package:nagarathar/globals.dart' as globals;
import 'dart:typed_data';

class eventsPage extends StatefulWidget {
  const eventsPage({super.key});

  @override
  State<eventsPage> createState() => _eventsPageState();
}

@override
@override
class _eventsPageState extends State<eventsPage> {
  List<List<Uint8List>> totalImages = [];
  List<List<Uint8List>> shownImages = [];
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();
  List<String> categoriesChosen = [];
  List<selectableCategoryLabel> categoryWidgets = [];
  List<int> imageIDs = [];

  @override
  void initState() {
    super.initState();
    loadInitialData();
    for (int i = 0; i < globals.totalCategories.length; i++) {
      categoryWidgets.add(selectableCategoryLabel(
          label: globals.totalCategories[i], chooseCategory: updateCategories));
    }
    _scrollController.addListener(_onScroll);
  }

  Future<void> loadInitialData() async {
    globals.totalEvents = await loadEvents();
    globals.shownEvents = globals.totalEvents.toList();
    await loadImages();
    setState(() {});
  }

  Future<List<dynamic>> loadEvents() async {
    var url = Uri.parse(globals.url + 'events');
    var response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Cookie": globals.token,
    });
    if (response.statusCode == 200) {
      return json.decode(response.body)["events"];
    } else {
      debugPrint("Failed to load events");
      return [];
    }
  }

  Future<void> loadImages() async {
  for (int i = shownImages.length;
      i < globals.shownEvents.length && i < globals.shownEvents.length + 5;
      i++) {
    if (imageIDs.contains(globals.shownEvents[i]["id"])) {
      shownImages.add(
        totalImages[imageIDs.indexOf(globals.shownEvents[i]["id"])]
      );
      continue;
    }

    List<Uint8List> newImages = [];
    var url =
        Uri.parse('${globals.url}events/${globals.shownEvents[i]["id"]}');
    var responseEvent = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Cookie": globals.token,
    });

    if (responseEvent.statusCode == 200) {
      var images = json.decode(responseEvent.body)["event"]["images"];
      for (var imageUrl in images) {
        var imageResponse = await http.get(
          Uri.parse(
              globals.url + "events" + imageUrl["url"].split("event")[1]),
          headers: {
            "Content-Type": "application/json",
            "Cookie": globals.token,
          },
        );

        if (imageResponse.statusCode == 200) {
          newImages.add(imageResponse.bodyBytes);
        } else {
          debugPrint("Failed to load an image for event ${i + 1}");
        }
      }
    } else {
      debugPrint("Failed to load event data for event ${i + 1}");
    }

    totalImages.add(newImages);
    imageIDs.add(globals.shownEvents[i]["id"]);
    shownImages.add(newImages);
  }

  setState(() {});
}


  Future<void> loadMoreData(bool refresh) async {
    if (_isLoading || shownImages.length >= globals.shownEvents.length) return;
    if (refresh) {
      shownImages.clear();
    }
    setState(() {
      _isLoading = true;
    });

    await loadImages();
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
      for (int j = 0; j < categoriesChosen.length; j++) {
        if (globals.totalEvents[i]["category"] != null &&
            globals.totalEvents[i]["category"]["category"] ==
                categoriesChosen[j]) {
          globals.shownEvents.add(globals.totalEvents[i]);
        }
      }
    }
  }

  void updateCategories(bool chosen, String category) {
    if (chosen) {
      categoriesChosen.add(category);
    } else {
      categoriesChosen.remove(category);
    }

    if (categoriesChosen.isEmpty) {
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
          child: globals.shownEvents.isEmpty || shownImages.isEmpty
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
                            images: shownImages[index],
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
