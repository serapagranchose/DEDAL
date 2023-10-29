import 'package:dedal/constants/colors.dart';
import 'package:flutter/material.dart';

class MainTextFields extends StatefulWidget {
  const MainTextFields({
    super.key,
    required this.onChanged,
    this.placeholder,
    this.title,
    this.border,
    this.isHide,
  });

  final void Function(String) onChanged;
  final String? placeholder;
  final bool? isHide;
  final String? title;
  final Color? border;
  @override
  State<MainTextFields> createState() => _MainTextFieldsState();
}

class _MainTextFieldsState extends State<MainTextFields> {
  final _controller = TextEditingController();
  bool hided = false;

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
              obscureText: hided,
              textAlign: TextAlign.center,
              controller: _controller,
              onChanged: (_) => widget.onChanged.call(_controller.text.trim()),
              autocorrect: false,
              cursorColor: Colors.black,
              cursorWidth: 1,
              decoration: InputDecoration(
                iconColor: widget.border ?? SharedColorPalette().main,
                suffixIcon: widget.isHide ?? false
                    ? hided
                        ? InkWell(
                            child: const Icon(Icons.lock),
                            onTap: () => setState(() {
                              hided = !hided;
                            }),
                          )
                        : InkWell(
                            child: const Icon(Icons.lock_open),
                            onTap: () => setState(() {
                              hided = !hided;
                            }),
                          )
                    : null,
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

  @override
  void initState() {
    setState(() {
      hided = widget.isHide ?? false;
    });
    super.initState();
  }
}
