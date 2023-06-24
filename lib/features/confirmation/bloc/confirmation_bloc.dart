// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, avoid_print

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'confirmation_event.dart';
part 'confirmation_state.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  ConfirmationBloc() : super(ConfirmationInitial()) {
    on<ConfirmationInitialEvent>(confirmationInitialEvent);
    on<ConfirmationConfirmPaymentEvent>(confirmationConfirmPaymentEvent);
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
      if (temp['vit_email'] == event.email) {
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

  // void handlePaymentErrorResponse(PaymentFailureResponse response) {
  //   showAlertDialog(context, "Payment Failed",
  //       "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  // }

  // void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
  //   showAlertDialog(
  //       context, "Payment Successful", "Payment ID: ${response.paymentId}");
  // }

  Future<FutureOr<void>> confirmationConfirmPaymentEvent(
      ConfirmationConfirmPaymentEvent event,
      Emitter<ConfirmationState> emit) async {
    // emit(ConfirmationInitialState());
    // String docId;
    // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    // QuerySnapshot snapshot =
    //     await _firestore.collection('confirm_requests').get();
    // final docsId = snapshot.docs.map((doc) => doc.id).toList();
    // print(docsId);
    // final allData = snapshot.docs.map((doc) => doc.data()).toList();
    // print(allData);
    // for (int i = 0; i < allData.length; i++) {
    //   Map temp = allData[i] as Map<String, dynamic>;
    //   if (temp['vit_email'] == event.email) {
    //     docId = docsId[i].toString();
    //     break;
    //   }
    // }
    Razorpay razorpay = Razorpay();
    var options = {
      'key': 'rzp_test_LdysacQfV16qbb',
      'amount': 100,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    razorpay.open(options);
    bool paymentDone = false;
    late PaymentSuccessResponse resSuccess;
    late PaymentFailureResponse resFailed;
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) {
      resFailed = response;
      // emit(ConfirmationPaymentFailed(response: response));
    });
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
      print("Payment Confirmed");
      paymentDone = true;
      resSuccess = response;
    });
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, () {});
    print("Payment Done Variable value:$paymentDone");
    if (paymentDone) {
      emit(ConfirmationPaymentSuccess(response: resSuccess));
    } else {
      emit(ConfirmationPaymentFailed(response: resFailed));
    }
  }

  Future<FutureOr<void>> confirmationCancelPaymentEvent(
      ConfirmationCancelPaymentEvent event,
      Emitter<ConfirmationState> emit) async {
    emit(ConfirmationInitialState());
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await _firestore.collection('confirm_requests').get();
    final docsId = snapshot.docs.map((doc) => doc.id).toList();
    print(docsId);
    final allData = snapshot.docs.map((doc) => doc.data()).toList();
    print(allData);
    for (int i = 0; i < allData.length; i++) {
      Map temp = allData[i] as Map<String, dynamic>;
      if (temp['vit_email'] == event.email) {
        _firestore.collection('confirm_requests').doc(docsId[i]).delete();
        break;
      }
    }
    emit(ConfirmationCancelPaymentState());
  }
}
