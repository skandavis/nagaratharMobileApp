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
    return Column(
      children: [
        SizedBox(height: 20),
        TextField(
          controller: widget.controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: widget.label,
            label: Text(
              widget.label,
              style: const TextStyle(
                  color: Color.fromARGB(255, 255, 183, 13),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
