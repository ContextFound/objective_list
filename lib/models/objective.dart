import 'action.dart';

class Objective {
  String id;
  String title;
  String description;
  String status; // Consider using an enum for status values (Active, Closed)
  List<ActionItem> actions;

  Objective({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.actions,
  });

  // Method to add an action to the objective
  void addAction(ActionItem action) {
    actions.add(action);
  }

  // Method to remove an action from the objective
  void removeAction(String actionId) {
    actions.removeWhere((action) => action.id == actionId);
  }

  // Method to update the status of the objective
  void updateStatus(String newStatus) {
    status = newStatus;
  }

  List<ActionItem> getNextActions() {
    return actions.where((action) => action.status == 'Next').toList();
  }

  List<ActionItem> getDoneActions() {
    return actions.where((action) => action.status == 'Done').toList();
  }

  // Convert an Objective instance to a Map. Useful for serialization.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'actions': actions.map((action) => action.toMap()).toList(),
    };
  }

  // Create an Objective instance from a Map. Useful for deserialization.
  factory Objective.fromMap(Map<String, dynamic> map) {
    return Objective(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      status: map['status'],
      actions: List<ActionItem>.from(
          map['actions']?.map((x) => ActionItem.fromMap(x))),
    );
  }
}
