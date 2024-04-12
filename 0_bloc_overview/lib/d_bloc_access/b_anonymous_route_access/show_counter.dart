import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_overview/d_bloc_access/b_anonymous_route_access/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';

class ShowCounter extends StatelessWidget {
  const ShowCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter"),
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, CounterState>(
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