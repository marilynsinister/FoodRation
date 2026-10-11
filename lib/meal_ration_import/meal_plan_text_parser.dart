import 'parsed_meal_plan.dart';
import 'pdf_text_page.dart';

typedef _Line = ({int page, String text});

final _dayRe = RegExp(r'^День\s+(\d+)\s*$', caseSensitive: false);
final _dailyKbjRe = RegExp(
  r'^К[Бб][Жж][Уу]\s+на\s+день:\s*(\d+)/(\d+)/(\d+)/(\d+)\s*$',
  caseSensitive: false,
);
final _mealHeaderRe = RegExp(
  r'^(Завтрак|Обед|Перекус|Ужин)\s*(?:\(к[бб][жж][уу]\s*(\d+)/(\d+)/(\d+)/(\d+)\))?\s*$',
  caseSensitive: false,
);
final _bulletRe = RegExp(r'^[▪•]\s*(.+)$');
final _pageMarkerRe = RegExp(r'^--\s*\d+\s+of\s+\d+\s*--\s*$', caseSensitive: false);
final _shoppingRe = RegExp(r'Продуктовая\s+корзина', caseSensitive: false);
final _instaRe = RegExp(r'@([a-zA-Z0-9_.]+)');
final _yieldLineRe = RegExp(r'^Готовим\s+на\s+2\s+дня:?\s*$', caseSensitive: false);
final _stepStartRe = RegExp(r'^(\d+)\.\s*(.*)$');
final _prepHeaderRe = RegExp(
  r'^Приготовление|^Способ\s+приготовления|^Для\s+заливки:|^Для\s+заправки:',
  caseSensitive: false,
);

const _mealRuToEn = {
  'завтрак': 'breakfast',
  'обед': 'lunch',
  'перекус': 'snack',
  'ужин': 'dinner',
};

/// Flattens [pages] to lines with 1-based PDF page indices.
List<_Line> _flattenPages(List<PdfTextPage> pages) {
  final out = <_Line>[];
  for (final p in pages) {
    for (final raw in p.text.split('\n')) {
      final line = raw.trim();
      if (line.isEmpty) continue;
      if (_pageMarkerRe.hasMatch(line)) continue;
      out.add((page: p.pageNumber, text: line));
    }
  }
  return out;
}

double _portionFromTitle(String title) {
  final t = title.toLowerCase();
  if (t.contains('половина порции') || t.contains('1/2 порции')) return 0.5;
  return 1.0;
}

String _canonicalTitle(String title) {
  var s = title.trim();
  s = s.replaceAll(RegExp(r'\s*\(?половина\s+порции\)?\.?', caseSensitive: false), '');
  s = s.replaceAll(RegExp(r',\s*половина\s+порции\.?', caseSensitive: false), '');
  s = s.replaceAll(RegExp(r'\s+половина\s+порции\.?', caseSensitive: false), '');
  s = s.replaceAll(RegExp(r'половина\s+порции\.?', caseSensitive: false), '');
  s = s.replaceAll(RegExp(r',\s*$'), '');
  return s.trim();
}

String _normalizeName(String s) {
  var t = s.toLowerCase().trim();
  t = t.replaceAll(RegExp(r'[«»"„]'), '');
  t = t.replaceAll(RegExp(r'\s+'), ' ');
  return t;
}

bool _isLikelyIngredientLine(String line) {
  if (_stepStartRe.hasMatch(line)) return false;
  if (_yieldLineRe.hasMatch(line)) return false;
  if (line.length > 120) return false;
  final lower = line.toLowerCase().trim();
  if (lower == 'яйцо' ||
      lower == 'яйца' ||
      lower.startsWith('яйцо ') ||
      lower.startsWith('яйца ') ||
      (lower.contains('яйцо') && line.length < 50) ||
      (lower.contains('яйца') && line.length < 50)) {
    return true;
  }
  if (lower == 'сахзам' ||
      lower.startsWith('сахарозаменитель') ||
      lower.startsWith('сахзам ')) {
    return true;
  }
  if (lower.contains('по вкусу')) return true;
  if (RegExp(r'\d').hasMatch(line) &&
      (line.contains('гр') ||
          line.contains('г ') ||
          line.contains('мл') ||
          line.contains('шт') ||
          line.contains('ч.л') ||
          line.contains('ч. л'))) {
    return true;
  }
  if (line.contains('–') || line.contains(' - ')) return true;
  return false;
}

