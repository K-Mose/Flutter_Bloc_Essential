import 'package:bloc_overview/a_counter/bloc/counter_bloc.dart';
import 'package:bloc_overview/a_counter/other_page.dart';
import 'package:bloc_overview/a_counter/test_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBlocScreen extends StatelessWidget {
  const CounterBlocScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter - Bloc"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TestWidget(1),
            BlocListener<CounterBloc, CounterState>(
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
              child: Text(
                '${context.watch<CounterBloc>().state.counter}',
                style: const TextStyle(fontSize: 52.0),
              ),
            ),
            const TestWidget(2),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'increment',
            onPressed: () {
              // event를 state의 stream에 add
              BlocProvider.of<CounterBloc>(context)
                  .add(CounterIncrementPressedEvent());
            },
            child: Icon(Icons.add),
          ),
          const SizedBox(width: 16,),
          FloatingActionButton(
            heroTag: 'decrement',
            onPressed: () {
              context.read<CounterBloc>().add(CounterDecrementPressedEvent());
            },
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}