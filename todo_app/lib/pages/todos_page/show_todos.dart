import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubits/cubits.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosCubit>().state.filteredTodos;
    print("todos: $todos");
    print(todos.length);
     return ListView(
       primary: false,
       shrinkWrap: true,
       children: [
         for(final todo in todos)
            Text(todo.desc, style: TextStyle(fontSize: 20.0)),
       ],
     );
  }
}
