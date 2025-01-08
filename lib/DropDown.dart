import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  final List<String> options;
  final String label;
  final String initialValue;
  Function(String) onChanged;
  DropDown({
    super.key,
    required this.options,
    required this.label,
    required this.initialValue,
    required this.onChanged,
  });
  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  late String dropdownValue = widget.initialValue;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.label,
              style: const TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 255, 183, 13),
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButton<String>(
              value: dropdownValue,
              elevation: 16,
              dropdownColor: const Color.fromARGB(255, 5, 3, 30),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              onChanged: (String? value) {
                setState(
                  () {
                    dropdownValue = value!;
                  },
                );
                widget.onChanged(dropdownValue);
              },
              items: widget.options.map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
          ],
        ),
      ],
    );
  }
}
