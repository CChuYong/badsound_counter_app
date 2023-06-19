import 'package:flutter/material.dart';

class TitleTextBox extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;

  TitleTextBox(this.title, {this.hint = '', this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
            ))
      ],
    );
  }
}
