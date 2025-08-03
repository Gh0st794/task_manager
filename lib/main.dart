import 'package:adv_task_manager/core/constants/constants.dart';
import 'package:adv_task_manager/features/countries/UI/pages/countries_page.dart';
import 'package:adv_task_manager/features/tasks/UI/pages/Task/tasks_page.dart';
import 'package:adv_task_manager/features/tasks/data/models/task/task_model.dart';
import 'package:adv_task_manager/features/tasks/data/models/task/task_model_adapter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

enum AppMenu { tasks, countries }

final selectedMenuProvider = StateProvider<AppMenu>((ref) => AppMenu.tasks);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('tasksBox');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Task Manager',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void _showAppInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('App Information'),
        content: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              const TextSpan(text: 'Advanced Task Manager\n\n'),
              const TextSpan(text: 'Developer: Geovanny Llanos G.\n'),
              TextSpan(
                text: 'Github: ${Constants.projectURL}\n',
                style: const TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    final url = Uri.parse(Constants.projectURL);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Could not launch URL')),
                      );
                    }
                  },
              ),
              const TextSpan(text: 'Version: 1.0.0\n\n'),
              const TextSpan(
                text:
                    'Built with Flutter, Clean Architecture, REST & GraphQL APIs.\n',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMenu = ref.watch(selectedMenuProvider);

    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 220,
            color: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                ListTile(
                  leading: const Icon(Icons.task),
                  title: const Text('Tasks'),
                  selected: selectedMenu == AppMenu.tasks,
                  selectedTileColor: Colors.blue.shade100,
                  onTap: () => ref.read(selectedMenuProvider.notifier).state =
                      AppMenu.tasks,
                ),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('Countries'),
                  selected: selectedMenu == AppMenu.countries,
                  selectedTileColor: Colors.blue.shade100,
                  onTap: () => ref.read(selectedMenuProvider.notifier).state =
                      AppMenu.countries,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () => _showAppInfoDialog(context),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: selectedMenu == AppMenu.tasks
                  ? const TasksPage(key: ValueKey('TasksPage'))
                  : const CountriesPage(key: ValueKey('CountriesPage')),
            ),
          ),
        ],
      ),
    );
  }
}
