import 'package:doit/Dashboard/todo_cubit.dart';
import 'package:doit/Service/TodosRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditTodoView extends StatefulWidget {
  Todo todo;

  EditTodoView(this.todo);

  @override
  EditTodoViewState createState() {
    return EditTodoViewState(todo);
  }
}

class EditTodoViewState extends State<EditTodoView> {
  final Todo todo;
  final formKey = GlobalKey<FormState>();
  TextEditingController taskNameController;
  TextEditingController taskDescriptionController;
  bool isEditing = false;
  DateTime currentDate;
  EditTodoViewState(this.todo);

  @override
  void initState() {
    super.initState();
    currentDate = null;
    taskNameController = TextEditingController(text: todo.getName());
    taskDescriptionController =
        TextEditingController(text: todo.getDescription());
    isEditing = false;
  }

  @override
  Widget build(BuildContext context) {
    return isEditing ? editingView(context) : nonEditingView(context);
  }

  Widget nonEditingView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            BlocProvider.of<TodoCubit>(context).getTodos();
          },
        ),
        title: Text('Edit Task'),
      ),
      body: Column(
        children: [
          SizedBox(height: 15.0),
          Center(
              child: Text(todo.getName(),
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                      fontSize: 25, decoration: TextDecoration.underline))),
          SizedBox(height: 20.0),
          FractionallySizedBox(
              widthFactor: 0.95,
              child: Row(
                children: [
                  Icon(Icons.notes),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Text(todo.getDescription(),
                        style: TextStyle(fontSize: 20)),
                  )),
                ],
              )),
          SizedBox(height: 20.0),
          FractionallySizedBox(
              widthFactor: 0.95,
              child: Row(
                children: [
                  Icon(Icons.calendar_today_outlined),
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Text(
                        todo.getDateGoal() == null
                            ? "No deadline set"
                            : showDate(todo.getDateGoal()),
                        style: TextStyle(fontSize: 20)),
                  )
                ],
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isEditing = true;
          });
        },
        child: const Icon(Icons.edit),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  Widget editingView(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            onPressed: () {
              BlocProvider.of<TodoCubit>(context).getTodos();
            },
          ),
          title: Text('Edit Task'),
        ),
        body: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 15.0),
                FractionallySizedBox(
                    widthFactor: 0.90,
                    child: Text(
                      "Name",
                      textAlign: TextAlign.left,
                    )),
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
                FractionallySizedBox(
                    widthFactor: 0.90,
                    child: Text(
                      "Description",
                      textAlign: TextAlign.left,
                    )),
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
                FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Row(
                      children: [
                        Text("Deadline: " + (currentDate == null
                            ? "No deadline set"
                            : showDate(currentDate)), style: TextStyle(
                            fontSize: 16),),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => selectDate(context),
                        ),
                        IconButton(
                          icon: Icon(Icons.close_rounded),
                          onPressed: () => clearDate(context),
                        ),
                      ],
                    )),
                SizedBox(height: 15.0),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xff01A0C7),
                  child: MaterialButton(
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        showSnackBar(context, "Editing your task");
                      }
                      BlocProvider.of<TodoCubit>(context)
                          .updateTodoNameAndDescription(
                              todo,
                              taskNameController.text,
                              taskDescriptionController.text);
                      taskNameController.text = '';
                      taskDescriptionController.text = '';
                      // setState(() {
                      //   isEditing = false;
                      // });
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

  Future<void> selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
    if (pickedDate != null)
      setState(() {
        currentDate = pickedDate;
      });
  }


  clearDate(BuildContext context) {
    setState(() {
      currentDate = null;
    });
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

  String showDate(DateTime currentDate) {
    return currentDate.day.toString() +
        "/" +
        currentDate.month.toString() +
        "/" +
        currentDate.year.toString();
  }
}
