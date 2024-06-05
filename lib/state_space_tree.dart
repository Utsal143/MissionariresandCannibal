import 'dart:collection'; // Import the queue

import 'package:flutter/material.dart';

import 'models.dart' as customModels;
import 'models.dart'; // Import the models defined in models.dart

class StateSpaceTree extends StatelessWidget {
  final TreeNode rootNode = buildStateSpaceTree();

  static TreeNode buildStateSpaceTree() {
    return generateSubtree();
  }

  static TreeNode generateSubtree() {
    Queue<customModels.MissionariesAndCannibals> queue = Queue();
    Set<customModels.MissionariesAndCannibals> visitedStates = {};
    Map<customModels.MissionariesAndCannibals, TreeNode> nodeMap = {};

    customModels.MissionariesAndCannibals initialState =
        customModels.MissionariesAndCannibals(3, 3, true);
    TreeNode root = TreeNode(NodeState.Unprocessed, []);

    queue.add(initialState);
    nodeMap[initialState] = root;

    while (queue.isNotEmpty) {
      customModels.MissionariesAndCannibals currentState = queue.removeFirst();
      TreeNode currentNode = nodeMap[currentState]!;

      visitedStates.add(currentState);

      if (currentState.missionaries == 0 &&
          currentState.cannibals == 0 &&
          !currentState.boatOnLeft) {
        currentNode.state = NodeState.Goal;
      } else {
        for (var action in generatePossibleActions()) {
          customModels.MissionariesAndCannibals newState =
              currentState.applyAction(action);
          if (newState.isValidState() && !visitedStates.contains(newState)) {
            if (!nodeMap.containsKey(newState)) {
              TreeNode newNode = TreeNode(NodeState.Unprocessed, []);
              nodeMap[newState] = newNode;
              queue.add(newState);
            }
            currentNode.children.add(nodeMap[newState]!);
          }
        }
        if (currentNode.children.isEmpty) {
          currentNode.state = NodeState.Processed;
        }
      }
    }

    return root;
  }

  static List<customModels.Action> generatePossibleActions() {
    return [
      customModels.Action(1, 0),
      customModels.Action(2, 0),
      customModels.Action(0, 1),
      customModels.Action(0, 2),
      customModels.Action(1, 1),
    ];
  }

  Widget buildNode(TreeNode node) {
    Color color;
    switch (node.state) {
      case NodeState.Processed:
        color = Colors.green;
        break;
      case NodeState.Killed:
        color = Colors.red;
        break;
      case NodeState.Goal:
        color = Colors.yellow;
        break;
      default:
        color = Colors.white;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Center(
        child: Text(
          node.state.toString().split('.').last,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget buildSubtree(TreeNode node) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildNode(node),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: node.children.map((child) => buildSubtree(child)).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: buildSubtree(rootNode),
      ),
    );
  }
}
