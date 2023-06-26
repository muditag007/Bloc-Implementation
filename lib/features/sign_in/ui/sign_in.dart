// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_declarations, unnecessary_cast, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/constants.dart';
import 'package:test_app/features/home/ui/home.dart';
import 'package:test_app/features/register/ui/register.dart';
import 'package:test_app/features/sign_in/bloc/sign_in_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final SignInBloc signInBloc = SignInBloc();

  @override
  void initState() {
    signInBloc.add(SignInInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      bloc: signInBloc,
      listenWhen: (previous, current) => current is SignInActionState,
      buildWhen: (previous, current) => current is! SignInActionState,
      listener: (context, state) {
        if (state is SignInNavigateHomeState) {
          final successState = state as SignInNavigateHomeState;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Register(
                email: successState.email,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case SignInLoadingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case SignInSuccessState:
            double height = (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top) /
                844;
            double width = MediaQuery.of(context).size.width / 390;
            return Scaffold(
              backgroundColor: kYellow,
              body: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                  left: 40 * width,
                  right: 40 * width,
                  bottom: 94 * height,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 143 * height,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Welcome Back,",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Login Now.",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30 * height,
                    ),
                    Container(
                      height: 63 * height,
                      width: 63 * height,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                    SizedBox(
                      height: 53 * height,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Elevate Your\nPassenger\nExperience, from\nStart to Finish",
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 14 * height,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Gear Up for Smoother Rides\nand Smarter Routes...",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    InkWell(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        signInBloc.add(SignInClickedEvent());
                      },
                      child: Container(
                        height: 64 * height,
                        width: 303 * width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10 * width,
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 48 * height,
                                width: 48 * height,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x3F000000),
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/google.png",
                                    height: 25 * height,
                                    width: 25 * height,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 37 * width,
                              ),
                              Text(
                                "Login With Google",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          case SignInDoneState:
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
