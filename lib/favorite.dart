import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nagarathar/globals.dart' as globals;

class FavoriteIcon extends StatefulWidget {
  int index;
  late Map<String, dynamic> event = globals.shownEvents[index];
  FavoriteIcon({super.key, required this.index});

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  @override
  void initState() {
    debugPrint(widget.index.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool favorite = widget.event["favorite"];
    int id = widget.event["id"];
    return IconButton(
      onPressed: () {
        setState(() {
          favorite = !favorite;
          globals.shownEvents[widget.index]["favorite"] = favorite;
        });
        if (favorite) {
          var url = Uri.parse(
              globals.url + 'events/' + id.toString() + '/favoritize');
          debugPrint(globals.token);
          http.put(url, headers: {
            "Content-Type": "application/json",
            "Cookie": globals.token
          });
        } else {
          var url = Uri.parse(
              globals.url + 'events/' + id.toString() + '/unfavoritize');
          debugPrint(globals.token);
          http.put(url, headers: {
            "Content-Type": "application/json",
            "Cookie": globals.token
          });
        }
      },
      icon: Icon(
        size: 28,
        favorite ? Icons.favorite : Icons.favorite_border,
        color: favorite ? Colors.pink : Color.fromARGB(255, 255, 183, 13),
      ),
    );
  }
}
