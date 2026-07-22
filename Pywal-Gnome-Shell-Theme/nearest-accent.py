#!/usr/bin/env python3
"""
Mapeia uma cor hex arbitrária (ex: accent do pywal) para o accent-color
nomeado mais próximo do GNOME (org.gnome.desktop.interface accent-color).

Reimplementação em Python de adw_accent_color_nearest_from_rgba()
(libadwaita/src/adw-accent-color.c), usando conversão sRGB -> OKLCH.
"""
import sys
import math


def srgb_to_linear(c):
    c = c / 255
    return c / 12.92 if c <= 0.04045 else ((c + 0.055) / 1.055) ** 2.4


def hex_to_oklch(hexcolor):
    hexcolor = hexcolor.lstrip('#')
    r, g, b = (int(hexcolor[i:i + 2], 16) for i in (0, 2, 4))
    r, g, b = srgb_to_linear(r), srgb_to_linear(g), srgb_to_linear(b)

    l = 0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b
    m = 0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b
    s = 0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b

    l_, m_, s_ = l ** (1 / 3), m ** (1 / 3), s ** (1 / 3)

    lightness = 0.2104542553 * l_ + 0.7936177850 * m_ - 0.0040720468 * s_
    a = 1.9779984951 * l_ - 2.4285922050 * m_ + 0.4505937099 * s_
    b2 = 0.0259040371 * l_ + 0.7827717662 * m_ - 0.8086757660 * s_

    chroma = math.sqrt(a * a + b2 * b2)
    hue = math.degrees(math.atan2(b2, a))
    if hue < 0:
        hue += 360
    return lightness, chroma, hue


def nearest_accent(hexcolor):
    _, chroma, hue = hex_to_oklch(hexcolor)
    if chroma < 0.04:
        return 'slate'
    if hue > 345:
        return 'pink'
    if hue > 280:
        return 'purple'
    if hue > 230:
        return 'blue'
    if hue > 175:
        return 'teal'
    if hue > 115:
        return 'green'
    if hue > 75.5:
        return 'yellow'
    if hue > 35:
        return 'orange'
    if hue > 10:
        return 'red'
    return 'pink'


if __name__ == '__main__':
    print(nearest_accent(sys.argv[1]))
