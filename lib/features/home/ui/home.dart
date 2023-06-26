// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_cast, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/constants.dart';
import 'package:test_app/features/home/bloc/home_bloc.dart';
import 'package:test_app/features/travel_summary/ui/travel_summary.dart';

class Home extends StatefulWidget {
  final String? email;
  const Home({super.key, required this.email});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();
  String? selectedStart;
  String? selectedEnd;
  String? selectedPassengers;

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateSummary) {
          final successState = state as HomeNavigateSummary;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TravelSummary(
                email: successState.email,
              ),
            ),
          );
        } else if (state is HomeWaitingConfirmationState) {
          final succcessState = state as HomeWaitingConfirmationState;
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Container(
                height: 200,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: StreamBuilder(
                  stream: succcessState.snapshots,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data['confirm']);
                      if (snapshot.data['confirm']) {
                        homeBloc.add(HomeAcceptedEvent(email: widget.email));
                        return SizedBox();
                      }
                      return Center(
                        child: Text(
                          "Waiting for Auto Wala to confirm",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeInitialState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeSuccessState:
            final successStateValues = state as HomeSuccessState;
            final List<dynamic> places = successStateValues.places;
            double height = (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top) /
                844;
            double width = MediaQuery.of(context).size.width / 390;
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                  left: 37 * width,
                  right: 37 * width,
                  bottom: 33 * height,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 51 * height,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Hi !\nWelcome !",
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 78 * height,
                    ),
                    Text(
                      "Where would you like to go today?",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: kBlackText,
                      ),
                    ),
                    SizedBox(
                      height: 36 * height,
                    ),
                    Container(
                      width: 350 * width,
                      decoration: BoxDecoration(
                        color: kGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24 * width,
                          vertical: 23 * height,
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 48 * height,
                              width: 303 * width,
                              child: DropdownButtonFormField<String>(
                                value: selectedStart,
                                icon: Image.asset('assets/images/dropdown.png'),
                                decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                    'assets/images/Oval.png',
                                  ),
                                  hintText: 'Choose your pick up point',
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 16,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color.fromRGBO(237, 237, 237, 1),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color.fromRGBO(237, 237, 237, 1),
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color.fromRGBO(237, 237, 237, 1),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color.fromRGBO(237, 237, 237, 1),
                                    ),
                                  ),
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedStart = newValue;
                                  });
                                },
                                items: <String>[
                                  // 'Option 1',
                                  // 'Option 2',
                                  // 'Option 3',
                                  ...places,
                                ].map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                            SizedBox(
                              height: 18 * height,
                            ),
                            Divider(
                              color: kDivider,
                            ),
                            SizedBox(
                              height: 18 * height,
                            ),
                            Container(
                              height: 48 * height,
                              width: 303 * width,
                              child: DropdownButtonFormField<String>(
                                value: selectedEnd,
                                icon: Image.asset('assets/images/dropdown.png'),
                                decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                    'assets/images/flag.png',
                                  ),
                                  hintText: 'Choose your drop point',
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 16,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color.fromRGBO(237, 237, 237, 1),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color.fromRGBO(237, 237, 237, 1),
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color.fromRGBO(237, 237, 237, 1),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color.fromRGBO(237, 237, 237, 1),
                                    ),
                                  ),
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedEnd = newValue;
                                  });
                                },
                                items: <String>[
                                  // 'Option 1',
                                  // 'Option 2',
                                  // 'Option 3',
                                  ...places,
                                ].map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                            SizedBox(
                              height: 18 * height,
                            ),
                            Divider(
                              color: kDivider,
                            ),
                            SizedBox(
                              height: 18 * height,
                            ),
                            Container(
                              height: 48 * height,
                              width: 303 * width,
                              child: DropdownButtonFormField<String>(
                                value: selectedPassengers,
                                icon: Image.asset('assets/images/dropdown.png'),
                                decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                    'assets/images/passenger.png',
                                  ),
                                  hintText: 'Number of passengers',
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 16,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color.fromRGBO(237, 237, 237, 1),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color.fromRGBO(237, 237, 237, 1),
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color.fromRGBO(237, 237, 237, 1),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color.fromRGBO(237, 237, 237, 1),
                                    ),
                                  ),
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedPassengers = newValue;
                                  });
                                },
                                items: <String>[
                                  '1',
                                  '2',
                                  '3',
                                  '4',
                                  '5',
                                  '6',
                                ].map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    InkWell(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        homeBloc.add(
                          HomeClickedEvent(
                            email: widget.email,
                            start: selectedStart.toString(),
                            end: selectedEnd.toString(),
                            passengers: int.parse(
                              selectedPassengers.toString(),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 303 * width,
                        height: 48 * height,
                        decoration: BoxDecoration(
                          color: kYellow,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "Book now ",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: kBlackText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          // case HomeWaitingConfirmationState:
          //   return Scaffold(
          //     body: Center(
          //       child: Text(
          //         "Waiting for confirmation",
          //       ),
          //     ),
          //   );
          case HomeTryingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          default:
            return Scaffold(
              body: Center(
                child: Text("Failed"),
              ),
            );
        }
      },
    );
  }
}
