# 2D Dynamic Pixel Art Water System (GameMaker)

A highly optimized, plug-and-play dynamic water system designed for 2D side-scrollers in GameMaker. Tailored specifically for low-resolution, pixel-art environments (e.g., 320x180 target resolution), this system delivers AAA-quality visual feedback without sacrificing CPU/GPU performance.

## Features

* **Dynamic Spring Physics:** Nodes react interactively, creating smooth, spreading ripples using tension and dampening mathematics.
* **Real-time Refraction Shader:** Distorts the background behind the water surface using a lightweight custom shader. Built with a single surface target to eliminate GPU bottlenecks.
* **Additive Surface Highlights:** A pixel-perfect, 3-stepped bright edge highlight using `bm_add` to give the water a sleek, wet, and illuminated surface feel.
* **Stylized God Rays:** Pseudo-randomized, swaying underwater light shafts that dynamically adapt to the wave movement and fade out naturally in the depths.
* **Scalable Masking:** Uses a single, scalable object mask. Stretch it across your entire room and the system dynamically calculates the required physics nodes based on its width.

##  Installation & Setup

1. **Create the Shader:** * Create a new shader named `shd_water_simple`.
   * Leave the Vertex Shader (`.vsh`) as default.
   * Replace the Fragment Shader (`.fsh`) code with the provided `shd_water_simple.fsh` file.
2. **Create the Sprite:**
   * Create a simple 16x16 or 32x32 white square sprite.
   * **Crucial:** Set the Origin to **Top Left**.
3. **Create the Object:**
   * Create an object (e.g., `obj_water`) and assign the sprite to it.
   * Copy the provided code from the `src` folder into the respective `Create`, `Step`, and `Draw` events.
4. **Place in Room:**
   * Drag the object into your room and stretch it across the area you want to flood. 
   * *Note: Ensure the water object's Depth is lower (closer to the camera) than your background layers, but higher than your player/boat objects so they render on top.*

## ⚙️ Customization (Tweaking the Feel)

You can easily adjust the "feel" of the water by modifying the variables in the **Create** and **Step** events:

* **Tension & Spread (Create Event):** Increase `tension` (e.g., 0.04) and decrease `spread` (e.g., 0.15) for tight, acidic, or highly viscous liquids.
* **Wave Amplitude (Step Event):** Modify the multipliers at the end of the `_wave_1` and `_wave_2` formulas to make the idle waves taller or shorter.
* **God Rays Angle (Draw Event):** Adjust the `_slant` variable. Set the base value to `0` for perfectly straight vertical rays, or `30` for a stylistic diagonal light bleed.

## Author

**Selim Burak Polat** Developed for 2D pixel-art indie game projects. 

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. Feel free to use it in your commercial or free games!
