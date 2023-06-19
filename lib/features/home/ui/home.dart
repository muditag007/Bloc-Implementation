// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/home/bloc/home_bloc.dart';

class Home extends StatefulWidget {
  final User? user;
  const Home({super.key, required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: homeBloc,
      // listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeSuccessState:
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(''),
                    Text(''),
                  ],
                ),
              ),
            );
          default:
            return Scaffold(
              body: Center(child: Text("Failed"),),
            );
        }
      },
    );
  }
}
