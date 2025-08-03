
# Advanced Task Manager

_A Flutter application for advanced task management, using **Clean Architecture**, **Riverpod**, and consuming both **REST** and **GraphQL APIs**._
---

## 📋 Overview

**Advanced Task Manager** is designed to:

- Flutter version: 3.32.8.
- Dart versiom: 3.8.1.
- Create, edit, and filter tasks.
- Persist tasks locally using **Hive**.
- Synchronize tasks via **REST API** and fetch country data via **GraphQL API**.
- Follow **Clean Architecture** for maintainability and scalability.

---

## 🚀 Features

### Task Management
- View tasks: **All**, **Completed**, **Pending**.
- Mark tasks as **Completed**.
- View task details and **edit** them.
- **Create** new tasks using a form.

### Data Persistence & APIs
- Local storage using **Hive**.
- Fetch initial tasks from **jsonplaceholder.typicode.com**.
- Fetch country data via **countries.trevorblades.com GraphQL API**.

### Architecture & Tools
- **Clean Architecture**: Presentation, Domain, Data layers.
- **Riverpod** for state management.
- **Freezed** for immutable models.
- **Dio** for REST API requests.
- **graphql_flutter** for GraphQL consumption.
- Error & loading state handling.
- Unit & Widget tests for business logic and UI.

---

## 🛠️ Tech Stack

| Technology         | Description                                  |
|--------------------|----------------------------------------------|
| **Flutter & Dart**  | Cross-platform app framework                |
| **Riverpod**        | State management                           |
| **Hive**            | Local persistence                         |
| **Dio**             | REST HTTP client                          |
| **graphql_flutter** | GraphQL client                            |
| **Freezed**         | Immutable model generation                 |
| **Mocktail**        | Mocking library for tests                  |
| **Flutter Test**    | Testing framework for unit & widget tests  |

---

## 📦 Installation Guide

### 1. Clone the Repository
```bash
git clone <repository-url>
cd adv_task_manager
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Initialize Hive in `main.dart`
```dart
await Hive.initFlutter();
Hive.registerAdapter(TaskModelAdapter());
await Hive.openBox<TaskModel>('tasksBox');
```

### 4. Run the App
```bash
flutter run
```

---

## 🧪 Running Tests

```bash
flutter test
```

**Tests included:**
1. Unit Test for business logic in `TasksNotifier`.
2. Widget Test verifying UI rendering of tasks.

---

## 🏗 Architecture

| Layer             | Responsibilities                                         |
|-------------------|---------------------------------------------------------|
| **Presentation**   | UI Widgets, Pages, Riverpod Providers                   |
| **Domain**         | Business Logic, Entities, Freezed Immutable Models      |
| **Data**           | Local (Hive) & Remote (REST, GraphQL) Datasources       |

> _This structure enhances scalability, testability, and clean separation of concerns._

---

## 📚 Usage Guide

1. **View & Filter Tasks** on the main screen.
2. **Mark tasks as completed** by tapping the icon.
3. **Tap a task** to view and edit its details.
4. Use the **Floating Action Button** to add new tasks.
5. Navigate to the **Countries Screen** to view GraphQL data.

---

## 📄 License

MIT License — [LICENSE](LICENSE)

---

## 🔗 Useful Links
- [Flutter Documentation](https://flutter.dev/docs)
- [Riverpod Documentation](https://riverpod.dev)
- [Hive Documentation](https://docs.hivedb.dev)
- [GraphQL Flutter](https://pub.dev/packages/graphql_flutter)
- [JsonPlaceholder API](https://jsonplaceholder.typicode.com)
- [TrevorBlades GraphQL API](https://countries.trevorblades.com)
