import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_overview/f_event_transformer/bloc/counter_bloc.dart';

class EventTransformerScreen extends StatelessWidget {
  const EventTransformerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter - Bloc"),
      ),
      body: Center(
        child: BlocListener<TransformerCounterBloc, CounterState>(
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
          },
          child: Text(
            '${context.watch<TransformerCounterBloc>().state.counter}',
            style: const TextStyle(fontSize: 52.0),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'increment',
            onPressed: () {
              // event를 state의 stream에 add
              BlocProvider.of<TransformerCounterBloc>(context)
                  .add(CounterIncrementPressed());
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 16,),
          FloatingActionButton(
            heroTag: 'decrement',
            onPressed: () {
              context.read<TransformerCounterBloc>().add(CounterDecrementPressed());
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}