import 'package:flutter/material.dart';
import 'package:nagarathar/DropDown.dart';
import 'package:nagarathar/formInput.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding
import 'package:nagarathar/globals.dart' as globals;

class contactUsPage extends StatefulWidget {
  const contactUsPage({super.key});

  @override
  State<contactUsPage> createState() => _contactUsPageState();
}

String selectedValue = 'Admin';
TextEditingController nameController = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();
TextEditingController subjectController = TextEditingController();
TextEditingController messageController = TextEditingController();

class _contactUsPageState extends State<contactUsPage> {
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
          'name': nameController.text,
          'city': cityController.text,
          'phoneNumber': phoneNumberController.text,
          "department": selectedValue,
          'subject': subjectController.text,
          'message': messageController.text,
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

  void onChange(String? value) {
    setState(() {
      selectedValue = value!;
      debugPrint(selectedValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .05,
          ),
          const Text(
            "Contact Us",
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .05,
          ),
          formInput(
            label: "Your Name",
            controller: nameController,
          ),
          formInput(
            label: "City",
            controller: cityController,
          ),
          formInput(
            label: "Your Phone Number",
            controller: phoneNumberController,
          ),
          formInput(
            label: "Subject",
            controller: subjectController,
          ),
          const SizedBox(
            height: 20,
          ),
          DropDown(
            options: ["Admin", "Events", "Food Committee", "Lost and Found"],
            label: "Choose the Department",
            initialValue: "Admin",
            onChanged: onChange,
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: messageController,
            minLines: 3,
            maxLines: 5,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: "ex: How can we help you?",
              label: const Text(
                "Your Message",
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 183, 13),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width * .8,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 255, 183, 13),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Send Message",
                  style: TextStyle(
                    color: Color.fromARGB(255, 5, 3, 30),
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
