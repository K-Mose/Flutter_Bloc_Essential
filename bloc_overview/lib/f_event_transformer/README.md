# Event Transformer 
스트림은 또다른 스트림으로 변환 될 수 있음, 
예를 들어 모든 스트림 값에 2를 곱한다던지, 홀수 값만 남긴다던지 등 

Event Transformation 
- concurrent / sequential / restartable / droppable 처럼 들어오는 이벤트를 저리하는 것
- 처리하는 함수를 Event Transformer 라고 함 

*Event Transformation*을 사용하기 위해서는 `bloc_concurrency`를 사용해야 함
```
dart pub add bloc_concurrency
```

### [Event Transformer](https://pub.dev/packages/bloc_concurrency)
![](https://raw.githubusercontent.com/felangel/bloc/master/assets/diagrams/bloc_concurrency.png)
- `concurrent` : 이벤트를 동시에 처리
- `sequential` : 이벤트를 순차적으로 처리
- `droppadble` : 이벤트가 실행 중에 추가되는 이벤트는 무시하면서 처리
- `restartable` : 새 이벤트가 들어오면 이전 이벤트는 취소시키고 새 이벤트를 처리

**두 이벤트 핸들러에서 transformer가 작동 되지 않는 이유**
```dart
// 이벤트를 각각 계속 실행시켜도 서로의 이벤트 간에서는  restartable이 잘 작동하지 않는다
class TransformerCounterBloc extends Bloc<CounterEvent, CounterState> {
  TransformerCounterBloc() : super(CounterState.initail()) {
    on<CounterIncrementPressed>((event, emit) async {
      await Future.delayed(const Duration(seconds: 4));
      emit(state.copyWith(counter: state.counter + 1));
    }, transformer: restartable());

    on<CounterDecrementPressed>((event, emit) async {
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(counter: state.counter - 1));
    }, transformer: restartable());
  }
}
```
이벤트 핸들러는 자기 자신의 이벤트 버킷을 갖음. 그래서 자기 버킷 내에서만 순차적으로 실행
-> 같은 transformer의 효과를 주기 위해서 하나의 이벤트 핸들러로 묶음

```dart
  TransformerCounterBloc() : super(CounterState.initail()) {
    // 모든 이벤트를 동시에 처리하는 핸들러
    // 두 이벤트의 상위 클래스를 타입으로 지정, 받는 이벤트의 타입에 따라서 해당하는 이벤트를 실행
    on<CounterEvent>(
      (event, emit) async {
        if (event is CounterIncrementPressed) {
          await _handleIncrementCounterEvent(event, emit);
        } else if (event is CounterDecrementPressed) {
          await _handleDecrementCounterEvent(event, emit);
        }
      },
      transformer: restartable()
    );
  }
```