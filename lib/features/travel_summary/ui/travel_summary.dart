// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/constants.dart';
import 'package:test_app/features/confirmation/ui/confirmation.dart';
import 'package:test_app/features/travel_summary/bloc/travel_summary_bloc.dart';

import '../../home/ui/home.dart';

class TravelSummary extends StatefulWidget {
  const TravelSummary({super.key, required this.email});
  final String? email;

  @override
  State<TravelSummary> createState() => _TravelSummaryState();
}

class _TravelSummaryState extends State<TravelSummary> {
  final TravelSummaryBloc travelSummaryBloc = TravelSummaryBloc();

  @override
  void initState() {
    travelSummaryBloc.add(TravelSummaryInitialEvent(email: widget.email));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TravelSummaryBloc, TravelSummaryState>(
        bloc: travelSummaryBloc,
        listenWhen: (previous, current) => current is TravelSummaryActionState,
        buildWhen: (previous, current) => current is! TravelSummaryActionState,
        listener: (context, state) async {
          if (state is TravelSummaryLoadingState) {
            await showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) => AlertDialog(
                content: Container(
                  height: 100,
                  width: 100,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            );
          } else if (state is TravelSummaryConfirmState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Confirmation(
                  email: widget.email,
                ),
              ),
            );
          } else if (state is TravelSummaryCancelState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(
                  email: widget.email,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case TravelSummaryInitialState:
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case TravelSummarySuccessState:
              final successState = state as TravelSummarySuccessState;
              double height = (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top) /
                  844;
              double width = MediaQuery.of(context).size.width / 390;
              return Scaffold(
                body: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: 20 * width,
                    right: 20 * width,
                    bottom: 33 * height,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30 * height,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Travel Summary",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35 * height,
                      ),
                      Container(
                        height: 182 * height,
                        width: 350 * width,
                        decoration: BoxDecoration(
                          color: kGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 15 * height,
                            horizontal: 20 * width,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pick Up Point",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: kGreyText,
                                ),
                              ),
                              SizedBox(
                                height: 4 * height,
                              ),
                              Text(
                                successState.start,
                                style: GoogleFonts.poppins(
                                  color: kBlackText,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 17 * height,
                              ),
                              Divider(
                                color: kDivider,
                              ),
                              SizedBox(
                                height: 17 * height,
                              ),
                              Text(
                                "Drop Down Point",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: kGreyText,
                                ),
                              ),
                              SizedBox(
                                height: 4 * height,
                              ),
                              Text(
                                successState.end,
                                style: GoogleFonts.poppins(
                                  color: kBlackText,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15 * height,
                      ),
                      Container(
                        width: 350 * width,
                        height: 76 * height,
                        decoration: BoxDecoration(
                          color: kGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No of passengers",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: kGreyText,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 4 * height,
                            ),
                            Text(
                              successState.passengers.toString(),
                              style: GoogleFonts.poppins(
                                color: kBlackText,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 14 * height,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 168 * width,
                            height: 76 * height,
                            decoration: BoxDecoration(
                              color: kGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Fixed Fare",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: kGreyText,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 4 * height,
                                ),
                                Text(
                                  "₹ ${successState.fixedFare}",
                                  style: GoogleFonts.poppins(
                                    color: kBlackText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 168 * width,
                            height: 76 * height,
                            decoration: BoxDecoration(
                              color: kGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Special Fare",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: kGreyText,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 4 * height,
                                ),
                                Text(
                                  "₹ ${successState.spFare}",
                                  style: GoogleFonts.poppins(
                                    color: kBlackText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 13 * height,
                      ),
                      Container(
                        width: 350 * width,
                        height: 76 * height,
                        decoration: BoxDecoration(
                          color: kGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Service Charge(fixed+special)",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: kGreyText,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 4 * height,
                            ),
                            Text(
                              "₹ ${successState.serCharge}",
                              style: GoogleFonts.poppins(
                                color: kBlackText,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 11 * height,
                      ),
                      Container(
                        width: 350 * width,
                        height: 76 * height,
                        decoration: BoxDecoration(
                          color: kGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total Fare",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: kGreyText,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 4 * height,
                            ),
                            Text(
                              "₹ ${successState.total}",
                              style: GoogleFonts.poppins(
                                color: kBlackText,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      InkWell(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          travelSummaryBloc.add(
                            TravelSummaryConfirmClickedEvent(
                              docId: successState.docId,
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
                              "Confirm booking",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 7 * height,
                      ),
                      InkWell(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          travelSummaryBloc.add(
                            TravelSummaryCancelClickedEvent(
                              docId: successState.docId,
                            ),
                          );
                        },
                        child: Container(
                          width: 303 * width,
                          height: 48 * height,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: kYellow,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              "Cancel booking",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.black,
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
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
