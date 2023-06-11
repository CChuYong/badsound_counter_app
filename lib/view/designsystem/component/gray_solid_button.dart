import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/base_color.dart';

class GraySolidButton extends StatefulWidget {
  final String text;
  final void Function()? onTap;

  const GraySolidButton(this.text, {super.key, this.onTap});

  @override
  State createState() => _GraySolidButtonState();
}

class _GraySolidButtonState extends State<GraySolidButton> {
  late bool isDown;

  @override
  void initState() {
    super.initState();
    setState(() => isDown = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (_) => setState(() => isDown = true),
        onTapUp: (_) => setState(() => isDown = false),
        onTapCancel: () => setState(() => isDown = false),
        onTap: widget.onTap,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.sp),
              color: isDown ? BaseColor.warmGray300 : BaseColor.warmGray100,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: 8.sp, bottom: 8.sp, left: 30.sp, right: 30.sp),
              child: Center(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: BaseColor.warmGray400,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )));
  }
}
