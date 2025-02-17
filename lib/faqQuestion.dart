import 'package:flutter/material.dart';

class faqQuestion extends StatefulWidget {
  String question;
  String answer;
  bool isExpanded = false;
  faqQuestion({super.key, required this.question, required this.answer});

  @override
  State<faqQuestion> createState() => _faqQuestionState();
}

class _faqQuestionState extends State<faqQuestion> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width * .9,
      // height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.question,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.isExpanded = !widget.isExpanded;
                  });
                },
                child: Icon(widget.isExpanded
                    ? Icons.arrow_upward
                    : Icons.arrow_downward),
              )
            ],
          ),
          if (widget.isExpanded)
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.answer,
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
