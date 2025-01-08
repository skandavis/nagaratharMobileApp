import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nagarathar/globals.dart' as globals;

class thumbsUpIcon extends StatefulWidget {
  int index;
  late Map<String, dynamic> event = globals.shownEvents[index];
  thumbsUpIcon({super.key, required this.index});

  @override
  State<thumbsUpIcon> createState() => _thumbsUpIconState();
}

class _thumbsUpIconState extends State<thumbsUpIcon> {
  @override
  Widget build(BuildContext context) {
    int count = widget.event["_count"]["likedUserDevice"];
    bool liked = widget.event["liked"];
    int id = widget.event["id"];
    return GestureDetector(
      onTap: () {
        setState(() {
          liked = !liked;
          count += liked ? 1 : -1;
          globals.shownEvents[widget.index]["liked"] = liked;
          globals.shownEvents[widget.index]["_count"]["likedUserDevice"] =
              count;
        });
        if (liked) {
          var url = Uri.parse('${globals.url}events/$id/like');
          debugPrint(globals.token);
          http.put(url, headers: {
            "Content-Type": "application/json",
            "Cookie": globals.token
          });
        } else {
          var url = Uri.parse('${globals.url}events/$id/unlike');
          debugPrint(globals.token);
          http.put(url, headers: {
            "Content-Type": "application/json",
            "Cookie": globals.token
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.thumb_up_sharp,
              color: liked ? Color.fromARGB(255, 255, 183, 13) : Colors.white,
              size: 28,
            ),
            Text(
              count.toString(),
              style: TextStyle(
                  color:
                      liked ? Color.fromARGB(255, 255, 183, 13) : Colors.white,
                  fontSize: 28),
            )
          ],
        ),
      ),
    );
  }
}
