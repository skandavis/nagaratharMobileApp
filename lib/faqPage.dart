import 'package:flutter/material.dart';
import 'package:nagarathar/faqQuestion.dart';
import 'utils.dart' as utils;

class faqPage extends StatefulWidget {
  const faqPage({super.key});

  @override
  State<faqPage> createState() => _faqPageState();
}

List<dynamic> questions = [];

class _faqPageState extends State<faqPage> {
  @override
  void initState() {
    utils.getRoute('faqs').then((onValue) {
      setState(() {
        questions = onValue["faqs"];
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
