import 'dart:async';

import 'package:overlay_tooltip/overlay_tooltip.dart';

final class OnboardingTooTipHelper {
  final TooltipController controller = TooltipController();

  void next() => controller.next();
  void start() => Future.sync(() => controller.start(0));
  void dismiss() => controller.dismiss();
}
