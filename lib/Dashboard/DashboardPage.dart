import 'package:doit/Dashboard/EditTodoView.dart';
import 'package:doit/Dashboard/todo_cubit.dart';
import 'package:doit/Service/TodosRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'NewTodoView.dart';

class TaskBox extends StatelessWidget {
  Todo todo;

  TaskBox(Todo todo) {
    this.todo = todo;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(todo.getId()),
        background: Container(color: Colors.red),
        onDismissed: (direction) {
          BlocProvider.of<TodoCubit>(context).deleteTodo(todo);
        },
        child: GestureDetector(
            onTap: () {
              BlocProvider.of<TodoCubit>(context).intentionToEditTodo(
                  this.todo);
            },
            onLongPress: () {
              // TODO LEAD TO SHOW OPTIONS
            },
            child: Container(
                margin: EdgeInsets.all(5.0),
                height: 50,
                child: Row(children: [
                  Checkbox(
                      value: todo.getIsDone(),
                      onChanged: (bool value) {
                        BlocProvider.of<TodoCubit>(context)
                            .updateTodoIsComplete(todo, value);
                      }),
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
                              todo.getName(),
                              textDirection: TextDirection.ltr,
                              style: todo.getIsDone()
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
                              value: todo.getProgress(),
                            )
                          ]),
                    ),
                  )
                ]))));
  }
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: BlocProvider(
        create: (context) =>
        TodoCubit()
          ..getTodos(),
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

                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<TodoCubit>(context)
                        .intentionToCreateNewTodo();
                  },
                  child: const Icon(Icons.add),
                  backgroundColor: Colors.blueAccent,
                ),
              );
            } else {
              return emptyTodoListView(context);
            }
          } else if (state is ListTodosFailure) {
            return Center(
              child: exceptionView(state.exception),
            );
          } else if (state is CreateNewTodo) {
            return NewTodoView();
          } else if (state is EditTodo) {
            return EditTodoView(state.todo);
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

    );
  }

  List<Widget> createTaskList(List<Todo> todos) {
    List<Widget> tasks = [];
    todos.forEach((element) {
      tasks.add(TaskBox(element));
    });
    return tasks;
  }

  Widget exceptionView(Exception e) {
    return Center(child: Text(e.toString()));
  }

  Widget emptyTodoListView(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(child: Text("You have no Tasks yet!")),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<TodoCubit>(context).intentionToCreateNewTodo();
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}

