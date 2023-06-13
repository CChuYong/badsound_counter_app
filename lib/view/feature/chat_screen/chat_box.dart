import 'package:badsound_counter_app/core/api/model/chat_response.dart';
import 'package:badsound_counter_app/core/model/chat.dart';
import 'package:badsound_counter_app/core/util/date_parser.dart';
import 'package:badsound_counter_app/view/designsystem/theme/base_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBox extends StatelessWidget {
  final Chat chat;
  ChatBox(this.chat, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
      children: [
        Container(
          width: 44.sp,
          height: 44.sp,
          decoration: const BoxDecoration(
            color: BaseColor.defaultGreen,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 10.sp),
        Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
            chat.senderNickname,
            style: TextStyle(
              color: BaseColor.warmGray500,
              fontSize: 12.sp,
              fontWeight: FontWeight.w800,
            )
        ),
       SizedBox(width: 3.sp),
       Text(
           DateParser.lastMessageFormat(chat.createdAtTs),
           style: TextStyle(
             color: BaseColor.warmGray500,
             fontSize: 10.sp,
             fontWeight: FontWeight.w500,
           )),
      ],
    ),
       Text(chat.content,
           style: TextStyle(
             color: BaseColor.warmGray500,
             fontSize: 14.sp,
             fontWeight: FontWeight.w700,
           )
       )]
    )]
    ),
          Text(
              '+13,000 원',
              style: TextStyle(
                color: BaseColor.defaultGreen,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ))
        ]));
  }

}
