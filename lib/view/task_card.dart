import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                task.description,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      );
}
