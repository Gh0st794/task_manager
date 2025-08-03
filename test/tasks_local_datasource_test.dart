import 'package:adv_task_manager/features/tasks/data/models/task/task_model_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:adv_task_manager/features/tasks/data/datasources/task_local_datasource.dart';
import 'package:adv_task_manager/features/tasks/data/models/task/task_model.dart';

void main() {
  late TaskLocalDatasource datasource;

  setUp(() async {
    await setUpTestHive();
    Hive.registerAdapter(TaskModelAdapter());
    final box = await Hive.openBox<TaskModel>('tasksBox');
    datasource = TaskLocalDatasource(box);
  });

  tearDown(() async {
    await Hive.close();
  });

  test('Should add a new task to local datasource', () async {
    final task = TaskModel(
      id: 10,
      title: 'Test Task',
      comment: '',
      completed: false,
    );
    await datasource.addTask(task);

    final tasks = await datasource.getTasks();
    expect(tasks.length, 1);
    expect(tasks.first.title, 'Test Task');
  });
}
