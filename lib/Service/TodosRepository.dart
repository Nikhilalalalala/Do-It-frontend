// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';
//
// @immutable
// class Todo extends Equatable {
//   final String name;
//   final bool isDone;
//   final String description;
//   final String date_goal;

//
//   Todo(this.name, {this.isDone = false, String description = '', String date_goal =''})
//       : this.name = name ?? 'Untitled Task',
//         super();
//
//
//   Todo copyWith({ String name, bool isDone, String description, String date_goal}) {
//     return Todo(
//       name ?? this.name,
//       isDone: isDone ?? this.isDone,
//       description: description ?? this.description,
//       date_goal: date_goal ?? this.date_goal,
//     );
//   }
//
//
//   @override
//   String toString() {
//     return 'Todo { complete: $complete, task: $task, note: $note, id: $id }';
//   }
//
//
//   TodoEntity toEntity() {
//     return TodoEntity(task, id, note, complete);
//   }
//
//
//   static Todo fromEntity(TodoEntity entity) {
//     return Todo(
//       entity.task,
//       complete: entity.complete ?? false,
//       note: entity.note,
//       id: entity.id ?? Uuid().generateV4(),
//     );
//   }
// }

import 'package:doit/Service/AuthRepository.dart';
import "dart:convert";
import "package:http/http.dart" as http;

class Todo {
  final String id;
  final String name;
  final String description;
  final bool isDone;
  final String dateGoal;

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
      isDone: data['isDone'],
      dateGoal: data['dateGoal'] ?? null);

  Map<String, dynamic> toDatabaseJson() {
    if (this.dateGoal != null) {
      return {
        "name": this.name,
        "description": this.description,
        "isDone": this.isDone,
        "dateGoal": this.dateGoal
      };
    } else {
      return {
        "name": this.name,
        "description": this.description,
        "isDone": this.isDone,
      };
    }
  }

  String getName() {
    return name;
  }
  String getId() {
    return name;
  }
  String getDescription() {
    return name;
  }


  @override
  String toString() {
    return "Task: $name, $description, IsDONE? $isDone, doBy: $dateGoal";
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
    if (response.statusCode == 200) {
      print(responseJson);
      print(responseJson["tasks"]);
      List<dynamic> todoListJson = jsonDecode(responseJson["tasks"]);
      print(todoListJson);
      todoListJson.forEach((element) {
        print(element.toString());
        todoList.add(Todo.fromDatabaseJson(element));
      });
    }
    print("Todolist: " + todoList.toString());
    return todoList;
  }

  void createTodo(String name, String description, {String date_goal}) async {
    String token = await AuthService.getToken();
    http.Response response = await http.post(
      Uri.http(mainUrl, "/api/tasks"),
      headers: {
        "Accept": "application/json",
        "x-access-token": token,
      },
      body: new Todo(name: name, description: description, dateGoal: date_goal).toDatabaseJson()
    );
  }

}
