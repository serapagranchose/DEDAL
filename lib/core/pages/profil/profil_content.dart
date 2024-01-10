import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/string_extention.dart';
import 'package:dedal/components/button/custom_button.dart';
import 'package:dedal/components/text_fields/main_text_field.dart';
import 'package:dedal/constants/colors.dart';
import 'package:dedal/components/button/icon_button.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:dedal/core/pages/login/main.dart';
import 'package:dedal/core/dtos/change_username_dto.dart';

class ProfileContent extends StatefulWidget {
  const ProfileContent({
    required this.user,
    required this.edit,
    super.key,
  });

  static const name = 'profil';
  final User? user;
  final Future<bool> Function(ChangeUsernameDto username) edit;

  @override
  ProfileContentState createState() => ProfileContentState();
}

class ProfileContentState extends State<ProfileContent> {
  late User? _user;
  late AdaptiveThemeMode _themeMode;

Future<void> editField(String field) async {
  String newValue = "";

  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Edit $field'),
      content: Container(
        height: 100,
        child: MainTextFields(
          placeholder: 'Enter new $field',
          onChanged: (String value) => setState(() {
            newValue = value;
          }),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 10),
      actions: [
        CustomStringButton(
          backgroundColor: SharedColorPalette().accent(Theme.of(context)),
          border: Border.all(
            width: 2,
            color: SharedColorPalette().mainDisable(Theme.of(context)),
          ),
          context: context,
          text: context.l18n!.profilModify.capitalize(),
          onTap: (_) async {
            ChangeUsernameDto changeUsernameDto = ChangeUsernameDto(
              user: _user,
              username: newValue,
            );
            setState(() {
              _user?.name = newValue;
            });
            widget.edit(changeUsernameDto);
            Navigator.of(context).pop();
          },
        )
      ],
    ),
  );
}

  @override
  void initState() {
    super.initState();
    _themeMode = AdaptiveTheme.of(context).mode;
    _user = widget.user;
    _loadUserData();
  }

  void toggleThemeMode() {
    final newMode = _themeMode == AdaptiveThemeMode.light
        ? AdaptiveThemeMode.dark
        : AdaptiveThemeMode.light;
    setState(() {
      _themeMode = newMode;
    });
    AdaptiveTheme.of(context).setThemeMode(newMode);
  }

  void _loadUserData() async {
    // final getUserResult =
    //     await context.read<ProfilCubit>().getUser.call(const NoParam());

    // getUserResult.fold(
    //   (user) {
    //     // Update the _user variable with the fetched user data.
    //     setState(() {
    //       _user = user;
    //     });
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) =>
        Column(
          children: [
            const Gap(30),
            Text(
              '${Theme.of(context).brightness == Brightness.light ? 'light' : 'dark'}',
              textAlign: TextAlign.start,
              style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '${_user?.name}',
              textAlign: TextAlign.start,
              style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Gap(15),
            Text('${_user?.email}'),
            const Gap(30),
            // Modify Profile
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90),
              child: Column(children: [
                CustomStringButton(
                  backgroundColor:
                  SharedColorPalette().accent(Theme.of(context)),
                          border: Border.all(
                            width: 2,
                            color: SharedColorPalette()
                                .mainDisable(Theme.of(context)),
                          ),
                          context: context,
                          text: context.l18n!.profilModify.capitalize(),
                          onTap: (_) async => editField('username'),
                        ),
                      ])),
                  const Gap(15),
                ],
              );
}
