import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/models/task.dart';

typedef TaskAdded = void Function(Task task);

class TaskAdder extends StatelessWidget {
  final TaskAdded onTaskAdded;

  TaskAdder({Key key, this.onTaskAdded}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _descController = TextEditingController();

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
                      final task = new Task(description: _descController.text);

                      _descController.clear();

                      onTaskAdded(task);
                    }
                  },
                  child: Text('Add')),
            ],
          ),
        ),
      ),
    );
  }

  void dispose() {
    _descController.dispose();
  }
}
