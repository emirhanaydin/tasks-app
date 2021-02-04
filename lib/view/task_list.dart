import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/bloc/task_collection_bloc.dart';
import 'package:tasks_app/models/task_collection.dart';
import 'package:tasks_app/network/response.dart';
import 'package:tasks_app/view/error.dart';
import 'package:tasks_app/view/loading.dart';
import 'package:tasks_app/view/task_card.dart';

class TaskList extends StatelessWidget {
  final TaskCollectionBloc taskCollectionBloc;

  TaskList({this.taskCollectionBloc});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => taskCollectionBloc.fetchTasks(),
      child: StreamBuilder<Response<TaskCollection>>(
        stream: taskCollectionBloc.taskListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case ResponseStatus.LOADING:
                return Loading(
                  loadingMessage: snapshot.data.message,
                );
                break;
              case ResponseStatus.COMPLETED:
                return _TaskCollectionList(snapshot.data.data);
                break;
              case ResponseStatus.ERROR:
                return Error(
                  errorMessage: snapshot.data.message,
                  onRetryPressed: () => taskCollectionBloc.fetchTasks(),
                );
                break;
              default:
                return Error(
                  errorMessage: "An error occurred while fetching tasks",
                  onRetryPressed: () => taskCollectionBloc.fetchTasks(),
                );
            }
          }

          return Container();
        },
      ),
    );
  }
}

class _TaskCollectionList extends StatelessWidget {
  final TaskCollection _taskCollection;

  _TaskCollectionList(this._taskCollection);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[100],
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: _taskCollection.tasks.length,
            physics: ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return TaskCard(
                task: _taskCollection.tasks[index],
              );
            }));
  }
}
