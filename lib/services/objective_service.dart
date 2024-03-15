import '../models/objective.dart';
import '../models/action.dart';

class ObjectiveService {
  // This is a mock database until you integrate with a real database
  final List<Objective> _objectives = [
    Objective(
      id: '1',
      title: 'Cursor Editor',
      description: 'Decision is made between Cursor and VScode + Copilot',
      status: 'Active',
      actions: [
        ActionItem(
          id: '1',
          description: 'Publish review video for team feedback',
          status: 'Next',
          committed: 'John',
          createdDate: DateTime(2024, 2, 22),
        ),
        ActionItem(
          id: '2',
          description: 'Build objective application using Cursor',
          status: 'Done',
          committed: 'Dora',
          createdDate: DateTime(2024, 3, 1),
          doneDate: DateTime(2024, 3, 10),
        ),
        ActionItem(
          id: '3',
          description: 'Setup Cursor install',
          status: 'Done',
          committed: 'Dora',
          createdDate: DateTime.now(),
          doneDate: DateTime(2024, 3, 9),
        ),
      ],
    ),
    Objective(
      id: '2',
      title: 'Objective 2',
      description: 'Description 2',
      status: 'Active',
      actions: [
        ActionItem(
          id: '1',
          description: 'Action Item A',
          status: 'Next',
          committed: 'John',
          createdDate: DateTime(2024, 3, 11),
        ),
      ],
    ),
    Objective(
        id: '3',
        title: 'Objective 3',
        description: 'Description 3',
        status: 'Active',
        actions: [
          ActionItem(
            id: '1',
            description: 'Action Item B',
            status: 'Next',
            committed: 'John',
            createdDate: DateTime(2024, 2, 28),
          ),
        ]),
    Objective(
        id: '4',
        title: 'Objective 4',
        description: 'Description 4',
        status: 'Active',
        actions: [
          ActionItem(
            id: '1',
            description: 'Action Item C',
            status: 'Next',
            committed: 'John',
            createdDate: DateTime(2024, 3, 8),
          ),
        ]),
  ];

  // Get all objectives
  List<Objective> getObjectives() {
    return _objectives;
  }

  // Get Next status actions for a given objective
  List<ActionItem> getNextActionsForObjective(String objectiveId) {
    final Objective? objective =
        _objectives.firstWhere((obj) => obj.id == objectiveId);
    if (objective != null) {
      return objective.getNextActions();
    }
    return [];
  }

  List<ActionItem> getDoneActionsForObjective(String objectiveId) {
    final Objective? objective =
        _objectives.firstWhere((obj) => obj.id == objectiveId);
    if (objective != null) {
      return objective.getDoneActions();
    }
    return [];
  }

  // Add a new objective
  void addObjective(Objective objective) {
    _objectives.add(objective);
  }

  // Update an existing objective
  void updateObjective(String id, Objective updatedObjective) {
    final index = _objectives.indexWhere((objective) => objective.id == id);
    if (index != -1) {
      _objectives[index] = updatedObjective;
    }
  }

  // Delete an objective
  void deleteObjective(String id) {
    _objectives.removeWhere((objective) => objective.id == id);
  }

  // Add an action to an objective

  // increasePriority by swapping given objective (by id) with the one above it
  void increasePriority(String objectiveId) {
    final Objective? objective =
        _objectives.firstWhere((obj) => obj.id == objectiveId);
    if (objective != null) {
      final index = _objectives.indexWhere((obj) => obj.id == objectiveId);
      if (index > 0) {
        final temp = _objectives[index - 1];
        _objectives[index - 1] = _objectives[index];
        _objectives[index] = temp;
      }
    }
  }

  // decreasePriority by swapping given objective (by id) with the one below it
  void decreasePriority(String objectiveId) {
    final Objective? objective =
        _objectives.firstWhere((obj) => obj.id == objectiveId);
    if (objective != null) {
      final index = _objectives.indexWhere((obj) => obj.id == objectiveId);
      if (index < _objectives.length - 1) {
        final temp = _objectives[index + 1];
        _objectives[index + 1] = _objectives[index];
        _objectives[index] = temp;
      }
    }
  }

  // Change the status of an objective
  void changeObjectiveStatus(String objectiveId, String newStatus) {
    final Objective? objective =
        _objectives.firstWhere((obj) => obj.id == objectiveId);
    if (objective != null) {
      objective.updateStatus(newStatus);
    }
  }

  void addActionToObjective(String objectiveId, ActionItem action) {
    final Objective? objective =
        _objectives.firstWhere((obj) => obj.id == objectiveId);
    if (objective != null) {
      objective.addAction(action);
    }
  }

  void editAction(
      String objectiveId, String actionId, ActionItem updatedAction) {
    final Objective? objective =
        _objectives.firstWhere((obj) => obj.id == objectiveId);
    if (objective != null) {
      final actionIndex = objective.actions.indexWhere((a) => a.id == actionId);
      if (actionIndex != -1) {
        objective.actions[actionIndex] = updatedAction;
      }
    }
  }

  // Update an action in an objective
  void markActionDone(
    String objectiveId,
    String actionId,
  ) {
    final Objective? objective =
        _objectives.firstWhere((obj) => obj.id == objectiveId);
    if (objective != null) {
      final actionIndex =
          objective.actions.indexWhere((action) => action.id == actionId);
      if (actionIndex != -1) {
        objective.actions[actionIndex].status = 'Done';
        objective.actions[actionIndex].doneDate = DateTime.now();
      }
    }
  }

  // Delete an action from an objective
  void deleteActionFromObjective(String objectiveId, String actionId) {
    final Objective? objective =
        _objectives.firstWhere((obj) => obj.id == objectiveId);
    if (objective != null) {
      objective.removeAction(actionId);
    }
  }

  List<ActionItem> getActionsForObjectiveByStatus(
      String objectiveId, String status) {
    var objective = _objectives.firstWhere(
      (obj) => obj.id == objectiveId,
    );
    return objective.actions
        .where((action) => action.status == status)
        .toList();
  }
}
