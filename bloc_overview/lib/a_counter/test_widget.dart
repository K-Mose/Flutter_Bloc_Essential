import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  const TestWidget(this.number, {super.key});

  final int number;
  @override
  Widget build(BuildContext context) {
    print("#$number TEST WIDGET IS JUST CREATED!!");
    return Text("#$number TEST");
  }
}