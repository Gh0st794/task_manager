class Constants {
  static String tasksApi =
      "https://my-json-server.typicode.com/Gh0st794/tasks/tasksList";
  static String countriesApi = "https://countries.trevorblades.com/";

  static String countriesQuery = r'''
    query {
      countries {
        code
        name
        emoji
        capital
        continent {
          name
        }
      }
    }
  ''';
}
