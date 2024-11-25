import 'package:flutter/material.dart';

class LocalAndWebObjectsView extends StatelessWidget {
  const LocalAndWebObjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR View: Landmark Enrichment'),
      ),
      body: const Center(
        child: Text(
          'This screen will handle enrichment information from landmarks (local & web)',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
