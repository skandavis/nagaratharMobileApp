import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding
import 'package:app_set_id/app_set_id.dart';
import 'package:nagarathar/login.dart';
import 'package:nagarathar/globals.dart' as globals;
import 'package:nagarathar/messageReciever.dart';
import 'package:nagarathar/register.dart';

class forgotPasswordPage extends StatefulWidget {
  const forgotPasswordPage({super.key});

  @override
  State<forgotPasswordPage> createState() => _forgotPasswordPageState();
}

Future<void> registerUser(String email) async {
  debugPrint("dkdk");
  var url = Uri.parse(globals.url + 'register');
  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      // "email": email,
      "email": "viswanathanmanickam5@gmail.com",
    }),
  );
}

Future<String?> getDeviceId() async {
  // var deviceInfo = DeviceInfoPlugin();

  // if (Platform.isAndroid) {
  //   // Android device
  //   AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //   return androidInfo.id; // This is the unique device ID for Android devices.
  // } else if (Platform.isIOS) {
  //   // iOS device
  //   IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //   return iosInfo.identifierForVendor; // This is the unique device ID for iOS devices.
  // }
  // return null;
  return await AppSetId().getIdentifier();
}

class _forgotPasswordPageState extends State<forgotPasswordPage> {
  void showDialogBox() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              "Email Confirmation",
              style: TextStyle(color: Colors.black),
            ),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                children: [
                  Container(
                    child: const Text(
                      "We have sent a 4-digit PIN to your email to your email to verify your account.Please cheack it and reenter it.",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Divider(),
                  TextButton(
                    child: Text("If you didn't get an email click here"),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const registerPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    if (result == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const loginPage(),
        ),
      );
    }
  }

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    getDeviceId().then((onvalue) {
      debugPrint(onvalue);
    });

    return messageReciever(
      body: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 24, 19, 118),
              Colors.black,
            ], begin: Alignment.centerLeft, end: Alignment.centerRight),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(50),
                    child: const Text("Forgot Your \nPassword",
                        style: TextStyle(
                            color: Colors.white, fontSize: 48, height: 1)),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(50),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .75,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        TextField(
                          decoration: const InputDecoration(labelText: "Email"),
                          controller: email,
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () async {
                        await registerUser(email.text).then((value) {
                          showDialogBox();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 24, 19, 118),
                                Colors.black,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                        ),
                        child: const Text(
                          "Send",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text("Remember your password?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const forgotPasswordPage()),
                                );
                              },
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const loginPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
