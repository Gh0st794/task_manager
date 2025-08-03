Advanced Task Manager
A Flutter application for advanced task management, built using Clean Architecture, Riverpod for state management, and consuming both REST and GraphQL APIs.

📋 Overview
This app allows users to create, list, edit, and filter tasks with local persistence (Hive) and synchronization from remote REST and GraphQL APIs. The project follows Clean Architecture principles to ensure a clean separation of concerns and maintainability.


🚀 Features
Task list with filtering options:

View all, completed, or pending tasks

Mark tasks as completed

Task detail screen with edit functionality

Create new tasks

Local persistence using Hive

REST API consumption to load initial tasks (jsonplaceholder.typicode.com)

GraphQL API consumption to display a list of countries (example: countries.trevorblades.com)

Clean Architecture (Presentation, Domain, Data layers)

State management with Riverpod

Immutable models with Freezed

Loading and error state handling

Unit and widget tests for business logic and UI


🛠️ Tech Stack
Flutter & Dart

Riverpod: state management

Hive: local storage

Dio: REST HTTP client

graphql_flutter: GraphQL client

Freezed: immutable model generation

Mocktail: mocking in tests

Flutter Test: for unit and widget testing

📦 Installation
Clone the repository

bash
Copy
Edit
git clone <repository-url>
cd adv_task_manager
Install dependencies

bash
Copy
Edit
flutter pub get
Initialize Hive (preferably in main.dart or setup)

dart
Copy
Edit
await Hive.initFlutter();
Hive.registerAdapter(TaskModelAdapter());
await Hive.openBox<TaskModel>('tasksBox');
Run the application

bash
Copy
Edit
flutter run
🧪 Testing
Run all tests (unit and widget):

bash
Copy
Edit
flutter test
The project includes:

A unit test for business logic in TasksNotifier

A widget test to verify that tasks are correctly displayed in the UI

🏗 Architecture
The app is structured following Clean Architecture principles with clear separation into layers:

Presentation: Widgets and Riverpod Providers

Domain: Business logic and immutable models (Freezed)

Data: Local and remote datasources (Hive, REST, GraphQL)

This approach promotes maintainability, testability, and scalability.

📚 Usage
On the main screen, view and filter tasks by status, and mark tasks as completed.

Tap a task to view its details and edit information.

Use the floating action button to create new tasks.

Navigate to the Countries screen to view data fetched from a GraphQL API.

📄 License
MIT License
