// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'confirmation_event.dart';
part 'confirmation_state.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  ConfirmationBloc() : super(ConfirmationInitial()) {
    on<ConfirmationInitialEvent>(confirmationInitialEvent);
    on<ConfirmationPaymentEvent>(confirmationPaymentEvent);
    on<ConfirmationCancelPaymentEvent>(confirmationCancelPaymentEvent);
  }

  FutureOr<void> confirmationInitialEvent(
      ConfirmationInitialEvent event, Emitter<ConfirmationState> emit) {
    emit(ConfirmationInitialState());
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  }

  FutureOr<void> confirmationPaymentEvent(
      ConfirmationPaymentEvent event, Emitter<ConfirmationState> emit) {}

  FutureOr<void> confirmationCancelPaymentEvent(
      ConfirmationCancelPaymentEvent event, Emitter<ConfirmationState> emit) {}
}
