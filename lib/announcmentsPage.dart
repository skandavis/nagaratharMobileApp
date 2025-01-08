import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nagarathar/announcment.dart';
import 'package:nagarathar/checkBox.dart';
import 'dart:convert'; // For JSON encoding
import 'package:nagarathar/globals.dart' as globals;

class announcmentsPage extends StatefulWidget {
  announcmentsPage({super.key});

  @override
  State<announcmentsPage> createState() => _announcmentsPageState();
}

TextEditingController messageController = TextEditingController();
List<dynamic> messages = [];
bool isPush = false;

class _announcmentsPageState extends State<announcmentsPage> {
  Future<List<dynamic>> fetchNotifications() async {
    final url =
        Uri.parse('${globals.url}notifications'); // Replace with actual URL
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Cookie": globals.token,
      },
    );
    debugPrint(json.decode(response.body)["notifications"].toString());
    return json.decode(response.body)["notifications"];
  }

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
            backgroundColor: const Color.fromARGB(255, 5, 3, 30),
            title: const Text(
              "New Announcement",
              style: TextStyle(color: Colors.white),
            ),
            content: Container(
              height: MediaQuery.sizeOf(context).height * .25,
              child: Column(
                children: [
                  TextField(
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    minLines: 3,
                    controller: messageController,
                    autofocus: true,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: "Ex: Everyone come to dinner",
                    ),
                  ),
                  Check(
                    name: "Push Notification",
                    onChange: updateIsPush,
                  ),
                ],
              ),
            ),
            actions: [
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
                icon: const Icon(Icons.add), // Icon to display
                label: const Text('Send'), // Text to display
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> sendMessage() async {
    final url = Uri.parse(
        '${globals.url}notifications'); // Replace with your Django endpoint URL
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Cookie": globals.token,
      },
      body: jsonEncode(
        {
          'message': messageController.text,
          "type": isPush ? "P" : "N",
        },
      ),
    );

    if (response.statusCode == 200) {
      // Handle success
      debugPrint('Message sent successfully!');
    } else {
      // Handle error
      debugPrint('Failed to send message. Status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    fetchNotifications().then((onValue) {
      setState(() {
        messages = onValue;
      });
      debugPrint(messages.toString());
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
