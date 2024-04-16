import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/blocs.dart';
import 'package:todo_app/observer/bloc_observer.dart';
import 'package:todo_app/pages/todo_page.dart';

void main() {
  runApp(const MyApp());
  Bloc.observer = CounterObserver();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoFilterBloc>(
            create: (context) => TodoFilterBloc(),),
        BlocProvider<TodoSearchBloc>(
            create: (context) => TodoSearchBloc(),),
        BlocProvider<TodoListBloc>(
            create: (context) => TodoListBloc(),),
        BlocProvider<ActiveTodoCountBloc>(
            create: (context) => ActiveTodoCountBloc(
              // 초기값 설정을 위해 constructor에 값을 넘겨서 초기화 시킴
              initialActiveTodoCount: context.read<TodoListBloc>().state.todos.length,
              todoListBloc: BlocProvider.of<TodoListBloc>(context)
            ),
        ),
        BlocProvider<FilteredTodosBloc>(
            create: (context) => FilteredTodosBloc(
              initialTodos: context.read<TodoListBloc>().state.todos,
              todoFilterBloc: BlocProvider.of<TodoFilterBloc>(context),
              todoSearchBloc: BlocProvider.of<TodoSearchBloc>(context),
              todoListBloc: BlocProvider.of<TodoListBloc>(context)
            ),),
      ],
      child: MaterialApp(
        title: 'Bloc Todo',
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TodoPage()// const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return const TodoPage();
                  },)
                );
              },
              child: const Text("Bloc-StreamSubscription"),
            ),
          ],
        ),
      )
    );
  }
}