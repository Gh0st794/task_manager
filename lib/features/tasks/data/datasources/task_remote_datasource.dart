import 'package:adv_task_manager/core/constants/constants.dart';
import 'package:adv_task_manager/features/tasks/data/models/task/task_model.dart';
import 'package:dio/dio.dart';

class TaskRemoteDatasource {
  final Dio dio;

  TaskRemoteDatasource({required this.dio});

  Future<List<TaskModel>> fetchTasks() async {
    final response = await dio.get(Constants.tasksApi);

    final List data = response.data as List;
    return data.map((json) => TaskModel.fromJson(json)).toList();
  }
}
