// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_cast

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/confirmation/bloc/confirmation_bloc.dart';
import 'package:test_app/features/home/ui/home.dart';

class Confirmation extends StatefulWidget {
  const Confirmation({super.key, required this.email});
  final String? email;
  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  final ConfirmationBloc confirmationBloc = ConfirmationBloc();

  @override
  void initState() {
    confirmationBloc.add(ConfirmationInitialEvent(email: widget.email));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ConfirmationBloc, ConfirmationState>(
        bloc: confirmationBloc,
        listenWhen: (previous, current) => current is ConfirmationActionState,
        buildWhen: (previous, current) => current is! ConfirmationActionState,
        listener: (context, state) {
          if (state is ConfirmationCancelPaymentState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(
                  email: widget.email,
                ),
              ),
            );
          } else if (state is ConfirmationNavigatePaymentGatewayState) {
          } else if (state is ConfirmationPaymentSuccess) {
            final successState = state as ConfirmationPaymentSuccess;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(
                  email: widget.email,
                ),
              ),
            );
            // showDialog(
            //   context: context,
            //   builder: (context) {
            //     return Container(
            //       height: 100,
            //       width: 100,
            //       child: Column(
            //         children: [
            //           Center(
            //             child: Text("Payment Success"),
            //           ),
            //           ElevatedButton(
            //             onPressed: () {
            //               Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                   builder: (context) => Home(
            //                     email: widget.email,
            //                   ),
            //                 ),
            //               );
            //             },
            //             child: Center(
            //               child: Text("New Trip"),
            //             ),
            //           )
            //         ],
            //       ),
            //     );
            //   },
            //   barrierDismissible: false,
            // );
          } else if (state is ConfirmationPaymentFailed) {
            final successState = state as ConfirmationPaymentSuccess;
            showDialog(
              context: context,
              builder: (context) {
                return Container(
                  height: 100,
                  width: 100,
                  child: Column(
                    children: [
                      Center(
                        child: Text("Payment Failed"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Center(
                          child: Text("New Trip"),
                        ),
                      )
                    ],
                  ),
                );
              },
              barrierDismissible: false,
            );
          }
        },
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
                  ElevatedButton(
                    onPressed: () {
                      confirmationBloc.add(
                          ConfirmationConfirmPaymentEvent(email: widget.email));
                    },
                    child: Center(
                      child: Text("Confirm Payment"),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      confirmationBloc.add(
                          ConfirmationCancelPaymentEvent(email: widget.email));
                    },
                    child: Center(
                      child: Text("Cancel Payment"),
                    ),
                  ),
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
