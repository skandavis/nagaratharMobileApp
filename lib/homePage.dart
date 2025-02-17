import 'package:flutter/material.dart';
import 'package:nagarathar/contactUsPage.dart';
import 'package:nagarathar/faqPage.dart';
import 'package:nagarathar/announcmentsPage.dart';
import 'package:nagarathar/eventsPage.dart';
import 'package:nagarathar/mainPage.dart';
import 'package:nagarathar/messageReciever.dart';
import 'package:nagarathar/settingsPage.dart';

class MyHomePage extends StatefulWidget {
  int index;
  MyHomePage({super.key, required this.index});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var pages = [
    const mainPage(),
    const eventsPage(),
    announcmentsPage(),
    const faqPage(),
    const contactUsPage(),
    const settingsPage(),
  ];
  int selectedIndex = 0;
  @override
  @override
  void initState() {
    super.initState();
    setState(() {
      selectedIndex = widget.index;
    });
  }

  Widget build(BuildContext context) {
    return messageReciever(
      body: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 5, 3, 30),
        body: pages[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 5, 3, 30),
          unselectedItemColor: const Color.fromARGB(255, 5, 3, 30),
          selectedItemColor: const Color.fromARGB(255, 62, 54, 217),
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(
                Icons.home,
              ),
            ),
            BottomNavigationBarItem(
              label: "Events",
              icon: Icon(
                Icons.event,
              ),
            ),
            BottomNavigationBarItem(
              label: "Messages",
              icon: Icon(
                Icons.question_answer,
              ),
            ),
            BottomNavigationBarItem(
              label: "FAQ",
              icon: Icon(Icons.contact_support),
            ),
            BottomNavigationBarItem(
              label: "Contact Us",
              icon: Icon(
                Icons.email,
              ),
            ),
            BottomNavigationBarItem(
              label: "Settings",
              icon: Icon(
                Icons.settings,
              ),
            ),
          ],
          currentIndex: selectedIndex,
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
