import 'package:dedal/components/button/button.dart';
import 'package:dedal/components/layouts/register_layout.dart';
import 'package:dedal/core/pages/login/signin/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

/// Displays a list of SampleItems.
class Main extends StatelessWidget {
  const Main({
    super.key,
  });

  static const routeName = 'Main';

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
          Text(
            'Le chemin de votre culture',
            style: GoogleFonts.archivo(
              fontSize: 30,
            ),
          ),
          GlobalButton(
            text: 'Sign up',
            onTap: () => context.pushNamed(SignInScreen.routeName),
          ),
          const GlobalButton(text: 'Google'),
          const Gap(20),
          const GlobalButton(text: 'Sign in'),
        ],
      ));
}
