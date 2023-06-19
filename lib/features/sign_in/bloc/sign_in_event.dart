part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

class SignInInitialEvent extends SignInEvent {}

class SignInClickedEvent extends SignInEvent {}
