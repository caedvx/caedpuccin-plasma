import sys, subprocess, io
import numpy as np
from PIL import Image

W, H, variant, out = int(sys.argv[1]), int(sys.argv[2]), sys.argv[3], sys.argv[4]
mark_svg = sys.argv[5] if len(sys.argv) > 5 else None
grain = float(sys.argv[6]) if len(sys.argv) > 6 else 3.2
rng = np.random.default_rng(7)
VM = max(W, H)
y, x = np.mgrid[0:H, 0:W].astype(np.float64)

# base: near-black at the top centre falling to pure black
r = np.sqrt(((x - W / 2) / (1.4 * W)) ** 2 + (y / H) ** 2)
img = 9.0 * np.clip(1 - r, 0, 1) ** 1.6

def orb(cx, cy, rad, level, alpha):
    d2 = ((x - cx) ** 2 + (y - cy) ** 2) / (rad ** 2)
    return level * alpha * np.exp(-d2 * 2.2)

img += orb(0.09 * VM, 0.10 * VM, 0.34 * VM, 138, 0.24)
img += orb(W - 0.04 * VM, 0.32 * VM, 0.26 * VM, 230, 0.075)
img += orb(0.22 * W + 0.18 * VM, H + 0.02 * VM, 0.30 * VM, 60, 0.45)

if variant in ("mark", "ghost") and mark_svg:
    size = int(H * (0.12 if variant == "mark" else 1.2))
    png = subprocess.run(["rsvg-convert", "-w", str(size), "-h", str(size), mark_svg], capture_output=True, check=True).stdout
    a = np.asarray(Image.open(io.BytesIO(png)).convert("RGBA"))[..., 3] / 255.0
    cx, cy = (W // 2, H // 2) if variant == "mark" else (int(W * 0.70), int(H * 0.60))
    x0, y0 = cx - size // 2, cy - size // 2
    m = np.zeros((H, W))
    sx0, sy0 = max(0, -x0), max(0, -y0)
    dx0, dy0 = max(0, x0), max(0, y0)
    w = min(size - sx0, W - dx0); h = min(size - sy0, H - dy0)
    m[dy0:dy0 + h, dx0:dx0 + w] = a[sy0:sy0 + h, sx0:sx0 + w]
    if variant == "mark":
        img = img * (1 - m) + 255 * m
    else:
        img = img + 9 * m

# film grain: monochrome gaussian, slightly softened clumps, doubles as dither
g = rng.normal(0, 1, (H, W))
g2 = rng.normal(0, 1, (H // 2 + 1, W // 2 + 1)).repeat(2, 0).repeat(2, 1)[:H, :W]
img += grain * (0.75 * g + 0.45 * g2)

Image.fromarray(np.clip(np.rint(img), 0, 255).astype(np.uint8), "L").convert("RGB").save(out, optimize=True)
