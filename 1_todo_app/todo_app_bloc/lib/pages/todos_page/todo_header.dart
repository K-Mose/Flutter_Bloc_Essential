import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/cubits/cubits.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('TODO', style: TextStyle(fontSize: 40.0),),
        BlocBuilder<ActiveTodoCountCubit, ActiveTodoCountState>(
          builder: (context, state) {
            return Text(
              '${state.activeTodoCount} item left',
              style: TextStyle(fontSize: 20.0, color: Colors.redAccent),);
          },
        ),
        // Text(
        //   '${context.watch<ActiveTodoCountCubit>().state.activeTodoCount} item left',
        //   style: TextStyle(fontSize: 20.0, color: Colors.redAccent),),
      ],
    );
  }
}