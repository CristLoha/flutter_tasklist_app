import 'package:flutter/material.dart';
import 'package:flutter_tasklist_app/data/datasources/task_remote_datasource.dart';
import 'package:flutter_tasklist_app/pages/add_task_page.dart';
import 'package:flutter_tasklist_app/pages/detail_task_page.dart';
import '../data/model/task_response_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoaded = false;

  List<Task> task = [];
  Future<void> getTask() async {
    setState(() {
      isLoaded = true;
    });
    final model = await TaskRemoteDataSource().getTask();
    task = model.data;

    setState(() {
      isLoaded = false;
    });
  }

  @override
  void initState() {
    getTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 2,
        title: const Text(
          'Task List',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoaded
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: task.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DetailTaskPage(
                            task: task[index],
                          );
                        },
                      ),
                    );
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(task[index].attributes.title),
                      subtitle: Text(task[index].attributes.description),
                      trailing: const Icon(Icons.check_circle),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddTaskPage();
              },
            ),
          );
          getTask();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
