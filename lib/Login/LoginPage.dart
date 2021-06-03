import 'package:doit/Service/AuthRepository.dart';
import 'package:doit/Auth/auth_bloc.dart';
import 'package:doit/Login/login_bloc.dart';
import 'package:doit/PageContainer/PageContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doit/Common/FormSubmissionStatus.dart';

class LoginPage extends StatelessWidget {
  Widget usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        obscureText: false,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Username",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        validator: (value) =>
        value
            .trim()
            .length > 0 ? null : "Fill in all fields",
        onChanged: (value) =>
            context
                .read<LoginBloc>()
                .add(LoginUsernameChanged(username: value)),
      );
    });
  }

  Widget passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Password",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        validator: (value) =>
        value
            .trim()
            .length > 0 ? null : "Fill in all fields",
        onChanged: (value) =>
            context
                .read<LoginBloc>()
                .add(LoginPasswordChanged(password: value)),
      );
    });
  }

  Widget loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formSubmissionStatus is FormSubmitting
          ? CircularProgressIndicator()
          : Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xff01A0C7),
        child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              context.read<LoginBloc>().add(LoginButtonClicked());
            }
          },
          child: Text("Login",
              textAlign: TextAlign.center,
              style: new TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      );
    });
  }

  final logo = Text(
    "Do It!",
    textAlign: TextAlign.center,
    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
    // style: style,
  );

  final _formKey = GlobalKey<FormState>();

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formSubmissionStatus = state.formSubmissionStatus;
        if (formSubmissionStatus is SubmissionFailed) {
          context.read<LoginBloc>().add(LoginSubmissionReset());
          _showSnackBar(context, formSubmissionStatus.exception.toString());
        }
      },
      child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                logo,
                SizedBox(height: 45.0),
                usernameField(),
                SizedBox(height: 25.0),
                passwordField(),
                SizedBox(
                  height: 35.0,
                ),
                loginButton(),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          )),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final authBloc = BlocProvider.of<AuthBloc>(context);
            // if (state is AuthUnauthenticated) {
            //   return loginForm(context);
            // }
            // return Center(
            //     child: CircularProgressIndicator(
            //     strokeWidth: 2,
            //     ),
            // );
            return loginForm(context);
          })

    );
  }

  Widget loginForm(BuildContext context) {
    final authService = RepositoryProvider.of<AuthService>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Container(
        alignment: Alignment.center,
        child: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(authBloc, authService),
          child:
             Center(
              child: Container(color: Colors.white, child: _loginForm()),
            )
          ),
        );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
