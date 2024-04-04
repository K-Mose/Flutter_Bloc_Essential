### Named Route 
MaterialApp에서 route를 정의할 때 BlocProvider를 넘겨주기 위해서 value constructor를 이용한다. 
value constructor로 받은 값은 자식 위젯의 context에서 접근 가능하다.

```dart
class _MyAppState extends State<MyApp> {
  // 전역으로 큐빗 생성
  final NamedCounterCubit namedCubit = NamedCounterCubit();
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ...
      initialRoute: "/",
      routes: {
        '/': (context) => const MainScreen(),
        // 해당 큐빗이 필요한 경로에 value로 넘겨줌
        BlocNamed.routeName: (context) => BlocProvider.value(
            value: namedCubit,
            child: const BlocNamed()
        ),
        ShowCounter.routeName: (context) => BlocProvider.value(
          value: namedCubit,
          child: const ShowCounter(),
        ),
      },
    );
  }

  // 전역으로 생성한 큐빗/블록은 자동으로 제거되지 않으므로 수동으로 닫아준다.
  @override
  void dispose() {
    namedCubit.close();
    super.dispose();
  }
}
```