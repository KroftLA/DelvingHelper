# DelvingHelper for The Lord of the Rings Online (LOTRO)

**DelvingHelper** is an essential in-game assistant and speedrun tracker designed for rapid Delving Writs farming, mission rotation tracking, Delving Malice hazard guides, and automated wrapper quest logging in LOTRO.

---

## What's New in v1.5.21

* **Siege-breaking & The Nettinglade on Saturday:**
  * Added *"Siege-breaking"* (Herne) and *"The Nettinglade"* (Andrath) to Saturday rotation lists and Burglar speedrun recommendations.
* **Cardolan Dynamic Rotation Documentation:**
  * Added guidance explaining that Cardolan (Andrath / Herne) missions appear dynamically/chaotically at NPCs, recommending using the search bar to locate them by name.
* **Updated Plugin Credits & Documentation:**
  * Official plugin development and documentation attributed to Kroft.
* **Removed Unfavorable Mission:**
  * Completely removed *"The Last Embers of Nûrz Ghâshu"* from rotation databases and speedrun recommendations.
* **Window State on Login:**
  * Fixed window auto-opening upon login or reload — the main window stays closed until explicitly clicked on the jewel icon.
* **Decoupled High Tier Delvings from Rotation Checkboxes:**
  * The `High tier delvings (tier 6 and higher)` counter is now strictly and exclusively driven by the in-game quest objective (`Completed high tier delvings (tier 6 and higher) (X/10)`).
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

> [!NOTE]
> **Cardolan Missions Note:** In Cardolan hubs (Andrath & Herne), daily missions appear dynamically/chaotically at the NPC. Use the search bar in DelvingHelper to quickly find any mission by name.

---

## 📦 Installation

1. Download the latest release from the [Releases](https://github.com/KroftLA/DelvingHelper/releases) page (`DelvingHelper_v1.5.21.zip`).
2. Extract the archive into your LOTRO plugins folder:
   ```text
   Documents\The Lord of the Rings Online\Plugins\
   ```
3. In-game, enable **DelvingHelper** in the **System → Plugin Manager** menu.
