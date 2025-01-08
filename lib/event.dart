import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:nagarathar/expandedEventPage.dart';
import 'package:nagarathar/favorite.dart';
import 'package:nagarathar/globals.dart' as globals;

class Event extends StatefulWidget {
  int index;
  List<Uint8List> images;
  Event({
    super.key,
    required this.index,
    required this.images,
  });

  @override
  State<Event> createState() => _EventState();
}

@override
class _EventState extends State<Event> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> event = globals.shownEvents[widget.index];
    DateTime startTime = DateTime.parse(event["startTime"]);
    List<String> monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
      ),
      //height: 150,
      width: MediaQuery.of(context).size.width * .8,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              if (widget.images.isNotEmpty)
                ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.memory(
                      widget.images[0],
                    )),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        monthNames[startTime.month - 1].substring(0, 3),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      Text(startTime.day.toString())
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  event["name"],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24),
                ),
                FavoriteIcon(
                  index: widget.index,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 250,
                  child: Text(
                    event["description"],
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 5, 3, 30),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "${event["duration"]} min",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.pin_drop,
                  ),
                  Text("Someplace,UK My Hotel"),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 5, 3, 30),
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "${startTime.hour > 12 ? startTime.hour - 12 : startTime.hour}:${startTime.minute} ${startTime.hour > 12 ? "PM" : "AM"}",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => expandedEventPage(
                    index: widget.index,
                    images: widget.images,
                  ),
                ),
              );
            },
            child: Container(
              height: 50,
              width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                  colors: [
                    // Color.fromARGB(255, 181, 41, 222),
                    // Color.fromARGB(255, 62, 54, 217)
                    Color.fromARGB(255, 255, 183, 13),
                    Color.fromARGB(255, 241, 119, 19),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Text(
                  "Read more",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
