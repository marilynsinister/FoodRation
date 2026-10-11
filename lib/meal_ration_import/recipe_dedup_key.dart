import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'parsed_meal_plan.dart';

String _normToken(String s) {
  return s.toLowerCase().replaceAll(RegExp(r'\s+'), ' ').trim();
}

/// Stable hash for merging the same dish across days (ingredients + steps + yield).
String recipeDedupKey(ParsedRecipe r) {
  final ing = r.ingredients
      .map((e) => '${_normToken(e.raw)}|${e.amount}|${e.unit}')
      .join(';');
  final st = r.steps.map((e) => '${e.number}:${_normToken(e.text)}').join(';');
  final payload =
      '${r.normalizedName}|$ing|$st|${r.yieldServings ?? ''}|${r.yieldText ?? ''}';
  final bytes = utf8.encode(payload);
  return sha256.convert(bytes).toString();
}
