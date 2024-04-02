# BLOC
Business Logic Component

### Bloc 구조
어떤 유형의 상태도 확장해서 관리할 수 있는 클래스  
Presentation(ui) <-> Business Logic(bloc) <-> Data(data)
![img.png](https://bloclibrary.dev/_astro/bloc_architecture_full.CYn-T9Ox_Z20Hwr9.webp)
event: 요청
state: 데이터
event를 입력받아 처리 후 state를 반환

UI와 bloc사이에는 2개의 communication channel이 필요함
UI와 bloc은 서로 event가 언제 발생해고 state가 언제 처리가 되는지 알 수 없어 stream으로 channel을 생성하여 항상 listen

Bloc의 작업
1. UI에서 발생한 evnet를 읽는다.
2. event를 분석 후 적절한 event handler에게 처리를 요청한다
3. event handler는 다양한 data source와 상호 작용을 통해 event를 처리한다.
4. event 처리 결과로 생긴 새로운 state를 UI에 반영한다.
간단한 작업에서 event와 event handler를 만들어 수행하는 것은 비용 측면에서 쓸모가 없음.
-> cubit을 사용해서 작업을 간소화

e.g.
```dart
/// Event
abstract class MyEvent {}
class E_1 extends MyEvent {}
// ...
class E_N extends MyEvent {}

/// Bloc
class MyBloc extends Bloc<Event, State> {
  MyBloc(State initState) : super(initState) {
    on<E_1>((event, emit) {
      emit(state + 1);
    });
    // ...
    on<E_N>(_eventHandlerN);
  }
  
  FutureOr<void> _eventHandlerN(event, emit) {
    final newState = state + 1;
    emit(newSate);
  }
}
```

### Cubit 구조
![cubit.png](https://bloclibrary.dev/_astro/cubit_architecture_full.CT5Fr9vK_ZU8vQ0.webp)
어떤 유형의 데이터도 확장해서 관리할 수 있는 클래스
state 정의 후 state를 관리하는 cubit 생성

Cubit의 작업
- *bloc의 간소화 버전*
1. state 정의
2. state 초기화
3. public function 정의
   1. 현재 상태는 state 변수를 통해 접근
   2. 새로운 상태를 계산
   3. emit 함수로 새로운 상태를 반환

 e.g.
```dart
class MyCubit extends Cubit<State> {
   MyCubit(State initState) : super(initState);

   void func1() {
      final newState = state + 1;
      emit(newState);
   }
}
```

구현 방식
1. Cubit
    - states
    - function: state를 변화시키는 함수
2. Bloc
    - states
    - events
    - event handlers: state를 변화시키는 event handler

Bloc에서 상태관리의 주체는 cubit과 bloc이므로 서로의 상태를 접근하기 위해서는 cubit, bloc간 소통이 되야함

event transformation - 이벤트를 처리하기 전에 이벤트를 앱의 특성에 맞게 변형시키는 작업
state는 기본적으로 휘발성, Persistent State는 Hydrated Bloc으로 구현

|Cubit    |Bloc  |
|:--------|:-----|
|States   |States|
|functions|Events|
| |Event Handlers|


**새 State 생성 시 기존 State 참조가 필요할 때**
Cubit과 bloc은 새로운 state를 기존 state의 stream에 dispatch 함  

### Commnunication between UI and Cubit/Bloc
**cubit/bloc**이 의미를 가지려면 UI와 연결되어 있어야함
- Create Cubit/Bloc instance 
   Injection into widget tree
  ```
  BlocProvider<T>(
    create: (context) => T(),
    child: WidgetA()  
  );
   ```   
- Cubit/Bloc은 App이 event를 발생시킬 수 있는 기능을 제공햐아 함
   - 그러기 위해 App에서는 필요한 Cubit/Bloc을 찾는 기능이 있어야 함
  ```
  BlocProvider.of<T>(context);
  context.read<T>();
  ```
- Cubit/Bloc을 찾았으면 이벤트를 trigger 시킬 수 있어야 함
  - cubit: public method
  - bloc: add method
  ```
  BlocProvider.of<T>(context).func()
  context.read<T>().func()
  BlocProvider.of<T>(context).add(Event())
  context.read<T>().add(Event())
  ```
- App은 Cubit/Bloc에서 새로운 state를 읽고 필요한 action을 해야함 
  - 그걸 위해서는 App에서 필요한 Cubit/Bloc을 찾는 기능이 있어야 함
  ```
  BlocProvider.of<T>(context, listen: true)
  context.watch<T>()
  BlocBuilder<T, S>()
  BlocListener<T, S>()
  BlocConsumer<T, S>()
  ```
- Cubit/Bloc의 state stream에서 state를 읽어와서 어떤 action을 할 것인지 결정할 수 있어야 함
  -Rebuilding UI
  ```
  BlocProvider.of<T>(context, listen: true).state
  ```
  - Doing Action (showing dialog, navigation)
  ```
  BlocListner<T, S> -> state
  ```
  - Rebuilding UI and Doing actions
  ```
  BlocConsumer<T, S> -> state
  ```
  
### UI
- Event trigger
  - Find the cubit/bloc (BlocProvider를 통해서 cubit/bloc을 획득)
  - Trigger events
    - Cubit: public method 
    - Bloc: add method  
- Deciding what to do with the new state
  - Find the cubit/bloc
  - Read the state from state stream
  - Decide what actions to take 
    - Rebuild UI
    - Do actions

### BlocProvider
UI 안에서 Cubit과 Bloc을 제공하는 위젯
Lazy loading이므로 사용 시점에서 생성이 됨 (선언 시점이 아님, lazy: false 시 선언 시 생성 ) 
BlocProvider는 ~Bloc/~Cubit을 필요로 하는 위젯 트리의 상위 위젯에서 사용,
BlocProvider.of<~Cubit/~Bloc>(context)를 사용해서 상위 context에서 상태를 얻음

### BlocBuilder 
`BlocBuilder`는 `bloc`과 `builder function`을 필요로하는 위젯이다. 
buiilder function은 pure function 이여야 하고, 필요에 따라서 flutter 내부에서 계속 호출할 수 있기 때문에 state 값에 따라 한 번만 호출하는 Navigation이나 Dialog 같은 작업들은 피해야한다.  
Bloc에서는 위 작업을 위해 `BlocListner`를 제공한다. 

### BlocListener
`BlocListener`는 Cubit/Bloc과 listener callback을 필요로하는 위젯
Listener가 Widget tree의 lookup 작업을 대신 하기 때문에 `of(context)`를 호출할 필요가 없다. 
Listener는 state에 반응하여 작성된 필요한 작업을 한 번만 수행하는 void 함수이다. 

### BlocConsumer 
`BlocConsumer`는 listener와 builder를 동시에 제공하여 빈번히 발생하는 `BlocBuilder`와 `BlocListener`의 코드를 줄여줍니다.
`BlocConsumer`에는 이전 상태(previousState)와 현재 상태(state)를 가지고 true/false를 빈환하여 반환 값에 따라서 listener를 실핼할 것인지 아닌지 결정한다. 한 위젯에서만 사용되고 `BlocProvider`와 `BuildContext`에 접근할 수 없는 cubit/bloc을 지정할 때 사용
