import 'package:dedal/core/pages/profil/profil_cubit.dart';
import 'package:flutter/material.dart';
import 'package:dedal/core/models/user.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  static const name = 'profil';

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  late AdaptiveThemeMode _themeMode;
  late User? _user;

  @override
  void initState() {
    super.initState();
    _themeMode = AdaptiveTheme.of(context).mode;
    _loadUserData();
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

  void _loadUserData() async {
  final getUserResult = await context.read<ProfilCubit>().getUser.call(const NoParam());

  getUserResult.fold(
    (user) {
      // Update the _user variable with the fetched user data.
      setState(() {
        _user = user;
      });
    },
  );
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
      body: Column(
        children: [
          Text('Current Theme: $themeText'),
          ElevatedButton(
            onPressed: toggleThemeMode,
            child: const Text('Toggle Theme'),
          ),
          if (_user != null) ...[
            Text('User Name: ${_user?.name}'),
          ],
        ],
      ),
    );
  }
}
