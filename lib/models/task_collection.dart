import 'package:tasks_app/models/task.dart';

class TaskCollection {
  final List<Task> tasks;

  TaskCollection({this.tasks});

  factory TaskCollection.fromJson(List<dynamic> json) {
    final tasks = List<Task>();

    json.forEach((element) {
      final task = Task.fromJson(Map<String, dynamic>.from(element));
      tasks.add(task);
    });

    return TaskCollection(tasks: tasks);
  }
}
