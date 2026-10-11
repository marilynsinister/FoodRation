"""Extracts recipes with declared KBJU from FoodRation_data/*.pdf into
assets/recipes/recipes.json.

Usage: python -X utf8 tool/extract_recipes.py [--report]

Requires PyMuPDF (`pip install pymupdf`).
"""

from __future__ import annotations

import glob
import hashlib
import json
import os
import re
import sys
from collections import Counter

import fitz  # PyMuPDF

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DATA_DIR = os.path.join(ROOT, 'FoodRation_data')
OUT_FILE = os.path.join(ROOT, 'assets', 'recipes', 'recipes.json')

# Personal menu constructors: their recipe annex has no KBJU.
SKIP_PREFIXES = ('Марина',)

NUM = r'(\d+(?:[.,]\d+)?)'
BULLET_CHARS = '•▪\uf0b7\uf0a7\uf0d8\uf0fc\uf076\uf0a8\u25aa\u25cf\u2022'

MEAL_RU = {
    'завтрак': 'breakfast',
    'обед': 'lunch',
    'перекус': 'snack',
    'ужин': 'dinner',
}

ALL_MEALS = ['breakfast', 'lunch', 'snack', 'dinner']


def fnum(s: str) -> float:
    return float(s.replace(',', '.'))


# --------------------------------------------------------------------------
# Text cleanup
# --------------------------------------------------------------------------

def load_lines(path: str, keep_square: bool = False) -> list[tuple[int, str]]:
    """Cleaned non-empty lines as (page, text); bullets become '• '.

    With [keep_square] the ration item marker '▪' is preserved as '▪ '.
    """
    doc = fitz.open(path)
    raw: list[tuple[int, str]] = []
    for pi, page in enumerate(doc):
        for line in page.get_text().split('\n'):
            raw.append((pi + 1, line))
    out: list[tuple[int, str]] = []
    carry_bullet = ''
    for page, line in raw:
        s = line.replace('\xa0', ' ').strip()
        if not s:
            continue
        if carry_bullet and s[0] not in BULLET_CHARS:
            s = carry_bullet + ' ' + s
        carry_bullet = ''
        if len(s) > 1 and s[-1] in BULLET_CHARS and s[-1] != '▪':
            carry_bullet = s[-1]
            s = s[:-1].strip()
        if 'rovenskaya_sveta' in s and len(s) < 60:
            continue
        if re.fullmatch(r'\d{1,3}', s):
            continue
        if s.startswith('Вернуться НАЗАД'):
            continue
        if s.startswith('▪') and keep_square:
            s = '▪ ' + s[1:].strip()
        else:
            for ch in BULLET_CHARS:
                if s.startswith(ch):
                    s = '• ' + s[len(ch):].strip()
                    break
        s = re.sub(r'\s+', ' ', s).strip()
        out.append((page, s))
    merged: list[tuple[int, str]] = []
    i = 0
    while i < len(out):
        page, s = out[i]
        if (s in ('•', '▪') or re.fullmatch(r'\d+[.)]', s)) and i + 1 < len(out):
            nxt = out[i + 1][1]
            if s in ('•', '▪'):
                nxt = nxt[2:] if nxt.startswith(('• ', '▪ ')) else nxt
                merged.append((page, s + ' ' + nxt))
            else:
                merged.append((page, f'{s} {nxt}'))
            i += 2
            continue
        merged.append((page, s))
        i += 1
    return merged


def is_bullet(s: str) -> bool:
    return s.startswith(('• ', '▪ '))


def is_step(s: str) -> bool:
    return re.match(r'^\d+\.\s*\S', s) is not None


def is_caps_header(s: str) -> bool:
    # «ПРОЧЕЕ (соусы, кремы, глазурь):» — заголовок с пояснением в скобках.
    letters = re.sub(r'[^А-Яа-яЁёA-Za-z]', '', s.split('(')[0])
    return len(letters) >= 4 and letters.upper() == letters and not re.search(r'\d', s)


# --------------------------------------------------------------------------
# Nutrition blocks
# --------------------------------------------------------------------------

