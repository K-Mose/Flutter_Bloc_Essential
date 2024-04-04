import 'package:bloc_overview/c_bloc_to_bloc/bloc/color/color_bloc.dart';
import 'package:bloc_overview/c_bloc_to_bloc/bloc/counter/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocToBlocScreen extends StatelessWidget {
  const BlocToBlocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 2개 이상의 cubit/bloc을 사용할 때
    return MultiBlocProvider(
      providers: [
        BlocProvider<ColorBloc>(
          create: (context) => ColorBloc(),
        ),
        BlocProvider<CounterBloc>(
          create: (context) => CounterBloc(
            colorBloc: context.read<ColorBloc>()
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: context.watch<ColorBloc>().state.color,
            appBar: AppBar(
              title: const Text("Bloc2Bloc"),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<ColorBloc>().add(ChangeColorEvent());
                    },
                    child: const Text("Change Color")
                  ),
                  Text(
                    '${context.watch<CounterBloc>().state.count}',
                    style: const TextStyle(
                      fontSize: 52.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CounterBloc>().add(ChangeCounterEvent());
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