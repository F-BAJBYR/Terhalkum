import 'package:flutter/material.dart';
import 'localAndWebObjectsView.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home View'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LocalAndWebObjectsView()),
            );
          },
          child: const Text('Go to AR View'),
        ),
      ),
    );
  }
}
