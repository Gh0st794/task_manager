import 'package:adv_task_manager/features/tasks/UI/providers/task_providers.dart';
import 'package:adv_task_manager/features/tasks/data/datasources/task_local_datasource.dart';
import 'package:adv_task_manager/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:adv_task_manager/features/tasks/data/models/task/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adv_task_manager/features/tasks/UI/pages/Task/tasks_page.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskLocalDatasource extends Mock implements TaskLocalDatasource {}

class MockTaskRemoteDatasource extends Mock implements TaskRemoteDatasource {}

void main() {
  late MockTaskLocalDatasource mockLocalDatasource;
  late MockTaskRemoteDatasource mockRemoteDatasource;

  setUp(() {
    mockLocalDatasource = MockTaskLocalDatasource();
    mockRemoteDatasource = MockTaskRemoteDatasource();

    // Mock local datasource getTasks()
    when(() => mockLocalDatasource.getTasks()).thenAnswer(
      (_) async => [
        TaskModel(
          id: 11,
          title: 'UI Test Task',
          comment: 'Task for widget test',
          completed: true,
        ),
      ],
    );

    // Mock remote datasource fetchTasks()
    when(() => mockRemoteDatasource.fetchTasks()).thenAnswer(
      (_) async => [
        TaskModel(
          id: 11,
          title: 'UI Test Task',
          comment: 'Task for widget test',
          completed: true,
        ),
      ],
    );

    // Mock saveTasks to do nothing
    when(
      () => mockLocalDatasource.saveTasks(any()),
    ).thenAnswer((_) async => {});
  });

  testWidgets('Should display a task in TasksPage', (
    WidgetTester tester,
  ) async {
    // Provide a notifier that uses the mocked datasources and calls loadTasks in constructor
    final notifier = TasksNotifier(
      localDatasource: mockLocalDatasource,
      remoteDatasource: mockRemoteDatasource,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          taskLocalDatasourceProvider.overrideWithValue(mockLocalDatasource),
          taskRemoteDatasourceProvider.overrideWithValue(mockRemoteDatasource),
          tasksProvider.overrideWithProvider(
            StateNotifierProvider<TasksNotifier, AsyncValue<List<TaskModel>>>(
              (ref) => notifier,
            ),
          ),
        ],
        child: const MaterialApp(home: TasksPage()),
      ),
    );

    // Wait for UI to settle after async loadTasks calls
    await tester.pumpAndSettle();

    // Check the UI shows your mocked task title
    expect(find.text('UI Test Task'), findsOneWidget);
  });
}
