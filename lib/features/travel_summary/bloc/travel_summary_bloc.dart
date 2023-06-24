// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, avoid_print, prefer_const_constructors

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

part 'travel_summary_event.dart';
part 'travel_summary_state.dart';

class TravelSummaryBloc extends Bloc<TravelSummaryEvent, TravelSummaryState> {
  TravelSummaryBloc() : super(TravelSummaryInitial()) {
    on<TravelSummaryInitialEvent>(travelSummaryInitialEvent);
    on<TravelSummaryConfirmClickedEvent>(travelSummaryConfirmClickedEvent);
    on<TravelSummaryCancelClickedEvent>(travelSummaryCancelClickedEvent);
  }

  Future<FutureOr<void>> travelSummaryInitialEvent(
      TravelSummaryInitialEvent event, Emitter<TravelSummaryState> emit) async {
    emit(TravelSummaryInitialState());
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await _firestore.collection('confirm_requests').get();
    final docsId = snapshot.docs.map((doc) => doc.id).toList();
    print(docsId);
    final allData = snapshot.docs.map((doc) => doc.data()).toList();
    print(allData);
    for (int i = 0; i < allData.length; i++) {
      Map temp = (allData[i]) as Map<String, dynamic>;
      if (temp['vit_email'] == event.email) {
        double serCharge = (temp['fare'] + temp['fare']) * 0.03;
        double total = temp['fare'] + temp['fare'] + serCharge;
        emit(
          TravelSummarySuccessState(
            start: temp['start'],
            end: temp['end'],
            passengers: temp['passengers'].toString(),
            spFare: double.parse(temp['fare'].toString()),
            fixedFare: double.parse(temp['fare'].toString()),
            serCharge: serCharge,
            total: total,
            docId: docsId[i].toString(),
          ),
        );
        break;
      }
    }
  }

  Future<FutureOr<void>> travelSummaryConfirmClickedEvent(
      TravelSummaryConfirmClickedEvent event,
      Emitter<TravelSummaryState> emit) async {
    emit(TravelSummaryLoadingState());
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore.collection('confirm_requests').doc(event.docId).update({
      'otp': 123456,
    });
    emit(TravelSummaryConfirmState());
  }

  Future<FutureOr<void>> travelSummaryCancelClickedEvent(
      TravelSummaryCancelClickedEvent event,
      Emitter<TravelSummaryState> emit) async {
    emit(TravelSummaryCancelState());
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore.collection('confirm_requests').doc(event.docId).delete();
    emit(TravelSummaryCancelState());
  }
}
