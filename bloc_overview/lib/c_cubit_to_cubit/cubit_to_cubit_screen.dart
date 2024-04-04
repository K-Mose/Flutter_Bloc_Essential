import 'package:bloc_overview/c_cubit_to_cubit/cubits/color/color_cubit.dart';
import 'package:bloc_overview/c_cubit_to_cubit/cubits/counter/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitToCubitScreen extends StatelessWidget {
  const CubitToCubitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 2개 이상의 cubit/bloc을 사용할 때
    return MultiBlocProvider(
      providers: [
        BlocProvider<ColorCubit>(
          create: (context) => ColorCubit(),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(
            colorCubit: context.read<ColorCubit>()
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
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
                    '${context.watch<CounterCubit>().state.count}',
                    style: const TextStyle(
                      fontSize: 52.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CounterCubit>().changeCounter();
                    },
                    child: const Text("Increment Counter")
                  ),
                ],
              )
            ),
          );
        }
      ),
    );
  }
}