import 'package:bloc_overview/c_cubit_to_cubit/cubits/color/color_cubit.dart';
import 'package:bloc_overview/c_cubit_to_cubit/cubits/counter/counter_cubit2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 화면상의 상태가 변경되기 때문에 StatefulWidget으로 변경
class CubitToCubitBlocListenerScreen extends StatefulWidget {
  const CubitToCubitBlocListenerScreen({super.key});

  @override
  State<CubitToCubitBlocListenerScreen> createState() => _CubitToCubitBlocListenerScreenState();
}

class _CubitToCubitBlocListenerScreenState extends State<CubitToCubitBlocListenerScreen> {
  int incrementSize = 1;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ColorCubit>(
          create: (context) => ColorCubit(),
        ),
        BlocProvider<CounterCubit2>(
          create: (context) => CounterCubit2(),
        ),
      ],
      // ColorState를 리스닝하여 값을 변경
      child: BlocListener<ColorCubit, ColorState>(
        listener: (context, state) {
          if (state.color == Colors.red) {
            incrementSize = 1;
          } else if (state.color == Colors.green) {
            incrementSize = 10;
          } else if (state.color == Colors.blue) {
            incrementSize = 100;
          } else if (state.color == Colors.black) {
            incrementSize = -100;
          }
        },
        child: Scaffold(
            backgroundColor: context.watch<ColorCubit>().state.color,
            appBar: AppBar(
              title: const Text("cubit2cubit"),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<ColorCubit>().changeColor();
                    },
                    child: const Text("Change Color")
                  ),
                  Text(
                    '${context.watch<CounterCubit2>().state.count}',
                    style: const TextStyle(
                      fontSize: 52.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CounterCubit2>().changeCounter(incrementSize);
                    },
                    child: const Text("Increment Counter")
                  ),
                ],
              )
            ),
        ),
      ),
    );
  }
}