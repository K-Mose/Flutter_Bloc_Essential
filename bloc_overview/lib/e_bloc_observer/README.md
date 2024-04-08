# Bloc Observer
`BlocObserver`를 통해서 상태 변화를 한 곳에서 관리할 수 있다.

## Cubit에서 상태 변화 
![cubit](https://raw.githubusercontent.com/felangel/bloc/master/assets/diagrams//cubit_flow.png)
1. Cubit 내부의 함수 호출
2. 함수 호출에 emit이 즉각적으로 반응하여 상태를 업데이트
3. 상태 변화 직전에 onChange 호출, 현재 상태와 다음 상태를 가지고있음 
4. 변경된 상태를 보냄

## Blo에서 상태 변화
![](https://raw.githubusercontent.com/felangel/bloc/master/assets/diagrams/bloc_flow.png)
1. Event가 add됨 
2. add 되면서 `onEvent`가 즉각 호출
3. `EventTransformer`에서 Event Stream을 다루는데 사용됨 
4. `EventTransformer`를 거친 `Event`는 `EvnetHandler`에서 처리, Emit를 호출해 새로운 상태를 내보냄
5. 실제 상태 변화가 발생하기 전에 `bloc`의 `Transition` 이벤트가 발생하고 `onTransition`이 호출됨
6. Transition은 현재 상태, 상태 변화를 일으킨 Event, 다음 상태를 갖는다 

## Bloc/Cubit Event Loop
![](/../screenshot/bloc_cubit_event.png)
1. Cubit/Bloc이 생성될 때 Crate 이벤트 발생 
2. Event 발생 시 onEvent 호출, Transition 이벤트 발생 시 onTransition 호출
3. onTransition 호출 되면 Change가 발생하여 onChange 호출
4. Cubit/Bloc이 필요 없어지면 Close 이벤트 발생 
Event ~ Change 까지 반복적으로 실행됨 

Bloc에서는 Transition을 통해서 상태 변화를 촉발시킨 이벤트에 대한 정보를 얻을 수 있음 -> 상태 변화를 추적 가능 
Cubit은 상태 변화가 되고 있다는 것을 알 수 있지만, 원인은 알 수 없음  
상태 변화의 결과는 같지만 원인이 다를 때 유용함 

`addError`로 에러 처리 가능 

Cubit/Bloc에 포함된 `onEvent` / `onTransition` / `onChange`를 Observer에서 사용 가능하다.
`BlocObserver` 사용 시 이점은 `Bloc`타입의 아규먼트가 추가되어 추적 가능하다.