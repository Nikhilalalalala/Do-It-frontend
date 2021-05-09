import 'package:flutter/material.dart';
import 'package:doit/SideBar/SideBar.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: ElevatedButton(
          // Within the `FirstScreen` widget
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/AddNewGoalPage');
          },
          child: Text('Add New Goal'),
        ),
      ),
    );
  }
}
