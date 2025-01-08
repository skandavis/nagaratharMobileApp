import 'package:flutter/material.dart';
import 'package:nagarathar/login.dart';
import 'package:nagarathar/messageReciever.dart';
import 'package:nagarathar/register.dart';

class introPage extends StatefulWidget {
  const introPage({super.key});

  @override
  State<introPage> createState() => _introPageState();
}

class _introPageState extends State<introPage> {
  @override
  Widget build(BuildContext context) {
    return messageReciever(
      body: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(50),
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 24, 19, 118),
              Colors.black,
            ], begin: Alignment.centerLeft, end: Alignment.centerRight),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Column(
                    children: [
                      Icon(
                        Icons.event,
                        size: 64,
                        color: Colors.white,
                      ),
                      Text(
                        "Nagarathar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "Welcome Back",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const loginPage(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 255, 183, 13),
                                width: 2),
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.transparent,
                          ),
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const registerPage(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 255, 183, 13),
                                width: 2),
                            borderRadius: BorderRadius.circular(25),
                            color: Color.fromARGB(255, 255, 183, 13),
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Color.fromARGB(255, 5, 3, 30),
                                fontSize: 24),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
