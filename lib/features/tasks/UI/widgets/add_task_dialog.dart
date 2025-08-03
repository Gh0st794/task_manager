import 'package:adv_task_manager/features/tasks/UI/providers/task_providers.dart';
import 'package:adv_task_manager/features/tasks/data/models/task/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTaskDialog extends ConsumerStatefulWidget {
  const AddTaskDialog({super.key});

  @override
  ConsumerState<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends ConsumerState<AddTaskDialog> {
  final titleController = TextEditingController();
  final commentController = TextEditingController();
  bool completed = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
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
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (titleController.text.isEmpty) return;
            final tasks = ref.read(tasksProvider).value ?? [];
            final newId = tasks.isEmpty
                ? 1
                : (tasks.map((e) => e.id).reduce((a, b) => a > b ? a : b) + 1);
            final newTask = TaskModel(
              id: newId,
              title: titleController.text,
              comment: commentController.text,
              completed: completed,
            );
            Navigator.pop(context, newTask);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
