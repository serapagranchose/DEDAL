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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.black12,
              ),
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: _controller,
                onChanged: (_) =>
                    widget.onChanged.call(_controller.text.trim()),
                autocorrect: false,
                cursorColor: Colors.black,
                cursorWidth: 1,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: widget.placeholder,
                ),
              ),
            ),
          ),
        ],
      );
}