/// Second line of a dish title split across PDF lines, e.g. «…половина» + «порции».
bool _isBulletTitleContinuation(String title, String line) {
  final t = title.trim().toLowerCase();
  final l = line.trim().toLowerCase();
  if (t.endsWith('половина') && (l == 'порции' || l == 'порции.')) return true;
  if (t.endsWith('половина,') && (l == 'порции' || l == 'порции.')) return true;
  return false;
}

/// Extra позиция в том же приёме без нового «▪» (часто «Чай + …»).
bool _isImplicitSecondItemLine(String line) {
  final l = line.trim().toLowerCase();
  if (l.startsWith('чай +') || l.startsWith('чай+')) return true;
  if (l.startsWith('кофе +') || l.startsWith('кофе+')) return true;
  return false;
}

bool _titleOnlySimple(String title) {
  final c = _canonicalTitle(title);
  return _isLikelyIngredientLine(c) && !c.contains('+');
}

List<ParsedIngredientLine> _parseIngredients(List<_Line> body) {
  final list = <ParsedIngredientLine>[];
  for (final L in body) {
    final line = L.text;
    if (line.isEmpty) continue;
    if (_yieldLineRe.hasMatch(line)) continue;
    if (_prepHeaderRe.hasMatch(line)) continue;
    if (_stepStartRe.hasMatch(line)) break;
    if (!_isLikelyIngredientLine(line) && list.isEmpty) continue;
    if (!_isLikelyIngredientLine(line) && list.isNotEmpty) break;
    list.add(_parseOneIngredient(line));
  }
  return list;
}

ParsedIngredientLine _parseOneIngredient(String line) {
  var prepState = '';
  var rest = line;
  final dry = RegExp(r'\(([^)]*сухом[^)]*)\)', caseSensitive: false);
  final mDry = dry.firstMatch(line);
  if (mDry != null) {
    prepState = mDry.group(1)!.trim();
    rest = line.replaceAll(mDry.group(0)!, '').trim();
  }
  double? amount;
  String? unit;
  String? amountText;
  final amountTail = RegExp(
    r'[,\s]+(\d+(?:[.,]\d+)?)\s*(гр|г|мл|ml|шт|штук|ч\.?\s*л\.?)\s*$',
    caseSensitive: false,
  );
  final tailM = amountTail.firstMatch(rest);
  if (tailM != null) {
    amount = double.tryParse(tailM.group(1)!.replaceAll(',', '.'));
    unit = _normUnit(tailM.group(2)!);
    amountText = tailM.group(0)!.trim();
    rest = rest.substring(0, tailM.start).trim();
  }
  final dash = RegExp(r'\s*[–-]\s*');
  if (amount == null && dash.hasMatch(rest)) {
    final parts = rest.split(dash);
    if (parts.length >= 2) {
      final last = parts.last.trim();
      final numM = RegExp(r'^(\d+(?:[.,]\d+)?)\s*(гр|г|мл|шт)?\s*$', caseSensitive: false)
          .firstMatch(last);
      if (numM != null) {
        amount = double.tryParse(numM.group(1)!.replaceAll(',', '.'));
        unit = _normUnit(numM.group(2) ?? 'g');
        rest = parts.sublist(0, parts.length - 1).join(' – ').trim();
        amountText = last;
      }
    }
  }
  if (rest.toLowerCase().contains('по вкусу')) {
    amountText = 'по вкусу';
  }
  return ParsedIngredientLine(
    raw: line,
    amount: amount,
    unit: unit,
    amountText: amountText,
    preparationState: prepState.isEmpty ? null : prepState,
  );
}

String _normUnit(String u) {
  final x = u.toLowerCase().replaceAll(RegExp(r'\s'), '');
  if (x == 'гр' || x == 'г') return 'g';
  if (x == 'мл') return 'ml';
  if (x.startsWith('шт')) return 'pc';
  if (x.contains('ч.л') || x.contains('чл')) return 'tsp';
  return u;
}

