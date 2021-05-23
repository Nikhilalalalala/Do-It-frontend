import 'package:doit/Login/LoginPage.dart';
import 'package:doit/PageContainer/PageContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doit/Login/AuthRepository.dart';

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
      home: RepositoryProvider(
        create: (context) => AuthRepository(),
        child: PageContainer(),
        ),
      // initialRoute: "/DashboardPage",
      // routes: {
      //   '/DashboardPage': (context) => DashboardPage(),
      //   '/AddNewGoalPage': (context) => AddNewGoalPage(),
      // },
    );
  }
}
