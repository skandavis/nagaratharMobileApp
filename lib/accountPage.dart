import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:nagarathar/formInput.dart';
import 'package:nagarathar/messageReciever.dart';
import 'package:app_set_id/app_set_id.dart';
import 'utils.dart' as utils;

class accountPage extends StatefulWidget {
  const accountPage({super.key});

  @override
  State<accountPage> createState() => _accountPageState();
}

TextEditingController cityController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController phoneController = TextEditingController();
final SharedPreferencesAsync prefs = SharedPreferencesAsync();
String email = "";
String deviceID = "";

class _accountPageState extends State<accountPage> {
  void getDeviceId() async {
    deviceID = (await AppSetId().getIdentifier())!;
  }

  @override
  void initState() {
    super.initState();
    getDeviceId();
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
      prefs.getString("email").then((value) {
        email = value!;
        debugPrint(email);
      });
    });
  }

  void sendData() async {
    utils.patchRoute({
      "email": "viswanathanmanickam5@gmail.com",
      "city": cityController.text,
      "name": nameController.text,
      "phoneNumber": phoneController.text,
    }, 'device/$deviceID');
  }

  Widget build(BuildContext context) {
    return messageReciever(
      body: Scaffold(
        backgroundColor: const Color.fromARGB(255, 5, 3, 30),
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: const Text(
            "Account",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 5, 3, 30),
        ),
        body: Column(
          children: [
            // make circle
            Container(
              height: 75,
              width: 75,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              // clipBehavior: Clip.antiAlias,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              email,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
            ),

            formInput(
              label: "Name",
              controller: nameController,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .025,
            ),
            formInput(
              label: "Phone Number",
              controller: phoneController,
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
            GestureDetector(
              onTap: () {
                prefs.setString('city', cityController.text);
                prefs.setString('phone', phoneController.text);
                prefs.setString('name', nameController.text);
                sendData();
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
                      "Save",
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
      ),
    );
  }
}
