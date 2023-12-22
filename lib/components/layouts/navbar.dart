import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:dedal/core/extensions/tooltip.dart';
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
            color: SharedColorPalette().navBar(Theme.of(context)),
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
              iconSize: 16,
              selectedFontSize: 12,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: SharedColorPalette().navBar(Theme.of(context)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Icon(
                        Icons.filter_alt_outlined,
                        color: widget.currentIndex == 0
                            ? SharedColorPalette().primary
                            : SharedColorPalette().lightPrimary,
                      ),
                    ),
                  ).allowShowTooltip(context,
                      index: 1,
                      title: context.l18n!.navBarFilter.capitalize(),
                      display: true,
                      description:
                          'Ici, vous pouvez nous confier vos envie\nNous les changerons en parcours 100% adaté a vous !'),
                  label: context.l18n!.navBarFilter.capitalize(),
                ),
                BottomNavigationBarItem(
                  icon: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: SharedColorPalette().navBar(Theme.of(context)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Icon(
                        Icons.map,
                        color: widget.currentIndex == 1
                            ? SharedColorPalette().primary
                            : SharedColorPalette().lightPrimary,
                      ),
                    ),
                  ).allowShowTooltip(context,
                      index: 2,
                      title: context.l18n!.navBarHome.capitalize(),
                      display: true,
                      description:
                          'Ici vous pouvez consulter la carte, vos parcours et voir tout les lieux que vous pouvez visiter'),
                  label: context.l18n!.navBarHome.capitalize(),
                ),
                BottomNavigationBarItem(
                  icon: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: SharedColorPalette().navBar(Theme.of(context)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Icon(
                        Icons.list,
                        color: widget.currentIndex == 2
                            ? SharedColorPalette().primary
                            : SharedColorPalette().lightPrimary,
                      ),
                    ),
                  ).allowShowTooltip(context,
                      index: 3,
                      title: context.l18n!.navBarLocation.capitalize(),
                      display: true,
                      description:
                          'Ici, vous pouvez consulter les lieux sur votre parocurs sous forme de liste\nVOus pourrez aussi adapter cette liste à vos envie en temps réel!'),
                  label: context.l18n!.navBarLocation.capitalize(),
                ),
                BottomNavigationBarItem(
                  icon: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: SharedColorPalette().navBar(Theme.of(context)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Icon(
                        Icons.person,
                        color: widget.currentIndex == 3
                            ? SharedColorPalette().primary
                            : SharedColorPalette().lightPrimary,
                      ),
                    ),
                  ).allowShowTooltip(context,
                      index: 4,
                      title: context.l18n!.navBarProfil.capitalize(),
                      display: true,
                      description:
                          'Ici vous retrouverai les details de votre compte ...'),
                  label: context.l18n!.navBarProfil.capitalize(),
                ),
              ],
            ),
          ),
        ),
      );
}