KBJU_RE = re.compile(
    r'^КБЖУ\s+на\s+(?P<basis>[^:]+?)\s*:\s*' + NUM + r'\s*/\s*' + NUM + r'\s*/\s*' + NUM + r'\s*/\s*' + NUM,
    re.IGNORECASE,
)


def _find_value(lines, start, end, keyword):
    for j in range(start, min(end, len(lines))):
        s = lines[j][1]
        if re.search(keyword, s, re.IGNORECASE):
            m = re.search(NUM, s.split(':', 1)[-1] if ':' in s else s)
            if m:
                return fnum(m.group(1)), j
    return None, None


def find_nutrition_blocks(lines):
    """Returns list of dicts: start, end (inclusive), kind, values."""
    blocks = []
    i = 0
    while i < len(lines):
        s = lines[i][1]
        m = KBJU_RE.match(s)
        if m:
            basis = m.group('basis').lower()
            vals = [fnum(m.group(k)) for k in range(2, 6)]
            b = {'start': i, 'end': i, 'values': vals}
            gm = re.match(r'^(\d+)\s*г', basis)
            pm = re.search(r'порцию\s*\((\d+)\s*г', basis)
            pcs = re.search(r'\((\d+)\s*шт', basis)
            if gm:
                b['kind'] = 'per_grams'
                b['grams'] = float(gm.group(1))
            elif pm:
                b['kind'] = 'serving'
                b['grams'] = float(pm.group(1))
            elif 'половин' in basis:
                b['kind'] = 'serving'
                b['servings'] = 2
            else:
                b['kind'] = 'whole'
                if pcs:
                    b['pieces'] = int(pcs.group(1))
            blocks.append(b)
            i += 1
            continue
        if re.match(r'^Калории\s*:', s):
            kcal = re.search(NUM, s)
            p, jp = _find_value(lines, i + 1, i + 5, r'^Белки')
            f, jf = _find_value(lines, i + 1, i + 6, r'^Жиры')
            c, jc = _find_value(lines, i + 1, i + 7, r'^Углеводы')
            if kcal and None not in (p, f, c):
                blocks.append({
                    'start': i, 'end': max(jp, jf, jc), 'kind': 'per_grams',
                    'grams': 100.0, 'values': [fnum(kcal.group(1)), p, f, c],
                })
                i = max(jp, jf, jc) + 1
                continue
        pm = re.match(r'^Пищевая ценность\s*\(на\s*(\d+)\s*г', s, re.IGNORECASE)
        if pm:
            kcal, jk = _find_value(lines, i + 1, i + 6, r'Калорийность')
            if kcal is None:
                kcal_m = re.search(r'Калорийность\D*' + NUM, ' '.join(l for _, l in lines[i + 1:i + 3]))
            p, jp = _find_value(lines, i + 1, i + 8, r'Белки')
            f, jf = _find_value(lines, i + 1, i + 9, r'Жиры')
            c, jc = _find_value(lines, i + 1, i + 10, r'Углеводы')
            if None not in (kcal, p, f, c):
                blocks.append({
                    'start': i, 'end': max(jk, jp, jf, jc), 'kind': 'per_grams',
                    'grams': float(pm.group(1)), 'values': [kcal, p, f, c],
                })
                i = max(jk, jp, jf, jc) + 1
                continue
        i += 1
    return blocks


# --------------------------------------------------------------------------
# Recipe body parsing
# --------------------------------------------------------------------------

WEIGHT_RE = re.compile(r'(\d+(?:[.,]\d+)?)\s*(кг|гр|г|мл|л)(?![а-яё])', re.IGNORECASE)
PCS_RE = re.compile(r'(\d+)\s*шт', re.IGNORECASE)
OUTPUT_RE = re.compile(r'(?:Выход|Вес готового блюда)\s*[-–:]?\s*(\d+)\s*г', re.IGNORECASE)
SERVINGS_RE = re.compile(r'на\s+(\d+)\s+порц', re.IGNORECASE)


