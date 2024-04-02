import 'package:bloc_overview/a_counter/cubit/counter_cubit.dart';
import 'package:bloc_overview/a_counter/other_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubitScreen extends StatelessWidget {
  const CounterCubitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter - Cubit"),
      ),
      // Buiulder Function은 pure function이여야 한다.
      // 화면이동이나 다이얼로그 등의 행동은 blocbuilder 내에서 수행되면 안됨
      body: BlocConsumer<CounterCubit, CounterState>(
        listener: (context, state) {
          if (state.counter == 3) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text("counter is ${state.counter}"),
                );
              },
            );
          }
          if (state.counter == -1) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const OtherPage();
            },));
          }
        },
        builder: (context, state) {
          return Center(
            child: Text(
              "${state.counter}",
              style: const TextStyle(fontSize: 52.0),
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'increment',
            onPressed: () {
              BlocProvider.of<CounterCubit>(context).increment();
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 16,),
          FloatingActionButton(
            heroTag: 'decrement',
            onPressed: () {
              BlocProvider.of<CounterCubit>(context).decrement();
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}