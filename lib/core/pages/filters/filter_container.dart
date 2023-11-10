import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/models/filter.dart';
import 'package:flutter/material.dart';

class FilterContainer extends StatelessWidget {
  const FilterContainer({
    super.key,
    required this.filter,
    required this.onTap,
    required this.selected,
  });

  final Filter filter;
  final bool selected;
  final void Function(Filter filter) onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    switch (filter.name) {
                      'Art et culture' => 'assets/images/filters/art.jpg',
                      'Bar et brasserie' => 'assets/images/filters/bar.png',
                      'Divertissement' =>
                        'assets/images/filters/divertissement.jpg',
                      'Shopping' => 'assets/images/filters/shopping.jpg',
                      'Café' => 'assets/images/filters/cafe.png',
                      'Parc et espace vert' => 'assets/images/filters/parc.jpg',
                      'Histoire' => 'assets/images/filters/histoire_lille.jpg',
                      'Restaurant' => 'assets/images/filters/restaurant.png',
                      'Bien-être' => 'assets/images/filters/bien-etre.jpg',
                      'Enfant' => 'assets/images/filters/enfant.png',
                      _ => 'assets/images/filters/divertissement.jpg',
                    },
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                border: selected
                    ? Border.all(
                        width: 3,
                        color: SharedColorPalette().main,
                      )
                    : null,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(26),
              child: Text(
                filter.name ?? '',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
        onTap: () => onTap(filter),
      );
}
