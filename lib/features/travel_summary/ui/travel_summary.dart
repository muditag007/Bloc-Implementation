// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/confirmation/ui/confirmation.dart';
import 'package:test_app/features/travel_summary/bloc/travel_summary_bloc.dart';

import '../../home/ui/home.dart';

class TravelSummary extends StatefulWidget {
  const TravelSummary({super.key, required this.user});
  final User? user;

  @override
  State<TravelSummary> createState() => _TravelSummaryState();
}

class _TravelSummaryState extends State<TravelSummary> {
  final TravelSummaryBloc travelSummaryBloc = TravelSummaryBloc();

  @override
  void initState() {
    travelSummaryBloc.add(TravelSummaryInitialEvent(user: widget.user));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TravelSummaryBloc, TravelSummaryState>(
        bloc: travelSummaryBloc,
        listenWhen: (previous, current) => current is TravelSummaryActionState,
        buildWhen: (previous, current) => current is! TravelSummaryActionState,
        listener: (context, state) async {
          if (state is TravelSummaryLoadingState) {
            await showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) => AlertDialog(
                content: Container(
                  height: 100,
                  width: 100,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            );
          } else if (state is TravelSummaryConfirmState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Confirmation(
                  user: widget.user,
                ),
              ),
            );
          }else if(state is TravelSummaryCancelState){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(
                  user: widget.user,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case TravelSummaryInitialState:
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case TravelSummarySuccessState:
              final successState = state as TravelSummarySuccessState;
              return Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(successState.start),
                    Text(successState.end),
                    Text(successState.passengers.toString()),
                    Text(successState.spFare.toString()),
                    Text(successState.fixedFare.toString()),
                    Text(successState.serCharge.toString()),
                    Text(successState.total.toString()),
                    SizedBox(
                      height: 50,
                    ),ElevatedButton(
                      onPressed: () {
                        travelSummaryBloc
                            .add(TravelSummaryConfirmClickedEvent(docId: successState.docId));
                      },
                      child: Center(
                        child: Text("Confirm"),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        travelSummaryBloc
                            .add(TravelSummaryCancelClickedEvent(docId:successState.docId));
                      },
                      child: Center(
                        child: Text("Cancel"),
                      ),
                    )
                  ],
                ),
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
