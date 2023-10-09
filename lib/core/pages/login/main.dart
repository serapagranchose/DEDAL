import 'package:dedal/components/button/button.dart';
import 'package:dedal/components/layouts/register_layout.dart';
import 'package:dedal/core/pages/login/signin/signin_screen.dart';
import 'package:dedal/core/pages/login/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class Main extends StatelessWidget {
  Main({
    super.key,
  });

  static const routeName = 'Main';

  void toggleTheme(BuildContext context) {
    AdaptiveTheme.of(context).toggleThemeMode();
  }

  @override
  Widget build(BuildContext context) => RegisterLayout(
          child: Column(
        children: [
          Text(
            'DEDAL',
            style: GoogleFonts.archivo(
              fontSize: 50,
            ),
          ),
          Image.asset('assets/logo/dedal.png'),
          /* Move to a profile section
          ElevatedButton(
              onPressed: () {
                toggleTheme(context);
              },
              child: Text("changer theme")
          ),
          */
          Text(
            'Le chemin de votre culture',
            style: GoogleFonts.archivo(
              fontSize: 30,
            ),
          ),
          GlobalButton(
            text: 'Sign up',
            onTap: () => context.pushNamed(SignUpScreen.routeName),
          ),
          GlobalButton(text: 'Google + ${Uri.base}'),
          const Gap(20),
          GlobalButton(
            text: 'Sign in',
            onTap: () => context.pushNamed(SignInScreen.routeName),
          ),
        ],
      ));
}
