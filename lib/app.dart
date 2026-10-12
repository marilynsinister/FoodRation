import 'package:flutter/material.dart';

import 'package:food_ration/database/app_database.dart';
import 'package:food_ration/foods/custom_foods.dart';
import 'package:food_ration/nutrition/nutrition_controller.dart';
import 'package:food_ration/planner/planner_controller.dart';
import 'package:food_ration/settings/settings_controller.dart';
import 'package:food_ration/ui/app_scope.dart';
import 'package:food_ration/ui/planner_tab.dart';
import 'package:food_ration/ui/profile_tab.dart';
import 'package:food_ration/ui/recipes_tab.dart';
import 'package:food_ration/ui/settings_page.dart';
import 'package:food_ration/ui/today_tab.dart';

class FoodRationApp extends StatefulWidget {
  const FoodRationApp({
    super.key,
    required this.controller,
    required this.planner,
    required this.settings,
    required this.foods,
    this.database,
  });

  final NutritionController controller;
  final PlannerController planner;
  final SettingsController settings;
  final CustomFoodsController foods;

  /// null на вебе: данные живут в памяти.
  final AppDatabase? database;

  @override
  State<FoodRationApp> createState() => _FoodRationAppState();
}

class _FoodRationAppState extends State<FoodRationApp> {
  @override
  void dispose() {
    widget.controller.dispose();
    widget.planner.dispose();
    widget.settings.dispose();
    widget.foods.dispose();
    widget.database?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.settings,
      builder: (context, _) => AppScope(
        planner: widget.planner,
        foods: widget.foods,
        child: MaterialApp(
          title: 'Food Ration',
          theme: widget.settings.lightTheme,
          darkTheme: widget.settings.darkTheme,
          themeMode: widget.settings.themeMode,
          home: MainShell(
            controller: widget.controller,
            planner: widget.planner,
            settings: widget.settings,
          ),
        ),
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({
    super.key,
    required this.controller,
    required this.planner,
    required this.settings,
  });

  final NutritionController controller;
  final PlannerController planner;
  final SettingsController settings;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  static const _today = 0;
  static const _plan = 2;
  static const _profile = 3;
  static const _titles = ['Сегодня', 'Рецепты', 'План', 'Моя норма КБЖУ'];

  final _plannerKey = GlobalKey<PlannerTabState>();

  int _index = _today;

  /// Ранее открытые вкладки — системная «Назад» возвращает к ним.
  final _history = <int>[];

  @override
  void initState() {
    super.initState();
    if (widget.controller.loaded && !widget.controller.hasProfile) _index = _profile;
  }

  /// [remember] = false — уход с вкладки без возврата (например, после
  /// сохранения нормы не нужно возвращаться в калькулятор).
  void _go(int i, {bool remember = true}) {
    if (i == _index) return;
    setState(() {
      _history.remove(_index);
      if (remember) _history.add(_index);
      _history.remove(i);
      _index = i;
    });
  }

  /// «Назад» на главном экране: внутренняя вкладка плана → предыдущая
  /// вкладка → «Сегодня». Приложение сворачивается только с «Сегодня».
  void _back() {
    if (_index == _plan && (_plannerKey.currentState?.handleBack() ?? false)) return;
    setState(() {
      _index = _history.isNotEmpty ? _history.removeLast() : _today;
      _history.remove(_index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _index == _today && _history.isEmpty,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _back();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_titles[_index]),
          actions: [
            IconButton(
              key: const Key('open-settings'),
              tooltip: 'Настройки',
              icon: const Icon(Icons.settings_outlined),
              onPressed: () => SettingsPage.open(context, widget.settings),
            ),
          ],
        ),
        body: IndexedStack(
          index: _index,
          children: [
            TodayTab(
              controller: widget.controller,
              onOpenProfile: () => _go(_profile),
            ),
            RecipesTab(controller: widget.controller),
            PlannerTab(key: _plannerKey, controller: widget.controller, planner: widget.planner),
            ProfileTab(
              controller: widget.controller,
              onSaved: () => _go(_today, remember: false),
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: _go,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.today_outlined),
              selectedIcon: Icon(Icons.today),
              label: 'Сегодня',
            ),
            NavigationDestination(
              icon: Icon(Icons.restaurant_menu_outlined),
              selectedIcon: Icon(Icons.restaurant_menu),
              label: 'Рецепты',
            ),
            NavigationDestination(
              icon: Icon(Icons.event_note_outlined),
              selectedIcon: Icon(Icons.event_note),
              label: 'План',
            ),
            NavigationDestination(
              icon: Icon(Icons.calculate_outlined),
              selectedIcon: Icon(Icons.calculate),
              label: 'Норма',
            ),
          ],
        ),
      ),
    );
  }
}
