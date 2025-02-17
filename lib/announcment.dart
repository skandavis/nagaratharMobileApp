import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'utils.dart' as utils;
class announcment extends StatefulWidget {
  DateTime date = DateTime.now();
  String message;
  Function delete;
  int id;
  announcment(
      {super.key,
      required this.message,
      required this.delete,
      required this.id});

  @override
  State<announcment> createState() => _announcmentState();
}

class _announcmentState extends State<announcment> {
  void removeNotification() async {
    utils.deleteRoute('notifications/${widget.id}');
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              //monday,tuesday,Wednesday,Thursday,Friday,Saturday,Sunday
              //saturday may 11, 12:00 AM

              DateFormat('EEEE MMM d, hh:mm a').format(widget.date),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
                onPressed: (context) {
                  widget.delete();
                  debugPrint("deleted");
                  removeNotification();
                },
              ),
            ],
          ),
          child: Container(
            width: MediaQuery.sizeOf(context).width * 1,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.5),
              child: Text(
                widget.message,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
