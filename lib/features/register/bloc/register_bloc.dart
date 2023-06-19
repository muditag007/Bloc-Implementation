// ignore_for_file: depend_on_referenced_packages, no_leading_underscores_for_local_identifiers, unused_local_variable, unused_import, prefer_const_constructors

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_app/features/register/models/user_model.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterInitialEvent>(registerInitialEvent);
    on<RegisterClickedEvent>(registerClickedEvent);
  }

  FutureOr<void> registerInitialEvent(
      RegisterInitialEvent event, Emitter<RegisterState> emit) {
    emit(RegisterInitialState());
    emit(RegisterSuccessState());
  }

  Future<FutureOr<void>> registerClickedEvent(
      RegisterClickedEvent event, Emitter<RegisterState> emit) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    emit(RegisterTryingState());
    await _firestore.collection('users_register').add({
      'firstName': event.userDetails.firstName,
      'lastName': event.userDetails.lastName,
      'regNo': event.userDetails.regNo,
      'phoneNumber': event.userDetails.phoneNumber,
      'email': event.userDetails.email,
    });
    emit(RegisterDoneState());
    await Future.delayed(Duration(seconds: 2));
    emit(RegisterNavigateHomeState(user: event.user));
  }
}
