import 'package:dedal/components/button/button.dart';
import 'package:dedal/components/button/custom_button.dart';
import 'package:dedal/components/text_fields/main_text_field.dart';
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
                const Text(
                  'Code',
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'entrez le code que vous avez reçu par mail',
                  textAlign: TextAlign.center,
                ),
                MainTextFields(
                    onChanged: (value) => setState(() {
                          code = value;
                        })),
                CustomStringButton(
                  text: '',
                  context: context,
                  onTap: (c) async => widget.action.call(code),
                )
              ],
            ),
          ),
        ),
      );
}
