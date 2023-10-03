import 'package:dedal/components/button/button.dart';
import 'package:dedal/components/text_fields/main_text_field.dart';
import 'package:flutter/material.dart';

class SigninContent extends StatefulWidget {
  const SigninContent({
    required this.validate,
    this.isError,
    super.key,
  });

  final void Function(String email, String password) validate;
  final bool? isError;

  @override
  SigninContentyState createState() => SigninContentyState();
}

class SigninContentyState extends State<SigninContent> {
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MainTextFields(
            title: 'Votre E-mail',
            placeholder: 'exemple@test.idk',
            onChanged: (String value) => setState(() {
              _email = value;
            }),
            border: widget.isError == false ? Colors.red : null,
          ),
          MainTextFields(
            title: 'Votre mot de passe',
            onChanged: (String value) => setState(() {
              _password = value;
            }),
            border: widget.isError == false ? Colors.red : null,
          ),
          if (widget.isError == false)
            const Text('Email ou mot de passe incorrect'),
          GlobalButton(
            disable: !(RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(_email) &&
                RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])(?=.{8,})+")
                    .hasMatch(_password)),
            onTap: () => widget.validate.call(_email, _password),
            text: 'Connection',
          ),
        ],
      );
}
