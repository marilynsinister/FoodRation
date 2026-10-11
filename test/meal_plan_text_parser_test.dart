import 'package:flutter_test/flutter_test.dart';
import 'package:food_ration/meal_ration_import/meal_plan_text_parser.dart';
import 'package:food_ration/meal_ration_import/pdf_text_page.dart';

void main() {
  test('parseMealPlanTextPages extracts day, slots, recipe and half portion', () {
    const text = '''
День 1
КБЖУ на день: 1298/85/43/150
Завтрак (кбжу 299/11/6/53)
▪ Ленивая овсянка:
геркулес, 40 гр
1. Смешать и оставить на ночь.
Обед (кбжу 352/25/7/50)
▪ Спагетти «Болоньезе» (половина порции)
Готовим на 2 дня:
Фарш - 200 г
1. Обжарить фарш.
''';
    final bundle = parseMealPlanTextPages([PdfTextPage(pageNumber: 1, text: text)]);

    expect(bundle.days, hasLength(1));
    final day = bundle.days.single;
    expect(day.dayNumber, 1);
    expect(day.dailyKcal, 1298);
    expect(day.slots, hasLength(2));

    final breakfast = day.slots.first;
    expect(breakfast.mealType, 'breakfast');
    expect(breakfast.items.single.recipe, isNotNull);
    expect(breakfast.items.single.recipe!.canonicalName, 'Ленивая овсянка');

    final lunch = day.slots[1];
    expect(lunch.mealType, 'lunch');
    final lunchItem = lunch.items.single;
    expect(lunchItem.portionFraction, 0.5);
    expect(lunchItem.recipe, isNotNull);
    expect(lunchItem.recipe!.yieldServings, 2);
  });

  test('1300_2 style: title wraps половина + порции; Чай + as second item', () {
    const text = '''
День 1
КБЖУ на день: 1293/111/51/100
Завтрак (кбжу 286/25/8/28)
▪ Рулет из лаваша:
лаваш, 50 гр
Чай + шоколад, 20 гр
Обед (кбжу 360/29/13/33)
▪ Куриное филе с грибами, половина
порции
Готовим на 2 дня:
Филе - 160 г
1. Нарезать.
''';
    final bundle = parseMealPlanTextPages([PdfTextPage(pageNumber: 1, text: text)]);
    final breakfast = bundle.days.single.slots.first;
    expect(breakfast.items, hasLength(2));
    expect(breakfast.items.first.displayName, 'Рулет из лаваша');
    expect(breakfast.items.first.recipe, isNotNull);
    expect(breakfast.items[1].displayName, 'Чай + шоколад, 20 гр');
    expect(breakfast.items[1].simpleRaw, isNotNull);

    final lunch = bundle.days.single.slots[1];
    expect(lunch.items, hasLength(1));
    final li = lunch.items.single;
    expect(li.portionFraction, 0.5);
    expect(li.recipe!.canonicalName, 'Куриное филе с грибами');
    expect(li.recipe!.yieldServings, 2);
  });
}
