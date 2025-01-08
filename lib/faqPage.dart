import 'package:flutter/material.dart';
import 'package:nagarathar/faqQuestion.dart';
import 'dart:convert'; // For JSON encoding
import 'package:nagarathar/globals.dart' as globals;
import 'package:http/http.dart' as http;

class faqPage extends StatefulWidget {
  const faqPage({super.key});

  @override
  State<faqPage> createState() => _faqPageState();
}

List<dynamic> questions = [];
Future<List<dynamic>> loadQuestions() async {
  var url = Uri.parse(globals.url + 'faqs');
  var response = await http.get(url, headers: {
    "Content-Type": "application/json",
    "Cookie": globals.token,
  });
  if (response.statusCode == 200) {
    return json.decode(response.body)["faqs"];
  } else {
    debugPrint("Failed to load events");
    return [];
  }
}

class _faqPageState extends State<faqPage> {
  @override
  void initState() {
    loadQuestions().then((onValue) {
      setState(() {
        questions = onValue;
        debugPrint(questions.toString());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .05,
            ),
            const Text(
              "FAQ",
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(questions.length, (index) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      faqQuestion(
                        question: questions[index]["question"],
                        answer: questions[index]["answer"],
                      )
                    ],
                  );
                }))
          ],
        ),
      ],
    );
  }
}
