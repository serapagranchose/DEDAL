import 'package:dedal/components/loaders/main_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wyatt_ui_components/wyatt_ui_components.dart';

class ButtonController<T> extends ChangeNotifier {
  ButtonController(this._content, this._onTap, [this._async = false]);

  T _content;
  bool _disabled = false;
  bool _isLoading = false;
  final bool _async;
  final Future<void> Function(ButtonController<T>) _onTap;
  bool clicking = false;

  Widget Function(BuildContext, ButtonController<T>)? builder;

  Function get onTap => _onTap;

  bool get async => _async;

  T get content => _content;

  set content(T value) {
    _content = value;
    notifyListeners();
  }

  bool get disabled => _disabled;

  bool get isLoading => _isLoading;

  set disabled(bool value) {
    _disabled = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

class TextButtonController extends ButtonController<String> {
  TextButtonController(
    String textContent,
    Future<void> Function(ButtonController<String>) onTap, {
    required this.textColor,
    required this.border,
    required this.baseStyle,
    required this.backgroundColor,
    required this.disabledTextColor,
    required this.disabledBackgroundColor,
    bool disabled = false,
    bool isLoading = false,
    bool async = false,
  }) : super(textContent, onTap, async) {
    this.disabled = disabled;
    this.isLoading = isLoading;

    style = baseStyle.copyWith(color: textColor);
    disabledStyle = baseStyle.copyWith(color: disabledTextColor);

    builder = (context, controller) => Material(
          color: controller.isLoading
              ? Colors.transparent
              : controller.disabled
                  ? disabledBackgroundColor
                  : backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: InkWell(
            customBorder: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            onTap: () async {
              if (controller.clicking) {
                return;
              }
              if (controller.disabled) {
                return;
              }
              if (controller.isLoading) {
                return;
              }
              controller.clicking = true;
              if (controller.async) {
                controller.disabled = true;
                await controller.onTap(controller);
                controller.disabled = false;
              } else {
                controller.onTap(controller);
              }
              controller.clicking = false;
            },
            child: Container(
              padding:
                  EdgeInsets.symmetric(vertical: baseStyle.fontSize! / 1.3),
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                border: border,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: controller.isLoading
                  ? const RotatedBox(
                      quarterTurns: 2,
                      child: MainLoader(),
                    )
                  : Text(
                      controller.content,
                      style: controller.disabled ? disabledStyle : style,
                    ),
            ),
          ),
        );
  }
  Color textColor;
  Color backgroundColor;
  Color? disabledTextColor;
  Color? disabledBackgroundColor;
  BoxBorder? border;
  TextStyle baseStyle;

  late TextStyle style;
  late TextStyle disabledStyle;
}
