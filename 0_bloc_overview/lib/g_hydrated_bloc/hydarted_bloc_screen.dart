import 'package:bloc_overview/g_hydrated_bloc/bloc/counter/counter_bloc.dart';
import 'package:bloc_overview/g_hydrated_bloc/bloc/theme/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class HydratedBlocScreen extends StatelessWidget {
  const HydratedBlocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hydrated - Bloc"),
      ),
      body: Center(
        child: Text(
          '${context.watch<HydratedCounterBloc>().state.counter}',
          style: const TextStyle(fontSize: 64.0),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'theme',
            onPressed: () {
              // event를 state의 stream에 add
              BlocProvider.of<HydratedThemeBloc>(context)
                  .add(ToggleThemeEvent());
            },
            child: const Icon(Icons.brightness_6),
          ),
          const SizedBox(width: 6,),
          FloatingActionButton(
            heroTag: 'increment',
            onPressed: () {
              // event를 state의 stream에 add
              BlocProvider.of<HydratedCounterBloc>(context)
                  .add(CounterIncrementPressed());
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 6,),
          FloatingActionButton(
            heroTag: 'decrement',
            onPressed: () {
              // event를 state의 stream에 add
              BlocProvider.of<HydratedCounterBloc>(context)
                  .add(CounterDecrementPressed());
            },
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 6,),
          FloatingActionButton(
            heroTag: 'storage',
            onPressed: () async {
              await HydratedBloc.storage.clear();
            },
            child: const Icon(Icons.delete_forever),
          ),
        ],
      ),
    );
  }
}
