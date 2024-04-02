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
