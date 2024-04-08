import 'package:bloc_overview/e_bloc_observer/bloc/color/color_bloc.dart';
import 'package:bloc_overview/e_bloc_observer/bloc/counter/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocObserverScreen extends StatelessWidget {
  const BlocObserverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 2개 이상의 cubit/bloc을 사용할 때
    return MultiBlocProvider(
      providers: [
        BlocProvider<ObserverColorBloc>(
          create: (context) => ObserverColorBloc(),
        ),
        BlocProvider<ObserverCounterBloc>(
          create: (context) => ObserverCounterBloc(
              colorBloc: context.read<ObserverColorBloc>()
          ),
        ),
      ],
      child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: context.watch<ObserverColorBloc>().state.color,
              appBar: AppBar(
                title: const Text("Bloc2Bloc"),
              ),
              body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            context.read<ObserverColorBloc>().add(ColorChangeEvent());
                          },
                          child: const Text("Change Color")
                      ),
                      Text(
                        '${context.watch<ObserverCounterBloc>().state.counter}',
                        style: const TextStyle(
                            fontSize: 52.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            context.read<ObserverCounterBloc>().add(CounterIncrementPressedEvent());
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