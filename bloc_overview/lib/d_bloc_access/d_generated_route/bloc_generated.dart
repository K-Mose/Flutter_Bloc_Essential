import 'package:bloc_overview/d_bloc_access/c_named_route/show_counter.dart';
import 'package:bloc_overview/d_bloc_access/d_generated_route/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocGenerated extends StatelessWidget {
  static const routeName = 'generated-route';
  const BlocGenerated({Key? key}) : super(key: key);

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
                Navigator.pushNamed(
                    context,
                    ShowCounter.routeName
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
                BlocProvider.of<GeneratedCounterCubit>(context).increment();
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
