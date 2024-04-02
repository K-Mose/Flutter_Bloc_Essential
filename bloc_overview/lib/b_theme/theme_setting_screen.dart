import 'dart:math';

import 'package:bloc_overview/b_theme/bloc/theme_bloc.dart';
import 'package:bloc_overview/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSettingScreen extends StatelessWidget {
  const ThemeSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event payload"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final randInt = Random().nextInt(10);
            print("randInt: $randInt");
            // event에 payload를 넣어 생성자를 호춣한다.
            context.read<ThemeBloc>().add(
                ChangeThemeEvent(randInt: randInt));
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