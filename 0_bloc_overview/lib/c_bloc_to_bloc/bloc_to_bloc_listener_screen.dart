import 'package:bloc_overview/c_bloc_to_bloc/bloc/color/color_bloc.dart';
import 'package:bloc_overview/c_bloc_to_bloc/bloc/counter/counter_bloc.dart';
import 'package:bloc_overview/c_bloc_to_bloc/bloc/counter/counter_bloc2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocToBlocScreen extends StatefulWidget {
  const BlocToBlocScreen({super.key});

  @override
  State<BlocToBlocScreen> createState() => _BlocToBlocScreenState();
}

class _BlocToBlocScreenState extends State<BlocToBlocScreen> {
  int incrementSize = 1;
  @override
  Widget build(BuildContext context) {
    // 2개 이상의 cubit/bloc을 사용할 때
    return MultiBlocProvider(
      providers: [
        BlocProvider<ColorBloc>(
          create: (context) => ColorBloc(),
        ),
        BlocProvider<CounterBloc2>(
          create: (context) => CounterBloc2(),
        ),
      ],
      child: BlocListener<ColorBloc, ColorState>(
        listener: (context, colorState) {
          if (colorState.color == Colors.red) {
            incrementSize = 1;
          } else if (colorState.color == Colors.green) {
            incrementSize = 10;
          } else if (colorState.color == Colors.blue) {
            incrementSize = 100;
          } else if (colorState.color == Colors.black) {
            incrementSize = -100;
            context
                .read<CounterBloc2>()
                .add(ChangeCounterEvent2(incrementSize: incrementSize));
          }
        },
        child: Scaffold(
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
                      context
                          .read<CounterBloc2>()
                          .add(ChangeCounterEvent2(incrementSize: incrementSize));
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