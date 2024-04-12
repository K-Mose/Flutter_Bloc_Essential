import 'package:bloc_overview/d_bloc_access/a_bloc_access/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocAccess extends StatelessWidget {
  const BlocAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Bloc Context"),
        ),
        body: Builder(
          // Builder위젯은 새로운 BuildContext를 생성해서 해당 context는 build의 하위 context가 된다.
          builder: (context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${BlocProvider.of<CounterCubit>(context, listen: true).state.counter}",
                    style: const TextStyle(fontSize: 44),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).increment();
                    },
                    child: const Text(
                      "Increment",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}


class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${BlocProvider.of<CounterCubit>(context, listen: true).state.counter}",
            style: const TextStyle(fontSize: 44),
          ),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<CounterCubit>(context).increment();
            },
            child: const Text(
              "Increment",
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}