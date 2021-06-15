import 'package:doit/Auth/auth_bloc.dart';
import 'package:doit/Settings/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() {
    return SettingsPageState();
  }
}

class SettingsPageState extends State<SettingsPage> {
  TextEditingController bioController = new TextEditingController();
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    bioController = new TextEditingController(text: "");
    isEditing = false;
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocProvider<UserCubit>(
        create: (context) => UserCubit()..getUserDetails(),
        child: main(authBloc));
  }

  Widget main(dynamic authBloc) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: AppBar(
                title: Text('Settings'),
                actions: isEditing
                    ? [
                        IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            BlocProvider.of<UserCubit>(context)
                                .updateUserBio(bioController.text);
                          },
                        ),
                      ]
                    : [
                        IconButton(
                          icon: const Icon(Icons.exit_to_app),
                          onPressed: () => authBloc.add(LoggedOut()),
                        ),
                      ],
              ),
              body: BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is UserDetailsSuccess) {
                    bioController.text = state.user.bio ?? "";
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        FractionallySizedBox(
                            widthFactor: 0.90,
                            child: Text(
                              "Bio",
                              textAlign: TextAlign.left,
                            )),
                        Center(
                          child: FractionallySizedBox(
                            widthFactor: 0.95,
                            child: Focus(
                                child: TextFormField(
                                  controller: bioController,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      hintText: "Bio",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0))),
                                  minLines: 4,
                                  maxLines: 6,
                                ),
                                onFocusChange: (hasFocus) {
                                  setState(() {
                                    isEditing = hasFocus;
                                  });
                                  BlocProvider.of<UserCubit>(context)
                                      .updateUserBio(bioController.text);
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ]),
                    );
                  } else if (state is UserDetailsFailure) {
                    return Center(
                      child: exceptionView(state.exception),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              // logoutButton(authBloc),
            ));
      },
    );
  }

  Widget exceptionView(Exception e) {
    return Center(child: Text(e.toString()));
  }

  // Widget logoutButton(dynamic authBloc) {
  //   return Material(
  //     elevation: 5.0,
  //     borderRadius: BorderRadius.circular(30.0),
  //     color: Color(0xff01A0C7),
  //     child: MaterialButton(
  //       padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
  //       onPressed: () => authBloc.add(LoggedOut()),
  //       child: Text("Log out",
  //           textAlign: TextAlign.center,
  //           style: new TextStyle(
  //               color: Colors.white, fontWeight: FontWeight.bold)),
  //     ),
  //   );
  // }
}
