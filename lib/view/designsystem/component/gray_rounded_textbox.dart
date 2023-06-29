import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/base_color.dart';

class GrayRoundedTextBox extends StatefulWidget {
  final String text;
  final TextEditingController controller;

  const GrayRoundedTextBox(this.text, {super.key, required this.controller});

  @override
  State createState() => _GreyRoundedTextBoxState();
}

class _GreyRoundedTextBoxState extends State<GrayRoundedTextBox> {
  late bool isDown;

  @override
  void initState() {
    super.initState();
    setState(() => isDown = false);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: BaseColor.warmGray300,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13.sp),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: BaseColor.warmGray500),
            borderRadius: BorderRadius.circular(13.sp),
          ),
          labelText: widget.text,
        ));
  }
}
