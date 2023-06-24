part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeClickedEvent extends HomeEvent {
  final String start;
  final String end;
  final int passengers;
  final String? email;

  HomeClickedEvent(
      {required this.email,
      required this.start,
      required this.end,
      required this.passengers});
}



class HomeAcceptedEvent extends HomeEvent {
  final String? email;

  HomeAcceptedEvent({required this.email});


}
