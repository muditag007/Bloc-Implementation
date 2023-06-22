// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_cast, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/home/bloc/home_bloc.dart';
import 'package:test_app/features/travel_summary/ui/travel_summary.dart';

class Home extends StatefulWidget {
  final User? user;
  const Home({super.key, required this.user});

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
                user: successState.user,
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
                        homeBloc.add(HomeAcceptedEvent(user: widget.user));
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
            return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      width: constraints
                          .maxWidth, // Use the maximum available width
                      height: constraints
                          .maxHeight, // Use the maximum available height
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 37, top: 60),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Hi !',
                                style: const TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 37,
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Welcome !',
                                style: const TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          const SizedBox(height: 78),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 37,
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Where would you like to  go today?',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 300,
                            width: 350,
                            decoration: BoxDecoration(
                                color: const Color(0xFFF6F6F6),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: DropdownButtonFormField<String>(
                                      value: selectedStart,
                                      icon: Image.asset(
                                          'assets/images/dropdown.png'),
                                      decoration: InputDecoration(
                                        prefixIcon: Image.asset(
                                            'assets/images/Oval.png'), // Icon on the left
                                        hintText:
                                            'Choose your Pick up point', // Hint text in the center
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 16),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        //suffixIcon: Icon(Icons.arrow_drop_down), // Dropdown icon on the right
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedStart =
                                              newValue; // Update the selected option
                                        });
                                      },
                                      items: <String>[
                                        // 'Option 1',
                                        // 'Option 2',
                                        // 'Option 3',
                                        ...places
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList()),
                                ),
                                const Divider(
                                  // Add a horizontal line
                                  color: Colors.grey,
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: DropdownButtonFormField<String>(
                                      value: selectedEnd,
                                      icon: Image.asset(
                                          'assets/images/dropdown.png'),
                                      decoration: InputDecoration(
                                        prefixIcon: Image.asset(
                                            'assets/images/flag.png'), // Icon on the left
                                        hintText:
                                            'Choose your drop point', // Hint text in the center
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 16),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        //suffixIcon: Icon(Icons.arrow_drop_down), // Dropdown icon on the right
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedEnd =
                                              newValue; // Update the selected option
                                        });
                                      },
                                      items: <String>[
                                        ...places,
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList()),
                                ),
                                const Divider(
                                  // Add a horizontal line
                                  color: Colors.grey,
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: DropdownButtonFormField<String>(
                                      value: selectedPassengers,
                                      icon: Image.asset(
                                          'assets/images/dropdown.png'),
                                      decoration: InputDecoration(
                                        prefixIcon: Image.asset(
                                            'assets/images/passenger.png'), // Icon on the left
                                        hintText:
                                            'Number of Passengers', // Hint text in the center
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 16),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        //suffixIcon: Icon(Icons.arrow_drop_down), // Dropdown icon on the right
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedPassengers =
                                              newValue; // Update the selected option
                                        });
                                      },
                                      items: <String>[
                                        '1',
                                        '2',
                                        '3',
                                        '4',
                                        '5',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList()),
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                          Expanded(child: Container()),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                print(selectedPassengers);
                                homeBloc.add(
                                  HomeClickedEvent(
                                    start: selectedStart.toString(),
                                    end: selectedEnd.toString(),
                                    passengers: int.parse(
                                        selectedPassengers.toString()),
                                    user: widget.user,
                                  ),
                                );
                              },
                              child: Text("Book Now"),
                            ),
                          ),

                          // InkWell(
                          //   onTap: () {},
                          //   child: Container(
                          //     padding: const EdgeInsets.only(top: 10, bottom: 10),
                          //     margin: const EdgeInsets.only(left: 30, right: 30),
                          //     decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(30)),
                          //     child: Center(
                          //       child: Text(
                          //         "Book Now",
                          //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    );
                  },
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
