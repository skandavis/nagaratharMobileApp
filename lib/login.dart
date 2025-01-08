import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding
import 'dart:io' show Platform;
import 'package:app_set_id/app_set_id.dart';
import 'package:nagarathar/forgotPasswordPage.dart';
import 'package:nagarathar/globals.dart' as globals;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nagarathar/homePage.dart';
import 'package:nagarathar/messageReciever.dart';
import 'package:nagarathar/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

String deviceId = "";
String ApnsToken = "";

Future<void> loginUser(String email, String pin) async {
  debugPrint("deviceId: $deviceId");
  debugPrint("ApnsID: $ApnsToken");
  var url = Uri.parse('${globals.url}authenticate');
  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "email": "viswanathanmanickam5@gmail.com",
      "passcode": "9165",
      "deviceID": deviceId,
      "deviceAPN": ApnsToken,
    }),
  );
  response.statusCode == 200 ? debugPrint("Success") : debugPrint("Fail");
  globals.token = response.headers["set-cookie"].toString().split(";")[0];
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();
  await prefs.setString('cookie', globals.token);
  debugPrint("Header: ${response.headers}");
  debugPrint("token: ${globals.token}");
}

Future<String?> getDeviceId() async {
  deviceId = (await AppSetId().getIdentifier())!;
  return await AppSetId().getIdentifier();
}

bool isValidEmail(String email) {
  final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  return emailRegex.hasMatch(email);
}

class _loginPageState extends State<loginPage> {
  @override
  Widget build(BuildContext context) {
    getApnsToken();
    getDeviceId();
    final _formKey = GlobalKey<FormState>();
    TextEditingController password = TextEditingController();
    TextEditingController email = TextEditingController();
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
                    child: const Text(
                      "Hello \nSign in!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        height: 1,
                      ),
                    ),
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
                        TextFormField(
                          key: _formKey,
                          decoration: const InputDecoration(labelText: "Email"),
                          controller: email,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          maxLength: 4,
                          decoration: const InputDecoration(labelText: "PIN"),
                          controller: password,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const forgotPasswordPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Forgot Password",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    TextButton(
                      onPressed: () async {
                        if (email.text.isEmpty || password.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please enter email or password'),
                            ),
                          );
                        } else if (isValidEmail(email.text)) {
                          // If the form is valid
                          loginUser(email.toString(), password.text)
                              .then((onValue) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyHomePage(),
                              ),
                            );
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('${email.text} is an invalid email'),
                            ),
                          );
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * .75,
                        padding: const EdgeInsets.symmetric(vertical: 15),
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
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const registerPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
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

Future<String> getApnsToken() async {
  // String? token = await FirebaseMessaging.instance.getToken();
  String? token = Platform.isAndroid
      ? await FirebaseMessaging.instance.getToken()
      : await FirebaseMessaging.instance.getAPNSToken();
  //String? token = await FirebaseMessaging.instance.;
  debugPrint('APNs Token: $token');
  ApnsToken = token!;
  return token!;
}
