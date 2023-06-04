import 'package:badsound_counter_app/core/framework/base_intent.dart';

class ViewIntent extends Intent {
  ViewIntent._();

  factory ViewIntent.initial() = InitialState;
  factory ViewIntent.loading() = LoadingState;
}

class InitialState extends ViewIntent {
  InitialState(): super._();
}


class LoadingState extends ViewIntent {
  LoadingState(): super._();
}
