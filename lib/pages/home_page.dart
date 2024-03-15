import 'package:flutter/material.dart';
import '../models/action.dart';
import '../models/objective.dart';
import '../services/objective_service.dart';
import '../widgets/action_card.dart';
import '../widgets/objective_card.dart';
import 'action_editor.dart';
import 'objective_editor.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ObjectiveService _objectiveService = ObjectiveService();
  // final ActionService _actionService = ActionService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Objective List'),
      ),
      body: _buildObjectiveList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewObjective(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildObjectiveList() {
    List<Objective> objectives = _objectiveService.getObjectives();
    double screenWidth = MediaQuery.of(context).size.width - 32;
    double cardWidth = screenWidth / 3; // Calculate the width for each card

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: objectives.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              if (index == 0) // Only add headers before the first item
                const Padding(
                  padding: EdgeInsets.only(
                      bottom: 8.0), // Space between headers and list
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: Text("Objective",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20))),
                      Expanded(
                          child: Text("Next Action",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20))),
                      Expanded(
                          child: Text("Done Action",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20))),
                    ],
                  ),
                ),
              Container(
                margin: const EdgeInsets.only(
                    bottom: 12.0), // Add space between rows
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Color of the border
                    width: 1.0, // Width of the border
                  ),
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ObjectiveCard(
                      objective: objectives[index],
                      width: cardWidth, // Pass the calculated width
                      onEdit: () => _editObjective(objectives[index]),
                      onDelete: () => _deleteObjective(objectives[index].id),
                      onPriorityIncrease: () =>
                          _increasePriority(objectives[index].id),
                      onPriorityDecrease: () =>
                          _decreasePriority(objectives[index].id),
                      onAddAction: () => _addNewAction(objectives[index].id),
                    ),

                    // Add a list of next actions for this objective
                    Column(
                      children: _buildActionsList(
                          objectives[index].id,
                          cardWidth,
                          "Next"), // Adjusted to include width and status parameter
                    ),

                    // Done actions
                    Column(
                      children: _buildActionsList(
                          objectives[index].id,
                          cardWidth,
                          "Done"), // Adjusted to include width and status parameter
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _addNewObjective() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ObjectiveEditor(
          onSave: (objective) {
            setState(() {
              _objectiveService.addObjective(objective);
            });
          },
        ),
      ),
    );
  }

  void _editObjective(Objective objective) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ObjectiveEditor(
          objective: objective,
          onSave: (updatedObjective) {
            setState(() {
              _objectiveService.updateObjective(objective.id, updatedObjective);
            });
          },
        ),
      ),
    );
  }

  void _deleteObjective(String id) {
    setState(() {
      _objectiveService.deleteObjective(id);
    });
  }

  void _increasePriority(String objectiveId) {
    setState(() {
      _objectiveService.increasePriority(objectiveId);
    });
  }

  void _decreasePriority(String objectiveId) {
    setState(() {
      _objectiveService.decreasePriority(objectiveId);
    });
  }

  void _addNewAction(String objectiveId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ActionEditor(
          onSave: (ActionItem newAction) {
            setState(() {
              _objectiveService.addActionToObjective(objectiveId, newAction);
            });
          },
        ),
      ),
    );
  }

  _editAction(String objectiveId, ActionItem action) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ActionEditor(
          action: action,
          onSave: (updatedAction) {
            setState(() {
              _objectiveService.editAction(
                objectiveId,
                action.id,
                updatedAction,
              );
            });
          },
        ),
      ),
    );
  }

  List<Widget> _buildActionsList(
      String objectiveId, double width, String status) {
    List<ActionItem> actions =
        _objectiveService.getActionsForObjectiveByStatus(objectiveId, status);
    // if no actions, return sizedbox of width
    if (actions.isEmpty) {
      return [SizedBox(width: width)];
    }
    return actions
        .map((action) => ActionCard(
              action: action,
              width: width, // Pass the calculated width
              onMarkDone: () => setState(() {
                _objectiveService.markActionDone(
                  objectiveId,
                  action.id,
                );
              }),
              onEdit: () => _editAction(objectiveId, action),
            ))
        .toList();
  }
}
