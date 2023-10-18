import 'package:dedal/components/button/custom_button.dart';
import 'package:dedal/core/models/place.dart';
import 'package:flutter/material.dart';

class LocationPlaceDialog extends StatelessWidget {
  const LocationPlaceDialog({
    super.key,
    required this.place,
    required this.action,
    required this.text,
  });
  final Place place;
  final String text;
  final void Function(Place) action;

  @override
  Widget build(BuildContext context) => Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: AspectRatio(
          aspectRatio: 1.2,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  place.name ?? '',
                  textAlign: TextAlign.center,
                ),
                Text(
                  place.description ?? '',
                  textAlign: TextAlign.center,
                ),
                CustomStringButton(
                  context: context,
                  text: text,
                  onTap: (c) async => action.call(place),
                )
              ],
            ),
          ),
        ),
      );
}
