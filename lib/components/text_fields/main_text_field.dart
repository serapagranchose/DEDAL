import 'package:dedal/constants/colors.dart';
import 'package:flutter/material.dart';

class MainTextFields extends StatefulWidget {
  const MainTextFields({
    super.key,
    required this.onChanged,
    this.placeholder,
    this.title,
    this.border,
  });

  final void Function(String) onChanged;
  final String? placeholder;
  final String? title;
  final Color? border;
  @override
  State<MainTextFields> createState() => _MainTextFieldsState();
}

class _MainTextFieldsState extends State<MainTextFields> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.title != null
                ? Text(
                    widget.title!,
                  )
                : const SizedBox.shrink(),
            TextFormField(
              textAlign: TextAlign.center,
              controller: _controller,
              onChanged: (_) =>
                  widget.onChanged.call(_controller.text.trim()),
              autocorrect: false,
              cursorColor: Colors.black,
              cursorWidth: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.border ?? SharedColorPalette().main,
                  ),
                ),
                isDense: true,
                hintText: widget.placeholder,
              ),
            ),
          ],
        ),
      );
}
