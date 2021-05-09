import 'package:doit/Dashboard/DashboardPage.dart';
import 'package:doit/AddNewGoal/AddNewGoalPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Do It',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardPage(),
      initialRoute: "/DashboardPage",
      routes: {
        '/DashboardPage': (context) => DashboardPage(),
        '/AddNewGoalPage': (context) => AddNewGoalPage(),
      },
    );
  }
}
