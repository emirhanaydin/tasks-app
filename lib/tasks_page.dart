import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/profile_page.dart';

class TasksPage extends StatefulWidget {
  @override
  State createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    child: _profileButton(),
                    right: 0,
                  ),
                ],
              ),
            ),
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
