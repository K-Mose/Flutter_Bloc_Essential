import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubits/active_todo_count/active_todo_count_cubit.dart';
import 'package:todo_app/pages/todos_page/create_todo.dart';
import 'package:todo_app/pages/todos_page/search_and_filter_todo.dart';
import 'package:todo_app/pages/todos_page/show_todos.dart';
import 'package:todo_app/pages/todos_page/todo_header.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 40),
              child: Column(
                children: [
                  const TodoHeader(),
                  const CreateTodo(),
                  const SizedBox(height: 20.0,),
                  const SearchAndFilterTodo(),
                  const ShowTodos(),
                ],
              ),
            ),
          )
      ),
    );
  }
}