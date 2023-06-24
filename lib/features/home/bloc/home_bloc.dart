// ignore_for_file: avoid_print, unused_local_variable, prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeClickedEvent>(homeClickedEvent);
    on<HomeAcceptedEvent>(homeAcceptedEvent);
  }

  Future<FutureOr<void>> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeInitial());
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await _firestore.collection('places').get();
    final allData = snapshot.docs.map((doc) => doc.data()).toList();
    print(allData);
    List<String> place = [];
    for (int i = 0; i < allData.length; i++) {
      Map temp = (allData[i]) as Map<String, dynamic>;
      // print(temp['name']);
      place.add(temp['name'].toString());
    }
    emit(HomeSuccessState(places: place));
  }

  Future<FutureOr<void>> homeClickedEvent(
      HomeClickedEvent event, Emitter<HomeState> emit) async {
    emit(HomeTryingState());
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var newDoc = await _firestore.collection('confirm_requests').add({
      'vit_email': event.email,
      'auto_email': null,
      'otp': null,
      'start': event.start,
      'end': event.end,
      'passengers': event.passengers,
      'fare': null,
      'confirm': false,
    });
    Stream snapshots =
        _firestore.collection('confirm_requests').doc(newDoc.id).snapshots();
    emit(HomeWaitingConfirmationState(snapshots: snapshots));
    // emit(HomeWaitingConfirmationState(docId: newDoc.id));
  }

  FutureOr<void> homeAcceptedEvent(
      HomeAcceptedEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateSummary(email: event.email));
  }
}
