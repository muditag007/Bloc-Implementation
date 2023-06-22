part of 'travel_summary_bloc.dart';

abstract class TravelSummaryState {}

abstract class TravelSummaryActionState extends TravelSummaryState {}

class TravelSummaryInitial extends TravelSummaryState {}

class TravelSummaryInitialState extends TravelSummaryState {}

class TravelSummarySuccessState extends TravelSummaryState {
  final String start;
  final String end;
  final String passengers;
  final double spFare;
  final double fixedFare;
  final double serCharge;
  final double total;
  final String docId;

  TravelSummarySuccessState({
    required this.docId,
    required this.start,
    required this.end,
    required this.passengers,
    required this.spFare,
    required this.fixedFare,
    required this.serCharge,
    required this.total,
  });
}

class TravelSummaryLoadingState extends TravelSummaryActionState {}

class TravelSummaryConfirmState extends TravelSummaryActionState {}

class TravelSummaryCancelState extends TravelSummaryActionState {}
