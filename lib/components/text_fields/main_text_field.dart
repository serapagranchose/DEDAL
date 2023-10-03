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
  Widget build(BuildContext context) {
    print('erroer ==> ${widget.border}');
    var myVariable = Column(
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
              onChanged: (_) => widget.onChanged.call(_controller.text.trim()),
              autocorrect: false,
              cursorColor: Colors.black,
              cursorWidth: 1,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.border ?? SharedColorPalette().main,
                  ),
                ),
                isDense: true,
                hintText: widget.placeholder,
              ),
            ),
          ),
        ),
      ],
    );
    return myVariable;
  }
}
