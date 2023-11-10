import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:dedal/core/pages/filters/filters_screen.dart';
import 'package:dedal/core/pages/home/home_screen.dart';
import 'package:dedal/core/pages/locations/location_screen.dart';
import 'package:dedal/core/pages/profil/profil_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBar extends StatefulWidget {
  const NavBar({required this.currentIndex, super.key});

  final int currentIndex;
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 16,
              spreadRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            color: Colors.white,
            notchMargin: 6,
            elevation: 0,
            child: BottomNavigationBar(
              currentIndex: widget.currentIndex,
              onTap: (index) async {
                switch (index) {
                  case 0:
                    context.goNamed(FilterScreen.name);
                    break;
                  case 1:
                    context.goNamed(HomeScreen.name);
                    break;
                  case 2:
                    context.goNamed(LocationScreen.name);
                    break;
                  case _:
                    context.goNamed(ProfilScreen.name);
                    break;
                }
              },
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor.withAlpha(0),
              selectedItemColor: Colors.black,
              unselectedItemColor: const Color.fromRGBO(100, 116, 139, 1),
              showUnselectedLabels: true,
              showSelectedLabels: true,
              iconSize: 21,
              selectedFontSize: 12,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.filter_alt_outlined,
                      color: widget.currentIndex == 0
                          ? SharedColorPalette().main2
                          : SharedColorPalette().mainDisable2,
                    ),
                  ),
                  label: context.l18n!.navBarFilter.capitalize(),
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.map,
                      color: widget.currentIndex == 1
                          ? SharedColorPalette().main2
                          : SharedColorPalette().mainDisable2,
                    ),
                  ),
                  label: context.l18n!.navBarHome.capitalize(),
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.list,
                      color: widget.currentIndex == 2
                          ? SharedColorPalette().main2
                          : SharedColorPalette().mainDisable2,
                    ),
                  ),
                  label: context.l18n!.navBarLocation.capitalize(),
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.person,
                      color: widget.currentIndex == 3
                          ? SharedColorPalette().main2
                          : SharedColorPalette().mainDisable2,
                    ),
                  ),
                  label: context.l18n!.navBarProfil.capitalize(),
                ),
              ],
            ),
          ),
        ),
      );
}
