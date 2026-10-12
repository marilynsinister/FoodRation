import 'package:flutter/material.dart';

import 'package:food_ration/settings/settings_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.settings});

  final SettingsController settings;

  static Future<void> open(BuildContext context, SettingsController settings) =>
      Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => SettingsPage(settings: settings)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: ListenableBuilder(
        listenable: settings,
        builder: (context, _) {
          final theme = Theme.of(context);
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            children: [
              Text('Тема', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              SegmentedButton<ThemeMode>(
                key: const Key('theme-mode'),
                segments: const [
                  ButtonSegment(
                    value: ThemeMode.system,
                    icon: Icon(Icons.brightness_auto_outlined),
                    label: Text('Как в системе'),
                  ),
                  ButtonSegment(
                    value: ThemeMode.light,
                    icon: Icon(Icons.light_mode_outlined),
                    label: Text('Светлая'),
                  ),
                  ButtonSegment(
                    value: ThemeMode.dark,
                    icon: Icon(Icons.dark_mode_outlined),
                    label: Text('Тёмная'),
                  ),
                ],
                selected: {settings.themeMode},
                showSelectedIcon: false,
                onSelectionChanged: (s) => settings.setThemeMode(s.first),
              ),
              const SizedBox(height: 24),
              Text('Вариант тёмной темы', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              for (final v in DarkVariant.values)
                _DarkVariantTile(
                  variant: v,
                  accent: settings.accent,
                  selected: settings.darkVariant == v,
                  onTap: () => settings.setDarkVariant(v),
                ),
              if (settings.themeMode == ThemeMode.light)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'Сейчас включена светлая тема — вариант применится, когда тема станет тёмной.',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              const SizedBox(height: 24),
              Text('Акцентный цвет', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final a in AccentColor.values)
                    _AccentDot(
                      accent: a,
                      selected: settings.accent == a,
                      onTap: () => settings.setAccent(a),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DarkVariantTile extends StatelessWidget {
  const _DarkVariantTile({
    required this.variant,
    required this.accent,
    required this.selected,
    required this.onTap,
  });

  final DarkVariant variant;
  final AccentColor accent;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final preview = buildDarkTheme(accent, variant).colorScheme;
    return Card(
      key: Key('dark-${variant.name}'),
      margin: const EdgeInsets.symmetric(vertical: 4),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: selected ? theme.colorScheme.primary : theme.colorScheme.outlineVariant,
          width: selected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _Preview(scheme: preview),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(variant.label, style: theme.textTheme.titleSmall),
                    Text(variant.description, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: selected ? theme.colorScheme.primary : theme.colorScheme.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Миниатюра экрана в цветах варианта темы.
class _Preview extends StatelessWidget {
  const _Preview({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    Widget bar(double w, Color c) => Container(
          width: w,
          height: 6,
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(3)),
        );
    return Container(
      width: 64,
      height: 52,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 18,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Container(width: 8, height: 8, decoration: BoxDecoration(color: scheme.primary, shape: BoxShape.circle)),
                const SizedBox(width: 4),
                Expanded(child: bar(double.infinity, scheme.onSurfaceVariant.withValues(alpha: 0.6))),
              ],
            ),
          ),
          bar(40, scheme.onSurface.withValues(alpha: 0.7)),
          bar(28, scheme.primary),
        ],
      ),
    );
  }
}

class _AccentDot extends StatelessWidget {
  const _AccentDot({required this.accent, required this.selected, required this.onTap});

  final AccentColor accent;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = ColorScheme.fromSeed(seedColor: accent.color, brightness: theme.brightness).primary;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(32),
      child: SizedBox(
        width: 64,
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? theme.colorScheme.onSurface : Colors.transparent,
                  width: 3,
                ),
              ),
              child: selected ? Icon(Icons.check, color: theme.colorScheme.surface, size: 20) : null,
            ),
            const SizedBox(height: 4),
            Text(accent.label, style: theme.textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}
