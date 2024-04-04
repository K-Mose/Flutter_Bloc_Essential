# Cubit to Cubit
Cubit 간 스트림 연결

기본적으로 상태 스트림에 디스패치해서 상태값을 업데이트 함 
두 큐빗 CubitA, CubitB 간 한 state가 다른 state에 의존할 때 Stream을 사용해서 큐빗간 상태 업데이트를 관찰한다.
*B가 A를 의존할 때*
```dart
class CubitB extends Cubit<CubitBState> {
  final CubitA cubitA;
  late final StreamSubscription cubitASubscription;
  CubitB(this.cubitA) : super(initCubitBState) {
    // 의존할 큐빗에서 stream을 listen하는 StreamSubscription 생성
    cubitASubscription = cubitA.stream.listen((CubitAState cubitAState) {
      // CubitA의 상태가 변할 때 마다 listener의 콜백이 실행되므로 
      // CubitA 상태에 따른 CubitB의 작업을 정의해준다.
      if (cubitAState.value == someValue) {
        // ...
      }
    });
  }
  
  @override
  Future<void> close() {
    cubitASubscription.cancel();
    return super.close();
  }
}
```

참고: [BlocToBloc Communication](https://bloclibrary.dev/architecture/#bloc-to-bloc-communication)