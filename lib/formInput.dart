import 'package:flutter/material.dart';

class formInput extends StatefulWidget {
  String label;
  TextEditingController controller;
  formInput({super.key, required this.label, required this.controller});

  @override
  State<formInput> createState() => _formInputState();
}

class _formInputState extends State<formInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onEditingComplete: () {
        debugPrint(widget.controller.text);
      },
      controller: widget.controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabled: true,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 255, 183, 13),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 13, 182, 255),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 255, 183, 13),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        hintText: widget.label,
        label: Text(
          widget.label,
          style: const TextStyle(
              color: Color.fromARGB(255, 255, 183, 13),
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        fillColor: Color.fromARGB(255, 10, 5, 70),
      ),
    );
  }
}
