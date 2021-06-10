import 'package:doit/Dashboard/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
