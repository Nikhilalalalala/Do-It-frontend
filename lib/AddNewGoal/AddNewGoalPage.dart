import 'package:flutter/material.dart';

class AddNewGoalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Add New Goal'),
      // ),
      body: Center(
        child: ElevatedButton(
          // Within the `FirstScreen` widget
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/DashboardPage');
          },
          child: Text('Go Back To DashBoard'),
        ),
      ),
    );
  }
}
