import 'dart:core';
import 'package:doit/Service/AuthRepository.dart';
import "dart:convert";
import "package:http/http.dart" as http;
import "dart:math" as Math;

class Todo {
  String id;
  String name;
  String description;
  bool isDone;
  String dateGoal;

  Todo(
      {this.id = '',
      this.name = 'Untitled Task',
      this.description = '',
      this.isDone = false,
      this.dateGoal});

  factory Todo.fromDatabaseJson(Map<String, dynamic> data) => Todo(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      isDone: data['isDone'] == null ? false : data['isDone'],
      dateGoal: data['dateGoal'] ?? null);

  Map<String, dynamic> toDatabaseJson() {
    if (this.dateGoal != null) {
      return {
        "id" : id,
        "name": this.name,
        "description": this.description,
        "isDone": this.isDone.toString(),
        "dateGoal": this.dateGoal
      };
    } else {
      return {
        "id" : id,
        "name": this.name,
        "description": this.description,
        "isDone": this.isDone.toString(),
      };
    }
  }

  String getName() {
    return name;
  }
  String getId() {
    return id;
  }
  bool getIsDone() {
    return isDone;
  }
  String getDescription() {
    return description;
  }
  String getDateGoal() {
    return dateGoal;
  }
  double getProgress() {
    double progress = Math.Random.secure().nextDouble();
    return progress;
  }
  void setIsDone(bool newValue) {
    this.isDone = newValue;
  }

  void setName(String name) {
    this.name = name;
  }

  void setDescription(String description) {
    this.description = description;
  }

  @override
  String toString() {
    return "Task: $name, $description, isDone? $isDone, dateGoal: $dateGoal";
  }

}

class TodoRepository {
  static String mainUrl = "10.0.2.2:5000";

  Future<List<Todo>> getAllTodos() async {
    List<Todo> todoList = [];
    String token = await AuthService.getToken();
    http.Response response = await http.get(
      Uri.http(mainUrl, "/api/tasks"),
      headers: {
        "Accept": "application/json",
        "x-access-token": token,
      },
    );

    Map<String, dynamic> responseJson = jsonDecode(response.body);
    print(responseJson);
    if (response.statusCode == 200) {
      List<dynamic> todoListJson = jsonDecode(responseJson["tasks"]);
      todoListJson.forEach((element) {
        todoList.add(Todo.fromDatabaseJson(element));
      });
    }
    print("received todo list");
    print(todoList);
    return todoList;
  }

  void createTodo(String name, String description, {String date_goal}) async {
    String token = await AuthService.getToken();
    print(new Todo(name: name, description: description, dateGoal: date_goal).toDatabaseJson());
    http.Response response = await http.post(
      Uri.http(mainUrl, "/api/tasks"),
      headers: {
        "Accept": "application/json",
        "x-access-token": token,
      },
      body: jsonEncode(new Todo(name: name, description: description, dateGoal: date_goal).toDatabaseJson())
    );
    print("Created Todo" + response.statusCode.toString());
  }

  void updateTodoIsDone(Todo todo, bool isDone) async {
    String token = await AuthService.getToken();
    todo.setIsDone(isDone);
    updateTodo(todo);
  }

  void updateTodoName(Todo todo, String newName)async {
    String token = await AuthService.getToken();
    todo.setName(newName);
    updateTodo(todo);
  }

  void updateTodoDescription(Todo todo, String newDescription)async {
    String token = await AuthService.getToken();
    todo.setDescription(newDescription);
    updateTodo(todo);
  }

  void updateTodo(Todo todo) async {
    String token = await AuthService.getToken();
    http.Response response = await http.put(
        Uri.http(mainUrl, "/api/tasks"),
        headers: {
          "Accept": "application/json",
          "x-access-token": token,
        },
        body: jsonEncode(todo.toDatabaseJson())
    );
    print("Sending req to update todo \n" +  jsonEncode(todo.toDatabaseJson()).toString());
  }

  void deleteTodo(Todo todo) async {
    print("sent delete request");
    String token = await AuthService.getToken();
    String id = todo.getId();
    http.Response response = await http.delete(
        Uri.http(mainUrl, "/api/tasks"),
        headers: {
          "Accept": "application/json",
          "x-access-token": token,
        },
        body: jsonEncode({"id" : todo.getId()})
    );
    print(response);
  }

}