def ingredient_grams(text: str) -> float:
    low = text.lower()
    if 'по вкусу' in low and not WEIGHT_RE.search(low):
        return 0.0
    ms = list(WEIGHT_RE.finditer(low))
    if ms:
        m = ms[-1]
        v = fnum(m.group(1))
        unit = m.group(2)
        if unit in ('кг', 'л'):
            v *= 1000
        return v
    if 'яйц' in low or 'яйко' in low:
        pm = PCS_RE.search(low)
        return 55.0 * (int(pm.group(1)) if pm else 1)
    return 0.0


def parse_body(body: list[str]):
    ingredients: list[str] = []
    steps: list[str] = []
    in_steps = False
    for s in body:
        if re.match(r'^(Пищевая ценность|Калорийность|Белки|Жиры|Углеводы|Калории|КБЖУ)', s.lstrip('• '), re.IGNORECASE):
            continue
        if is_step(s):
            in_steps = True
            steps.append(re.sub(r'^\d+\.\s*', '', s))
            continue
        if is_bullet(s):
            item = s[2:].strip().rstrip(';').rstrip('.')
            if item.endswith(':'):
                continue
            if item and not in_steps:
                ingredients.append(item)
            elif item and steps:
                steps[-1] += ' ' + item
            continue
        if in_steps and steps:
            if re.match(r'^(Приготовление|Ингредиенты|Для )', s) or is_caps_header(s):
                continue
            if len(steps[-1]) < 600:
                steps[-1] += ' ' + s
    total = sum(ingredient_grams(x) for x in ingredients)
    return ingredients, [x.strip() for x in steps if x.strip()], total


def clean_title(s: str) -> str:
    s = re.sub(r'^\d+\s*[.)]?\s*', '', s).strip()
    s = s.strip().rstrip(':').strip()
    s = re.sub(r'\s+', ' ', s)
    if len(s) > 50:
        s = re.sub(r'\s*\([^)]{20,}\)', '', s).strip()
    return s[:1].upper() + s[1:] if s else s


# --------------------------------------------------------------------------
# Categories / meal types
# --------------------------------------------------------------------------

CATEGORY_RULES = [
    (r'суп', 'Супы', ['lunch']),
    (r'салат', 'Салаты', ['lunch', 'dinner', 'snack']),
    (r'закуск', 'Закуски', ['snack', 'dinner']),
    (r'вторые|горяч|основн|гарнир|мяс|рыб|птиц', 'Вторые блюда', ['lunch', 'dinner']),
    (r'торт', 'Торты', ['snack']),
    (r'выпеч|десерт|сладк|чаю|пирог|печень', 'Выпечка и десерты', ['breakfast', 'snack']),
    (r'соус|крем|глазур', 'Соусы и кремы', []),
    (r'завтрак|каш|омлет|блин|оладь|сырник', 'Завтраки', ['breakfast']),
    (r'напит|смузи|коктейл', 'Напитки', ['snack']),
]


def classify_header(header: str):
    low = header.lower()
    for pat, cat, meals in CATEGORY_RULES:
        if re.search(pat, low):
            return cat, meals
    return None


def guess_from_name(name: str, book: str):
    low = name.lower()
    if book == 'Любимые завтраки':
        return 'Завтраки', ['breakfast']
    if book == 'Что-нибудь к чаю':
        return 'Выпечка и десерты', ['breakfast', 'snack']
    for pat, cat, meals in CATEGORY_RULES:
        if re.search(pat, low):
            return cat, meals
    return 'Разное', list(ALL_MEALS)


DEFAULT_PORTION = {
    'Супы': 300,
    'Салаты': 170,
    'Закуски': 120,
    'Вторые блюда': 220,
    'Торты': 100,
    'Выпечка и десерты': 120,
    'Соусы и кремы': 30,
    'Завтраки': 200,
    'Напитки': 250,
    'Разное': 200,
}


# --------------------------------------------------------------------------
# Recipe books
# --------------------------------------------------------------------------

