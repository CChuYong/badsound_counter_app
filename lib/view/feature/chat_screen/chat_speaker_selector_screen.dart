import 'package:badsound_counter_app/core/framework/base_view.dart';
import 'package:badsound_counter_app/presenter/feature/chat_screen/chat_speaker_selector_screen_store.dart';
import 'package:badsound_counter_app/view/component/touchableopacity.dart';
import 'package:badsound_counter_app/view/designsystem/theme/base_icon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/api/model/me_response.dart';
import '../../../presenter/feature/chat_screen/chat_screen_store.dart';
import '../../designsystem/component/base_top_bar.dart';
import '../../designsystem/theme/base_color.dart';

class ChatSpeakerSelectorScreen extends BaseView<ChatSpeakerSelectorScreen, ChatSpeakerSelectorScreenAction, ChatSpeakerSelectorScreenState>{
  final List<MeResponse> members;
  final ChatScreenAction chatScreenAction;
  ChatSpeakerSelectorScreen(this.members, this.chatScreenAction, {super.key});

  @override
  ChatSpeakerSelectorScreenAction initAction() => ChatSpeakerSelectorScreenAction(members, chatScreenAction);

  @override
  Widget render(BuildContext context, ChatSpeakerSelectorScreenAction action, ChatSpeakerSelectorScreenState state) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: BaseColor.defaultBackgroundColor,
      child: SafeArea(
          child: Scaffold(
            backgroundColor: BaseColor.defaultBackgroundColor,
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                BaseTopBar('나쁜말을 누가 했나요?'),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
                      child: RefreshIndicator(
                        onRefresh: () async => {},
                        triggerMode: RefreshIndicatorTriggerMode.onEdge,
                        child: CustomScrollView(slivers: [
                          SliverList(
                              delegate: SliverChildListDelegate(state.members
                                  .map((e) => user(e, action))
                                  .toList())),
                        ]),
                      )),
                ),
              ],
            ),
          )),
    );
  }

  Widget user(MeResponse user, ChatSpeakerSelectorScreenAction action){
    return Column(
      children: [TouchableOpacity(
        onTap: () => action.selectUser(user),
        child:
            Padding(
              padding: EdgeInsets.only(bottom: 5.sp, top: 5.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 30.sp,
                  height: 30.sp,
                  decoration: BoxDecoration(
                      color: BaseColor.warmGray400,
                      shape: BoxShape.circle,
                      image: DecorationImage(image: CachedNetworkImageProvider(user.profileImgUrl))
                  ),
                ),
                SizedBox(width: 10.sp),
                Text(user.nickname,
                    style: TextStyle(
                      color: BaseColor.warmGray500,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ))
              ],
            )
            ,
            Icon(
              BaseIcon.arrowRight,
              size: 16.sp,
              color: BaseColor.warmGray500,
            )
          ],
        ),
    )
            ,
      ),
        Divider()
    ])
      ;
  }

}
