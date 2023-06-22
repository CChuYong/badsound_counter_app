import 'package:badsound_counter_app/core/api/model/notification_config_response.dart';
import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/view/feature/update_notification_config/update_notification_config.dart';

class UpdateNotificationConfigState {
  bool socialAlert;
  bool badSoundAlert;
  bool nonBadSoundAlert;
  bool noticeAlert;
  UpdateNotificationConfigState(this.socialAlert, this.badSoundAlert, this.nonBadSoundAlert, this.noticeAlert);
}

class UpdateNotificationConfigAction extends BaseAction<UpdateNotificationConfig, UpdateNotificationConfigAction, UpdateNotificationConfigState> {
  UpdateNotificationConfigAction(NotificationConfigResponse config) : super(UpdateNotificationConfigState(
    config.socialAlert,
    config.badSoundAlert,
    config.nonBadSoundAlert,
    config.noticeAlert,
  ));

  @override
  Future<UpdateNotificationConfigState> initState() async => state;

  Future<bool> changeSetting(String type, bool enabled) async {
    print(type);
    print(enabled);
    return false;
  }

}
