import 'dart:async';

import 'package:tasks_app/models/task.dart';
import 'package:tasks_app/models/task_collection.dart';
import 'package:tasks_app/network/response.dart';
import 'package:tasks_app/repository/task_repository.dart';

class TaskCollectionBloc {
  TaskRepository _taskRepository;
  StreamController<Response<TaskCollection>> _taskListController;

  StreamSink<Response<TaskCollection>> get taskListSink =>
      _taskListController.sink;

  Stream<Response<TaskCollection>> get taskListStream =>
      _taskListController.stream;

  TaskCollectionBloc() {
    _taskRepository = TaskRepository();
    _taskListController = StreamController();
  }

  Future<void> fetchTasks() async {
    try {
      final tasks = await _taskRepository.getTasks();
      final taskCollection = TaskCollection(tasks: tasks);
      taskListSink.add(Response.completed(taskCollection));
    } catch (e) {
      print(e);
    }
  }

  Future<void> addTask(Task task) async {
    await _taskRepository.addTask(task);
    return fetchTasks();
  }

  dispose() {
    _taskListController?.close();
  }
}
