import 'package:adv_task_manager/features/tasks/UI/providers/task_providers.dart';
import 'package:adv_task_manager/features/tasks/data/models/task/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskDetailPage extends ConsumerStatefulWidget {
  final TaskModel task;

  const TaskDetailPage({super.key, required this.task});

  @override
  ConsumerState<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends ConsumerState<TaskDetailPage> {
  late TextEditingController titleController;
  late TextEditingController commentController;
  late bool completed;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    commentController = TextEditingController(text: widget.task.comment);
    completed = widget.task.completed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: commentController,
              decoration: const InputDecoration(labelText: 'Comment'),
            ),
            SwitchListTile(
              value: completed,
              onChanged: (value) {
                setState(() {
                  completed = value;
                });
              },
              title: const Text('Completed'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedTask = widget.task.copyWith(
                  title: titleController.text,
                  comment: commentController.text,
                  completed: completed,
                );
                ref.read(tasksProvider.notifier).updateTask(updatedTask);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
