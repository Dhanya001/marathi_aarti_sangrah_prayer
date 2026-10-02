import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infocontract/core/router/app_router.gr.dart';
import 'package:infocontract/features/home/bloc/cubit/home_cubit.dart';

Future<void> openAartiDetail(BuildContext context, String aartiId) async {
  await context.router.push(AartiDetailRoute(aartiId: aartiId));
  if (!context.mounted) return;
  try {
    context.read<HomeCubit>().syncFavorites();
  } catch (_) {}
}