List<ParsedStep> _parseSteps(List<_Line> body) {
  final steps = <int, StringBuffer>{};
  var inSteps = false;
  for (final L in body) {
    final line = L.text.trim();
    if (!inSteps) {
      if (_stepStartRe.hasMatch(line)) {
        inSteps = true;
      } else if (_prepHeaderRe.hasMatch(line)) {
        continue;
      } else {
        continue;
      }
    }
    final sm = _stepStartRe.firstMatch(line);
    if (sm != null) {
      final n = int.tryParse(sm.group(1)!);
      if (n != null) {
        steps[n] = StringBuffer(sm.group(2)!.trim());
      }
    } else if (steps.isNotEmpty) {
      final lastN = steps.keys.reduce((a, b) => a > b ? a : b);
      steps[lastN]!.write(' ');
      steps[lastN]!.write(line);
    }
  }
  final out = <ParsedStep>[];
  for (final n in steps.keys.toList()..sort()) {
    final text = steps[n]!.toString().trim();
    if (text.isEmpty) continue;
    out.add(ParsedStep(
      number: n,
      text: text,
      timeMinutes: _extractMinutes(text),
      temperatureC: _extractTemp(text),
    ));
  }
  return out;
}

int? _extractMinutes(String text) {
  final m = RegExp(r'(\d+)\s*[-–]?\s*(\d+)?\s*минут', caseSensitive: false).firstMatch(text);
  if (m != null) return int.tryParse(m.group(1)!);
  return null;
}

int? _extractTemp(String text) {
  final m = RegExp(r'(\d+)\s*градус', caseSensitive: false).firstMatch(text);
  if (m != null) return int.tryParse(m.group(1)!);
  return null;
}

ParsedRecipe? _bodyToRecipe(String canonical, List<_Line> body, int? pStart, int? pEnd) {
  if (body.isEmpty) return null;
  var yieldServings = 0.0;
  String? yieldText;
  for (final L in body) {
    if (_yieldLineRe.hasMatch(L.text)) {
      yieldServings = 2;
      yieldText = 'Готовим на 2 дня';
      break;
    }
  }
  final ingredients = _parseIngredients(body);
  final steps = _parseSteps(body);
  if (ingredients.isEmpty && steps.isEmpty) return null;
  int? cookMin;
  int? temp;
  for (final s in steps) {
    cookMin ??= s.timeMinutes;
    temp ??= s.temperatureC;
  }
  final norm = _normalizeName(canonical);
  return ParsedRecipe(
    canonicalName: canonical,
    normalizedName: norm,
    ingredients: ingredients,
    steps: steps,
    yieldServings: yieldServings > 0 ? yieldServings : null,
    yieldText: yieldText,
    pageStart: pStart,
    pageEnd: pEnd,
    cookTimeMinutes: cookMin,
    temperatureC: temp,
  );
}

ParsedSlotItem _flushItem(
  String title,
  List<_Line> body,
) {
  final display = title.trim();
  final portion = _portionFromTitle(display);
  final canonical = _canonicalTitle(display);
  final pStart = body.isNotEmpty ? body.first.page : null;
  final pEnd = body.isNotEmpty ? body.last.page : null;

  if (body.isEmpty && _titleOnlySimple(display)) {
    return ParsedSlotItem(
      displayName: display,
      portionFraction: portion,
      simpleRaw: _canonicalTitle(display),
      pageStart: pStart,
      pageEnd: pEnd,
    );
  }

  final recipe = _bodyToRecipe(canonical, body, pStart, pEnd);
  if (recipe != null) {
    return ParsedSlotItem(
      displayName: display,
      portionFraction: portion,
      recipe: recipe,
      pageStart: pStart,
      pageEnd: pEnd,
    );
  }

  if (body.isNotEmpty) {
    final asSimple = body.map((e) => e.text).join('; ');
    return ParsedSlotItem(
      displayName: display,
      portionFraction: portion,
      simpleRaw: asSimple,
      pageStart: pStart,
      pageEnd: pEnd,
    );
  }

  return ParsedSlotItem(
    displayName: display,
    portionFraction: portion,
    simpleRaw: _canonicalTitle(display),
    pageStart: pStart,
    pageEnd: pEnd,
  );
}

