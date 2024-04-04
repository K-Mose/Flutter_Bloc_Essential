import 'package:bloc_overview/d_bloc_access/b_anonymous_route_access/cubit/counter_cubit.dart';
import 'package:bloc_overview/d_bloc_access/b_anonymous_route_access/show_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocAnonymous extends StatelessWidget {
  const BlocAnonymous({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) {
                    // return const ShowCounter();
                    // value named constructor로 변경하여 하위 위젯으로 넣음
                    return BlocProvider.value(
                      value: context.read<CounterCubit>(),
                      child: const ShowCounter(),
                    );
                  },)
                );
              },
              child: const Text(
                "Show Me Counter",
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 22,),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<CounterCubit>(context).increment();
              },
              child: const Text(
                "Increment Counter",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}