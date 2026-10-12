import 'dart:math' as math;

/// Единица количества в строке ингредиента.
enum QtyUnit {
  g('г'),
  ml('мл'),
  pcs('шт'),
  tbsp('ст. л.'),
  tsp('ч. л.'),
  cup('стакан');

  const QtyUnit(this.label);

  final String label;

  /// Примерный вес в граммах одной единицы (мл ≈ г); null для штук.
  double? get gramsPerUnit => switch (this) {
        g || ml => 1,
        tbsp => 15,
        tsp => 5,
        cup => 200,
        pcs => null,
      };
}

/// Как количество сравнивается с запасами: по весу/объёму или поштучно.
enum QtyKind { mass, count }

/// Строка ингредиента из рецепта, разобранная на название и количество.
///
/// Исходные строки свободного вида: «Творог 5% - 150 гр», «Яйца, 2 шт»,
/// «190 г молока 1,5%», «Соль по вкусу».
class Ingredient {
  Ingredient._({
    required this.raw,
    required this.name,
    this.amount,
    this.unit,
    this.altGrams,
    this.numberStart,
    this.numberEnd,
  });

  factory Ingredient.parse(String raw) {
    final outer = raw.replaceAllMapped(_parens, (m) => ' ' * m[0]!.length);
    final match = _qty.firstMatch(outer) ?? _qty.firstMatch(raw);
    if (match == null) return _parseLoose(raw, outer);
    final unit = _unitOf(match.group(2)!);
    var amount = _number(match.group(1)!);
    final lower = match.group(2)!.toLowerCase();
    if (lower == 'кг' || lower == 'л') amount *= 1000;
    final before = raw.substring(0, match.start);
    final after = raw.substring(match.end);
    final name = cleanName(before.trim().isEmpty ? after : before);
    double? alt;
    if (unit == QtyUnit.pcs) {
      final m = _altGrams.firstMatch(after);
      if (m != null) alt = _number(m.group(1)!);
    }
    return Ingredient._(
      raw: raw,
      name: name.isEmpty ? cleanName(raw) : name,
      amount: amount,
      unit: unit,
      altGrams: alt,
      numberStart: match.start,
      numberEnd: match.start + match.group(1)!.length,
    );
  }

  /// Записи без единиц: «Куриное филе, 160» (граммы), «2 яйца», «Чеснок - 2 зубчика».
  static Ingredient _parseLoose(String raw, String outer) {
    Ingredient counted(RegExpMatch m, QtyUnit unit, String name) => Ingredient._(
          raw: raw,
          name: name,
          amount: _number(m[0]!),
          unit: unit,
          numberStart: m.start,
          numberEnd: m.end,
        );
    final trailing = _trailingGrams.firstMatch(outer);
    if (trailing != null) {
      return counted(trailing, QtyUnit.g, cleanName(raw.substring(0, trailing.start)));
    }
    final pieces = _pieceWords.firstMatch(outer);
    if (pieces != null) {
      return counted(pieces, QtyUnit.pcs, cleanName(raw.substring(0, pieces.start)));
    }
    final leading = _leadingCount.firstMatch(outer);
    if (leading != null) {
      return counted(leading, QtyUnit.pcs, cleanName(raw.substring(leading.end)));
    }
    return Ingredient._(raw: raw, name: cleanName(raw));
  }

  final String raw;

  /// Название без количества и уточнений: «Творог 5%» → «творог».
  final String name;

  /// Количество в [unit]; кг и литры уже переведены в г и мл.
  final double? amount;
  final QtyUnit? unit;

  /// Вес из скобок для штучных: «Яйца - 2 шт. (110 г)».
  final double? altGrams;

  final int? numberStart;
  final int? numberEnd;

  /// Можно учитывать в запасах (есть количество).
  bool get tracked => amount != null && amount! > 0;

  late final List<String> tokens = nameTokens(name);

  /// Количество, умноженное на [scale], в единицах вида [kind].
  /// Для штук без известного веса и пересчёта в массу — null.
  double? quantityIn(QtyKind kind, double scale) {
    if (!tracked) return null;
    final a = amount! * scale;
    if (kind == QtyKind.count) {
      if (unit == QtyUnit.pcs) return a;
      final per = pieceGrams(tokens);
      final grams = unit!.gramsPerUnit;
      return per == null || grams == null ? null : a * grams / per;
    }
    final grams = unit!.gramsPerUnit;
    if (grams != null) return a * grams;
    if (altGrams != null) return altGrams! * scale;
    final per = pieceGrams(tokens);
    return per == null ? null : a * per;
  }

  /// Естественный вид количества: штуки или масса.
  QtyKind? get kind => !tracked ? null : unit == QtyUnit.pcs ? QtyKind.count : QtyKind.mass;

  /// Строка рецепта с количеством, умноженным на [scale].
  String scaled(double scale) {
    if (!tracked || (scale - 1).abs() < 1e-6) return raw;
    final original = raw.substring(numberStart!, numberEnd!);
    final value = _number(original) * scale;
    final unitText = raw.substring(numberEnd!).trimLeft().toLowerCase();
    // В исходной строке «кг»/«л» — показываем в тех же единицах.
    final big = unitText.startsWith('кг') || unitText.startsWith('л');
    return raw.replaceRange(
      numberStart!,
      numberEnd!,
      formatAmount(value, unit!, big: big),
    );
  }

