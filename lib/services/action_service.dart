import 'package:uuid/uuid.dart';
import '../models/action.dart';

class ActionService {
  final List<ActionItem> _actions = [];
  final Uuid _uuid = const Uuid();

  // Get all actions
  List<ActionItem> getActions() {
    return _actions;
  }

  // Add a new action
  void addAction(String description, String committed) {
    final newAction = ActionItem(
      id: _uuid.v4(),
      description: description,
      committed: committed,
      status: 'Next', // Assuming 'Next' is the initial status
      createdDate: DateTime.now(),
    );
    _actions.add(newAction);
  }

  // Update an existing action
  void updateAction(String id, String description, String committed,
      String status, DateTime? doneDate) {
    final index = _actions.indexWhere((action) => action.id == id);
    if (index != -1) {
      _actions[index].description = description;
      _actions[index].committed = committed;
      _actions[index].updateStatus(status);
      if (doneDate != null) {
        _actions[index].setDoneDate(doneDate);
      }
    }
  }

  // Delete an action
  void deleteAction(String id) {
    _actions.removeWhere((action) => action.id == id);
  }

  // Move an action to a different status
  void moveAction(String id, String newStatus) {
    final index = _actions.indexWhere((action) => action.id == id);
    if (index != -1) {
      _actions[index].updateStatus(newStatus);
      if (newStatus == 'Done') {
        _actions[index].setDoneDate(DateTime.now());
      }
    }
  }
}
