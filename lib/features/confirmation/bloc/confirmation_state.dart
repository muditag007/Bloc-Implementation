part of 'confirmation_bloc.dart';

abstract class ConfirmationState {}

abstract class ConfirmationActionState extends ConfirmationState {}

class ConfirmationInitial extends ConfirmationState {}

class ConfirmationSuccessState extends ConfirmationState {}

class ConfirmationInitialState extends ConfirmationState {}

class ConfirmationNavigatePaymentGatewayState extends ConfirmationActionState {}

class ConfirmationCancelPaymentState extends ConfirmationActionState {}
