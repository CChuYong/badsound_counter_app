import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/view/feature/navigator_screen/calendar_screen/calendar_screen.dart';

class CalendarScreenState {}

class CalendarScreenAction extends BaseAction<CalendarPage,
    CalendarScreenAction, CalendarScreenState> {
  CalendarScreenAction() : super(CalendarScreenState());

  @override
  Future<CalendarScreenState> initState() async {
    return CalendarScreenState();
  }
}
