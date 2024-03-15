import 'package:flutter/material.dart';
import '../models/objective.dart';

class ObjectiveEditor extends StatefulWidget {
  final Objective? objective;
  final Function(Objective objective) onSave;

  const ObjectiveEditor({Key? key, this.objective, required this.onSave})
      : super(key: key);

  @override
  _ObjectiveEditorState createState() => _ObjectiveEditorState();
}

class _ObjectiveEditorState extends State<ObjectiveEditor> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  String _status = 'Active'; // Default status

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.objective?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.objective?.description ?? '');
    _status = widget.objective?.status ?? 'Active';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveObjective() {
    if (_formKey.currentState!.validate()) {
      final objective = Objective(
        id: widget.objective?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        status: _status,
        actions: widget.objective?.actions ?? [],
      );
      widget.onSave(objective);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.objective == null ? 'Add Objective' : 'Edit Objective'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveObjective,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: ['Active', 'Closed'].map((String value) {
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
