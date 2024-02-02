import 'package:flutter/material.dart';
import 'package:flutter_tasklist_app/data/datasources/task_remote_datasource.dart';
import 'package:flutter_tasklist_app/data/model/add_task_request_model.dart';

import 'package:flutter_tasklist_app/data/model/task_response_model.dart';
import 'package:flutter_tasklist_app/pages/home_page.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;
  const EditTaskPage({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final titleC = TextEditingController();
  final descC = TextEditingController();

  @override
  void initState() {
    titleC.text = widget.task.attributes.title;
    descC.text = widget.task.attributes.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 2,
        title: const Text(
          'Edit Task',
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
              final newModel = AddTaskRequestModel(
                data: Data(title: titleC.text, description: descC.text),
              );
              await TaskRemoteDataSource().updateTask(widget.task.id, newModel);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const HomePage();
                  },
                ),
              );
            },
            child: Text('Edit'),
          ),
        ],
      ),
    );
  }
}
