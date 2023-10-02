import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/pages/filters/filters_screen.dart';
import 'package:dedal/core/pages/home/home_screen.dart';
import 'package:dedal/core/pages/locations/location_screen.dart';
import 'package:dedal/core/pages/profil/profil_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class RegisterLayout extends StatelessWidget {
  const RegisterLayout({
    super.key,
    required this.child,
    this.appBar,
    this.title,
    this.actions,
    this.navBar,
  });

  final bool? appBar;
  final bool? navBar;
  final Widget child;
  final String? title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBar.isNotNull
            ? AppBar(
                backgroundColor: SharedColorPalette().main,
                leading: InkWell(
                  onTap: () => context.pop(),
                  child: const Icon(Icons.arrow_back_ios_new),
                ),
                title: title.isNotNull ? Text(title!) : const SizedBox.shrink(),
                actions:
                    actions.isNotNull ? actions! : [const SizedBox.shrink()],
              )
            : null,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        )),
        bottomNavigationBar: navBar.isNotNull
            ? BottomNavigationBar(
                onTap: (value) => switch (value) {
                  0 => context.goNamed(FilterScreen.name),
                  1 => context.goNamed(HomeScreen.name),
                  2 => context.goNamed(LocationScreen.name),
                  _ => context.goNamed(ProfilScreen.name),
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.filter_alt_outlined,
                        color: SharedColorPalette().main,
                      ),
                      label: 'Filtres'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.map,
                        color: SharedColorPalette().main,
                      ),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.list,
                        color: SharedColorPalette().main,
                      ),
                      label: 'Location'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                        color: SharedColorPalette().main,
                      ),
                      label: 'Profil'),
                ],
              )
            : null,
      );
}
