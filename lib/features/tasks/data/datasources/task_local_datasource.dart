import 'package:adv_task_manager/features/tasks/data/models/task/task_model.dart';
import 'package:hive/hive.dart';

class TaskLocalDatasource {
  final Box<TaskModel> tasksBox;

  TaskLocalDatasource(this.tasksBox);

  Future<List<TaskModel>> getTasks() async {
    return tasksBox.values.toList();
  }

  Future<void> saveTasks(List<TaskModel> tasks) async {
    await tasksBox.clear();
    for (var task in tasks) {
      await tasksBox.put(task.id, task);
    }
  }

  Future<void> updateTask(TaskModel task) async {
    await tasksBox.put(task.id, task);
  }

  Future<void> addTask(TaskModel task) async {
    await tasksBox.put(task.id, task);
  }

  Future<void> deleteTask(int id) async {
    await tasksBox.delete(id);
  }
}
