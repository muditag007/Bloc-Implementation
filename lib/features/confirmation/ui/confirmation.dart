// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_cast

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/features/confirmation/bloc/confirmation_bloc.dart';
import 'package:test_app/features/home/ui/home.dart';

import '../../../constants.dart';

class Confirmation extends StatefulWidget {
  const Confirmation({super.key, required this.email});
  final String? email;
  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  final ConfirmationBloc confirmationBloc = ConfirmationBloc();

  @override
  void initState() {
    confirmationBloc.add(ConfirmationInitialEvent(email: widget.email));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ConfirmationBloc, ConfirmationState>(
        bloc: confirmationBloc,
        listenWhen: (previous, current) => current is ConfirmationActionState,
        buildWhen: (previous, current) => current is! ConfirmationActionState,
        listener: (context, state) {
          if (state is ConfirmationCancelPaymentState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(
                  email: widget.email,
                ),
              ),
            );
          } else if (state is ConfirmationNavigatePaymentGatewayState) {
          } else if (state is ConfirmationPaymentSuccess) {
            final successState = state as ConfirmationPaymentSuccess;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(
                  email: widget.email,
                ),
              ),
            );
            // showDialog(
            //   context: context,
            //   builder: (context) {
            //     return Container(
            //       height: 100,
            //       width: 100,
            //       child: Column(
            //         children: [
            //           Center(
            //             child: Text("Payment Success"),
            //           ),
            //           ElevatedButton(
            //             onPressed: () {
            //               Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                   builder: (context) => Home(
            //                     email: widget.email,
            //                   ),
            //                 ),
            //               );
            //             },
            //             child: Center(
            //               child: Text("New Trip"),
            //             ),
            //           )
            //         ],
            //       ),
            //     );
            //   },
            //   barrierDismissible: false,
            // );
          } else if (state is ConfirmationPaymentFailed) {
            final successState = state as ConfirmationPaymentSuccess;
            showDialog(
              context: context,
              builder: (context) {
                return Container(
                  height: 100,
                  width: 100,
                  child: Column(
                    children: [
                      Center(
                        child: Text("Payment Failed"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Center(
                          child: Text("New Trip"),
                        ),
                      )
                    ],
                  ),
                );
              },
              barrierDismissible: false,
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ConfirmationInitialState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConfirmationSuccessState:
              final successState = state as ConfirmationSuccessState;
              double height = (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top) /
                  844;
              double width = MediaQuery.of(context).size.width / 390;
              return Scaffold(
                body: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: 22 * width,
                    right: 22 * width,
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
                          "Confirmation",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 33 * height,
                      ),
                      Container(
                        width: 346 * width,
                        height: 146 * height,
                        decoration: BoxDecoration(
                          color: kGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 20 * height,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 80 * height,
                                width: 90 * width,
                                child: Image.asset(
                                  "assets/images/check_circle.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                "Booking Confirmed",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: kBlackText,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 21 * height,
                      ),
                      Divider(
                        color: kDivider,
                      ),
                      SizedBox(
                        height: 7 * height,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "OTP",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: kGreyText,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 44 * height,
                            width: 44 * height,
                            decoration: BoxDecoration(
                              color: kYellow,
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                successState.otp.toString()[0],
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: kBlackText,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3 * width,
                          ),
                          Container(
                            height: 44 * height,
                            width: 44 * height,
                            decoration: BoxDecoration(
                              color: kYellow,
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                successState.otp.toString()[1],
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: kBlackText,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3 * width,
                          ),
                          Container(
                            height: 44 * height,
                            width: 44 * height,
                            decoration: BoxDecoration(
                              color: kYellow,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                successState.otp.toString()[2],
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: kBlackText,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3 * width,
                          ),
                          Container(
                            height: 44 * height,
                            width: 44 * height,
                            decoration: BoxDecoration(
                              color: kYellow,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                successState.otp.toString()[3],
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: kBlackText,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3 * width,
                          ),
                          Container(
                            height: 44 * height,
                            width: 44 * height,
                            decoration: BoxDecoration(
                              color: kYellow,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                successState.otp.toString()[4],
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: kBlackText,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3 * width,
                          ),
                          Container(
                            height: 44 * height,
                            width: 44 * height,
                            decoration: BoxDecoration(
                              color: kYellow,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                successState.otp.toString()[5],
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: kBlackText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20 * height,
                      ),
                      Divider(
                        color: kDivider,
                      ),
                      SizedBox(
                        height: 10 * height,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Auto Information",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: kGreyText,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 7 * height,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          successState.autoPhoto,
                          height: 197 * height,
                          width: 350 * width,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 20 * height,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 76 * height,
                            width: 110 * width,
                            decoration: BoxDecoration(
                              color: kGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Auto Number",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: kGreyText,
                                  ),
                                ),
                                Text(
                                  successState.autoNum,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: kBlackText,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 76 * height,
                            width: 110 * width,
                            decoration: BoxDecoration(
                              color: kGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Driver Name",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: kGreyText,
                                  ),
                                ),
                                Text(
                                  successState.autoName,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: kBlackText,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 76 * height,
                            width: 110 * width,
                            decoration: BoxDecoration(
                              color: kGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Phone Number",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: kGreyText,
                                  ),
                                ),
                                Text(
                                  successState.autoPhone,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: kBlackText,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      InkWell(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          confirmationBloc.add(
                            ConfirmationConfirmPaymentEvent(
                              email: widget.email,
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
                              "Proceed to Payment",
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
                          confirmationBloc.add(
                            ConfirmationCancelPaymentEvent(
                              email: widget.email,
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
                              "Cancel Payment",
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
