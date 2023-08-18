class TaskEntity {
  int? id;
  String title;

  TaskEntity({this.id, required this.title});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }

  factory TaskEntity.fromMap(Map<String, dynamic> map) {
    return TaskEntity(
      id: map['id'],
      title: map['title'],
    );
  }
}
