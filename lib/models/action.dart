class ActionItem {
  String id;
  String description;
  String committed;
  String status; // Consider using an enum for status values (Next, Done)
  DateTime createdDate;
  DateTime? doneDate;

  ActionItem({
    required this.id,
    required this.description,
    required this.committed,
    required this.status,
    required this.createdDate,
    this.doneDate,
  });

  // Method to update the status of the action
  void updateStatus(String newStatus) {
    status = newStatus;
  }

  // Method to set the done date when action is completed
  void setDoneDate(DateTime completedDate) {
    doneDate = completedDate;
  }

  // Convert an ActionItem instance to a Map. Useful for serialization.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'committed': committed,
      'status': status,
      'createdDate': createdDate.toIso8601String(),
      'doneDate': doneDate?.toIso8601String(),
    };
  }

  // Create an ActionItem instance from a Map. Useful for deserialization.
  factory ActionItem.fromMap(Map<String, dynamic> map) {
    return ActionItem(
      id: map['id'],
      description: map['description'],
      committed: map['committed'],
      status: map['status'],
      createdDate: DateTime.parse(map['createdDate']),
      doneDate:
          map['doneDate'] != null ? DateTime.parse(map['doneDate']) : null,
    );
  }
}
