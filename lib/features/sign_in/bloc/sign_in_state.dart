part of 'sign_in_bloc.dart';

@immutable
abstract class SignInState {}

abstract class SignInActionState extends SignInState {}

class SignInInitialState extends SignInState {}

class SignInSuccessState extends SignInState {}

class SignInDoneState extends SignInState {}

class SignInFailedState extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInNavigateHomeState extends SignInActionState {
  final User? user;
  SignInNavigateHomeState({required this.user});
}
