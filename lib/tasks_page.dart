
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/profile_page.dart';
import 'package:tasks_app/task_adder.dart';

class TasksPage extends StatefulWidget {
  @override
  State createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
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
                child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  height: 50,
                  color: Colors.lightBlue,
                  child: Center(
                    child: Text('Entry'),
                  ),
                );
              },
              padding: const EdgeInsets.all(8),
              itemCount: 10,
            )),
            Row(children: [
              TaskAdder(
                onTaskAdded: (task) {},
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
