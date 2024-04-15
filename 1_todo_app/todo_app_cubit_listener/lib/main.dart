import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubits/cubits.dart';
import 'package:todo_app/pages/todo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoFilterCubit>(
            create: (context) => TodoFilterCubit(),),
        BlocProvider<TodoSearchCubit>(
            create: (context) => TodoSearchCubit(),),
        BlocProvider<TodoListCubit>(
            create: (context) => TodoListCubit(),),
        BlocProvider<ActiveTodoCountCubit>(
            create: (context) => ActiveTodoCountCubit(
              // 초기값 설정을 위해 constructor에 값을 넘겨서 초기화 시킴
              initialActiveTodoCount: context.read<TodoListCubit>().state.todos.length,
            ),),
        BlocProvider<FilteredTodosCubit>(
            create: (context) => FilteredTodosCubit(
              initialTodos: context.read<TodoListCubit>().state.todos,
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
              child: const Text("Cubit-StreamSubscription"),
            ),
          ],
        ),
      )
    );
  }
}