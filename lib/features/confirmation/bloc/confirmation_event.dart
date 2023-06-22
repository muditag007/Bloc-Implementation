part of 'confirmation_bloc.dart';

abstract class ConfirmationEvent {}

class ConfirmationInitialEvent extends ConfirmationEvent {}

class ConfirmationPaymentEvent extends ConfirmationEvent {}

class ConfirmationCancelPaymentEvent extends ConfirmationEvent {}
