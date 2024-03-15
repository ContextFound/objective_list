import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/action.dart';

class ActionEditor extends StatefulWidget {
  final ActionItem? action;
  final Function(ActionItem) onSave;

  const ActionEditor({Key? key, this.action, required this.onSave})
      : super(key: key);

  @override
  _ActionEditorState createState() => _ActionEditorState();
}

class _ActionEditorState extends State<ActionEditor> {
  final _formKey = GlobalKey<FormState>();
  late String _description;
  late String _committed;
  late String _status;
  late DateTime _createdDate;
  DateTime? _doneDate;

  @override
  void initState() {
    super.initState();
    if (widget.action != null) {
      _description = widget.action!.description;
      _committed = widget.action!.committed;
      _status = widget.action!.status;
      _createdDate = widget.action!.createdDate;
      _doneDate = widget.action!.doneDate;
    } else {
      _description = '';
      _committed = '';
      _status = 'Next';
      _createdDate = DateTime.now();
      _doneDate = null;
    }
  }

  void _saveAction() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final action = ActionItem(
        id: widget.action?.id ?? DateTime.now().toIso8601String(),
        description: _description,
        committed: _committed,
        status: _status,
        createdDate: _createdDate,
        doneDate: _doneDate,
      );
      widget.onSave(action);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.action == null ? 'Add Action' : 'Edit Action'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveAction,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              TextFormField(
                initialValue: _committed,
                decoration: const InputDecoration(labelText: 'Committed by'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _committed = value!;
                },
              ),
              DropdownButtonFormField(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: ['Next', 'Done'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _status = newValue!;
                  });
                },
                onSaved: (value) {
                  _status = value.toString();
                },
              ),
              if (_status == 'Done')
                TextFormField(
                  initialValue: _doneDate != null
                      ? DateFormat('yyyy-MM-dd').format(_doneDate!)
                      : '',
                  decoration: const InputDecoration(labelText: 'Done Date'),
                  onTap: () async {
                    FocusScope.of(context).requestFocus(
                        FocusNode()); // to prevent opening default keyboard
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _doneDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025),
                    );
                    if (picked != null && picked != _doneDate) {
                      setState(() {
                        _doneDate = picked;
                      });
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
