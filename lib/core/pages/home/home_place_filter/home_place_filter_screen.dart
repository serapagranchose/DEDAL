import 'package:dedal/components/button/filter_icon.dart';
import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/extensions/build_context_applocalisation_extention.dart';
import 'package:dedal/core/extensions/get_it.dart';
import 'package:dedal/core/models/filter.dart';
import 'package:dedal/core/pages/home/home_cubit.dart';
import 'package:dedal/core/pages/home/home_place_filter/home_place_filter_cubit.dart';
import 'package:dedal/core/use_cases/get_filters.dart';
import 'package:dedal/core/use_cases/get_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyatt_bloc_helper/wyatt_bloc_helper.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';

class HomePlaceFilterScreen
    extends CubitScreen<HomePlaceFilterCubit, CrudState> {
  const HomePlaceFilterScreen({this.selected, super.key});

  final String? selected;

  @override
  HomePlaceFilterCubit create(BuildContext context) => HomePlaceFilterCubit(
      getFilters: GetFilters(filterDataSource: getIt()),
      getUser: GetUser(localStorageDataSource: getIt()))
    ..load();

  @override
  Widget onBuild(BuildContext context, CrudState state) =>
      state is CrudLoaded<List<Filter>?> && state.data != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                height: 57,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: state.data!
                      .map(
                        (e) => FilterIcon(
                            icon: Icon(e.getIcon(),
                                color: selected == e.id
                                    ? SharedColorPalette()
                                        .mainDisable(Theme.of(context))
                                    : SharedColorPalette().primary),
                            title: context.l18n!.filterNameEnum(
                                (e.name ?? '').split(' ')[0].split('-')[0]),
                            action: () => context
                                .read<HomeCubit>()
                                .loadWithPlace(
                                    selected == e.id ? '' : e.id ?? '')),
                      )
                      .toList(),
                ),
              ),
            )
          : const SizedBox.shrink();
}
