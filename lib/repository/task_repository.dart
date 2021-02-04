import 'package:firebase_database/firebase_database.dart';
import 'package:tasks_app/models/task.dart';
import 'package:tasks_app/network/api_provider.dart';

class TaskRepository {
  ApiProvider _apiProvider = ApiProvider();
  DatabaseReference _userTasksDbRef;

  TaskRepository() {
    _userTasksDbRef = getUserTasksDbRef();
  }

  DatabaseReference get userTasksDbRef => _userTasksDbRef;

  DatabaseReference getUserTasksDbRef() {
    final dbRef = _apiProvider.dbRef;
    final user = _apiProvider.user;

    return dbRef.child('tasks').child(user.uid);
  }

  Future<List<Task>> getTasks() async {
    final data = await _userTasksDbRef.once();
    final values = data.value as Map<dynamic, dynamic>;
    final tasks = List<Task>();

    values.forEach((key, value) {
      try {
        final task = Task.fromJson(Map<String, dynamic>.from(value));
        tasks.add(task);
      } catch (e) {
        print(e);
      }
    });

    return tasks;
  }

  Future<void> addTask(Task task) {
    final ref = _userTasksDbRef.push();
    return ref.set(task.toJson());
  }
}
