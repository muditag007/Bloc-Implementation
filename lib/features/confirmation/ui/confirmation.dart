// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/confirmation/bloc/confirmation_bloc.dart';

class Confirmation extends StatefulWidget {
  const Confirmation({super.key});

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ConfirmationBloc, ConfirmationState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container();
        },
      ),
    );
  }
}
