// ignore_for_file: avoid_print

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeInitial());
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await _firestore.collection('users_register').get();
    print("hello");
    final allData = snapshot.docs.map((doc) => doc.data()).toList();
    print(allData);
    for (int i = 0; i < allData.length; i++) {
      Map temp = (allData[i]) as Map<String, dynamic>;
      print(temp['firstName']);
    }
    emit(HomeSuccessState());
  }
}
