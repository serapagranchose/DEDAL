import 'package:flutter/material.dart';

class MainTextFields extends StatefulWidget {
  const MainTextFields({
    super.key,
    required this.onChanged,
    this.placeholder,
    this.title,
  });

  final void Function(String) onChanged;
  final String? placeholder;
  final String? title;
  @override
  State<MainTextFields> createState() => _MainTextFieldsState();
}

class _MainTextFieldsState extends State<MainTextFields> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) => Column(
        children: [
          widget.title != null ? Text(widget.title!) : const SizedBox.shrink(),
          TextFormField(
            textAlign: TextAlign.center,
            controller: _controller,
            onChanged: (_) => widget.onChanged.call(_controller.text.trim()),
            autocorrect: false,
            cursorColor: Colors.black,
            cursorWidth: 1,
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: widget.placeholder,
            ),
          ),
        ],
      );
}
