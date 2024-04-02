import 'package:bloc_overview/a_counter/bloc/counter_bloc.dart';
import 'package:bloc_overview/a_counter/counter_bloc_screen.dart';
import 'package:bloc_overview/a_counter/counter_cubit_screen.dart';
import 'package:bloc_overview/a_counter/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              child: const Text("#1 Counter App"),
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
              child: const Text("#1 Counter App"),
            ),
          ],
        ),
      ),
    );
  }
}