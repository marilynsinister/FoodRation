"""Flat illustrated covers for recipe categories (fallback when a dish has no photo)."""

from __future__ import annotations

import math
import os

from PIL import Image, ImageDraw

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(ROOT, 'assets', 'recipe_images')

# name -> (bg, accent, extra)
PALETTES = {
    'cat_soups': ((255, 236, 214), (232, 120, 48), (120, 168, 88)),
    'cat_salads': ((226, 245, 214), (76, 160, 72), (232, 88, 72)),
    'cat_snacks': ((255, 236, 196), (212, 148, 48), (168, 92, 48)),
    'cat_mains': ((255, 228, 214), (196, 72, 56), (88, 140, 72)),
    'cat_cakes': ((255, 228, 236), (216, 96, 128), (255, 196, 168)),
    'cat_dessert': ((255, 236, 220), (168, 104, 64), (232, 80, 96)),
    'cat_sauces': ((255, 244, 214), (232, 176, 48), (196, 88, 48)),
    'cat_breakfast': ((255, 244, 214), (232, 168, 48), (120, 176, 216)),
    'cat_ration': ((220, 244, 236), (32, 148, 132), (232, 140, 64)),
    'cat_drinks': ((220, 236, 255), (72, 128, 212), (255, 196, 96)),
    'cat_other': ((236, 232, 255), (120, 104, 196), (232, 148, 88)),
}


def _ellipse(d: ImageDraw.ImageDraw, box, fill, outline=None, width=3):
    d.ellipse(box, fill=fill, outline=outline, width=width)


def draw_plate(d, cx, cy, r, fill=(250, 248, 242), rim=(220, 212, 196)):
    _ellipse(d, [cx - r, cy - r + 8, cx + r, cy + r + 8], (200, 188, 168))
    _ellipse(d, [cx - r, cy - r, cx + r, cy + r], fill, rim, 4)


def cover(name: str, bg, accent, extra) -> Image.Image:
    img = Image.new('RGB', (512, 512), bg)
    d = ImageDraw.Draw(img)
    # soft circles
    _ellipse(d, [-80, -80, 220, 220], tuple(min(255, c + 18) for c in bg))
    _ellipse(d, [320, 340, 620, 640], tuple(max(0, c - 18) for c in bg))
    cx, cy = 256, 270

    if name in ('cat_soups',):
        draw_plate(d, cx, cy, 150, accent)
        _ellipse(d, [cx - 118, cy - 40, cx + 118, cy + 90], extra)
        for a in range(0, 360, 40):
            x = cx + int(70 * math.cos(math.radians(a)))
            y = cy + 20 + int(28 * math.sin(math.radians(a)))
            _ellipse(d, [x - 10, y - 10, x + 10, y + 10], accent)
        d.polygon([(cx - 12, 70), (cx + 12, 70), (cx, 150)], fill=(230, 230, 230))
    elif name == 'cat_salads':
        draw_plate(d, cx, cy, 150)
        for i, (dx, dy, r) in enumerate([(-40, -10, 70), (50, 10, 64), (0, 40, 58)]):
            col = extra if i == 1 else accent
            _ellipse(d, [cx + dx - r, cy + dy - r, cx + dx + r, cy + dy + r], col)
    elif name == 'cat_breakfast':
        draw_plate(d, cx, cy + 20, 140)
        d.rounded_rectangle([cx - 90, cy - 40, cx + 90, cy + 70], 24, fill=accent)
        _ellipse(d, [cx - 30, cy - 10, cx, cy + 20], extra)
        _ellipse(d, [cx + 10, cy, cx + 40, cy + 30], (220, 64, 80))
        d.rounded_rectangle([cx + 110, 80, cx + 180, 200], 20, fill=extra)
    elif name == 'cat_mains':
        draw_plate(d, cx, cy, 150)
        d.rounded_rectangle([cx - 80, cy - 50, cx + 20, cy + 40], 18, fill=accent)
        _ellipse(d, [cx + 20, cy - 20, cx + 100, cy + 50], extra)
        d.ellipse([cx - 70, cy + 30, cx + 10, cy + 70], fill=(232, 196, 96))
    elif name in ('cat_cakes', 'cat_dessert'):
        d.polygon([(cx - 110, cy + 70), (cx + 110, cy + 70), (cx + 80, cy + 130), (cx - 80, cy + 130)], fill=(210, 190, 160))
        d.rounded_rectangle([cx - 90, cy - 20, cx + 90, cy + 80], 8, fill=accent)
        d.rounded_rectangle([cx - 70, cy - 70, cx + 70, cy - 10], 8, fill=extra)
        _ellipse(d, [cx - 16, cy - 100, cx + 16, cy - 68], (220, 64, 80))
    elif name == 'cat_sauces':
        d.polygon([(cx - 40, 100), (cx + 40, 100), (cx + 70, 360), (cx - 70, 360)], fill=accent)
        _ellipse(d, [cx - 74, 320, cx + 74, 430], extra)
        _ellipse(d, [cx - 20, 80, cx + 20, 130], (250, 248, 240))
    elif name == 'cat_snacks':
        draw_plate(d, cx, cy, 140)
        for i in range(5):
            ang = -40 + i * 20
            x = cx + int(70 * math.sin(math.radians(ang)))
            y = cy + int(20 * math.cos(math.radians(ang)))
            d.rounded_rectangle([x - 18, y - 50, x + 18, y + 50], 10, fill=accent if i % 2 == 0 else extra)
    elif name == 'cat_drinks':
        d.polygon([(cx - 50, 140), (cx + 50, 140), (cx + 70, 380), (cx - 70, 380)], fill=extra)
        d.rectangle([cx - 46, 160, cx + 46, 300], fill=accent)
        d.line([(cx + 70, 180), (cx + 130, 140)], fill=(180, 180, 180), width=6)
    elif name == 'cat_ration':
        draw_plate(d, cx, cy, 145, (240, 252, 248), extra)
        d.rounded_rectangle([cx - 90, cy - 30, cx + 90, cy + 50], 16, fill=accent)
        _ellipse(d, [cx - 40, cy - 10, cx + 40, cy + 30], extra)
    else:
        draw_plate(d, cx, cy, 145)
        _ellipse(d, [cx - 50, cy - 40, cx + 50, cy + 50], extra)
        d.rounded_rectangle([cx - 80, cy + 20, cx + 80, cy + 70], 20, fill=accent)
    return img


def main():
    os.makedirs(OUT, exist_ok=True)
    for name, colors in PALETTES.items():
        cover(name, *colors).save(os.path.join(OUT, f'{name}.png'), 'PNG')
        print(name)


if __name__ == '__main__':
    main()
