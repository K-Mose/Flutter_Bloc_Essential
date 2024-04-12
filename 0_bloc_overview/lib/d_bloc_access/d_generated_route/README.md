### Generated Route 
`onGenerateRoute`를 통해서 라우팅에 cubit/bloc을 제공한다.

([NamedRoute](../c_named_route/README.md)와 비슷하게 작동) 
```dart
class _MyAppState extends State<MyApp> {
  final NamedCounterCubit namedCubit = NamedCounterCubit();
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (context) => ThemeCubit(),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData.light(),
            initialRoute: "/",
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case BlocNamed.routeName:
                  return MaterialPageRoute(builder: (context) => BlocProvider.value(
                    value: namedCubit,
                    child: const BlocNamed(),));
                case BlocGenerated.routeName :
                  return MaterialPageRoute(builder: (context) => BlocProvider.value(
                      value: namedCubit,
                      child: const BlocGenerated()
                  ),);
                case ShowCounter.routeName:
                  return MaterialPageRoute(builder: (context) => BlocProvider.value(
                      value: namedCubit,
                      child: const ShowCounter()
                  ),);
                default:
                  return null;

              }
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    namedCubit.close();
    super.dispose();
  }
}
```

`MaterialApp`을 `BlocProvider/MultiBlocPorvider`로 감싸면 제공하는 cubit/bloc을 전역적으로 사용할 수 있으나 
해당 상태를 필요로 하지 않는 화면에서는 리소스 낭비가 된다. 그러므로 한 두개의 화면에서 사용되는 상태가 아닌, 전역적으로 사용이 필요한 사용자의 상태 같은 것들을 사용한다.  