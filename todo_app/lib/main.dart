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
              todoListCubit: BlocProvider.of<TodoListCubit>(context)
            ),),
        BlocProvider<FilteredTodosCubit>(
            create: (context) => FilteredTodosCubit(
              todoFilterCubit: BlocProvider.of<TodoFilterCubit>(context),
              todoSearchCubit: BlocProvider.of<TodoSearchCubit>(context),
              todoListCubit: BlocProvider.of<TodoListCubit>(context)
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