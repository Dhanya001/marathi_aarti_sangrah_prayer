import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infocontract/core/constants/assets/assets.gen.dart';
import 'package:infocontract/core/router/app_router.gr.dart';
import 'package:infocontract/features/splash/bloc/cubit/splash_cubit.dart';
import 'package:infocontract/features/splash/bloc/cubit/splash_state.dart';
import 'package:infocontract/features/splash/presentation/widgets/component/splash_colors.dart';
import 'package:infocontract/features/splash/presentation/widgets/component/splash_content.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit(),
      child: const _SplashScreenView(),
    );
  }
}

class _SplashScreenView extends StatefulWidget {
  const _SplashScreenView();

  @override
  State<_SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<_SplashScreenView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashCubit>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == SplashStatus.completed,
      listener: (context, state) {
        context.router.replace(const HomeRoute());
      },
      child: Scaffold(
        backgroundColor: SplashColors.background,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth / constraints.maxHeight > 0.62;

            return Stack(
              fit: StackFit.expand,
              children: [
                Assets.png.splash.splashBackground.image(
                  fit: BoxFit.cover,
                  alignment: isWide
                      ? Alignment.bottomCenter
                      : const Alignment(0, 0.12),
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  filterQuality: FilterQuality.high,
                ),
                IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withValues(alpha: 0.22),
                          Colors.transparent,
                          Colors.transparent,
                          Colors.white.withValues(alpha: 0.18),
                        ],
                        stops: const [0, 0.22, 0.72, 1],
                      ),
                    ),
                  ),
                ),
                const SplashContent(),
              ],
            );
          },
        ),
      ),
    );
  }
}
