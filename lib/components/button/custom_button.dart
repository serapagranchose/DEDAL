import 'package:dedal/components/button/custom_button_controller.dart';
import 'package:dedal/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomStringButton extends Button<String> {
  CustomStringButton({
    required BuildContext context,
    required String text,
    required Future<void> Function(ButtonController<String>) onTap,
    bool async = false,
    Color? textColor,
    Color? backgroundColor,
    Color? disabledTextColor,
    Color? disabledBackgroundColor,
    TextStyle? baseStyle,
    BoxBorder? border,
    bool disabled = false,
    super.key,
  }) : super.text(
          controller: TextButtonController(
            text,
            onTap,
            async: async,
            border: border,
            baseStyle: baseStyle ??
                GoogleFonts.archivo(
                  fontSize: 15,
                ),
            textColor: textColor ?? Colors.white,
            backgroundColor: backgroundColor ?? SharedColorPalette().secondary,
            disabledTextColor: disabledTextColor ?? Colors.white,
            disabledBackgroundColor: disabledBackgroundColor ??
                SharedColorPalette().disableSecondary(Theme.of(context)),
            disabled: disabled,
          ),
        );
}

abstract class Button<T> extends StatefulWidget {
  const Button.text({
    required this.controller,
    super.key,
  });

  const Button.textExternal({required this.controller, super.key});

  const Button.icon({
    required this.controller,
    super.key,
  });

  const Button.svg({
    required this.controller,
    super.key,
  });
  final ButtonController<T> controller;

  @override
  State<Button<T>> createState() => _ButtonState<T>();
}

class _ButtonState<T> extends State<Button<T>> {
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(controllerCallback);
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.addListener(controllerCallback);
    if (widget.controller.builder != null) {
      return widget.controller.builder!(context, widget.controller);
    }

    return Material(
      child: InkWell(
        onTap: () async {
          if (!widget.controller.clicking && !widget.controller.disabled) {
            widget.controller.clicking = true;
            if (widget.controller.async) {
              widget.controller.disabled = true;
              await widget.controller.onTap(widget.controller);
              widget.controller.disabled = false;
            } else {
              widget.controller.onTap(widget.controller);
            }
            widget.controller.clicking = false;
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          alignment: AlignmentDirectional.center,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: (widget.controller is ButtonController<Widget>)
              ? (widget.controller as ButtonController<Widget>).content
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(controllerCallback);
  }

  void controllerCallback() {
    setState(() {});
  }
}
