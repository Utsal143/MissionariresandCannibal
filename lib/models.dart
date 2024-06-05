class Action {
  final int missionaries;
  final int cannibals;

  Action(this.missionaries, this.cannibals);
}

enum NodeState { Unprocessed, Processed, Killed, Goal }

class TreeNode {
  NodeState state;
  final List<TreeNode> children;

  TreeNode(this.state, this.children);
}

class MissionariesAndCannibals {
  final int missionaries;
  final int cannibals;
  final bool boatOnLeft;

  MissionariesAndCannibals(
    this.missionaries,
    this.cannibals,
    this.boatOnLeft,
  );

  bool isValidState() {
    if (missionaries < 0 || cannibals < 0) {
      return false;
    }
    if (missionaries > 3 || cannibals > 3) {
      return false;
    }
    if (missionaries > 0 && missionaries < cannibals) {
      return false;
    }
    if (missionaries < 3 && missionaries > cannibals) {
      return false;
    }
    return true;
  }

  MissionariesAndCannibals applyAction(Action action) {
    int newMissionaries =
        missionaries + (boatOnLeft ? -1 : 1) * action.missionaries;
    int newCannibals = cannibals + (boatOnLeft ? -1 : 1) * action.cannibals;
    bool newBoatOnLeft = !boatOnLeft;

    MissionariesAndCannibals newState =
        MissionariesAndCannibals(newMissionaries, newCannibals, newBoatOnLeft);

    return newState;
  }
}
