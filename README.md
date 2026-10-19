# OpenMOI-Home PWA

A Progressive Web App (PWA) portal for **OpenMOI** — designed for measuring Moment of Inertia (MOI), Swing Weight (SW), and Twist Weight (TW) of sports equipment (pickleball paddles, tennis racquets) using smartphone motion sensors.

Styled with Samsung **One UI 9.0** design principles.

---

## Navigation & Features

1. **Overview Page**: Full project overview, primary use cases (paddle/racquet measurement, weight tuning, quality control, zero-hardware sensor timing), and key technical features (sine-wave curve fitting, SW/TW physics calculations, $\kappa$ calibration, tare zeroing, outlier management, and session group management).
2. **Android Page**: Highlights the benefits of the native Android version (**better hardware utilization** with unthrottled sensor polling and **no internet dependency**) alongside a direct download for `OpenMOI.apk` (~54 MB).
3. **Online Version Page**: Highlights universal cross-platform access while detailing web limitations (**internet dependency** and **slower hardware utilization** especially on Apple iOS Safari due to throttled sensor rates), with a direct launcher button to the live online tool at [https://jat08.github.io/open_moi_pwa/](https://jat08.github.io/open_moi_pwa/).
