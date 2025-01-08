import 'package:flutter/material.dart';

class selectableCategoryLabel extends StatefulWidget {
  String label;
  Color bc = Colors.white;
  Color tc = Colors.black;
  Function(bool, String) chooseCategory;
  selectableCategoryLabel({super.key, required this.label, required this.chooseCategory});

  @override
  State<selectableCategoryLabel> createState() => _selectableCategoryLabelState();
}

class _selectableCategoryLabelState extends State<selectableCategoryLabel> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (widget.bc == Colors.white) {
            widget.bc = Color.fromARGB(255, 255, 183, 13);
            widget.tc = Colors.black;
            widget.chooseCategory(true, widget.label);
          } else {
            widget.bc = Colors.white;
            widget.tc = Colors.black;
            widget.chooseCategory(false, widget.label);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: widget.tc, width: 2),
            borderRadius: BorderRadius.circular(15),
            color: widget.bc),
        child: Text(
          widget.label,
          style: TextStyle(fontSize: 16, color: widget.tc),
        ),
      ),
    );
  }
}
