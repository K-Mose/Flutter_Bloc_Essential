import 'dart:math';

import 'package:bloc_overview/b_theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSettingCubitScreen extends StatelessWidget {
  const ThemeSettingCubitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event payload - cubit"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final randInt = Random().nextInt(10);
            print("randInt: $randInt");
            // cubit에서는 함수의 매개변수로 넘기면 됨
            context.read<ThemeCubit>().changeTheme(randInt);
          },
          child: const Text(
            "Change Theme",
            style: TextStyle(fontSize: 32.0),
          ),
        ),
      ),
    );
  }
}