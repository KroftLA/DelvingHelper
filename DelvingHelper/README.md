# DelvingHelper for The Lord of the Rings Online (LOTRO)

**DelvingHelper** is an essential in-game assistant and speedrun tracker designed for rapid Delving Writs farming, mission rotation tracking, Delving Malice hazard guides, and automated wrapper quest logging in LOTRO.

---

## What's New in v1.5.16

* **Decoupled High Tier Delvings from Rotation Checkboxes:**
  * The `High tier delvings (tier 6 and higher)` counter is now strictly and exclusively driven by the in-game quest objective (`Completed high tier delvings (tier 6 and higher) (X/10)`).
  * Running rotation missions on Tier 1–5 will mark the mission checklist card as completed, but will **never falsely increment** the High Tier Delvings counter!
* **Real-Time Wrapper Quest Synchronization:**
  * All 3 weekly wrapper quests (`(X/10)`, `(X/15)`, `(X/45)`) synchronize with the game's authoritative quest updates from chat without drift or leftover offsets across weekly resets.
* **Improved UI Sub-bar Layout:**
  * Sub-bar buttons and labels redesigned with generous spacing (378px) preventing text truncation or overlap across all 3 rows.
* **Offline HTML User Manual (`README.html`):**
  * Added an interactive HTML user guide inside the plugin folder that opens directly in any web browser with instant Russian / English language switching.

---

## 🌟 Key Features

* **Daily Mission Rotation Tracker:** Automatically detects the active server day and displays only the missions officially available today.
* **Curated Speedrun Routes:** Pre-filtered lists for the shortest, safest, and fastest instances with minimal mob density.
* **Hub Filters:** Instant tabs for Cardolan (Andrath), Swanfleet (Herne), War Room (Annak-khurfu), Gundabad, or All Hubs.
* **Delving Malice Guide:** Real-time breakdown of today's hazard, recommended curative potions (Wound, Poison, Disease, Fear), and combat tactics.
* **Collapsible Travel Tray:** Built-in shortcut tray for return maps and fast-travel skills directly inside the plugin window.
* **Live Search & Incomplete Filter:** Filter cards by keywords or click `Incomplete` to hide missions you have already completed today.
* **1-Click Instant Reloader:** Right-click the jewel icon → *Reload Plugin* to update smoothly without freezing.

---

## 📦 Installation

1. Download the latest release from the [Releases](https://github.com/KroftLA/DelvingHelper/releases) page (`DelvingHelper_v1.5.16.zip`).
2. Extract the archive into your LOTRO plugins folder:
   ```text
   Documents\The Lord of the Rings Online\Plugins\
   ```
3. In-game, enable **DelvingHelper** in the **System → Plugin Manager** menu.
