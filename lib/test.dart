// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:test_app/constants.dart';

class PlaceSearch extends StatefulWidget {
  const PlaceSearch({super.key});

  @override
  State<PlaceSearch> createState() => _PlaceSearchState();
}

class _PlaceSearchState extends State<PlaceSearch> {
  @override
  Widget build(BuildContext context) {
    return PlacePicker(
      apiKey: kGoogleApiKey,
      selectedPlaceWidgetBuilder:
          (_, selectedPlace, state, isSearchBarFocused) {
        return isSearchBarFocused
            ? Container()
            // Use FloatingCard or just create your own Widget.
            : FloatingCard(
                bottomPosition:
                    0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                leftPosition: 0.0,
                rightPosition: 0.0,
                width: 500,
                borderRadius: BorderRadius.circular(12.0),
                child: state == SearchingState.Searching
                    ? Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () {
                          print(selectedPlace!.formattedAddress);
                          print(selectedPlace!.addressComponents![0].longName);
                          
                          print("do something with [selectedPlace] data");
                        },
                        child: Text("Click Me!!!"),
                      ),
              );
      },
      initialPosition: LatLng(12.921470, 79.131561),
    );
  }
}
