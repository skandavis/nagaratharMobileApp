import 'package:flutter/material.dart';

class descriptionBox extends StatefulWidget {
  bool ellipsis;
  String description;
  descriptionBox(
      {super.key, required this.ellipsis, required this.description});

  @override
  State<descriptionBox> createState() => _descriptionBoxState();
}

class _descriptionBoxState extends State<descriptionBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.description,
          maxLines: widget.ellipsis ? 5 : 100,
          style: TextStyle(
            
            fontSize: 18,
            color: Colors.white,
            overflow:
                widget.ellipsis ? TextOverflow.ellipsis : TextOverflow.visible,
            decoration: TextDecoration.none,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              widget.ellipsis = !widget.ellipsis;
            });
          },
          child: Text(
            widget.ellipsis ? "Read More" : "Show Less",
            style: const TextStyle(
              color: Color.fromARGB(255, 116, 102, 222),
            ),
          ),
        )
      ],
    );
  }
}
