import 'package:dedal/components/layouts/navbar.dart';
import 'package:dedal/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class RegisterLayout extends StatelessWidget {
  const RegisterLayout(
      {super.key,
      required this.child,
      this.appBar,
      this.title,
      this.actions,
      this.navBar,
      this.index = 0});

  final bool? appBar;
  final bool? navBar;
  final Widget child;
  final String? title;
  final int index;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBar.isNotNull
            ? AppBar(
                backgroundColor: SharedColorPalette().main,
                leading: context.canPop()
                    ? InkWell(
                        onTap: () => context.pop(),
                        child: const Icon(Icons.arrow_back_ios_new),
                      )
                    : null,
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
            ? NavBar(
                currentIndex: index,
              )
            : null,
      );
}
