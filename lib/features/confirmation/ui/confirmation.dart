// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/confirmation/bloc/confirmation_bloc.dart';

class Confirmation extends StatefulWidget {
  const Confirmation({super.key, required this.user});
  final User? user;
  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  final ConfirmationBloc confirmationBloc = ConfirmationBloc();

  @override
  void initState() {
    confirmationBloc.add(ConfirmationInitialEvent(user: widget.user));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ConfirmationBloc, ConfirmationState>(
        bloc: confirmationBloc,
        listenWhen: (previous, current) => current is ConfirmationActionState,
        buildWhen: (previous, current) => current is! ConfirmationActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case ConfirmationInitialState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConfirmationSuccessState:
              final successState = state as ConfirmationSuccessState;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(successState.autoName),
                  Text(successState.autoNum),
                  Text(successState.autoPhone),
                  Text(successState.otp.toString()),
                  Image(image: NetworkImage(successState.autoPhoto)),
                ],
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
