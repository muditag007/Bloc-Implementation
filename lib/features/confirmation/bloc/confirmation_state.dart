part of 'confirmation_bloc.dart';

abstract class ConfirmationState {}

abstract class ConfirmationActionState extends ConfirmationState {}

class ConfirmationInitial extends ConfirmationState {}

class ConfirmationSuccessState extends ConfirmationState {
  final String autoName;
  final String autoNum;
  final String autoPhone;
  final String autoPhoto;
  final int otp;

  ConfirmationSuccessState({
    required this.autoName,
    required this.autoNum,
    required this.autoPhone,
    required this.autoPhoto,
    required this.otp,
  });
}

class ConfirmationInitialState extends ConfirmationState {}

class ConfirmationNavigatePaymentGatewayState extends ConfirmationActionState {}

class ConfirmationCancelPaymentState extends ConfirmationActionState {}