def parse_book(path: str, book: str, report: Counter):
    lines = load_lines(path)
    blocks = find_nutrition_blocks(lines)
    if not blocks:
        return []

    def next_is_ingredients(b):
        j = b['end'] + 1
        if j >= len(lines):
            return False
        s = lines[j][1]
        return is_bullet(s) or re.match(r'^(Ингред|Готовим)', s, re.IGNORECASE) is not None

    header_votes = sum(1 for b in blocks if next_is_ingredients(b))
    header_format = header_votes * 2 >= len(blocks)
    report[f'{book}: format'] = 'header' if header_format else 'footer'

    # Caps category headers with their line index (TOC part excluded later by position).
    caps = [(i, s) for i, (_, s) in enumerate(lines) if is_caps_header(s) and len(s) < 40]

    def category_at(idx):
        cur = None
        for i, s in caps:
            if i > idx:
                break
            c = classify_header(s)
            if c:
                cur = c
        return cur

    recipes = []
    spans = []
    if header_format:
        title_idx = []
        for b in blocks:
            first = b['start'] - 1
            while first >= 0 and is_caps_header(lines[first][1]):
                first -= 1
            t = None
            for j in range(first, max(first - 3, -1), -1):
                s = lines[j][1]
                if is_bullet(s) or (is_step(s) and j != first):
                    break
                if re.match(r'^\d+\s*[.)]?\s*[А-ЯЁA-Z«"]', s):
                    t = j
                    break
            if t is None:
                s = lines[first][1] if first >= 0 else ''
                t = first if s and not is_bullet(s) else b['start']
            title_idx.append(t)
        for k, b in enumerate(blocks):
            t = title_idx[k]
            title_lines = [lines[j][1] for j in range(t, b['start']) if not is_caps_header(lines[j][1])]
            end = title_idx[k + 1] if k + 1 < len(blocks) else len(lines)
            body = [lines[j][1] for j in range(b['end'] + 1, end)]
            spans.append((t, title_lines, body, b))
    else:
        prev_end = -1
        for b in blocks:
            span = list(range(prev_end + 1, b['start']))
            first = next(
                (j for j in span if re.match(r'^(Ингред|Выход)', lines[j][1], re.IGNORECASE)),
                None,
            )
            if first is None and prev_end >= 0:
                first = next((j for j in span if is_bullet(lines[j][1])), None)
            if first is None:
                prev_end = b['end']
                report[f'{book}: footer recipe without body'] += 1
                continue
            if prev_end >= 0:
                # The next recipe starts right after the previous nutrition block.
                t = prev_end + 1
                while t < first and is_caps_header(lines[t][1]):
                    t += 1
                title_lines = [lines[t][1]]
                if t + 1 < first and lines[t + 1][1][:1].islower() and not is_bullet(lines[t + 1][1]):
                    title_lines.append(lines[t + 1][1])
            else:
                if lines[first][1].lower().startswith('ингред') and first - 1 > prev_end and \
                        re.match(r'^Выход', lines[first - 1][1], re.IGNORECASE):
                    first -= 1
                numbered = [
                    j for j in range(max(0, first - 15), first)
                    if re.match(r'^\d+\.\s*[А-ЯЁ]', lines[j][1]) and '…' not in lines[j][1]
                ]
                if numbered:
                    t = numbered[-1]
                else:
                    t = first - 1
                    while t > prev_end and (is_caps_header(lines[t][1]) or
                                            lines[t][1].endswith('.') or
                                            re.fullmatch(r'(Выход\s*[-–]?\s*)?\d+\s*г\.?', lines[t][1])):
                        t -= 1
                title_lines = [lines[t][1]]
            body = [lines[j][1] for j in range(first, b['start'])]
            spans.append((t, title_lines, body, b))
            prev_end = b['end']

    prev_base = ''
    for t, title_lines, body, b in spans:
        name = clean_title(' '.join(title_lines))
        vm = re.search(r'Вариант\s+\d+\s*(\([^)]*\))?', name)
        if vm:
            base = name[:vm.start()].strip()
            if not base or base[-1] in '.!' or len(base) > 60 or re.search(r'\d', base):
                base = prev_base
            prev_base = base
            name = f'{base} {vm.group(1) or ""}'.strip() if base else name
        if not name or len(name) > 90 or len(name) < 2:
            report[f'{book}: bad title'] += 1
            if '--debug' in sys.argv:
                print('BAD TITLE', book, repr(title_lines), lines[b['start']])
            continue
        ingredients, steps, total = parse_body(body)
        if not ingredients:
            report[f'{book}: no ingredients'] += 1
            if '--debug' in sys.argv:
                print('NO INGREDIENTS', book, name)
            continue
        text_all = ' '.join(title_lines + body)
        out_m = OUTPUT_RE.search(text_all)
        serv_m = SERVINGS_RE.search(text_all)
        total_weight = float(out_m.group(1)) if out_m else (round(total) if total >= 50 else None)

        cat = category_at(t) or guess_from_name(name, book)
        if book == 'Любимые завтраки':
            cat = ('Завтраки', ['breakfast'])
        category, meals = cat

        kcal, p, f, c = b['values']
        page = lines[t][0] if 0 <= t < len(lines) else None
        rec = {
            '_anchor': (page, name),
            'name': name,
            'book': book,
            'category': category,
            'mealTypes': meals,
            'page': page,
            'ingredients': ingredients,
            'steps': steps,
            'totalWeightG': total_weight,
        }
        if b['kind'] == 'per_grams':
            g = b['grams']
            rec['per100'] = [round(v * 100 / g, 1) for v in (kcal, p, f, c)]
            portion = DEFAULT_PORTION.get(category, 200)
            servings = int(serv_m.group(1)) if serv_m else None
            if servings and total_weight:
                portion = round(total_weight / servings / 10) * 10
            elif total_weight and total_weight < portion * 1.3:
                portion = round(total_weight / 10) * 10
            rec['portionG'] = max(30, portion)
            rec['servings'] = servings
        elif b['kind'] == 'serving':
            rec['serving'] = [kcal, p, f, c]
            rec['servingG'] = b.get('grams')
            rec['servings'] = b.get('servings', 1)
            if b.get('grams'):
                rec['per100'] = [round(v * 100 / b['grams'], 1) for v in (kcal, p, f, c)]
                rec['portionG'] = b['grams']
        else:  # whole dish
            pieces = b.get('pieces')
            if pieces:
                rec['serving'] = [round(v / pieces, 1) for v in (kcal, p, f, c)]
                rec['servingLabel'] = '1 шт'
                rec['servings'] = pieces
            else:
                rec['serving'] = [kcal, p, f, c]
                rec['servings'] = 1
            if total_weight:
                rec['per100'] = [round(v * 100 / total_weight, 1) for v in (kcal, p, f, c)]
                rec['servingG'] = round(total_weight / rec['servings'])
        recipes.append(rec)
    return recipes


