# ToDo App

Bloc 이용한 ToDoApp
- Cubit + StreamSubscription 
- Cubit + BlocListener
- Bloc + StreamSubscription
- Bloc + BlocListener

### Best Practice
- State는 가급적 atomic하게 만듦
  - 논리적으로 분리할 수 있으면 별도의 state로 만들어서 관리 
- State는 주로 class 형태로 관리
  - 논리적으로 연관된 값들을 묶어서 관리
  - String, int 등 primitive type 변수도 class화 해서 관리 -> type 충돌을 피할 수 있는 장점
- Immnutable state
  - copyWith 함수를 사용해 새로운 state를 만듦
- Always extends Equatable class 
  - Object instance들의 equality check를 쉽게 할 수 있음
  - stringify 등의 편의 함수 제공

### State 종류
- Independent Stats : 독립적으로 사용되는 상태
  - todoFilter / todoSearch / todoList ..
- Computed States : 다른 상태를 의존하는 상태 (복합적으로 사용되는)
  - StreamSubscription / BlocListener 로 사용
  - activeTodo / filteredTodos ..

## BlocListener vs StreamSubscription
- **BlocListener**
  1. 서로 다른 Bloc/Cubit을 Listen(bloc-to-bloc communication)하는 동작이 화면 단위에서 일어남 (`BlocListener`의 listen) 
     Business Logic의 분리가 안됨 
  2. 최상위 `BlocProvider`에서 Bloc/Cubit 간 의존성 주입(DI. Dependency Injection)이 필요 없음

- **StreamSubscription** 
  1. Bloc/Cubit 내부에서 다른 Bloc/Cubit을 Listen함 (bloc.stream.listen)
  2. 최상위 `BlocProvider`에서 Bloc/Cubit 간 의존성 주입이 필요함
  3. 