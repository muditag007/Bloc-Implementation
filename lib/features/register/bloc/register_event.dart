part of 'register_bloc.dart';

abstract class RegisterEvent {}

class RegisterInitialEvent extends RegisterEvent {}

class RegisterClickedEvent extends RegisterEvent {
  final UserModel userDetails;
  final String? email;

  RegisterClickedEvent({required this.email, required this.userDetails});
}
