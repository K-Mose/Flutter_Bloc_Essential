import 'package:bloc_overview/a_counter/cubit/counter_cubit.dart';
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
      body: Center(
        child: Text(
          // .of 메소드는 listen이 false임. true를 주면 상태값 업데이트
          "${BlocProvider.of<CounterCubit>(context, listen: true).state}",
          style: const TextStyle(fontSize: 52.0),
        ),
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