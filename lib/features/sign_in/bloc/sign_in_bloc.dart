// ignore_for_file: no_leading_underscores_for_local_identifiers, await_only_futures, unused_local_variable

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitialState()) {
    on<SignInInitialEvent>(signInInitialEvent);
    on<SignInClickedEvent>(signInClicked);
  }

  FutureOr<void> signInClicked(
      SignInClickedEvent event, Emitter<SignInState> emit) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? _user;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    emit(SignInDoneState());
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    await _auth.signInWithCredential(credential);
    _user = await _auth.currentUser;
    // print(_user!.email);
    // print(_user!.displayName);
    // emit(SignInNavigateHomeState());
    emit(SignInNavigateHomeState(user: _user));
  }

  FutureOr<void> signInInitialEvent(
      SignInInitialEvent event, Emitter<SignInState> emit) async {
    emit(SignInLoadingState());
    // await Future.delayed(const Duration(seconds: 3));
    emit(SignInSuccessState());
  }
}
