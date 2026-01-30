import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/theme_cubit.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../resources/app_images.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.profileTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                AppImages.profilePlaceholder,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              context.l10n.profileDemoName,
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.profileDevInfo,
              style: context.textTheme.titleMedium?.copyWith(
                color: AppColors.primary.withValues(alpha: 0.8),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: context.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.4,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.palette_outlined,
                          color: context.colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          context.l10n.profileAppearance,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<ThemeCubit, ThemeMode>(
                      builder: (context, currentMode) {
                        return SegmentedButton<ThemeMode>(
                          segments: [
                            ButtonSegment(
                              value: ThemeMode.system,
                              label: Text(context.l10n.profileThemeSystem),
                              icon: Icon(Icons.brightness_auto),
                            ),
                            ButtonSegment(
                              value: ThemeMode.light,
                              label: Text(context.l10n.profileThemeLight),
                              icon: Icon(Icons.light_mode),
                            ),
                            ButtonSegment(
                              value: ThemeMode.dark,
                              label: Text(context.l10n.profileThemeDark),
                              icon: Icon(Icons.dark_mode),
                            ),
                          ],
                          selected: {currentMode},
                          onSelectionChanged: (newSelection) {
                            final mode = newSelection.first;
                            context.read<ThemeCubit>().updateTheme(mode);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: context.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.4,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.school_outlined,
                          color: context.colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          context.l10n.profileAboutApp,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      context.l10n.profileAboutDescription,
                      style: context.textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),
            Text(
              context.l10n.profileVersion('1.0.0'),
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
