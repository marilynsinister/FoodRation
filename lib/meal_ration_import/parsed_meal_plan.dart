/// In-memory result of parsing a Rovenskaya-style meal PDF (text layer).
class ParsedImportBundle {
  ParsedImportBundle({
    required this.meta,
    required this.days,
    this.shoppingBasketRaw,
  });

  final ParsedMealPlanMeta meta;
  final List<ParsedDay> days;
  final String? shoppingBasketRaw;
}

class ParsedMealPlanMeta {
  ParsedMealPlanMeta({this.author});

  String? author;
  final StringBuffer introNotes = StringBuffer();
}

class ParsedDay {
  ParsedDay({required this.dayNumber});

  final int dayNumber;
  double? dailyKcal;
  double? dailyProtein;
  double? dailyFat;
  double? dailyCarbs;
  final List<ParsedSlot> slots = [];
}

class ParsedSlot {
  ParsedSlot({
    required this.mealType,
    required this.displayNameRu,
    required this.orderIndex,
    this.slotKcal,
    this.slotProtein,
    this.slotFat,
    this.slotCarbs,
  });

  final String mealType;
  final String displayNameRu;
  final int orderIndex;
  final double? slotKcal;
  final double? slotProtein;
  final double? slotFat;
  final double? slotCarbs;
  final List<ParsedSlotItem> items = [];
}

class ParsedSlotItem {
  ParsedSlotItem({
    required this.displayName,
    required this.portionFraction,
    this.recipe,
    this.simpleRaw,
    this.pageStart,
    this.pageEnd,
  });

  final String displayName;
  final double portionFraction;
  final ParsedRecipe? recipe;
  final String? simpleRaw;
  final int? pageStart;
  final int? pageEnd;
}

class ParsedRecipe {
  ParsedRecipe({
    required this.canonicalName,
    required this.normalizedName,
    required this.ingredients,
    required this.steps,
    this.yieldServings,
    this.yieldText,
    this.pageStart,
    this.pageEnd,
    this.cookTimeMinutes,
    this.temperatureC,
  });

  final String canonicalName;
  final String normalizedName;
  final List<ParsedIngredientLine> ingredients;
  final List<ParsedStep> steps;
  final double? yieldServings;
  final String? yieldText;
  final int? pageStart;
  final int? pageEnd;
  final int? cookTimeMinutes;
  final int? temperatureC;
}

class ParsedIngredientLine {
  ParsedIngredientLine({
    required this.raw,
    this.amount,
    this.unit,
    this.amountText,
    this.preparationState,
  });

  final String raw;
  final double? amount;
  final String? unit;
  final String? amountText;
  final String? preparationState;
}

class ParsedStep {
  ParsedStep({
    required this.number,
    required this.text,
    this.timeMinutes,
    this.temperatureC,
  });

  final int number;
  final String text;
  final int? timeMinutes;
  final int? temperatureC;
}
