import 'package:flutter/material.dart';

import 'package:food_ration/database/app_database.dart';
import 'package:food_ration/nutrition/nutrition_controller.dart';
import 'package:food_ration/ui/book_reference_tab.dart';
import 'package:food_ration/ui/profile_tab.dart';
import 'package:food_ration/ui/recipes_tab.dart';
import 'package:food_ration/ui/today_tab.dart';

class FoodRationApp extends StatefulWidget {
  const FoodRationApp({super.key, required this.controller, this.database});

  final NutritionController controller;

  /// null на вебе: справочник книги хранится только в SQLite.
  final AppDatabase? database;

  @override
  State<FoodRationApp> createState() => _FoodRationAppState();
}

class _FoodRationAppState extends State<FoodRationApp> {
  @override
  void dispose() {
    widget.controller.dispose();
    widget.database?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Ration',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: MainShell(controller: widget.controller, database: widget.database),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key, required this.controller, this.database});

  final NutritionController controller;
  final AppDatabase? database;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  static const _today = 0;
  static const _profile = 2;

  int _index = _today;

  @override
  void initState() {
    super.initState();
    if (widget.controller.loaded && !widget.controller.hasProfile) _index = _profile;
  }

  @override
  Widget build(BuildContext context) {
    final db = widget.database;
    final titles = ['Сегодня', 'Рецепты', 'Моя норма КБЖУ', if (db != null) 'Книга'];
    return Scaffold(
      appBar: AppBar(title: Text(titles[_index])),
      body: IndexedStack(
        index: _index,
        children: [
          TodayTab(
            controller: widget.controller,
            onOpenProfile: () => setState(() => _index = _profile),
          ),
          RecipesTab(controller: widget.controller),
          ProfileTab(
            controller: widget.controller,
            onSaved: () => setState(() => _index = _today),
          ),
          if (db != null) BookReferenceTab(database: db),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.today_outlined),
            selectedIcon: Icon(Icons.today),
            label: 'Сегодня',
          ),
          const NavigationDestination(
            icon: Icon(Icons.restaurant_menu_outlined),
            selectedIcon: Icon(Icons.restaurant_menu),
            label: 'Рецепты',
          ),
          const NavigationDestination(
            icon: Icon(Icons.calculate_outlined),
            selectedIcon: Icon(Icons.calculate),
            label: 'Норма',
          ),
          if (db != null)
            const NavigationDestination(
              icon: Icon(Icons.menu_book_outlined),
              selectedIcon: Icon(Icons.menu_book),
              label: 'Книга',
            ),
        ],
      ),
    );
  }
}
