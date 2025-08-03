import 'package:adv_task_manager/features/tasks/UI/providers/task_providers.dart';
import 'package:adv_task_manager/features/tasks/UI/widgets/add_task_dialog.dart';
import 'package:adv_task_manager/features/tasks/data/models/task/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'task_detail_page.dart';

class TasksPage extends ConsumerWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(tasksProvider);
    final filter = ref.watch(taskFilterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: tasksAsync.when(
        data: (tasks) {
          List<TaskModel> filteredTasks = tasks.where((task) {
            if (filter == TaskFilter.all) return true;
            if (filter == TaskFilter.completed) return task.completed;
            return !task.completed;
          }).toList();

          return Column(
            children: [
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilterChip(
                    label: const Text('All'),
                    selected: filter == TaskFilter.all,
                    onSelected: (_) =>
                        ref.read(taskFilterProvider.notifier).state =
                            TaskFilter.all,
                  ),
                  FilterChip(
                    label: const Text('Completed'),
                    selected: filter == TaskFilter.completed,
                    onSelected: (_) =>
                        ref.read(taskFilterProvider.notifier).state =
                            TaskFilter.completed,
                  ),
                  FilterChip(
                    label: const Text('Pending'),
                    selected: filter == TaskFilter.pending,
                    onSelected: (_) =>
                        ref.read(taskFilterProvider.notifier).state =
                            TaskFilter.pending,
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = filteredTasks[index];

                    return Dismissible(
                      key: Key(task.id.toString()),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      secondaryBackground: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      direction: DismissDirection.horizontal,
                      confirmDismiss: (_) async {
                        return await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete Task'),
                            content: const Text(
                              'Are you sure you want to delete this task?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );
                      },
                      onDismissed: (_) {
                        ref.read(tasksProvider.notifier).deleteTask(task.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Task "${task.title}" deleted'),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(task.title),
                        subtitle: task.comment.isNotEmpty
                            ? Text(task.comment)
                            : null,
                        trailing: Icon(
                          task.completed
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          color: task.completed ? Colors.green : Colors.grey,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskDetailPage(task: task),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<TaskModel>(
            context: context,
            builder: (context) => const AddTaskDialog(),
          );

          if (result != null) {
            ref.read(tasksProvider.notifier).addTask(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
