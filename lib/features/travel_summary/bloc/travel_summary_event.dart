part of 'travel_summary_bloc.dart';

abstract class TravelSummaryEvent {}

class TravelSummaryInitialEvent extends TravelSummaryEvent {
  final String? email;

  TravelSummaryInitialEvent({required this.email});
}

class TravelSummaryCancelClickedEvent extends TravelSummaryEvent {
  final String docId;

  TravelSummaryCancelClickedEvent({required this.docId});
}

class TravelSummaryConfirmClickedEvent extends TravelSummaryEvent {
  final String docId;

  TravelSummaryConfirmClickedEvent({required this.docId});
}
