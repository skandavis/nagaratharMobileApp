import 'package:flutter/material.dart';
import 'package:nagarathar/attribute.dart';
import 'package:nagarathar/categoryLabel.dart';
import 'package:nagarathar/description.dart';
import 'package:nagarathar/favorite.dart';
import 'package:nagarathar/homePage.dart';
import 'package:nagarathar/imageCarousel.dart';
import 'package:nagarathar/thumbsUpIcon.dart';
import 'package:nagarathar/verticalDivider.dart';
import 'dart:typed_data';
import 'package:nagarathar/globals.dart' as globals;

class expandedEventPage extends StatefulWidget {
  List<Uint8List> images;
  int index;
  expandedEventPage({super.key, required this.images, required this.index});

  @override
  State<expandedEventPage> createState() => _expandedEventPageState();
}

class _expandedEventPageState extends State<expandedEventPage> {
  bool ellipsis = true;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> event = globals.shownEvents[widget.index];
    DateTime startTime = DateTime.parse(event["startTime"]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        foregroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(index: 1,),
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
            )
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 5, 3, 30),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Colors.transparent],
                      stops: [
                        0.75,
                        1.0
                      ], // Controls where the fade begins and ends
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  // child: Image.network(
                  // "https://img.freepik.com/free-photo/group-active-kids-cheerful-girls-dancing-isolated-green-background-neon-light_155003-46334.jpg"),
                  child: ImageCarousel(images: widget.images),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        event["name"],
                        style: const TextStyle(
                            fontSize: 36,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      if (event["category"] != null)
                        categoryLabel(
                          event: event,
                        )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "The Great Norwegian Tour",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  FavoriteIcon(
                    index: widget.index,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                attribute(
                  attributeTitle: "Date",
                  attributeValue:
                      "June ${startTime.day}, ${startTime.hour > 12 ? startTime.hour - 12 : startTime.hour}:${startTime.minute} ${startTime.hour > 12 ? "PM" : "AM"}",
                ),
                const myVerticaldivider(),
                attribute(
                  attributeTitle: "Location",
                  attributeValue: event["location"],
                ),
                const myVerticaldivider(),
                attribute(
                  attributeTitle: "Duration",
                  attributeValue: "${event["duration"]} min",
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            thumbsUpIcon(
              index: widget.index,
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        "About Event",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  descriptionBox(
                    ellipsis: ellipsis,
                    description: event["description"],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
