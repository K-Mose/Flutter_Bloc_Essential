# BlocListener 를 이용한 ToDo App

1. 기존 Cubit에서 외부 Cubit을 listen하는 StreamSubscription을 제거
2. Cubit constructor에서 parameter로 받는 Cubit 제거, Constructor body 제거
3. Cubit 외부에서 상태를 업데이트 할 수 있게 상태 변화 함수 추가/수정 
4. 상태 변화를 감지하기 위한 위젯에 `BlocListener`추가
> 기존 Cubit에서 streamSubscription으로 업데이트 된 상태 관련 작업들을 Listener 내에서 업데이트 시킴

