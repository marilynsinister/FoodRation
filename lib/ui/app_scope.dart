import 'package:flutter/widgets.dart';

import 'package:food_ration/foods/custom_foods.dart';
import 'package:food_ration/planner/planner_controller.dart';

/// Даёт экранам (в том числе открытым через Navigator) доступ к плану
/// и своим продуктам.
class AppScope extends InheritedWidget {
  const AppScope({super.key, required this.planner, required this.foods, required super.child});

  final PlannerController planner;
  final CustomFoodsController foods;

  static AppScope? _of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<AppScope>();

  static PlannerController? plannerOf(BuildContext context) => _of(context)?.planner;

  static CustomFoodsController? foodsOf(BuildContext context) => _of(context)?.foods;

  @override
  bool updateShouldNotify(AppScope old) => planner != old.planner || foods != old.foods;
}
