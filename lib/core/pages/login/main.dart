import 'package:dedal/components/button/custom_button.dart';
import 'package:dedal/components/layouts/register_layout.dart';
import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:dedal/core/pages/login/signin/signin_screen.dart';
import 'package:dedal/core/pages/login/signup/signup_screen.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
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
            context.l18n!.mainCatch.capitalize(),
            style: GoogleFonts.archivo(
              fontSize: 30,
            ),
          ),
          const SizedBox.shrink(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomStringButton(
                backgroundColor: SharedColorPalette().secondary,
                context: context,
                text: context.l18n!.mainSignUp.capitalize(),
                onTap: (controller) async => showModalBottomSheet<void>(
                  isScrollControlled: true,
                  isDismissible: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => const SignUpScreen(),
                ),
              ),
              const Gap(15),
              CustomStringButton(
                backgroundColor: SharedColorPalette().accent(Theme.of(context)),
                textColor: SharedColorPalette().text(Theme.of(context)),
                context: context,
                text: context.l18n!.mainSignIn.capitalize(),
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
