🚀 Advanced Task Manager
A Flutter application for advanced task management, following Clean Architecture, using Riverpod for state management, and consuming both REST and GraphQL APIs with local persistence via Hive.

📋 Overview
The Advanced Task Manager allows users to manage their tasks efficiently with features like creation, editing, filtering, and completion status updates. The application integrates data from REST and GraphQL APIs, ensuring seamless synchronization with persistent local storage.

The project emphasizes clean code practices by implementing Clean Architecture principles, making it maintainable, scalable, and testable.

✨ Features
Task Listing with:

Filter by All, Completed, or Pending tasks.

Mark tasks as Completed.

Task Detail Screen for editing task information.

Create & Edit tasks.

Local Persistence using Hive for offline access.

REST API Integration (jsonplaceholder.typicode.com) to fetch initial tasks.

GraphQL API Integration (countries.trevorblades.com) to display a list of countries.

Clean Architecture with layered separation:

Presentation

Domain

Data

State Management using Riverpod.

Immutable Models using Freezed.

Loading & Error States Handling.

Unit & Widget Testing for business logic and UI validation.

🛠️ Tech Stack
Technology	Purpose
Flutter & Dart	Application framework
Riverpod	State management
Hive	Local data persistence
Dio	REST API client
graphql_flutter	GraphQL client
Freezed	Immutable data models
Mocktail	Mocking for tests
Flutter Test	Unit & Widget testing

📦 Installation Guide
Clone the Repository

bash
Copy
Edit
git clone <repository-url>
cd adv_task_manager
Install Dependencies

bash
Copy
Edit
flutter pub get
Initialize Hive (usually in main.dart)

dart
Copy
Edit
await Hive.initFlutter();
Hive.registerAdapter(TaskModelAdapter());
await Hive.openBox<TaskModel>('tasksBox');
Run the App

bash
Copy
Edit
flutter run
🧪 Testing
Run all unit and widget tests:

bash
Copy
Edit
flutter test
Tests included:

✅ Unit Test: Business logic validation for TasksNotifier.

✅ Widget Test: Verifies tasks are displayed correctly in the UI.

🏗️ Architecture Breakdown
The project is structured with Clean Architecture, ensuring high modularity and separation of concerns:

Presentation Layer: Flutter UI Widgets, Riverpod Providers.

Domain Layer: Business logic, Use Cases, Freezed Models.

Data Layer: Repositories, Local Datasource (Hive), Remote Datasources (REST & GraphQL APIs).

This structure enhances:

Maintainability

Testability

Scalability

📚 Usage Instructions
Open the app to see the Task List Screen.

Filter tasks by:

All

Completed

Pending

Tap a task to view/edit its details.

Use the Floating Action Button (FAB) to create new tasks.

Navigate to the Countries Screen to see a list of countries fetched from a GraphQL API.

📄 License
This project is licensed under the MIT License.
