import 'package:dedal/components/button/custom_button.dart';
import 'package:dedal/components/text_fields/main_text_field.dart';
import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:flutter/material.dart';

class CodeDialog extends StatefulWidget {
  const CodeDialog({
    super.key,
    required this.action,
  });

  final void Function(String?) action;

  @override
  State<CodeDialog> createState() => _CodeDialogState();
}

class _CodeDialogState extends State<CodeDialog> {
  String? code;

  @override
  Widget build(BuildContext context) => Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: AspectRatio(
          aspectRatio: 1.2,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  context.l18n!.loginCode.capitalize(),
                  textAlign: TextAlign.center,
                ),
                Text(
                  context.l18n!.loginCodeBis.capitalize(),
                  textAlign: TextAlign.center,
                ),
                MainTextFields(
                    onChanged: (value) => setState(() {
                          code = value;
                        })),
                CustomStringButton(
                  text: context.l18n!.globalValidate.capitalize(),
                  context: context,
                  onTap: (c) async => widget.action.call(code),
                )
              ],
            ),
          ),
        ),
      );
}
