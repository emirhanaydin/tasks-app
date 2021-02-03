import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/task.dart';

final _database = FirebaseDatabase.instance;
final _auth = FirebaseAuth.instance;

typedef TaskAdded = void Function(Task task);

class TaskAdder extends StatefulWidget {
  final TaskAdded onTaskAdded;

  TaskAdder({Key key, this.onTaskAdded}) : super(key: key);

  @override
  State createState() => _TaskAdderState();
}

class _TaskAdderState extends State<TaskAdder> {
  final _formKey = GlobalKey<FormState>();
  final _descController = TextEditingController();
  DatabaseReference _dbRef;
  User _dbUser;

  _TaskAdderState() {
    _dbUser = _auth.currentUser;
    _dbRef = _database.reference().child('tasks').child(_dbUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                    controller: _descController,
                    decoration: InputDecoration(
                      labelText: 'Enter task description',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      return value.isEmpty ? 'The field is required' : null;
                    }),
              ),
              RaisedButton(
                  color: Colors.lightBlue,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      final task = new Task(_descController.text);

                      _addTask(task).then((_) {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Task added')),
                        );
                        _descController.clear();

                        widget.onTaskAdded(task);
                      }).catchError((onError) {
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text(onError)));
                      });
                    }
                  },
                  child: Text('Add')),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _descController.dispose();
  }

  Future<Task> _addTask(Task task) {
    return _dbRef.push().set(task.toJson());
  }
}
