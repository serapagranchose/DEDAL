import 'package:auto_size_text/auto_size_text.dart';
import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/extensions/string_extention.dart';
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
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(26),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: AutoSizeText(
                        switch (filter.name ?? '') {
                          'bar' => 'Bar et Brasserie',
                          'magasin' => 'Shopping',
                          'nature' => 'Parc et espace vert',
                          "soin" => 'Bien-être',
                          String() => (filter.name ?? '').capitalize(),
                        },
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: !selected
                              ? SharedColorPalette().mainDisable
                              : SharedColorPalette().main,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      switch (filter.name ?? '') {
                        'bar' => Icons.local_drink_sharp,
                        'art et culture' => Icons.museum,
                        'divertissement' => Icons.local_play_outlined,
                        'restaurant' => Icons.restaurant,
                        'café' => Icons.coffee,
                        'histoire' => Icons.history,
                        'enfant' => Icons.child_friendly_outlined,
                        'magasin' => Icons.shopping_bag_outlined,
                        'nature' => Icons.emoji_nature_outlined,
                        "soin" => Icons.face_2_outlined,
                        String() => Icons.abc,
                      },
                      size: 20,
                      color: !selected
                          ? SharedColorPalette().mainDisable.withOpacity(0.2)
                          : SharedColorPalette().main,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        onTap: () => onTap(filter),
      );
}
