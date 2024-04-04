import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bloc_overview/d_bloc_access/c_named_route/cubit/counter_cubit.dart';

class ShowCounter extends StatelessWidget {
  static const routeName = '/show-counter';
  const ShowCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter"),
      ),
      body: Center(
        child: BlocBuilder<NamedCounterCubit, CounterState>(
          builder: (context, state) {
            return Text(
              "${state.counter}",
              style: const TextStyle(fontSize: 48.0),
            );
          },
        ),
      ),
    );
  }
}