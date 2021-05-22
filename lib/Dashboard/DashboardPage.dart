import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatelessWidget {

  final String baseUrl = "https://192.168.10.120:5000";
  Future<String> getData() async {
     http.Response response = await http.post(
        Uri.http("10.0.2.2:5000", "/api/users"),
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
            // createAlbum("Hello");
            getData()
                .then((result) {
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
