import 'package:dedal/components/button/button.dart';
import 'package:dedal/components/layouts/register_layout.dart';
import 'package:dedal/components/loaders/main_loader.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/pages/home/home_content.dart';
import 'package:dedal/core/pages/home/home_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:wyatt_bloc_helper/wyatt_bloc_helper.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';

class HomeScreen extends CubitScreen<HomeCubit, CrudState> {
  const HomeScreen({super.key});

  static const name = 'home';

  @override
  create(BuildContext context) => HomeCubit()..load(context);
  @override
  Widget onBuild(BuildContext context, CrudState state) => RegisterLayout(
      navBar: true,
      child: switch (state) {
        CrudLoading() => const MainLoader(),
        CrudError(message: final message) => Column(
            children: [
              Text(message ?? 'une erreur est subvenu'),
              const GlobalButton(
                text: 'reload',
              )
            ],
          ),
        CrudLoaded<User?>(data: final data) => data?.pos != null
            ? HomeContent(
                initialPosition: data!.pos!,
              )
            : const SizedBox.shrink(),
        _ => const Text('error'),
      });
}