# --------------------------------------------------------------------------
# 21-day rations: a slot with a single dish gives the KBJU of one portion.
# --------------------------------------------------------------------------

DAY_RE = re.compile(r'^День\s+(\d+)\s*$', re.IGNORECASE)
DAILY_RE = re.compile(r'^К[Бб][Жж][Уу]\s+на\s+день:?\s*' + r'/'.join([NUM] * 4))
SLOT_RE = re.compile(
    r'^(Завтрак|Обед|Перекус|Ужин)\s*\(\s*к[бб][жж][уу]:?\s*' + r'\s*/\s*'.join([NUM] * 4) + r'\s*\)',
    re.IGNORECASE,
)


def ration_title_clean(s: str) -> tuple[str, float]:
    low = s.lower()
    fraction = 1.0
    if 'половина порции' in low or '1/2 порции' in low or 'половина' in low:
        fraction = 0.5
    m = re.search(r'(\d)/(\d)\s+от\s+порци', low)
    if m:
        fraction = int(m.group(1)) / int(m.group(2))
    s = re.sub(r'^(Чай|Кофе)\s*\+\s*', '', s, flags=re.IGNORECASE)
    s = re.sub(r'[,(]?\s*(половина|1/2|\d/\d от|одна)\s+порци[ия]\)?\.?', '', s, flags=re.IGNORECASE)
    s = re.sub(r',?\s*\d+\s*гр?\s*(\(в сухом виде\))?', '', s)
    s = s.strip(' ,.:')
    return clean_title(s), fraction


