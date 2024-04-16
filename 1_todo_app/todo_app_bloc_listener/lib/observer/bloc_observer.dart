import 'package:flutter_bloc/flutter_bloc.dart';

class CounterObserver extends BlocObserver {

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    print("CounterObserver:: OnError::: ${bloc.runtimeType} \n ::: $error\n\n $stackTrace");
  }

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    print("CounterObserver:: OnTransition::: ${bloc.runtimeType} \n ::: $transition");
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    print("CounterObserver:: OnChange::: ${bloc.runtimeType} \n ::: $change");
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    print("CounterObserver:: OnEvent::: ${bloc.runtimeType} \n ::: $event");
  }
}