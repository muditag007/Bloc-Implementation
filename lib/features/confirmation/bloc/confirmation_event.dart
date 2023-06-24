part of 'confirmation_bloc.dart';

abstract class ConfirmationEvent {}

class ConfirmationInitialEvent extends ConfirmationEvent {
  final String? email;

  ConfirmationInitialEvent({required this.email});
}

class ConfirmationConfirmPaymentEvent extends ConfirmationEvent {
  final String? email;

  ConfirmationConfirmPaymentEvent({required this.email});
}

class ConfirmationCancelPaymentEvent extends ConfirmationEvent {
  final String? email;

  ConfirmationCancelPaymentEvent({required this.email});
}
