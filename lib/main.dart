import 'package:doit/AddNewGoal/AddNewGoalPage.dart';
import 'package:doit/Login/LoginPage.dart';
import 'package:doit/PageContainer/PageContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doit/Service/AuthRepository.dart';
import 'package:bloc/bloc.dart';

import 'package:doit/Auth/auth_bloc.dart';

// void main() {
//   runApp(MyApp());
// }

void main() {
  runApp(
      RepositoryProvider<AuthService>(
        create: (context) {
          return AuthService();
        },
        // Injects the Authentication BLoC
        child: BlocProvider<AuthBloc>(
          create: (context) {
            final authService = RepositoryProvider.of<AuthService>(context);
            return AuthBloc(authService)..add(AppStarted());
          },
          child: MyApp(),
        ),
      )
  );
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
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            // show home page
            return PageContainer();
          }
          // otherwise show login page
          return LoginPage();
        },
      ),



        // LoginPage(),
      // routes: {
      //   '/loginSuccess': (context) => PageContainer(),
      //   '/notLoggedIn': (context) => AddNewGoalPage(),
      // },
      // BlocBuilder<AuthBloc, AuthState>(
      //   builder: (context, state) {
      //     if (state is AuthUnauthenticated) {
      //       print("I am not authenticated");
      //       return LoginPage();
      //     }
      //     if (state is AuthAuthenticated) {
      //       context.read<AuthBloc>().add(DummyEvent());
      //       print("I am authenticated");
      //       return PageContainer();
      //     }
      //     if (state is AuthLoading) {
      //       print("I am loading");
      //       return Scaffold(
      //         body: Container(
      //           color: Colors.white,
      //           width: MediaQuery
      //               .of(context)
      //               .size
      //               .width,
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: <Widget>[
      //               SizedBox(
      //                 height: 25.0,
      //                 width: 25.0,
      //                 child: CircularProgressIndicator(
      //                   // valueColor: new AlwaysStoppedAnimation<Color>(Style.Colors.mainColor),
      //                   strokeWidth: 4.0,
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //       );
      //     }
      //     print("I am in else");
      //     return LoginPage();
      //   }
      // )


      // RepositoryProvider(
      //   create: (context) => AuthRepository(),
      //   child: LoginPage(),
      //   ),
      // initialRoute: "/DashboardPage",
      // routes: {
      //   '/DashboardPage': (context) => DashboardPage(),
      //   '/AddNewGoalPage': (context) => AddNewGoalPage(),
      // },
    );
  }
}
