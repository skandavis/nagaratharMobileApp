import 'package:flutter/material.dart';
import 'package:nagarathar/announcment.dart';
import 'package:nagarathar/checkBox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils.dart' as utils;

class announcmentsPage extends StatefulWidget {
  announcmentsPage({super.key});

  @override
  State<announcmentsPage> createState() => _announcmentsPageState();
}

TextEditingController messageController = TextEditingController();
List<dynamic> messages = [];
bool isPush = false;
String type = '';
final SharedPreferencesAsync prefs = SharedPreferencesAsync();

class _announcmentsPageState extends State<announcmentsPage> {
  void updateIsPush() {
    setState(() {
      isPush = !isPush;
    });
  }

  void showDialogBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            backgroundColor: const Color.fromARGB(255, 15, 9, 95),
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New Announcement",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: Container(
              height: MediaQuery.sizeOf(context).height * .18,
              width: MediaQuery.sizeOf(context).width * .8,
              child: Column(
                children: [
                  TextField(
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    minLines: 2,
                    controller: messageController,
                    autofocus: true,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: "Ex: Everyone come to dinner",
                    ),
                  ),
                  Check(
                    color: Colors.white,
                    name: "Push Notification",
                    onChange: updateIsPush,
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      messageController.clear();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Quit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.white,
                      ),
                      foregroundColor: WidgetStatePropertyAll(
                        const Color.fromARGB(255, 62, 54, 217),
                      ),
                    ),
                    onPressed: () {
                      if (messageController.text.isEmpty) {
                        return;
                      }
                      setState(() {
                        messages.add({
                          "id": messages.length + 1,
                          "message": messageController.text,
                          "type": "P"
                        });
                        sendMessage();
                        messageController.clear();
                        Navigator.of(context).pop();
                      });
                    },
                    icon: const Icon(Icons.send), // Icon to display
                    label: const Text('Send'), // Text to display
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void sendMessage() async {
    utils.postRoute(
      {
        'message': messageController.text,
        "type": isPush ? "P" : "N",
      },
      'notifications',
    );
  }

  @override
  void initState() {
    utils.getRoute('notifications').then((value) {
      setState(() {
        messages = value['notifications'];
        debugPrint(messages.toString());
      });
    });
    prefs.getString("userType").then((value) {
      setState(() {
        type = value!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .05,
        ),
        const Text(
          "Announcements",
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
        Container(
          height: MediaQuery.sizeOf(context).height * .7,
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  announcment(
                    id: messages[index]["id"],
                    delete: () {
                      setState(() {
                        messages.removeAt(index);
                      });
                    },
                    message: messages[index]["message"],
                  ),
                ],
              );
            },
          ),
        ),
        if (type == "admin" || type == "SuperAdmin")
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: showDialogBox,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 255, 183, 13),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          )
      ],
    );
  }
}
