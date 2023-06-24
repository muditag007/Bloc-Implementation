part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeSuccessState extends HomeState {
  final List places;

  HomeSuccessState({required this.places});
}

class HomeInitialState extends HomeState {}

class HomeTryingState extends HomeState {}

class HomeDoneState extends HomeState {}

// class HomeWaitingConfirmationState extends HomeActionState {
//   // final Stream snapshots;
//   final String docId;

//   HomeWaitingConfirmationState({required this.docId});
// }

class HomeWaitingConfirmationState extends HomeActionState {
  final Stream snapshots;

  HomeWaitingConfirmationState({required this.snapshots});
}

class HomeNavigateSummary extends HomeActionState {
  final String? email;

  HomeNavigateSummary({required this.email});
}
