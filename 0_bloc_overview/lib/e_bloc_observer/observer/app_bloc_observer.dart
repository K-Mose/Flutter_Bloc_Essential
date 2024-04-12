import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    print("onError :: ${bloc.runtimeType}: $error, $stackTrace}");
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    print("onTransition :: ${bloc.runtimeType}: $transition}");
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    print("onChange :: ${bloc.runtimeType}: $change}");
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    print("onEvent :: ${bloc.runtimeType}: $event}");
  }
}