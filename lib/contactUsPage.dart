import 'package:flutter/material.dart';
import 'package:nagarathar/DropDown.dart';
import 'package:nagarathar/formInput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils.dart' as utils;

class contactUsPage extends StatefulWidget {
  const contactUsPage({super.key});

  @override
  State<contactUsPage> createState() => _contactUsPageState();
}

String selectedValue = 'Admin';
TextEditingController nameController = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController subjectController = TextEditingController();
TextEditingController messageController = TextEditingController();
final SharedPreferencesAsync prefs = SharedPreferencesAsync();

class _contactUsPageState extends State<contactUsPage> {
  void sendMessage() async {
    utils.postRoute(
      {
        'name': nameController.text,
        'city': cityController.text,
        'phoneNumber': phoneController.text,
        "department": selectedValue,
        'subject': subjectController.text,
        'message': messageController.text,
      },
      'contact',
    );
  }

  void onChange(String? value) {
    setState(() {
      selectedValue = value!;
      debugPrint(selectedValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      prefs.getString("phone").then((value) {
        phoneController.text = value!;
      });
      prefs.getString("name").then((value) {
        nameController.text = value!;
      });
      prefs.getString("city").then((value) {
        cityController.text = value!;
      });
    });
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
          SizedBox(
            height: MediaQuery.of(context).size.height * .025,
          ),
          formInput(
            label: "City",
            controller: cityController,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .025,
          ),
          formInput(
            label: "Your Phone Number",
            controller: phoneController,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .025,
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
          GestureDetector(
            onTap: () {
              if (messageController.text.isNotEmpty &&
                  nameController.text.isNotEmpty &&
                  cityController.text.isNotEmpty &&
                  phoneController.text.isNotEmpty &&
                  subjectController.text.isNotEmpty) {
                sendMessage();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Not all fields are filled in!'),
                  ),
                );
              }
            },
            child: Container(
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
          ),
        ],
      ),
    );
  }
}
