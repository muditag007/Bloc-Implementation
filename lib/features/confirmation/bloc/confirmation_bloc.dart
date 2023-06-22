// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'confirmation_event.dart';
part 'confirmation_state.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  ConfirmationBloc() : super(ConfirmationInitial()) {
    on<ConfirmationInitialEvent>(confirmationInitialEvent);
    on<ConfirmationPaymentEvent>(confirmationPaymentEvent);
    on<ConfirmationCancelPaymentEvent>(confirmationCancelPaymentEvent);
  }

  Future<FutureOr<void>> confirmationInitialEvent(
      ConfirmationInitialEvent event, Emitter<ConfirmationState> emit) async {
    emit(ConfirmationInitialState());
    String autoEmail = '';
    int otp = 111111;
    String autoName = '';
    String autoNumber = '';
    String phoneNumber = '';
    String photoUrl = '';
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await _firestore.collection('confirm_requests').get();
    final docsId = snapshot.docs.map((doc) => doc.id).toList();
    print(docsId);
    final allData = snapshot.docs.map((doc) => doc.data()).toList();
    print(allData);
    for (int i = 0; i < allData.length; i++) {
      Map temp = allData[i] as Map<String, dynamic>;
      if (temp['vit_email'] == event.user!.email) {
        autoEmail = temp['auto_email'];
        otp = temp['otp'];
        break;
      }
    }

    QuerySnapshot snapshotAuto = await _firestore.collection('auto').get();
    final docsIdAuto = snapshotAuto.docs.map((doc) => doc.id).toList();
    print(docsIdAuto);
    final allDataAuto = snapshotAuto.docs.map((doc) => doc.data()).toList();
    print(allDataAuto);
    for (int i = 0; i < allDataAuto.length; i++) {
      Map temp = allDataAuto[i] as Map<String, dynamic>;
      if (temp['email'] == autoEmail) {
        autoName = temp['name'];
        autoNumber = temp['autoNum'];
        photoUrl = temp['photoUrl'];
        phoneNumber = temp['phoneNum'];
        break;
      }
    }
    emit(ConfirmationSuccessState(
        autoName: autoName,
        autoNum: autoNumber,
        autoPhone: phoneNumber,
        autoPhoto: photoUrl,
        otp: otp));
  }

  FutureOr<void> confirmationPaymentEvent(
      ConfirmationPaymentEvent event, Emitter<ConfirmationState> emit) {}

  FutureOr<void> confirmationCancelPaymentEvent(
      ConfirmationCancelPaymentEvent event, Emitter<ConfirmationState> emit) {}
}
