### BlocContext
BlocProvider에서 context를 사용할 때 Provider에서 생성한 Cubit/Bloc을 같은 context 내에서 사용할 수 없고 하위 context에서 사용 가능하다. 
```dart
@override
Widget build(BuildContext context) {
  return BlocProvider<CounterCubit>(
    create: (context) => CounterCubit(),
    child: Scaffold(
      appBar: AppBar(),
      body: Center(
        // 여기서 사용 시
        // The following assertion was thrown building BlocAccess(dirty):
        //   BlocProvider.of() called with a context that does not contain a CounterCubit.
        // 위 에러가 발생한다.
        child: Text(
          "${BlocProvider.of<CounterCubit>(context, listen: true).state.counter}",
          style: const TextStyle(fontSize: 44),
        ),
      ),
    ),
  );
} 
```
BlocProvider에 전달된 context는 build함수에서 생성된 context이고
그 context를 타고 올라가도 해당하는 타입의 cubit/bloc이 없기 때문에 에러가 발생한다.
(chlid에서 사용하는 context와 BlocProvider가 받는 context가 동
*해결책*
1. child 위젯을 별도의 위젯으로 생성
2. Build 위젯 사용