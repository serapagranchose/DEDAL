import 'package:dedal/components/button/custom_button.dart';
import 'package:dedal/components/text_fields/main_text_field.dart';
import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SigninContent extends StatefulWidget {
  const SigninContent({
    required this.validate,
    this.isError,
    super.key,
  });

  final void Function(String email, String passwordn, bool saveCreadential)
      validate;
  final bool? isError;

  @override
  SigninContentyState createState() => SigninContentyState();
}

class SigninContentyState extends State<SigninContent> {
  String _email = '';
  String _password = '';
  bool _saveCreadential = false;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    child: const Icon(Icons.close_rounded),
                    onTap: () => context.pop()),
              ),
            ],
          ),
          MainTextFields(
            title: context.l18n!.loginEmail.capitalize(),
            placeholder: 'exemple@test.idk',
            onChanged: (String value) => setState(() {
              _email = value;
            }),
            border: widget.isError ?? false ? Colors.red.shade900 : null,
          ),
          Column(
            children: [
              MainTextFields(
                isHide: true,
                title: context.l18n!.loginPassword.capitalize(),
                onChanged: (String value) => setState(() {
                  _password = value;
                }),
                border: widget.isError ?? false
                    ? Colors.red.shade900
                    : SharedColorPalette().secondary,
              ),
              if (widget.isError ?? false)
                Text(
                  context.l18n!.loginError.capitalize(),
                  style: TextStyle(color: Colors.red.shade900),
                ),
            ],
          ),
          Row(
            children: [
              Checkbox(
                  value: _saveCreadential,
                  onChanged: (value) => setState(() {
                        _saveCreadential = !_saveCreadential;
                      })),
              const Text('Sauvegardere mes info')
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: CustomStringButton(
              context: context,
              disabled: !(RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
                      .hasMatch(_email) &&
                  RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])(?=.{8,})+")
                      .hasMatch(_password)),
              onTap: (c) async =>
                  widget.validate.call(_email, _password, _saveCreadential),
              text: context.l18n!.loginConnect.capitalize(),
            ),
          ),
        ],
      );
}
