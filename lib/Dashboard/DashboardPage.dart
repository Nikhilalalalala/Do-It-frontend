import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DashboardPage extends StatelessWidget {

  Future<String> getData() async {
    http.Response response = await http.post(
        Uri.http("127.0.0.1:5000", "/addUser"),
        headers: {
          "Accept": "application/json"
        },
        body: jsonEncode(<String, String>{
          "name": "Nik"
        }),
    );
    var data = (response.body);
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
      body: Center(
        child: ElevatedButton(
          // Within the `FirstScreen` widget
          onPressed: () {
            // Navigate to the second screen using a named route.
            getData().then((result) {
              buttonWord = result;
            });
            // Navigator.pushNamed(context, '/AddNewGoalPage');
          },
          child: Text('Add New Goal'),
        ),
      ),
    );
  }
}
