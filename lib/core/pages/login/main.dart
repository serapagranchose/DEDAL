import 'package:dedal/components/button/custom_button.dart';
import 'package:dedal/components/layouts/register_layout.dart';
import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/pages/login/signin/signin_screen.dart';
import 'package:dedal/core/pages/login/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class Main extends StatelessWidget {
  const Main({
    super.key,
  });

  static const routeName = 'Main';

  @override
  Widget build(BuildContext context) => RegisterLayout(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          const SizedBox.shrink(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomStringButton(
                context: context,
                text: 'Sign up',
                onTap: (controller) async => showModalBottomSheet<void>(
                  isScrollControlled: true,
                  isDismissible: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => const SignUpScreen(),
                ),
              ),
              CustomStringButton(
                context: context,
                backgroundColor: Colors.white,
                textColor: SharedColorPalette().main,
                text: 'Sign in',
                onTap: (controller) async => showModalBottomSheet<void>(
                  isScrollControlled: true,
                  isDismissible: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => const SignInScreen(),
                ),
              ),
            ],
          ),
        ],
      ));
}
