import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GoalBox extends StatelessWidget {
  String title;
  int id;
  bool isDone;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(this.id.toString()),
        background: Container(color: Colors.red),
        onDismissed: (direction) {
          //  TODO DELETE THE TASK
        },
          child: GestureDetector(
            onTap: () {
            // TODO LEAD TO EDIT TASK
            },
            onLongPress: () {
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
                              'Hello World',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
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

  GoalBox(String title, int id, bool isDone, {double progress}) {
    this.title = title;
    this.id = id;
    this.isDone = isDone;
    this.progress = progress;
  }
}

class DashboardPage extends StatelessWidget {
  Widget createGoalBox(String title, int id, bool isDone, {double progress}) {
    return progress != null
        ? GoalBox(title, id, isDone, progress: progress)
        : GoalBox(title, id, isDone, progress: 0);
  }

  final String baseUrl = "https://192.168.10.120:5000";

  Future<String> getData() async {
    http.Response response = await http.post(
      Uri.http("10.0.2.2:5000", "/api/users"),
      headers: {"Accept": "application/json"},
      body: jsonEncode(<String, String>{"name": "Nik"}),
    );
    var data = jsonDecode(response.body).cast<Map<String, dynamic>>();
    print(data);
    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    String buttonWord = "Add New Goal";
    return Scaffold(
      // drawer: SideBar(),
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 5),
        child: ListView(children: [
          createGoalBox("title", 1, false, progress: 0.6),
          createGoalBox("title", 1, false),
          createGoalBox("title", 1, false),
          createGoalBox("title", 1, false),
          createGoalBox("title", 1, false),
          createGoalBox("title", 1, false),
          createGoalBox("title", 1, false),
          createGoalBox("title", 1, false),
          createGoalBox("title", 1, false),
          createGoalBox("title", 1, false),
          createGoalBox("title", 1, false),
          createGoalBox("title", 1, false),
          createGoalBox("title", 1, false),
        ]
            // ElevatedButton(
            //   // Within the `FirstScreen` widget
            //   onPressed: () {
            //     // Navigate to the second screen using a named route.
            //     // createAlbum("Hello");
            //     getData()
            //         .then((result) {
            //       buttonWord = result;
            //     });
            //     // Navigator.pushNamed(context, '/AddNewGoalPage');
            //   },
            //   child: Text('Add New Goal'),
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
