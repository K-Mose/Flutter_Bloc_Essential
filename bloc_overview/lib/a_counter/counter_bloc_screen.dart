import 'package:flutter/material.dart';

class CounterBloc extends StatelessWidget {
  const CounterBloc({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter - Bloc"),
      ),
      body: Center(
        child: const Text(
          '0',
          style: TextStyle(fontSize: 52.0),
        ),
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            heroTag: 'increment',
            onPressed: () {

            },
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            heroTag: 'decrement',
            onPressed: () {

            },
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}