def parse_ration(path: str, book: str, report: Counter):
    lines = load_lines(path, keep_square=True)
    slots = []
    cur = None
    day = None
    for page, s in lines:
        dm = DAY_RE.match(s)
        if dm:
            day = int(dm.group(1))
            cur = None
            continue
        if re.search(r'Продуктовая\s+корзина', s, re.IGNORECASE):
            cur = None
            day = None
            continue
        sm = SLOT_RE.match(s)
        if sm and day is not None:
            cur = {
                'day': day,
                'meal': MEAL_RU[sm.group(1).lower()],
                'values': [fnum(sm.group(k)) for k in range(2, 6)],
                'items': [],
                'page': page,
            }
            slots.append(cur)
            continue
        if cur is None:
            continue
        if s.startswith('▪ '):
            cur['items'].append({'title': s[2:].strip(), 'body': [], 'page': page})
            continue
        if cur['items']:
            item = cur['items'][-1]
            if not item['body'] and not item['title'].rstrip().endswith(':') and \
                    s[:1].islower() and len(s) < 60 and not is_bullet(s):
                item['title'] += ' ' + s
                continue
            item['body'].append(s)

    by_name: dict[str, dict] = {}
    # Every item is an anchor, so photos of non-recipe items are not misattributed.
    anchors: list[tuple[int, str, dict | None]] = []
    for slot in slots:
        items = slot['items']
        if len(items) != 1:
            report[f'{book}: multi-item slots'] += 1
            anchors.extend((it['page'], it['title'], None) for it in items)
            continue
        item = items[0]
        name, fraction = ration_title_clean(item['title'])
        anchor_idx = len(anchors)
        anchors.append((item['page'], item['title'], None))
        body = item['body']
        ingredients, steps, _ = parse_body(body)
        if not steps and not ingredients:
            # Repeated day: recipe body was given on an earlier day.
            if name.lower() in by_name:
                continue
            report[f'{book}: slot without recipe'] += 1
            continue
        if not steps and len(ingredients) < 2:
            report[f'{book}: slot without steps'] += 1
            continue
        key = name.lower()
        if key in by_name:
            continue
        kcal, p, f, c = slot['values']
        two_days = any(re.match(r'^Готовим\s+на\s+2', x, re.IGNORECASE) for x in body)
        rec = {
            'name': name,
            'book': f'Рацион {book}',
            'category': 'Из рациона',
            'mealTypes': [slot['meal']],
            'page': slot['page'],
            'ingredients': ingredients,
            'steps': steps,
            'totalWeightG': None,
            'serving': [kcal, p, f, c],
            'servingLabel': 'порция из рациона',
            'servings': 2 if two_days or fraction < 1 else 1,
            'note': f"День {slot['day']}: целый приём пищи «{slot['meal']}» вместе с напитком",
        }
        by_name[key] = rec
        anchors[anchor_idx] = (item['page'], item['title'], rec)
    return list(by_name.values()), anchors


# --------------------------------------------------------------------------
# Photos: each photo belongs to the nearest recipe title above it.
# --------------------------------------------------------------------------

IMG_DIR = os.path.join(ROOT, 'assets', 'recipe_images')
IMG_WIDTH = 480


def _photo_positions(doc):
    pages_by_xref: dict[int, set[int]] = {}
    for pi, page in enumerate(doc):
        for img in page.get_images(full=True):
            pages_by_xref.setdefault(img[0], set()).add(pi)
    photos = []
    for pi, page in enumerate(doc):
        for img in page.get_images(full=True):
            xref, w, h = img[0], img[2], img[3]
            # Backgrounds and logos repeat on many pages.
            if len(pages_by_xref[xref]) > 2 or w < 300 or h < 200 or not 0.5 < w / h < 2.6:
                continue
            for r in page.get_image_rects(xref):
                if r.height > 80:
                    photos.append((pi + 1, r.y0, xref))
    photos.sort()
    return photos


def _anchor_y(doc, page: int, title: str) -> float:
    needle = re.sub(r'\s+', ' ', title).strip()[:28]
    if page is None or not needle:
        return 0.0
    hits = doc[page - 1].search_for(needle)
    return hits[0].y0 if hits else 0.0


