import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/common/theme/app_colors.dart';

import '/common/extension/context_extension.dart';
import '/common/theme/theme_manager.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<ThemesCubit>().toggleTheme(),
      icon: AnimatedCrossFade(
        duration: const Duration(milliseconds: 100),
        firstChild: Icon(
          Icons.mode_night_outlined,
          color: AppColors.darkGrey,
          size: 28.0,
        ),
        secondChild: Icon(
          Icons.light_mode_sharp,
          size: 28.0,
          color: AppColors.orane,
        ),
        crossFadeState: context.themMode == Brightness.light
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
      ),
    );
  }
}
