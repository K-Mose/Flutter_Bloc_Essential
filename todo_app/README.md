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