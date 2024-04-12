import 'package:flutter/material.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter - Cubit"),
      ),
      body: const Center(
        child: Text(
          "Other",
          style: TextStyle(fontSize: 80),
        ),
      ),
    );
  }
}