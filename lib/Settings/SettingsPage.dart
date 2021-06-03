import 'package:doit/Auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: logoutButton(authBloc)
      ),
    );
  }
}

Widget logoutButton(dynamic authBloc) {
  return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () => authBloc.add(LoggedOut()),
        child: Text("Log out",
            textAlign: TextAlign.center,
            style: new TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
  );
}