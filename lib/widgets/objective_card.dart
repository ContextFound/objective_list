import 'package:flutter/material.dart';
import '../models/objective.dart';

class ObjectiveCard extends StatelessWidget {
  final Objective objective;
  final double width; // Add width parameter
  final Function() onEdit;
  final Function() onDelete;
  final Function() onPriorityIncrease;
  final Function() onPriorityDecrease;
  final Function() onAddAction; // Add the onAddAction callback

  const ObjectiveCard({
    Key? key,
    required this.objective,
    required this.width, // Initialize width
    required this.onEdit,
    required this.onDelete,
    required this.onPriorityIncrease,
    required this.onPriorityDecrease,
    required this.onAddAction, // Initialize onAddAction in the constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8), // Add padding
      width: width, // Use the passed width
      child: Card(
        color: Theme.of(context).cardColor,
        child: ListTile(
          title: Text(objective.title),
          subtitle: Text(objective.description),
          trailing: PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'Edit':
                  onEdit();
                  break;
                case 'Delete':
                  onDelete();
                  break;
                case 'Increase Priority':
                  onPriorityIncrease();
                  break;
                case 'Decrease Priority':
                  onPriorityDecrease();
                  break;
                case 'Add Action':
                  onAddAction(); // Use the onAddAction callback here
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return {
                'Edit',
                'Delete',
                'Increase Priority',
                'Decrease Priority',
                'Add Action' // Add 'Add Action' option
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}
