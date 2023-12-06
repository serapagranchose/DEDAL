import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:flutter/material.dart';

class GlobalButton extends StatefulWidget {
  const GlobalButton({
    super.key,
    this.onTap,
    this.text,
    this.color,
    this.textColor,
    this.disable = false,
  });

  final VoidCallback? onTap;
  final String? text;
  final Color? textColor;
  final Color? color;
  final bool disable;

  @override
  GlobalButtonState createState() => GlobalButtonState();
}

class GlobalButtonState extends State<GlobalButton> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => widget.onTap != null
              ? !widget.disable
                  ? widget.onTap!.call()
                  : null
              : null,
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                color: widget.color ??
                    (widget.disable
                        ? SharedColorPalette().mainDisable(Theme.of(context))
                        : SharedColorPalette().secondary),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: Text(
                widget.text ?? context.l18n!.globalValidate.capitalize(),
                style: TextStyle(color: widget.textColor ?? Colors.white),
              ),
            ),
          ),
        ),
      );
}
