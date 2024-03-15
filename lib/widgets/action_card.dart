import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/action.dart';

class ActionCard extends StatelessWidget {
  final ActionItem action;
  final Function onMarkDone;
  final Function onEdit;
  final double width; // Add width parameter

  const ActionCard({
    Key? key,
    required this.action,
    required this.onMarkDone,
    required this.onEdit,
    required this.width, // Initialize width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // Use the passed width
      child: Card(
        color: Theme.of(context).cardColor, // Use the theme card color
        child: ListTile(
          title: Text(action.description),
          subtitle: Text(
            'Committed by: ${action.committed}' +
                (action.status == 'Next'
                    ? ', Created: ${DateFormat('M/dd').format(action.createdDate)}'
                    : ', Completed: ${DateFormat('M/dd').format(action.doneDate!)}'),
          ),
          leading: CircleAvatar(
            backgroundColor:
                action.status == 'Next' ? Colors.orange : Colors.green,
            child: Text(action.status == 'Next' ? 'N' : 'D'),
          ),
          trailing: Wrap(
            spacing: 12, // space between two icons
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => onEdit(),
              ),
              if (action.status == 'Next')
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () => onMarkDone(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
