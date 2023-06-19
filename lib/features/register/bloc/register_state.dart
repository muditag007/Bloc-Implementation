part of 'register_bloc.dart';

abstract class RegisterState {}

abstract class RegisterActionState extends RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterDoneState extends RegisterActionState {}

class RegisterTryingState extends RegisterState {}

class RegisterNavigateHomeState extends RegisterActionState {
  final User? user;

  RegisterNavigateHomeState({required this.user});
}
