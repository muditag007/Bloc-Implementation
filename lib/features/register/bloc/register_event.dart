part of 'register_bloc.dart';

abstract class RegisterEvent {}

class RegisterInitialEvent extends RegisterEvent {}

class RegisterClickedEvent extends RegisterEvent {
  final UserModel userDetails;
  final User? user;

  RegisterClickedEvent({required this.user, required this.userDetails});
}
