import 'package:adv_task_manager/features/tasks/data/datasources/task_local_datasource.dart';
import 'package:adv_task_manager/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:adv_task_manager/features/tasks/data/models/task/task_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

enum TaskFilter { all, completed, pending }

final taskFilterProvider = StateProvider<TaskFilter>((ref) => TaskFilter.all);
// Dio Provider
final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

//for testing
final localDatasourceProvider = Provider<TaskLocalDatasource>((ref) {
  final box = Hive.box<TaskModel>('tasksBox');
  return TaskLocalDatasource(box);
});

// RemoteDatasource Provider
final taskRemoteDatasourceProvider = Provider<TaskRemoteDatasource>((ref) {
  final dio = ref.watch(dioProvider);
  return TaskRemoteDatasource(dio: dio);
});

// LocalDatasource Provider
final taskLocalDatasourceProvider = Provider<TaskLocalDatasource>((ref) {
  final box = Hive.box<TaskModel>('tasksBox');
  return TaskLocalDatasource(box);
});

// Tasks StateNotifier
final tasksProvider =
    StateNotifierProvider<TasksNotifier, AsyncValue<List<TaskModel>>>(
      (ref) => TasksNotifier(
        remoteDatasource: ref.watch(taskRemoteDatasourceProvider),
        localDatasource: ref.watch(taskLocalDatasourceProvider),
      ),
    );

class TasksNotifier extends StateNotifier<AsyncValue<List<TaskModel>>> {
  final TaskRemoteDatasource remoteDatasource;
  final TaskLocalDatasource localDatasource;

  TasksNotifier({required this.remoteDatasource, required this.localDatasource})
    : super(const AsyncLoading()) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    try {
      final localTasks = await localDatasource.getTasks();
      if (localTasks.isNotEmpty) {
        state = AsyncData(localTasks);
      }

      final remoteTasks = await remoteDatasource.fetchTasks();
      await localDatasource.saveTasks(remoteTasks);
      state = AsyncData(remoteTasks);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> toggleTaskCompleted(TaskModel task) async {
    final updatedTask = task.copyWith(completed: !task.completed);
    await localDatasource.updateTask(updatedTask);

    final updatedTasks = await localDatasource.getTasks();
    state = AsyncData(updatedTasks);
  }

  Future<void> updateTask(TaskModel updatedTask) async {
    await localDatasource.updateTask(updatedTask);
    final updatedTasks = await localDatasource.getTasks();
    state = AsyncData(updatedTasks);
  }

  Future<void> addTask(TaskModel task) async {
    await localDatasource.addTask(task);
    final updatedTasks = await localDatasource.getTasks();
    state = AsyncData(updatedTasks);
  }

  Future<void> deleteTask(int id) async {
    await localDatasource.deleteTask(id);
    final updatedTasks = await localDatasource.getTasks();
    state = AsyncData(updatedTasks);
  }
}
