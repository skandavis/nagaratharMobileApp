import 'package:flutter/material.dart';

class selectableCategoryLabel extends StatefulWidget {
  String label;
  bool chosen;
  Function(bool, String) chooseCategory;
  selectableCategoryLabel(
      {super.key,
      required this.label,
      required this.chooseCategory,
      required this.chosen});

  @override
  State<selectableCategoryLabel> createState() =>
      _selectableCategoryLabelState();
}

class _selectableCategoryLabelState extends State<selectableCategoryLabel> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.chosen = !widget.chosen;
          widget.chooseCategory(widget.chosen, widget.label);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(15),
            color: widget.chosen
                ? Color.fromARGB(255, 255, 183, 13)
                : Colors.white),
        child: Text(
          widget.label,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }
}