  static String formatAmount(double value, QtyUnit unit, {bool big = false}) {
    if (big) return _trim(value, 2);
    switch (unit) {
      case QtyUnit.g:
      case QtyUnit.ml:
        if (value >= 20) return '${(value / 5).round() * 5}';
        if (value >= 3) return '${value.round()}';
        return _trim(value, 1);
      case QtyUnit.pcs:
      case QtyUnit.tbsp:
      case QtyUnit.tsp:
      case QtyUnit.cup:
        final halves = (value * 2).round() / 2;
        return _trim(halves == 0 ? 0.5 : halves, 1);
    }
  }

  static String _trim(double v, int digits) {
    if ((v - v.roundToDouble()).abs() < 1e-6) return v.round().toString();
    return v.toStringAsFixed(digits).replaceFirst(RegExp(r'0+$'), '').replaceAll('.', ',');
  }

  static final _parens = RegExp(r'\([^)]*\)?');
  static const _notLetter = r'(?![а-яёa-z])';
  static final _qty = RegExp(
    r'(\d+(?:[.,]\d+)?(?:\s*/\s*\d+)?|½|¼|¾)\s*'
    r'(кг|гр|г|g|мл|л|шт|стол[а-яё]*\s+лож[а-яё]*|чайн[а-яё]*\s+лож[а-яё]*|ст\.?\s*л|ч\.?\s*л|стакан[а-яё]*|ст)\.?'
    '$_notLetter',
    caseSensitive: false,
  );
  // Совпадение — только само число, остальное в lookaround.
  static final _trailingGrams = RegExp(r'(?<=,\s*)\d+(?:[.,]\d+)?(?=\s*$)');
  static final _pieceWords = RegExp(
    r'\d+(?:[.,]\d+)?(?=\s*(?:небольш[а-яё]*\s+|крупн[а-яё]*\s+)?(?:зубч|пуч))',
    caseSensitive: false,
  );
  static final _leadingCount = RegExp(r'(?<=^\s*)\d+(?=\s+[а-яё])', caseSensitive: false);
  static final _altGrams = RegExp(r'\(\s*(\d+(?:[.,]\d+)?)\s*(?:гр|г)\.?' '$_notLetter', caseSensitive: false);

  static QtyUnit _unitOf(String u) {
    final s = u.toLowerCase().replaceAll(RegExp(r'[\s.]'), '');
    if (s == 'мл' || s == 'л') return QtyUnit.ml;
    if (s == 'шт') return QtyUnit.pcs;
    if (s == 'стл' || s.startsWith('стол')) return QtyUnit.tbsp;
    if (s == 'чл' || s.startsWith('чайн')) return QtyUnit.tsp;
    if (s.startsWith('ст')) return QtyUnit.cup;
    return QtyUnit.g;
  }

  static double _number(String s) {
    switch (s) {
      case '½':
        return 0.5;
      case '¼':
        return 0.25;
      case '¾':
        return 0.75;
    }
    if (s.contains('/')) {
      final parts = s.split('/');
      final a = double.parse(parts[0].trim().replaceAll(',', '.'));
      final b = double.parse(parts[1].trim().replaceAll(',', '.'));
      return b == 0 ? a : a / b;
    }
    return double.parse(s.replaceAll(',', '.'));
  }

  /// Название продукта для показа: без скобок, процентов и «по вкусу».
  static String cleanName(String s) {
    var t = s.replaceAll(_parens, ' ');
    t = t.replaceAll(RegExp(r'\d+(?:[.,]\d+)?\s*%'), ' ');
    t = t.replaceAll(RegExp(r'по вкусу', caseSensitive: false), ' ');
    t = t.replaceAll(RegExp(r'[-–—:,;.]+\s*$'), ' ');
    t = t.split(RegExp(r'\s[-–—]\s|,')).first;
    t = t.replaceAll(RegExp(r'\s+'), ' ').trim();
    return t.toLowerCase();
  }

  static const _stopWords = {
    'и', 'или', 'для', 'с', 'со', 'по', 'на', 'в', 'из', 'без', 'любой', 'любые', 'свежие',
    'свежий', 'свежая', 'вкусу', 'можно', 'шт', 'гр', 'г', 'мл',
  };

  /// Слова названия для сопоставления с запасами.
  static List<String> nameTokens(String name) => [
        for (final w in name.toLowerCase().replaceAll('ё', 'е').split(RegExp(r'[^а-яa-z]+')))
          if (w.length >= 2 && !_stopWords.contains(w)) w,
      ];

  /// Совпадение слов с учётом окончаний: «яйца» ~ «яйцо», «творог» ~ «творога».
  static bool tokensMatch(String a, String b) {
    if (a == b) return true;
    final n = math.min(a.length, b.length);
    if (n < 3) return false;
    var common = 0;
    while (common < n && a.codeUnitAt(common) == b.codeUnitAt(common)) {
      common++;
    }
    return common >= math.max(3, n - 2);
  }

  /// Все слова названия запаса встречаются в названии ингредиента.
  static bool nameCovers(List<String> pantryTokens, List<String> ingredientTokens) =>
      pantryTokens.isNotEmpty &&
      pantryTokens.every((p) => ingredientTokens.any((i) => tokensMatch(p, i)));

  /// Средний вес штуки для частых продуктов.
  static double? pieceGrams(List<String> tokens) {
    for (final t in tokens) {
      for (final e in _pieceWeights.entries) {
        if (tokensMatch(e.key, t)) return e.value;
      }
    }
    return null;
  }

  static const _pieceWeights = {
    'яйцо': 55.0,
    'белок': 33.0,
    'желток': 18.0,
    'банан': 120.0,
    'яблоко': 150.0,
    'луковица': 80.0,
    'помидор': 120.0,
    'огурец': 100.0,
    'морковь': 80.0,
    'картофелина': 100.0,
  };
}