def _save_photo(doc, xref: int, key: str) -> str | None:
    from io import BytesIO

    from PIL import Image

    try:
        pix = fitz.Pixmap(doc, xref)
        if pix.n - pix.alpha >= 4:
            pix = fitz.Pixmap(fitz.csRGB, pix)
        img = Image.open(BytesIO(pix.tobytes('png'))).convert('RGB')
    except Exception:  # noqa: BLE001 - broken embedded image
        return None
    if img.width > IMG_WIDTH:
        img = img.resize((IMG_WIDTH, round(img.height * IMG_WIDTH / img.width)), Image.LANCZOS)
    rel = f'assets/recipe_images/{key}.jpg'
    img.save(os.path.join(ROOT, rel), 'JPEG', quality=72, optimize=True, progressive=True)
    return rel


def attach_photos(path: str, anchors: list[tuple[int, str, dict | None]], report: Counter):
    """Sets rec['_photo_xref'] for recipes whose title precedes a photo."""
    doc = fitz.open(path)
    positioned = sorted(
        ((p, _anchor_y(doc, p, t), rec) for p, t, rec in anchors if p is not None),
        key=lambda a: (a[0], a[1]),
    )
    photos = _photo_positions(doc)
    k = -1
    for page, y, xref in photos:
        while k + 1 < len(positioned) and (positioned[k + 1][0], positioned[k + 1][1]) <= (page, y + 1):
            k += 1
        if k < 0:
            continue
        rec = positioned[k][2]
        if rec is not None and '_photo' not in rec:
            rec['_photo'] = (path, xref)
    report[f'{os.path.basename(path)}: photos'] = sum(1 for _, _, r in positioned if r and '_photo' in r)


# --------------------------------------------------------------------------

def main():
    report = Counter()
    all_recipes = []
    for path in sorted(glob.glob(os.path.join(DATA_DIR, '*.pdf'))):
        book = os.path.splitext(os.path.basename(path))[0]
        if book.startswith(SKIP_PREFIXES):
            report[f'{book}: skipped (no KBJU per recipe)'] = 1
            continue
        if re.match(r'^1[23]00_', book):
            label = re.sub(r'[_\s]*\(?21[_ ]день\)?', '', book).replace('_', '-').strip(' -')
            recs, anchors = parse_ration(path, label, report)
        else:
            nice = 'Бесплатная подборка' if book.startswith('бесплатная') else book
            recs = parse_book(path, nice, report)
            anchors = [(r['_anchor'][0], r['_anchor'][1], r) for r in recs]
        if '--no-images' not in sys.argv:
            attach_photos(path, anchors, report)
        report[f'{book}: recipes'] = len(recs)
        all_recipes.extend(recs)

    seen = set()
    unique = []
    for r in all_recipes:
        k = (r['name'].lower(), r['book'])
        if k in seen:
            continue
        seen.add(k)
        unique.append(r)

    if '--no-images' not in sys.argv:
        os.makedirs(IMG_DIR, exist_ok=True)
        for old in glob.glob(os.path.join(IMG_DIR, '*.jpg')):
            os.remove(old)
    docs: dict[str, fitz.Document] = {}
    for r in unique:
        # Stable across re-extraction: diary entries reference recipes by this key.
        r['key'] = hashlib.sha1(f"{r['book']}|{r['name'].lower()}".encode('utf-8')).hexdigest()[:12]
        photo = r.pop('_photo', None)
        r.pop('_anchor', None)
        if photo:
            doc = docs.setdefault(photo[0], fitz.open(photo[0]))
            r['image'] = _save_photo(doc, photo[1], r['key'])
        for key in [k for k, v in r.items() if v is None]:
            del r[key]
    report['images saved'] = sum(1 for r in unique if 'image' in r)

    os.makedirs(os.path.dirname(OUT_FILE), exist_ok=True)
    with open(OUT_FILE, 'w', encoding='utf-8') as fh:
        json.dump({'schemaVersion': 1, 'recipes': unique}, fh, ensure_ascii=False, separators=(',', ':'))

    for k in sorted(report):
        print(f'{k}: {report[k]}')
    print('TOTAL', len(unique))
    if '--report' in sys.argv:
        cats = Counter((r['book'], r['category']) for r in unique)
        for (b, c), n in sorted(cats.items()):
            print(f'  {b} / {c}: {n}')


if __name__ == '__main__':
    main()
