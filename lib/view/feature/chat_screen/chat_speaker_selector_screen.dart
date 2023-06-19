import 'package:badsound_counter_app/core/framework/base_view.dart';
import 'package:badsound_counter_app/presenter/feature/chat_screen/chat_speaker_selector_screen_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/api/model/me_response.dart';
import '../../designsystem/component/base_top_bar.dart';
import '../../designsystem/theme/base_color.dart';

class ChatSpeakerSelectorScreen extends BaseView<ChatSpeakerSelectorScreen, ChatSpeakerSelectorScreenAction, ChatSpeakerSelectorScreenState>{
  final List<MeResponse> members;
  ChatSpeakerSelectorScreen(this.members, {super.key});

  @override
  ChatSpeakerSelectorScreenAction initAction() => ChatSpeakerSelectorScreenAction(members);

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
                        child: CustomScrollView(reverse: true, slivers: [
                          SliverList(
                              delegate: SliverChildListDelegate(state.members
                                  .map(user)
                                  .toList())),
                        ]),
                      )),
                ),
              ],
            ),
          )),
    );
  }

  Widget user(MeResponse user){
    return Row(
      children: [
        Text(user.nickname)
      ],
    );
  }

}
