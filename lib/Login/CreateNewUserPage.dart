import 'package:doit/Login/create_new_user_cubit.dart';
import 'package:doit/Service/AuthRepository.dart';
import 'package:doit/Auth/auth_bloc.dart';
import 'package:doit/Login/login_bloc.dart';
import 'package:doit/PageContainer/PageContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doit/Common/FormSubmissionStatus.dart';

class CreateNewUserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: BlocProvider<CreateNewUserCubit>(
        create: (context) => CreateNewUserCubit(),
        child: CreateNewUserPage(),
      ),
    );
  }
}

class CreateNewUserPage extends StatefulWidget {
  @override
  CreateNewUserPageState createState() {
    return CreateNewUserPageState();
  }
}

class CreateNewUserPageState extends State<CreateNewUserPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController;
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  Widget usernameField() {
    return TextFormField(
      controller: usernameController,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (value) =>
          value.trim().length > 0 ? null : "Fill in all fields",
    );
  }

  Widget passwordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (value) =>
          value.trim().length > 6 ? null : "Fill in all fields",
    );
  }

  Widget confirmPasswordField() {
    return TextFormField(
      controller: confirmPasswordController,
      obscureText: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Confirm Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (value) =>
          value.trim().length > 6 ? null : "Fill in all fields",
    );
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  Widget emailField() {
    return TextFormField(
      controller: emailController,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (value) =>
          validateEmail(value.trim()) ? null : "Fill in a valid email",
    );
  }

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget createNewUserButton(BuildContext context) {
    return BlocConsumer<CreateNewUserCubit, CreateNewUserState>(
        builder: (context, state) {
      return Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xff01A0C7),
        child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            if (formKey.currentState.validate()) {
              BlocProvider.of<CreateNewUserCubit>(context).createNewUser(
                  usernameController.text,
                  emailController.text,
                  passwordController.text,
                  confirmPasswordController.text);
            }
          },
          child: Text("Create Account",
              textAlign: TextAlign.center,
              style: new TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      );
    },
        listener: (context, state) {
          if (state is CreateNewUserSuccess) {
            print("BlocProvider.of<LoginBloc>(context).add(LoginSubmissionReset())");
            BlocProvider.of<LoginBloc>(context).add(LoginSubmissionReset());
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateNewUserCubit, CreateNewUserState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            onPressed: () {
              BlocProvider.of<LoginBloc>(context).add(LoginSubmissionReset());
            },
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
        ),
        body: Container(
          child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 36.0, right: 36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Create a new account",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                      // style: style,
                    ),
                    SizedBox(height: 15.0),
                    usernameField(),
                    SizedBox(height: 15.0),
                    emailField(),
                    SizedBox(height: 15.0),
                    passwordField(),
                    SizedBox(height: 15.0),
                    confirmPasswordField(),
                    SizedBox(height: 15.0),
                    createNewUserButton(context),
                    // SizedBox(height: 100.0),
                  ],
                ),
              )),
        ),
      );
    });
  }
}