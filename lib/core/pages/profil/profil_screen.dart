import 'package:dedal/components/button/custom_button.dart';
import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/pages/filters/filters_screen.dart';
import 'package:dedal/core/pages/home/home_screen.dart';
import 'package:dedal/core/pages/locations/location_screen.dart';
import 'package:dedal/core/pages/login/main.dart';
import 'package:dedal/core/pages/login/signin/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:go_router/go_router.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  static const name = 'profil';

  @override
  ProfilScreenState createState() => ProfilScreenState();
}

class ProfilScreenState extends State<ProfilScreen> {
  late AdaptiveThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = AdaptiveTheme.of(context).mode;
  }

  void toggleThemeMode() {
    final newMode = _themeMode == AdaptiveThemeMode.light
        ? AdaptiveThemeMode.dark
        : AdaptiveThemeMode.light;
    setState(() {
      _themeMode = newMode;
    });
    AdaptiveTheme.of(context).setThemeMode(newMode);
  }

  @override
  Widget build(BuildContext context) {
    String themeText = 'Unknown';
    if (_themeMode == AdaptiveThemeMode.light) {
      themeText = 'Light';
    } else if (_themeMode == AdaptiveThemeMode.dark) {
      themeText = 'Dark';
    } else if (_themeMode == AdaptiveThemeMode.system) {
      themeText = 'System';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Screen'),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
      body: Column(
        children: [
          Text('Current Theme: $themeText'),
          ElevatedButton(
            onPressed: toggleThemeMode,
            child: const Text('Toggle Theme'),
          ),
          CustomStringButton(
              context: context,
              text: 'Deconnection',
              onTap: (_) async => context.goNamed(Main.routeName))
        ],
      ),
    );
  }
}
