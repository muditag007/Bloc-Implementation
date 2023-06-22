part of 'confirmation_bloc.dart';

abstract class ConfirmationEvent {}

class ConfirmationInitialEvent extends ConfirmationEvent {
  final User? user;

  ConfirmationInitialEvent({required this.user});
}

class ConfirmationPaymentEvent extends ConfirmationEvent {}

class ConfirmationCancelPaymentEvent extends ConfirmationEvent {}
