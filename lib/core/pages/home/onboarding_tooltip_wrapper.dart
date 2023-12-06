import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/extensions/get_it.dart';
import 'package:dedal/core/use_cases/tooltip_helper.dart';
import 'package:flutter/material.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';

class OnboardingToolTipWrapper extends StatelessWidget {
  const OnboardingToolTipWrapper({required this.child, super.key});

  final Widget child;

  TooltipController get _controller =>
      getIt<OnboardingTooTipHelper>().controller;

  @override
  Widget build(BuildContext context) => OverlayTooltipScaffold(
        overlayColor: Colors.black.withOpacity(.65),
        controller: getIt<OnboardingTooTipHelper>().controller,
        preferredOverlay: GestureDetector(
          onTap: () {
            _controller.dismiss();
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: SharedColorPalette().main.withOpacity(0.9),
          ),
        ),
        builder: (context) => child,
      );
}
