import 'package:dedal/components/button/custom_button.dart';
import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/get_it.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:dedal/core/use_cases/tooltip_helper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';

extension ShowToolTip on Widget {
  //ignore: long-parameter-list
  Widget allowShowTooltip(
    BuildContext context, {
    int index = 0,
    int? indexToDisplay,
    String? title,
    String? description,
    bool display = false,
    Widget Function(Widget)? builder,
    double? padding,
  }) =>
      OverlayTooltipItem(
        tooltipHorizontalPosition: TooltipHorizontalPosition.CENTER,
        tooltipVerticalPosition: TooltipVerticalPosition.TOP,
        displayIndex: index,
        tooltip: (p0) => Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20).add(
              const EdgeInsets.only(bottom: 30),
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Gap(10),
                    Text(
                      title ?? 'no title',
                      style: TextStyle(
                          color: SharedColorPalette().main,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(20),
                    Text(
                      description ?? 'no description',
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: CustomStringButton(
                        context: context,
                        text: context.l18n!.globalNext.capitalize(),
                        backgroundColor: SharedColorPalette().mainDisable,
                        onTap: (_) async =>
                            getIt<OnboardingTooTipHelper>().next(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        child: this,
      );
}
