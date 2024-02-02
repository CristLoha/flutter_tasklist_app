// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_tasklist_app/data/datasources/task_remote_datasource.dart';

import 'package:flutter_tasklist_app/pages/edit_task_page.dart';
import 'package:flutter_tasklist_app/pages/home_page.dart';

import '../data/model/task_response_model.dart';

class DetailTaskPage extends StatefulWidget {
  final Task task;
  const DetailTaskPage({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<DetailTaskPage> createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends State<DetailTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 2,
        title: const Text(
          'Detail Task',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Text('Title: ${widget.task.attributes.title}'),
          const SizedBox(height: 16),
          Text('Description: ${widget.task.attributes.description}'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 40),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EditTaskPage(
                          task: widget.task,
                        );
                      },
                    ),
                  );
                },
                child: Text(
                  'Edit',
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(100, 40),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Confirmation'),
                        content: const Text(
                            'Are you sure want to delete this task?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('No'),
                          ),
                          TextButton(
                            onPressed: () async {
                              await TaskRemoteDataSource()
                                  .deleteTask(widget.task.id);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const HomePage();
                                  },
                                ),
                              );
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text(
                  'Delete',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
