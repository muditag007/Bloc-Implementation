part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeClickedEvent extends HomeEvent {
  final String start;
  final String end;
  final int passengers;
  final User? user;

  HomeClickedEvent(
      {required this.user,
      required this.start,
      required this.end,
      required this.passengers});
}



class HomeAcceptedEvent extends HomeEvent {
  final User? user;

  HomeAcceptedEvent({required this.user});


}
