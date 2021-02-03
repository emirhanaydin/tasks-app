import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/profile_page.dart';

final _dbRef = FirebaseDatabase.instance.reference().child('tasks');
final _auth = FirebaseAuth.instance;

class TasksPage extends StatefulWidget {
  @override
  State createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  User _user;
  DatabaseReference _dbUserRef;

  _TasksPageState() {
    _user = _auth.currentUser;
    _dbUserRef = _dbRef.child(_user.uid);
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
                _profileButton(),
              ],
            ),
            Expanded(child: Text('List placeholder')),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _addTaskButton(),
              ],
            )
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

  Widget _addTaskButton() => IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          final ref = _dbUserRef.push();
          ref.set('${Random().nextInt(1000)}');
        },
      );
}
