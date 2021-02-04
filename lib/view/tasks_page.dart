import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/bloc/task_collection_bloc.dart';
import 'package:tasks_app/view/profile_page.dart';
import 'package:tasks_app/view/task_adder.dart';
import 'package:tasks_app/view/task_list.dart';

class TasksPage extends StatefulWidget {
  @override
  State createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  TaskCollectionBloc _taskCollectionBloc;

  @override
  void initState() {
    super.initState();
    _taskCollectionBloc = TaskCollectionBloc();
    _taskCollectionBloc.fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: _profileButton(),
                )
              ],
            ),
            Expanded(
                child: TaskList(
              taskCollectionBloc: _taskCollectionBloc,
            )),
            Row(children: [
              TaskAdder(
                onTaskAdded: (task) {
                  _taskCollectionBloc.addTask(task);
                },
              )
            ]),
          ],
        ),
      ),
    );
  }

  Widget _profileButton() => IconButton(
    icon: Icon(Icons.more_vert),
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    },
  );
}
