# Bloc Event에 정보 추가하기 
Bloc Event 호출 시에 payload를 추가하기 위해서 사용

e.g. Todo 앱에서 새로운 todo를 추가하는 이벤트. 
```dart
class AddTodoEvent extends TodoEvent {
  final String desc;
  AddTodoEvent({
    required this.desc,
  });
  // ...
}
```
이벤트에서 payload를 함께 보내고싶을 때는 위 처럼 이벤트 생성자에 파라메터를 추가해서 생성하면 된다. 

Cubit에서는 function에서 매개변수로 넘겨받으면 된다.
```dart
// theme_cubit.dart 
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());

  void changeTheme(int randInt) {
    if (randInt % 2 == 0) {
      emit(state.copyWith(appTheme: AppTheme.light));
    } else {
      emit(state.copyWith(appTheme: AppTheme.dart));
    }
  }
}

// ... 
// theme_setting_cubit_screen.dart
// ...
onPressed: () {
  final randInt = Random().nextInt(10);
  context.read<ThemeCubit>().changeTheme(randInt);
},
// ...

```