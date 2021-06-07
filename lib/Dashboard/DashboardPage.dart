import 'package:doit/Dashboard/todo_cubit.dart';
import 'package:doit/Service/TodosRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TaskBox extends StatelessWidget {
  String title;
  String id;
  bool isDone;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(id),
        background: Container(color: Colors.red),
        onDismissed: (direction) {
          //  TODO DELETE THE TASK
        },
        child: GestureDetector(
            onTap: () {
              // TODO LEAD TO EDIT TASK
            },
            onLongPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewTodoView()),
              );
              // BlocProvider.of<TodoCubit>(context)
              //                     .createTodo(
              //                     "name", "description");
              // TODO LEAD TO SHOW OPTIONS
            },
            child: Container(
                margin: EdgeInsets.all(5.0),
                height: 50,
                child: Row(children: [
                  Checkbox(
                    value: this.isDone,
                    // onChanged: (bool value) {
                    //   TODO MARK THE TASK DONE
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      padding: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.black12))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              title,
                              textDirection: TextDirection.ltr,
                              style: isDone
                                  ? TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      decoration: TextDecoration.lineThrough,
                                    )
                                  : TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                            ),
                            CircularProgressIndicator(
                              value: progress,
                            )
                          ]),
                    ),
                  )
                ]))));
  }

  TaskBox(String title, String id, bool isDone, {double progress}) {
    this.title = title;
    this.id = id;
    this.isDone = isDone == null ? false : isDone;
    this.progress = progress;
  }
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: BlocProvider(
        create: (context) => TodoCubit()..getTodos(),
        child: TasksView(),
      ),
    );
  }
}

class TasksView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: SideBar(),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is ListTodosSuccess) {
            if (state.todos.length > 0) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Dashboard'),
                ),
                body: Container(
                    margin: EdgeInsets.only(top: 5),
                    child: ListView(children: createTaskList(state.todos))),
              );
            } else {
              return emptyTodoListView();
            }
          } else if (state is ListTodosFailure) {
            return Center(
              child: exceptionView(state.exception),
            );
          } else if (state is CreateNewTodo) {
            return NewTodoView();
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text('Dashboard'),
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<TodoCubit>(context).intentionToCreateNewTodo();
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  Widget createTaskBox(String title, String id, bool isDone,
      {double progress}) {
    return progress != null
        ? TaskBox(title, id, isDone, progress: progress)
        : TaskBox(title, id, isDone, progress: 0);
  }

  List<Widget> createTaskList(List<Todo> todos) {
    List<Widget> tasks = [];
    todos.forEach((element) {
      tasks.add(createTaskBox(element.name, element.id, element.isDone));
    });
    return tasks;
  }

  Widget exceptionView(Exception e) {
    return Center(child: Text(e.toString()));
  }

  Widget emptyTodoListView() {
    return Center(child: Text("You have no Tasks yet!"));
  }
}

class NewTodoView extends StatefulWidget {
  @override
  NewTodoViewState createState() {
    return NewTodoViewState();
  }
}

class NewTodoViewState extends State<NewTodoView> {
  final formKey = GlobalKey<FormState>();
  final taskNameController = TextEditingController();
  final taskDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            onPressed: () {
              BlocProvider.of<TodoCubit>(context).getTodos();
            },
          ),
          title: Text('Add New Task'),
        ),
        body: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 15.0),
                Center(
                  child: FractionallySizedBox(
                    widthFactor: 0.95,
                    child: TextFormField(
                      controller: taskNameController,
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Name of Task",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      validator: (value) => value.trim().length > 0
                          ? null
                          : "Please give a name to the task",
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Center(
                  child: FractionallySizedBox(
                    widthFactor: 0.95,
                    child: TextFormField(
                      controller: taskDescriptionController,
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Description",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      minLines: 4,
                      maxLines: 6,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xff01A0C7),
                  child: MaterialButton(
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        showSnackBar(context, "Making your task");
                      }
                      BlocProvider.of<TodoCubit>(context).createTodo(
                          taskNameController.text,
                          taskDescriptionController.text);
                      taskNameController.text = '';
                      taskDescriptionController.text = '';
                    },
                    child: Text("Save Task",
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            )));
  }

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    taskNameController.dispose();
    taskDescriptionController.dispose();
    super.dispose();
  }
}
