// ignore_for_file: use_build_context_synchronously

import 'package:dedal/components/button/button.dart';
import 'package:dedal/components/layouts/register_layout.dart';
import 'package:dedal/components/loaders/main_loader.dart';
import 'package:dedal/core/datasources/filters/filters_datasource.dart';
import 'package:dedal/core/datasources/localStorage/local_storage_datasource.dart';
import 'package:dedal/core/datasources/localStorage/local_storage_datasource_impl.dart';
import 'package:dedal/core/extensions/get_it.dart';
import 'package:dedal/core/models/filter.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/pages/filters/filters_cubit.dart';
import 'package:dedal/core/pages/filters/filters_content.dart';
import 'package:dedal/core/pages/home/home_cubit.dart';
import 'package:dedal/core/pages/home/home_screen.dart';
import 'package:dedal/core/use_cases/get_filters.dart';
import 'package:dedal/core/use_cases/get_user.dart';
import 'package:dedal/core/use_cases/set_user_info.dart';
import 'package:dedal/core/use_cases/user_generat_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wyatt_bloc_helper/wyatt_bloc_helper.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';

class FilterScreen extends CubitScreen<FiltersCubit, CrudState> {
  const FilterScreen({super.key});

  static const name = 'filters';

  @override
  create(BuildContext context) => FiltersCubit(
      getUser: GetUser(localStorageDataSource: getIt<LocalStorageDataSource>()),
      getFilters: GetFilters(filterDataSource: getIt<FilterDataSource>()),
      setInfoUser: SetInfoUser(filterDataSource: getIt<FilterDataSource>()),
      userGenerateRoute:
          UserGenerateRoute(filterDataSource: getIt<FilterDataSource>()))
    ..load();
  @override
  Widget onBuild(BuildContext context, CrudState state) => RegisterLayout(
      appBar: true,
      title: 'Filtre',
      navBar: true,
      child: switch (state) {
        CrudLoading() => const MainLoader(),
        CrudLoaded<(User, List<Filter>?)>(data: final data) =>
          data?.$1 != null && data?.$2 != null
              ? FilterContent(
                  filters: data!.$2!,
                  info: data.$1.info,
                  submit: (info) async {
                    final result =
                        await context.read<FiltersCubit>().setInfo(info);
                    if (result) {
                      context.goNamed(HomeScreen.name);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    'Erreur',
                                    textAlign: TextAlign.center,
                                  ),
                                  const Text(
                                    'Une erreur est subvenu',
                                    textAlign: TextAlign.center,
                                  ),
                                  GlobalButton(
                                    text: 'fermer',
                                    onTap: () => context.pop(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  })
              : const SizedBox.shrink(),
        CrudError(message: final message) => Column(
            children: [
              Text(message ?? 'une erreur est subvenu'),
              GlobalButton(
                text: 'reload',
                onTap: () => context.read<HomeCubit>().load(),
              )
            ],
          ),
        _ => const Text('error'),
      });
}
