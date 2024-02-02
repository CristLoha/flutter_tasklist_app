import 'package:flutter/material.dart';
import 'package:flutter_tasklist_app/data/datasources/task_remote_datasource.dart';
import 'package:flutter_tasklist_app/data/model/add_task_request_model.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final titleC = TextEditingController();
  final descC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 2,
        title: const Text(
          'Add Task',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          TextField(
            controller: titleC,
            decoration: InputDecoration(
              hintText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TextField(
            controller: descC,
            decoration: InputDecoration(
              hintText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () async {
              final model = AddTaskRequestModel(
                data: Data(title: titleC.text, description: descC.text),
              );
              final response = await TaskRemoteDataSource().addTask(model);
              Navigator.pop(context);
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
