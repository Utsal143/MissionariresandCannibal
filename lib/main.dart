import 'package:flutter/material.dart';

import 'state_space_tree.dart'; // Import the StateSpaceTree widget from state_space_tree.dart

void main() {
  runApp(StateSpaceTreeApp());
}

class StateSpaceTreeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StateSpaceTreeScreen(),
    );
  }
}

class StateSpaceTreeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Missionaries and Cannibals State Space Tree'),
      ),
      body: Center(
        child: StateSpaceTree(),
      ),
    );
  }
}
