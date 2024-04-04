# Cubit/Bloc to Cubit/Bloc

## State Stream 사용
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

## BlocListener 사용
State의 변화를 감지하여 액션을 수행하는 리스너에서 상태 변화를 감지하면 다른 Cubit/Bloc의 function/event를 트리거한다. 
(Cubit 함수를 호출하거나 Bloc의 이벤트 호출은 비즈니스 로직과는 무관)
BlocListener로 기능을 트리거 하기때문에 cubit/bloc 내에서 의존성이 떨어진다.  

- cubit + StreamSubscription
- cubit + BlocListener
- bloc + StreamSubscription
- bloc + BlocListener
같이 처리할 state가 많지 않을 때는 BlocListener로, state가 많으면 StreamSubscription을 사용하는 것을 추천
> **StreamSubscription** : construct body에 의존하는 state를 stream을 사용해서 listen
> **BlocListener** : 1개의 state를 listen해서 다른 state를 업데이트 