/// Parses structured days / slots / items from PDF text pages.
ParsedImportBundle parseMealPlanTextPages(List<PdfTextPage> pages) {
  final meta = ParsedMealPlanMeta();
  final days = <ParsedDay>[];
  final basket = StringBuffer();

  final lines = _flattenPages(pages);
  ParsedDay? curDay;
  ParsedSlot? curSlot;
  var slotOrder = 0;
  String? itemTitle;
  final itemBody = <_Line>[];
  var shoppingMode = false;
  var seenFirstDay = false;

  void flushItem() {
    if (curSlot == null || itemTitle == null) {
      itemTitle = null;
      itemBody.clear();
      return;
    }
    final item = _flushItem(itemTitle!, List.from(itemBody));
    curSlot!.items.add(item);
    itemTitle = null;
    itemBody.clear();
  }

  void flushSlot() {
    flushItem();
    if (curSlot != null && curDay != null) {
      if (curSlot!.items.isNotEmpty || curSlot!.displayNameRu.isNotEmpty) {
        curDay!.slots.add(curSlot!);
      }
    }
    curSlot = null;
  }

  void flushDay() {
    flushSlot();
    if (curDay != null) {
      days.add(curDay!);
    }
    curDay = null;
    slotOrder = 0;
  }

  for (final L in lines) {
    var line = L.text;
    if (!seenFirstDay) {
      final im = _instaRe.firstMatch(line);
      if (im != null) {
        meta.author = '@${im.group(1)}';
      }
    }

    if (_shoppingRe.hasMatch(line)) {
      flushDay();
      shoppingMode = true;
      basket.writeln(line);
      continue;
    }
    if (shoppingMode) {
      basket.writeln(line);
      continue;
    }

    final dm = _dayRe.firstMatch(line);
    if (dm != null) {
      flushDay();
      seenFirstDay = true;
      final n = int.parse(dm.group(1)!);
      curDay = ParsedDay(dayNumber: n);
      continue;
    }

    if (curDay != null) {
      final dk = _dailyKbjRe.firstMatch(line);
      if (dk != null) {
        curDay!.dailyKcal = double.tryParse(dk.group(1)!);
        curDay!.dailyProtein = double.tryParse(dk.group(2)!);
        curDay!.dailyFat = double.tryParse(dk.group(3)!);
        curDay!.dailyCarbs = double.tryParse(dk.group(4)!);
        continue;
      }
    }

    final mm = _mealHeaderRe.firstMatch(line);
    if (mm != null && curDay != null) {
      flushSlot();
      final ru = mm.group(1)!.toLowerCase();
      final en = _mealRuToEn[ru] ?? 'other';
      double? sk, sp, sf, sc;
      if (mm.group(2) != null) {
        sk = double.tryParse(mm.group(2)!);
        sp = double.tryParse(mm.group(3)!);
        sf = double.tryParse(mm.group(4)!);
        sc = double.tryParse(mm.group(5)!);
      }
      curSlot = ParsedSlot(
        mealType: en,
        displayNameRu: mm.group(1)!,
        orderIndex: slotOrder++,
        slotKcal: sk,
        slotProtein: sp,
        slotFat: sf,
        slotCarbs: sc,
      );
      continue;
    }

    final bm = _bulletRe.firstMatch(line);
    if (bm != null && curSlot != null) {
      flushItem();
      itemTitle = bm
          .group(1)!
          .trim()
          .replaceFirst(RegExp(r':\s*$'), '');
      continue;
    }

    if (curSlot != null && itemTitle != null) {
      if (itemBody.isEmpty &&
          _isBulletTitleContinuation(itemTitle!, line)) {
        itemTitle = '${itemTitle!.trim()} ${line.trim()}';
        continue;
      }
      if (itemBody.isNotEmpty && _isImplicitSecondItemLine(line)) {
        flushItem();
        itemTitle = line.trim().replaceFirst(RegExp(r':\s*$'), '');
        continue;
      }
      itemBody.add(L);
      continue;
    }

    if (!seenFirstDay) {
      meta.introNotes.writeln(line);
    }
  }

  flushDay();
  if (shoppingMode && basket.isEmpty) {
    return ParsedImportBundle(meta: meta, days: days);
  }
  final basketStr = basket.isNotEmpty ? basket.toString().trim() : null;
  return ParsedImportBundle(meta: meta, days: days, shoppingBasketRaw: basketStr);
}
