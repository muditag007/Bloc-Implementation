// ignore_for_file: prefer_const_constructors, unnecessary_import, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_cast

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/home/ui/home.dart';
import 'package:test_app/features/register/bloc/register_bloc.dart';
import 'package:test_app/features/register/models/user_model.dart';

class Register extends StatefulWidget {
  const Register({super.key, required this.user});
  final User? user;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController regNo = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  // TextEditingController fName = TextEditingController();
  final RegisterBloc registerBloc = RegisterBloc();

  @override
  void initState() {
    registerBloc.add(RegisterInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      bloc: registerBloc,
      listenWhen: (previous, current) => current is RegisterActionState,
      buildWhen: (previous, current) => current is! RegisterActionState,
      listener: (context, state) {
        if (state is RegisterNavigateHomeState) {
          final successState = state as RegisterNavigateHomeState;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Home(
                        user: successState.user,
                      )));
        } else if (state is RegisterDoneState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('User Registered')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          // case RegisterInitialState:
          case RegisterSuccessState:
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: fName,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(),
                        hintText: 'Enter a value',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: lName,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(),
                        hintText: 'Enter a value',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: regNo,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(),
                        hintText: 'Enter a value',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: phoneNo,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(),
                        hintText: 'Enter a value',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        registerBloc.add(
                          RegisterClickedEvent(
                            user: widget.user,
                            userDetails: UserModel(
                              firstName: fName.text,
                              lastName: lName.text,
                              phoneNumber: phoneNo.text,
                              regNo: regNo.text,
                              email: widget.user!.email.toString(),
                              idPhotoUrl: '',
                              photoUrl: '',
                            ),
                          ),
                        );
                      },
                      child: Center(
                        child: Text("Register"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          case RegisterTryingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
