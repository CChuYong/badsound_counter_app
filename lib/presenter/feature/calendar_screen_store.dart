import 'package:badsound_counter_app/core/framework/base_action.dart';

import '../../view/feature/navigator_screen/social_screen/social_sceren.dart';

class SocialScreenState {}

class SocialScreenAction extends BaseAction<SocialScreen,
    SocialScreenAction, SocialScreenState> {
  SocialScreenAction() : super(SocialScreenState());

  @override
  Future<SocialScreenState> initState() async {
    return SocialScreenState();
  }
}
