import 'package:bloc_overview/a_counter/bloc/counter_bloc.dart';
import 'package:bloc_overview/a_counter/counter_bloc_screen.dart';
import 'package:bloc_overview/a_counter/counter_cubit_screen.dart';
import 'package:bloc_overview/a_counter/cubit/counter_cubit.dart';
import 'package:bloc_overview/b_theme/app_theme.dart';
import 'package:bloc_overview/b_theme/cubit/theme_cubit.dart';
import 'package:bloc_overview/b_theme/theme_setting_screen.dart';
import 'package:bloc_overview/c_bloc_to_bloc/bloc_to_bloc_screen.dart';
import 'package:bloc_overview/c_cubit_to_cubit/cubit_to_cubit_bloc_listener_screen.dart';
import 'package:bloc_overview/c_cubit_to_cubit/cubit_to_cubit_screen.dart';
import 'package:bloc_overview/d_bloc_access/a_bloc_access/bloc_access.dart';
import 'package:bloc_overview/d_bloc_access/b_anonymous_route_access/bloc_anonymous.dart';
import 'package:bloc_overview/d_bloc_access/b_anonymous_route_access/cubit/counter_cubit.dart' as AnonymousCubit;
import 'package:bloc_overview/d_bloc_access/c_named_route/cubit/counter_cubit.dart';
import 'package:bloc_overview/d_bloc_access/c_named_route/bloc_named.dart';
import 'package:bloc_overview/d_bloc_access/c_named_route/show_counter.dart';
import 'package:bloc_overview/d_bloc_access/d_generated_route/bloc_generated.dart';
import 'package:bloc_overview/e_bloc_observer/bloc_observer_screen.dart';
import 'package:bloc_overview/e_bloc_observer/observer/app_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // Observer 등록
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Named Route에서 route를 지정할 때 context에 bloc을 넘겨주기 위해 사용
  // 전역적으로 동일한 cubit/bloc을 전달할 수 있음
  final NamedCounterCubit namedCubit = NamedCounterCubit();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Bloc
    // return BlocProvider<ThemeBloc>(
    //   create: (context) => ThemeBloc(),
    // MaterialApp을 BlocProvider로 감싸 전역적으로 접근 가능하게 한다. (Cubit/Bloc Gobal Access)
    return BlocProvider<ThemeCubit>(
      create: (context) => ThemeCubit(),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: context.watch<ThemeCubit>().state.appTheme == AppTheme.light
                ? ThemeData.light()
                : ThemeData.dark(),
            // home: const MainScreen(),
            initialRoute: "/",
            routes: {
              '/': (context) => const MainScreen(),
              // volue constructor로 cubit 넘겨줌
              BlocNamed.routeName: (context) => BlocProvider.value(
                value: namedCubit,
                child: const BlocNamed()
              ),
              ShowCounter.routeName: (context) => BlocProvider.value(
                  value: namedCubit,
                  child: const ShowCounter(),
              ),
              BlocGenerated.routeName: (context) => BlocProvider.value(
                  value: namedCubit,
                  child: const BlocGenerated()
              ),
            },
            // Generated Route에서도 value constructor를 사용해서 하위 위젯에 cubit/bloc을 전달한다.
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

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return BlocProvider<CounterCubit>(
                          create: (context) => CounterCubit(),
                          child: const CounterCubitScreen(),
                        );
                      },)
                  );
                },
                child: const Text("#1 Counter App - Cubit"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        // 하위 위젯에서 CounterBloc을 사용할 수 있게 의존성 주입
                        return BlocProvider<CounterBloc>(
                          create: (context) => CounterBloc(),
                          child: const CounterBlocScreen(),
                        );
                      },)
                  );
                },
                child: const Text("#1 Counter App - Bloc"),
              ),
              const SizedBox(height: 12,),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        // 하위 위젯에서 CounterBloc을 사용할 수 있게 의존성 주입
                        return const ThemeSettingScreen();
                      },)
                  );
                },
                child: const Text("#2 Theme App - Bloc Event Payload"),
              ),
              const SizedBox(height: 12,),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        // 하위 위젯에서 CounterBloc을 사용할 수 있게 의존성 주입
                        return const CubitToCubitScreen();
                      },)
                  );
                },
                child: const Text("#3 Cubit to Cubit - MultiBlocProvider"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        // 하위 위젯에서 CounterBloc을 사용할 수 있게 의존성 주입
                        return const CubitToCubitBlocListenerScreen();
                      },)
                  );
                },
                child: const Text("#3 Cubit to Cubit - BlocListener"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        // 하위 위젯에서 CounterBloc을 사용할 수 있게 의존성 주입
                        return const BlocToBlocScreen();
                      },)
                  );
                },
                child: const Text("#3 Bloc to Bloc"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        // 하위 위젯에서 CounterBloc을 사용할 수 있게 의존성 주입
                        return const BlocAccess();
                      },)
                  );
                },
                child: const Text("#4 Bloc Access"),
              ),
              const SizedBox(height: 12,),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        // 하위 위젯에서 CounterBloc을 사용할 수 있게 의존성 주입
                        return BlocProvider<AnonymousCubit.CounterCubit>(
                          create: (context) => AnonymousCubit.CounterCubit(),
                          child: const BlocAnonymous(),
                        );
                      },)
                  );
                },
                child: const Text("#4 Bloc Access - Anonymous"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    BlocNamed.routeName
                  );
                },
                child: const Text("#4 Bloc Access - Named"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    BlocNamed.routeName
                  );
                },
                child: const Text("#4 Bloc Access - Generated"),
              ),
              const SizedBox(height: 12,),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return const BlocObserverScreen();
                    },)
                  );
                },
                child: const Text("#5 Bloc Observer"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}