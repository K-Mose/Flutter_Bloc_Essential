# [Hydrated Bloc](https://pub.dev/packages/hydrated_bloc)
hydrated bloc - flutter bloc의 상태를 persist/restore하는 패키지의 확장 패키지
앱을 hot-restart, rebooting 등의 재실행 할 시에 state가 유지되지 않음 
-> state를 계속 유지시키기 위해 사용

remote storage 보다 local storage로 사용하기 위해서 사용, 저장소로는 [Hive](https://pub.dev/packages/hive)를 사용하는데 SQLFlite, SharedPreferences 보다 속도가 빠름

### `hydrate_bloc` 패키지 추가
```
flutter pub add hydrate_bloc
```

### Main 함수에 HydratedBloc Storage 추가
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  HydratedBloc.storage = await HydratedStorage.build(
    // 사용하고자 하는 디렉터리 지정
    // storageDirectory: await getTemporaryDirectory(), // 임시 저장소, 안전하지 않음
      storageDireectory: await getApplicationDocumentsDirectory()
  );
  
}
```

### Bloc with HydratedMixin
`HydratedMixin`을 사용할 수 있게 `fromJson/toJson`을 override 한다
```dart
class MyBloc with HydratedMixin {
  MyBloc() : super(MyState.initial()) {
    hydrate();
    // ...
  }
  
  // ...

  @override
  MyState? fromJson(Map<String, dynamic> json) {
    final myState = MyState.fromJson(json);
    return myState;
  }

  @override
  Map<String, dynamic>? toJson(MyState state) {
    final myJson = state.toJson();
    return myJson;
  }
}
```

### fromJson/toJson in State 
`State`안에 `fromJson/toJson`을 정의하여 상태가 직렬화가 쉽게 되게 한다. 
```dart
class MyState extends Equatable {
  final int counter;
  const MyState(this.counter);
  // ...

  Map<String, dynamic> toJson() {
    return {
      'counter': counter
    };
  }
  
  factory MyState.fromJson(Map<String, dynamic> json) {
    return MyState(json['counter']);
  }
  
}
```

### Hydrated 초기화
`HydratedBloc`의 `clear`함수를 호출하여 저장소를 초기화시킨다.
`await HydratedBloc.storage.clear();`