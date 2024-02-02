import 'package:flutter_tasklist_app/data/model/add_task_request_model.dart';
import 'package:flutter_tasklist_app/data/model/add_task_response_model.dart';
import 'package:flutter_tasklist_app/data/model/task_response_model.dart';
import 'package:http/http.dart' as http;

class TaskRemoteDataSource {
  Future<TaskResponseModel> getTask() async {
    final response = await http.get(
      Uri.parse('https://fic9.flutterdev.my.id/api/tasks'),
    );

    if (response.statusCode == 200) {
      return TaskResponseModel.fromRawJson(response.body);
    } else {
      throw Exception('Failed to load task');
    }
  }

  Future<AddTaskResponseModel> addTask(AddTaskRequestModel data) async {
    final response = await http.post(
      Uri.parse('https://fic9.flutterdev.my.id/api/tasks'),
      body: data.toRawJson(),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return AddTaskResponseModel.fromRawJson(response.body);
    } else {
      throw Exception('Failed to add task');
    }
  }

  Future<AddTaskResponseModel> deleteTask(int id) async {
    final response = await http.delete(
      Uri.parse('https://fic9.flutterdev.my.id/api/tasks/$id'),
    );
    if (response.statusCode == 200) {
      return AddTaskResponseModel.fromRawJson(response.body);
    } else {
      throw Exception('Failed to delete task');
    }
  }

  Future<AddTaskResponseModel> updateTask(
      int id, AddTaskRequestModel data) async {
    final response = await http.put(
      Uri.parse('https://fic9.flutterdev.my.id/api/tasks/$id'),
      body: data.toRawJson(),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return AddTaskResponseModel.fromRawJson(response.body);
    } else {
      throw Exception('Failed to updatetask');
    }
  }
}
