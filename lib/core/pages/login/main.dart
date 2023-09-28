import 'package:dedal/components/button/button.dart';
import 'package:dedal/components/layouts/register_layout.dart';
import 'package:dedal/core/pages/login/signin/signin_screen.dart';
import 'package:dedal/core/pages/login/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: unused_import
import 'package:webview_flutter/webview_flutter.dart';

/// Displays a list of SampleItems.
class Main extends StatelessWidget {
  Main({
    super.key,
  });

  static const routeName = 'Main';
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {
          print('start => $url');
        },
        onPageFinished: (String url) {
          print('end => $url');

        },
        onWebResourceError: (WebResourceError error) {},
       
      ),
    )
    ..loadRequest(Uri.parse(
        'https://dedal.auth.eu-west-1.amazoncognito.com/login?client_id=cse59djt26m2kikuacurl26uj&response_type=code&scope=email+openid+profile&redirect_uri=${Uri.base}'));
  @override
  Widget build(BuildContext context) =>
      // RegisterLayout(
      //         child: Column(
      //       children: [
      //         Text(
      //           'DEDAL',
      //           style: GoogleFonts.archivo(
      //             fontSize: 50,
      //           ),
      //         ),
      //         Image.asset('assets/logo/dedal.png'),
      //         Text(
      //           'Le chemin de votre culture',
      //           style: GoogleFonts.archivo(
      //             fontSize: 30,
      //           ),
      //         ),
      //         GlobalButton(
      //           text: 'Sign up',
      //           onTap: () => context.pushNamed(SignUpScreen.routeName),
      //         ),
      WebViewWidget(controller: controller);
  //         // GlobalButton(
  //         //   text: 'Google + ${Uri.base}',
  //         //   onTap: () async {
  //         //     final callbackUrl = Uri.base;
  //         //     await webviewFlu.openBrowserAsync(
  // 'https://dedal.auth.eu-west-1.amazoncognito.com/login?client_id=cse59djt26m2kikuacurl26uj&response_type=code&scope=email+openid+profile&redirect_uri=${callbackUrl}');
  //         //   },
  //         // ),
  //         const Gap(20),
  //         GlobalButton(
  //           text: 'Sign in',
  //           onTap: () => context.pushNamed(SignInScreen.routeName),
  //         ),
  //       ],
  //     ));
}
