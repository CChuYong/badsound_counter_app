import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/view/feature/update_notification_config/update_notification_config.dart';

class UpdateNotificationConfigState {

}

class UpdateNotificationConfigAction extends BaseAction<UpdateNotificationConfig, UpdateNotificationConfigAction, UpdateNotificationConfigState> {
  UpdateNotificationConfigAction() : super(UpdateNotificationConfigState());

  @override
  Future<UpdateNotificationConfigState> initState() async => UpdateNotificationConfigState();

}
