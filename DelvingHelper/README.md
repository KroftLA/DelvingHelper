# DelvingHelper for The Lord of the Rings Online

**DelvingHelper** is an in-game assistant and speedrun tracker for daily Delving Writs farming, mission rotation pools, Delving Malice hazards, and Mission Giver NPC coordinates in LOTRO.

---

## What's New in v1.5.13

- **Removed 'Magic of the Frost-bound'**:
  - Removed high-annoyance mission `Mission: Magic of the Frost-bound` (Annak-Khurfu War Room) from Wednesday (Day 3) pool in both `BurglarMissions` and `DailyMissions[3]`.

## What's New in v1.5.12

- **Phase-Driven Dynamic Plugin Reloading (Fixed 'Error loading: nil' message)**:
  - In LOTRO's Turbine API, `Turbine.PluginManager.LoadPlugin` returns `void`/`nil` on successful load. Fixed an incorrect error condition that treated `nil` as a failure.
  - Rewrote `DelvingHelperReloader` with a resilient multi-phase state machine (`unload` -> `waitUnload` -> `load` -> `waitLoad` -> `done`) dynamically checking `GetLoadedPlugins()` before attempting to load the new instance, eliminating race conditions.

## What's New in v1.5.11

- **Fixed Plugin Reloading Freeze (DelvingHelperReloader Deadlock)**:
  - Fixed an issue where clicking "Reload Plugin" (or typing `/dh reload`) could become stuck on `[DelvingHelper] Reloading plugin...` if `DelvingHelperReloader` remained active in memory from an earlier reload.
  - `TriggerReloadPlugin()` now explicitly unloads any stale `DelvingHelperReloader` instance before requesting a reload.
  - Transitioned reloader cleanup in `Init()` to an asynchronous deferred frame counter so the reloader's call stack completely unwinds before its script state is unloaded.
  - Added error diagnostic reporting in `DelvingHelperReloader.lua`.

## What's New in v1.5.10

- **Added 'The Tearful Tomb' to Wednesday Pool**:
  - Added `Mission: The Tearful Tomb` (Cardolan / Andrath) to Wednesday (Day 3) in both `BurglarMissions` (Burglar Stealth Route) and `DailyMissions[3]` (Standard Pools).
  - Updated mission rotation schedule metadata: now officially available on Monday, Tuesday, Wednesday, Thursday, and Saturday (`dayIds = { 1, 2, 3, 4, 6 }`).

## What's New in v1.5.9

- **Added 'Stirring of Spirits' to Wednesday Pool**:
  - Added `Mission: Stirring of Spirits` (Cardolan / Andrath) to Wednesday (Day 3) in both `BurglarMissions` (Burglar Stealth Route) and `DailyMissions[3]` (Standard Pools).
  - Updated mission rotation schedule metadata: now officially available on Monday, Tuesday, Wednesday, Thursday, and Saturday (`dayIds = { 1, 2, 3, 4, 6 }`).

## What's New in v1.5.8

- **Weekly 45 Missions Wrapper Support ("On A Continuing mission (weekly)")**:
  - **3rd Progress Counter Row**: Added dedicated tracking row `On a Continuing Mission: 0/45` with `[-]` and `[+]` mini stepper buttons directly below the 15 Missions counter.
  - **Weekly Reset Rules**: Adheres to official LOTRO weekly reset behavior (Thursday 03:00 Server Time / 10:00 MSK). If completed (`>= 45`), resets to 0. If incomplete (e.g. `28/45`), progress carries over automatically into the new week.
  - **Floating Icon Tooltip**: Updated jewel icon hover tooltip to display 5 lines, including `Continuing: %d/%d`.
  - **Chat Log Listener**: Automatically captures quest progression notifications for continuing missions (e.g. `(X/45)` or `45/45`).
  - **Chat Commands**:
    - `/dh count <d> <w> <c>` or `/dh set <d> <w> <c>` to manually set all 3 counters (Daily Delvings, Weekly 15 Missions, Weekly 45 Missions).
    - `/dh count45 <c>` or `/dh set45 <c>` to set the 45-mission counter individually.
    - `/dh count15 <w>` or `/dh set15 <w>` to set the 15-mission counter individually.
    - `/dh resetweekly` now accounts for the 45-mission wrapper.

## What's New in v1.5.7

- **Removed 'A Glutton in the Larder'**:
  - Removed high-danger / dense mob mission `Mission: A Glutton in the Larder` from Tuesday (Day 2) pool in `BurglarMissions` and `DailyMissions[2]`.

## What's New in v1.5.6

- **Fixed Native Apartment Configuration for Autonomous Reloading**:
  - Added `Apartment="DelvingHelper"` to `DelvingHelper.plugin` descriptor (identical to `Gibberish.plugin` and `EquipmentPlugin.plugin`).
  - Previously, `UnloadScriptState("DelvingHelper")` could not unload the plugin because it ran in the default un-named apartment, leaving the previous version running in memory.
  - Now, clicking **"Reload Plugin"** fully and autonomously unloads and reloads the fresh version from disk without ever needing manual unloads from the Plugin Manager.

## What's New in v1.5.5

- **Cleaned Search & Filter Bar Layout**:
  - **Removed Speedruns Filter**: Simplified the filter bar to focus on search and completion status.
  - **Clear Button Label**: Replaced the ambiguous `[x]` button next to the search box with a clear `"Clear"` text button, clearly grouped with the search input.
  - **Spaced Incomplete Filter**: Added a generous visual gap separating the search box from the `"Incomplete"` toggle button to prevent visual blending.
  - **Toggled State Indicator**: The Incomplete button now shows `"Incomplete (ON)"` when active and `"Incomplete"` when inactive.

## What's New in v1.5.4

- **Fast Search & Smart Mission Filters**:
  - **Live Search Bar**: Type any part of a mission name, short name, NPC, hub, or area to instantly filter cards in real time.
  - **Instant Clear `[x]`**: One-click button to reset search input.
  - **`[ Incomplete ]` Smart Filter**: One-click toggle to hide already completed missions, displaying only what still needs to be done.
  - **`[ Speedruns ]` Smart Filter**: One-click toggle to show only the fastest S-Tier / Tier 1 speedrun missions.
  - **`[ Reset Filters ]` Button**: Instantly restores the full mission pool.
  - **Chat Commands**: `/dh search <query>` (or `/delving search <query>`) and `/dh clear` to search or reset filters from chat.

## What's New in v1.5.3

- **Fixed Right-Click Context Menu Activation**:
  - Fixed an issue where right-clicking the jewel icon erroneously triggered the left-click handler (opening the main window) due to an invalid `args.Action` check evaluating to nil comparison in Lua.
  - Corrected mouse button detection to strictly check `args.Button == Turbine.UI.MouseButton.Right`.
  - Added persistent menu reference to protect the context menu from premature Lua garbage collection.

## What's New in v1.5.2

- **Right-Click "Reload Plugin" Context Menu (Gibberish3 Style)**:
  - Right-clicking the floating Delving jewel icon now opens a native context menu with **"Reload Plugin"**.
  - Clicking **"Reload Plugin"** smoothly unloads and reloads DelvingHelper in LOTRO without needing chat commands (`/plugins load`, etc.).
  - Powered by a lightweight dedicated companion reloader (`DelvingHelperReloader`).
  - Added chat command `/dh reload` / `/delving reload` as an alternate shortcut.
  - The context menu also provides quick toggles for **Open/Close Window**, **Lock/Unlock Icon Position**, and access to **Quick Settings**.

## What's New in v1.5.1

- **Added 'Crown of Caranost', 'Down on the Farm', and 'The Ruins of Amon Firn' to Sunday Rotation**:
  - Registered all 3 fast Cardolan (Andrath) missions for Sunday (`dayId = 7`) across `BurglarMissions` and `DailyMissions[7]`.
  - Updated schedule days array to include Sunday across all occurrences.

## What's New in v1.5.0

- **Amethyst / Royal Purple NPC Tag UI Styling**:
  - Re-themed the NPC Bestower tag badge (`[NPC: <Name>]`) to a vibrant royal purple/amethyst style (`PurpleBg`, `PurpleBorder`, and `PurpleText` in bright lilac).
  - Solves the visual conflict where the previous emerald green tag blended in with the green borders/highlights of completed missions.

## What's New in v1.4.9

- **Added 'Siege-breaking' to Thursday Rotation**:
  - Registered `Mission: Siege-breaking` (Cardolan - Herne [50.1S, 44.7W], Bestower: Hithriel) for Thursday (`dayId = 4`) across `BurglarMissions` and `DailyMissions[4]`.
  - Updated schedule days array to `Tuesday, Thursday, Friday, Sunday` (`dayIds = { 2, 4, 5, 7 }`).

## What's New in v1.4.8

- **Added 'The Nettinglade' to Thursday Rotation**:
  - Registered `Mission: The Nettinglade` (Cardolan - Andrath [37.6S, 49.8W]) for Thursday (`dayId = 4`) across `BurglarMissions` and `DailyMissions[4]`.
  - Updated schedule days array to `Tuesday, Thursday, Friday, Sunday` (`dayIds = { 2, 4, 5, 7 }`).

## What's New in v1.4.7

- **Emerald NPC Bestower Tag UI Enhancement**:
  - Redesigned the mission card bestower line with a dedicated Emerald NPC Tag badge (`[NPC: <Name>]`) in VerdanaBold12 with smoothed borders.
  - Improves visibility of mission givers (Horin, Ausma, Baglan, Hithriel) at a glance.
  - Location and coordinates cleanly aligned adjacent to the NPC badge in silver/gray.

## What's New in v1.4.6

- **Removed 'The Bloody Ruins' Mission**:
  - Removed `Mission: The Bloody Ruins` (War Room / Annak-Khurfu, NPC: Horin) from Wednesday rotation across `BurglarMissions` and `DailyMissions[3]`.
  - The mission was determined to be too tedious/unpleasant for delving runs.

## What's New in v1.4.5

- **Removed 'The Taurogrim Alliance' Mission**:
  - Removed `Mission: The Taurogrim Alliance` (War Room / Annak-Khurfu, NPC: Ausma) from Monday rotation across `BurglarMissions` and `DailyMissions[1]`.
  - The mission was determined to be too slow/tedious for solo delving speedruns.

## What's New in v1.4.4

- **Added 'Stirring of Spirits' & 'The Tearful Tomb' to Monday Rotation**:
  - Added both fast Cardolan (Andrath) speedrun missions to Monday (`dayId = 1`) across `BurglarMissions` and `DailyMissions[1]`.
  - Updated rotation definitions across all days (`days = "Monday, Tuesday, Thursday, Saturday"`, `dayIds = { 1, 2, 4, 6 }`).

## What's New in v1.4.3

- **Removed 'Tharbad Tower Ascent' Mission**:
  - Removed `Mission: Tharbad Tower Ascent` from all rotation days (Tuesday & Thursday) across both `BurglarMissions` and `DailyMissions`.
  - The mission was determined to be too difficult/slow for efficient delving speedruns.

## What's New in v1.4.2

- **Fix Multi-Day Mission Rotation Warnings**:
  - Fixed false-positive "[DelvingHelper Notice] is scheduled for Tuesday, Thursday" warnings when taking missions like `Stirring of Spirits` on Saturday.
  - `D.FindMissionInDatabase` now prioritizes the active rotation day (`activeDay`), correctly recognizing multi-day missions across all days they are valid.
  - Updated `Stirring of Spirits` and `The Tearful Tomb` definitions with complete multi-day schedule arrays (`Tuesday, Thursday, Saturday`, `dayIds = { 2, 4, 6 }`).

## What's New in v1.4.1

- **Baruk-Style Quickslot Engine (Equendil Architecture)**:
  - Adopted the exact Quickslot mechanism from Baruk (`Equendil.UI.QuickSlot`):
  - Solved the LOTRO engine bug where blank/undefined Quickslots automatically hide themselves (`SetVisible(false)`). With `VisibleChanged` override, slots stay permanently active and visible to accept drag & drop.
  - Added Baruk drag-out handling (`MouseDown` + `MouseLeave` + `MouseUp`) to easily clear or replace shortcuts.
  - Safe shortcut creation and setting via `pcall` matching Baruk's `setSlotData`.

## What's New in v1.4.0

- **Direct Native Quickslot Drag & Drop Fix**:
  - Eliminated intermediate sub-containers that blocked mouse hit-testing in Turbine UI (`MouseVisible`).
  - Quickslots are now direct children of `travelTray` at `ZOrder = 10`, allowing the LOTRO C++ client engine to natively accept drag-and-drop from the Skill Book (`K`) and Inventory Bags (`I`).
  - Restored native `ShortcutChanged` event handling matching proven working plugins (`EndlessFlame`).
  - Added visual slot frames and `+` markers behind empty Custom Travel slots.

## What's New in v1.3.99

- **Robust Travel Tray Drag & Drop (Custom Maps & Skills)**:
  - Fixed map and skill drag-and-drop to Fast Travel slots!
  - Added full `DragDrop` interception across both the Quickslot and the entire slot column container.
  - Implemented `args.DragDropInfo:SetSuccessful(false)` to prevent LOTRO from rejecting or cancelling item/skill drops from inventory bags or skill book.
  - Added visual slot frames with background boxes and `+` markers for empty Custom Travel slots.

## What's New in v1.3.98

- **Friday Mission Pool Expansion**:
  - Added 4 key Cardolan speedrun missions to Friday (Day 5) rotations:
    - `Crown of Caranost` (Cardolan - Andrath, Top Speed ~1.5m)
    - `Down on the Farm` (Cardolan - Andrath, Burst Boss ~1.5m, Blue Border)
    - `The Ruins of Amon Firn` (Cardolan - Andrath, Top Speed ~1.5m)
    - `The Accursed Flame` (Cardolan - Herne, Situational ~1.5m)
  - Full support across Burglar Stealth Route and Standard Mission View pools with exact matching objectives, tips, and coordinates.

## What's New in v1.3.97

- **Escape Key to Close (Esc)**:
  - Added native `Escape` key handling to `DelvingHelper`!
  - Pressing `Esc` immediately closes the main window, exactly like standard LOTRO UI windows.
  - If a sub-dialog is open (`Color Guide`, `Options`, or `Reset Confirmation`), pressing `Esc` closes the active dialog first without closing the main window.

## What's New in v1.3.96

- **Classical LOTRO Button for Fast Travel Tray (Variant 2)**:
  - Replaced the wide stretched strip button with a classic authentic 200px button (`[ - ] Travel & Return Maps` / `[ + ] Travel & Return Maps`) styled in the exact mold of `Color Guide` and `Reset Count`.
  - Added subtle center helper hint `(Click to toggle ports & maps)`.
  - Eliminated text truncation and trailing ellipsis (`...`).

## What's New in v1.3.95

- **Collapsible Fast Travel & Return Maps Tray (Option 3)**:
  - Added an in-game collapsible travel dock above the missions list:
    - **Andrath** Quickslot: `Return to Andrath` (`0x7006323D`) for Swanfleet/Cardolan missions (Nettinglade, Spirits, Tomb).
    - **Herne** Quickslot: `Return to Cardolan` (`0x700634AE`) for Tharbad / Herne missions (Siege-breaking).
    - **The Bloody Eagle** Quickslot: `Return to the Bloody Eagle Tavern` (`0x700697F2`) for Umbar delve boss (Beast of Belfalas).
    - **War Room** Quickslot: `Return to Annak-khurfu` (`0x7005856F`) for Gundabad / War Room missions (Marshun, Taurogrim).
    - **Custom 1 & Custom 2** Quickslots: Drag-and-drop slots accepting any teleport skill, reputation map, or milestone item from inventory.
  - Interactive **`[+] / [-] Delving Fast Travel & Return Maps`** toggle button with animated layout resizing.
  - **`Reset Slots`** button to quickly restore defaults.
  - Persistent state and custom shortcuts saved per character in `DelvingHelperSettings`.

## What's New in v1.3.94

- **XML Manifest BOM Fix & Load Failure Resolution**:
  - Removed hidden UTF-8 BOM (`0xEF 0xBB 0xBF`) from both `.plugin` manifests which caused LOTRO's XML parser to reject loading the plugin (`Unable to load "DelvingHelper"`).
  - Ensured both `.plugin` files and all `.lua` scripts use 100% pure 7-bit ASCII without BOM.
  - Added **`Mission: The Beast of Belfalas`** across all 7 daily rotation pools under `The Bloody Eagle` hub tab.
  - Cleaned up Tuesday rotation pools with **`The Nettinglade`** and **`Siege-breaking`** properly mapped without duplicate index collisions.

## What's New in v1.3.93

- **Siege-breaking Added to Tuesday**:
  - Added **Mission: Siege-breaking** to Tuesday's rotation pool (D.DailyMissions[2]) and Tuesday Burglar speedruns (dayIds = { 2, 5, 7 }).
  - Bestowed by **Mission Giver** at Herne (50.1S, 44.7W / 51.9S, 45.0W). Speedrun objective: Stealth past patrollers straight to the siege engines, burn all siege weapons, and claim the delving chest (~2 min run).

## What's New in v1.3.92

- **The Nettinglade Added to Tuesday**:
  - Added **Mission: The Nettinglade** to Tuesday's rotation pool (D.DailyMissions[2]) and Tuesday Burglar speedruns (dayIds = { 2, 5, 7 }).
  - Bestowed by **Mission Giver** at Andrath (37.6S, 49.8W). Speedrun objective: Stealth through the spider glade, free the 8 cocooned elves, and claim the delving chest (~1.5 min run).

## What's New in v1.3.91

- **The Bloody Eagle Hub & The Beast of Belfalas**:
  - Replaced the unused "Gundabad" hub tab with **`The Bloody Eagle`** (`bloody_eagle`).
  - Added new speedrun delving mission: **`Mission: The Beast of Belfalas`** bestowed by **Mission Giver** at The Bloody Eagle tavern (`21.4S, 97.4W` in Umbar Baharbel).
  - Strategy tip: `BURGLAR RUSH: Stealth through the shadows directly to the beast boss, assassinate it and claim the delving chest.`
  - Perfectly rebalanced the hub filter buttons row (`All Hubs` 80px, `The Bloody Eagle` 128px, `Cardolan` 86px, `Umbar` 78px, `War Room` 94px, `Favorites` 128px) spanning the exact 624px grid with 6px gaps.

## What's New in v1.3.89

- **Smoothed Classical LOTRO UI Layout**:
  - **Softened Chamfered Card Borders (`ApplySmoothedBorder`)**: Replaced harsh sharp rectangles with refined 3px chamfered corners and two-tone sculpted border frames (outer forest/bronze line + subtle inner highlight).
  - **Refined Slate-Charcoal Panel Fill**: Cards and panels feature rich, deep semi-transparent backgrounds that blend naturally with native LOTRO window parchment.
  - **Card Margin Spacing**: Mission cards in the scrollable list are now spaced with clean 6px margins.
  - **Sunken Timer Ribbon**: Header bar features a soft sunken chamfered border and TrajanPro14 typography with ample spacing before `Lock Icon`.
  - **Softened Malice & Writ Guide Panels**: Tier cards across all 3 view modes now share the unified smoothed aesthetic.

## What's New in v1.3.88

- **Fixed Alert Banner Multi-line Text Formatting**:
  - Resolved an issue where literal `<br>` tags appeared in the on-screen warning banner.
  - Enabled multi-line support (`SetMultiline(true)`) on the banner label and transitioned to native newline formatting (`\n`).
  - Warning and rotation mismatch banners now display clean, properly centered multi-line text without markup artifacts.

## What's New in v1.3.87

- **Smart Mission Acceptance Scanner & Alerts**:
  - Automatically intercepts quest acceptance events in game chat (`New Quest: Mission: ...`).
  - Scans the entire 7-day database (`D.BurglarMissions` and `D.DailyMissions[1..7]`).
  - If an unknown/unsupported mission is taken, triggers a prominent red on-screen warning banner and chat alert advising the player to cancel.
  - If an approved mission is taken on a non-rotation day, displays a helpful notice with its scheduled day.
  - Added option toggle in Quick Settings (`Warn on Unknown Missions`), Plugin Manager options, and chat command `/delving warn`.

## What's New in v1.3.86

- **Saturday Rotation (Cardolan / Andrath)**:
  - Added **`Mission: The Tearful Tomb`** to Saturday's rotation pool (`D.DailyMissions[6]`) and Saturday speedruns (`D.BurglarMissions`).
  - Bestowed by **Mission Giver** at Andrath (`37.6S, 49.8W`). Speedrun objective: Stealth through tomb corridors directly to the inner chamber, assassinate tomb guardian, and claim delve chest (~1.5 min run).

## What's New in v1.3.85

- **Saturday Rotation (Cardolan / Andrath)**:
  - Added **`Mission: Stirring of Spirits`** to Saturday's rotation pool (`D.DailyMissions[6]`) and Saturday speedruns (`D.BurglarMissions`).
  - Bestowed by **Mission Giver** at Andrath (`37.6S, 49.8W`). Speedrun objective: Stealth past roaming spirits straight into the boss cavern, assassinate the shadow boss, and claim the delving chest (~1.5 min run).

## What's New in v1.3.84

- **Friday Rotation - War Room (Annak-Khurfu)**:
  - Added **`Mission: The Vale-watch Rescue`** bestowed by **Horin** to Friday's rotation pool (`D.DailyMissions[5]`) and Friday speedruns (`D.BurglarMissions`).
  - Speedrun objective: Stealth between enemy cages, rescue all 4 captive dwarves, and claim the delving chest (~2 min run).

## What's New in v1.3.83

- **Friday Rotation - War Room (Annak-Khurfu)**:
  - Added **`Mission: The Last Embers of Nurz Ghashu`** bestowed by **Horin** to Friday's rotation pool (`D.DailyMissions[5]`) and Friday speedruns (`D.BurglarMissions`).
  - Highlighted with a **Red Border Alert** (`highlightColor = "red"`): boss is surrounded by dense packs of trash mobs, requiring fast single-target burst or crowd control.
  - Enhanced Unicode/diacritic normalization for game chat completion messages containing special vowels (`û`, `â`).

## What's New in v1.3.82

- **Friday Rotation - War Room (Annak-Khurfu)**:
  - Added **`Mission: Raiders From Gundabad`** bestowed by **Horin** to Friday's rotation pool (`D.DailyMissions[5]`) and Friday speedruns (`D.BurglarMissions`).
  - Speedrun objective: Stealth straight to the bottom clearing, ignore arriving waves of adds, wait for boss **Marshun**, eliminate him, and claim the delving chest (~1.5 min run).

## What's New in v1.3.81

- **Chat Auto-Tracker Robustness**:
  - Auto-tracker now always assigns completed missions to the current active server day (`autoDay`), regardless of whether the player is currently viewing a different day tab (e.g. Sunday) in the UI.

## What's New in v1.3.80

- **Cardolan Rotation & Mission Accuracy**:
  - Updated **`Mission: The Nettinglade`**:
    - Hub & Coordinates: **Cardolan (Andrath)** at **`37.6S, 49.8W`** (bestowed by **Mission Giver**).
    - Objective: **Free 8 elves from spider cocoons**.
    - Active rotation: Added to **Friday** (`D.DailyMissions[5]`) and active on **Sunday** in Burglar speedruns (`D.BurglarMissions`).

## What's New in v1.3.79

- **Direct In-Game Icon Lock / Unlock**:
  - Added a dedicated **`[ ] Lock Icon`** checkbox directly in the Main Window header banner (top-right next to the server countdown timer), eliminating the need to open Plugin Manager options just to reposition the icon.
  - Added **`dragMoved`** displacement tracking on the floating jewel icon: dragging the icon to reposition it will no longer trigger an accidental toggle of the main window upon mouse release.
  - Added chat commands **`/delving lock`** and **`/delving unlock`** (also via `/dh lock` / `/dh unlock`) for quick keyboard toggling.
  - Synchronized icon lock status seamlessly across the Main Window header, the right-click Quick Settings menu, and Plugin Manager options.

## What's New in v1.3.78

- **Roster Refinement**:
  - Completely removed legacy mission **`Among the Watch-towers`** from Thursday's speedrun pool in `Data.lua`.

## What's New in v1.3.77

- **Thursday Rotation - War Room (Annak-Khurfu)**:
  - Added **`Mission: Two Heads are Deadlier`** bestowed by **Ausma** to Thursday's rotation pool (`D.DailyMissions[4]`) and Thursday speedruns (`D.BurglarMissions`).
  - Speedrun objective: Stealth directly to the two-headed ettin boss, eliminate him, and claim the delving chest (~1.5 min run).

## What's New in v1.3.76

- **Thursday Rotation - War Room (Annak-Khurfu)**:
  - Added **`Mission: The Bloody Ritual`** bestowed by **Horin** to Thursday's rotation pool (`D.DailyMissions[4]`) and Thursday speedruns (`D.BurglarMissions`).
  - Speedrun objective: Stealth through the ritual grounds directly to both blood obelisks, destroy them to disrupt the ritual, and claim the delving chest (~1.5 min run).

## What's New in v1.3.75

- **Thursday Rotation - War Room (Annak-Khurfu)**:
  - Added **`Mission: Reclaiming the Vale-watch`** bestowed by **Horin** to Thursday's rotation pool (`D.DailyMissions[4]`) and Thursday speedruns (`D.BurglarMissions`).
  - Speedrun objective: Stealth between earth mounds across the Vale-watch, interact with all mounds while avoiding mob detection, and claim the delving chest (~2 min run).

## What's New in v1.3.74

- **Login Reset & Daily Checkbox Cleanup (LootLogs Architecture)**:
  - Added immediate reset evaluation on player login (`Init()`) right after `LoadSettings()`, ensuring all daily and weekly resets apply instantly upon entering the game.
  - Implemented daily checkbox hygiene: on daily rotation reset (03:00 Server Time), stale mission completion flags for today's active day are cleared, giving a fresh rotation list every day.
  - Fixed persistent `weekKey` recovery for characters whose weekly reset failed in previous sessions.

## What's New in v1.3.73

- **Bugfix: Weekly Reset Scope Issue**:
  - Fixed runtime error `attempt to call global 'CountCompletedDaily' (a nil value)` triggered during Thursday Weekly Reset.
  - Reordered local function declarations (`CountCompletedDaily`, `CountCompletedWeekly`, `CountCompletedCheckboxes`) to precede `CheckDailyReset` in `Main.lua`.
  - Added chat commands `/delving resetweekly` (apply weekly reset rules on demand) and `/delving reset` (open reset dialog).

## What's New in v1.3.72

- **Wednesday Rotation - War Room (Annak-Khurfu)**:
  - Added **`Mission: The Hand of Gorgar`** bestowed by **Ausma** to Wednesday's rotation pool (`D.DailyMissions[3]`) and Wednesday speedruns (`D.BurglarMissions`).
  - Speedrun objective: Stealth through the fortress directly to orc leader *Hand of Gorgar*, eliminate him, and claim the delving chest (~1.5 min run).

## What's New in v1.3.71

- **Wednesday Rotation - War Room (Annak-Khurfu)**:
  - Added **`Mission: Magic of the Frost-bound`** bestowed by **Ausma** to Wednesday's rotation pool (`D.DailyMissions[3]`) and Wednesday speedruns (`D.BurglarMissions`).
  - Tactical highlight: **Blue Border** alert. Eliminating orc boss *Frost-caller Tugost* after thinning nearby mobs. Includes pro-tip on pre-using *Delving Edhelharn Tokens* for Hope buffs that persist through tactical death wipes.

## What's New in v1.3.70

- **Wednesday Rotation - War Room (Annak-Khurfu)**:
  - Added **`Mission: Blockade at Glimmerdeep`** bestowed by **Ausma** to Wednesday's rotation pool (`D.DailyMissions[3]`) and Wednesday speedruns (`D.BurglarMissions`).
  - Speedrun objective: Stealth through the blockade barricades into Glimmerdeep, eliminate troll leader Magathlug, and claim the delving chest (~1.5 min run).

## What's New in v1.3.69

- **Wednesday Rotation - War Room (Annak-Khurfu)**:
  - Added **`Mission: The Throne of Tharrazhar`** bestowed by **Horin** to Wednesday's rotation pool (`D.DailyMissions[3]`) and Wednesday speedruns (`D.BurglarMissions`).
  - Speedrun objective: Stealth through Tharrazhar directly to the throne room, eliminate orc leader Graznul, and claim the delving chest (~1.5 min run).

## What's New in v1.3.68

- **Wednesday Rotation - War Room (Annak-Khurfu)**:
  - Added **`Mission: The Goblins for Gorgar`** bestowed by **Horin** to Wednesday's rotation pool (`D.DailyMissions[3]`) and Wednesday speedruns (`D.BurglarMissions`).
  - Speedrun objective: Stealth through the goblin encampment directly to goblin leader Gorgar, assassinate him, and claim the delving chest (~1.5 min run).

## What's New in v1.3.67

- **Wednesday Rotation - War Room (Annak-Khurfu)**:
  - Added **`Mission: The Bloody Ruins`** bestowed by **Horin** to Wednesday's rotation pool (`D.DailyMissions[3]`) and Wednesday speedruns (`D.BurglarMissions`).
  - Speedrun objective: Stealth down into the depths of the catacombs, eliminate the wraith boss, and loot the delving chest (~1.5 min run).

## What's New in v1.3.66

- **Wednesday Rotation - War Room (Annak-Khurfu)**:
  - Added **`Mission: Son of the Chieftain`** bestowed by **Horin** to Wednesday's rotation pool (`D.DailyMissions[3]`) and Wednesday speedruns (`D.BurglarMissions`).
  - Speedrun objective: Stealth directly through the mission area to assassinate the warg boss (*Son of the Chieftain*) and claim the delving chest (~1.5 min run).

## What's New in v1.3.65

- **Wednesday Rotation Roster Expansion**:
  - Added **`The Accursed Flame`** to Wednesday's rotation pool (`D.DailyMissions[3]`).
  - Configured multi-day availability (`days = "Monday, Wednesday, Saturday"`, `dayIds = { 1, 3, 6 }`) for `The Accursed Flame`.
  - Removed duplicate entry from Saturday's section in `Data.lua`, standardizing multi-day handling.

## What's New in v1.3.64

- **Wednesday Rotation Roster Expansion**:
  - Added **`The Ruins of Amon Firn`** and **`Down on the Farm`** to Wednesday's rotation pool.
  - Configured multi-day availability (`days = "Monday, Wednesday, Saturday"`, `dayIds = { 1, 3, 6 }`) for both missions across all hubs.
  - Eliminated legacy duplicate entries from Saturday's section in `Data.lua`.

## What's New in v1.3.63

- **Auto-All Days Navigation in Favorites**:
  - Clicking **`[Favorites]`** automatically selects **`[All]` (All Days)** view, immediately displaying all favorited missions across the entire week with their respective day badges (`[Mon]`, `[Wed]`, `[Thu]`, `[Sat]`).
  - Switching back to a standard hub (e.g. `[All Hubs]`) automatically restores the day view back to today's rotation.

## What's New in v1.3.62

- **Multi-Day Mission Architecture & Duplicate Prevention**:
  - Implemented dynamic multi-day matching (`D.MatchesDay`), enabling missions like `Crown of Caranost` to seamlessly appear on multiple scheduled days (Monday, Wednesday, Thursday, Saturday) from a single database entry.
  - Eliminated duplicate database entries and fixed duplicate card rendering on Thursday and Saturday tabs.
  - Added `Crown of Caranost` to Wednesday's rotation pool.
  - Strict day-isolated checkbox and favorite tracking: completing a multi-day mission on Monday marks only Monday's card (`1:Crown of Caranost`), keeping Wednesday, Thursday, and Saturday clean and independent.

## What's New in v1.3.61

- **Interactive Mission Color Guide**:
  - Added dedicated **`[Color Guide]`** button in the main window (left of counters), accessible at all times.
  - Added **`Mission Color Guide`** button in the Plugin Manager settings panel.
  - Added chat command: **`/delving colors`** (or `/delving guide`).
  - Clear explanations for all 5 color codes:
    - **Red**: Danger Alert / Difficult missions (dense mob packs, dangerous mechanics, e.g. banner planting in *Torrent-spires* or *Matron of the Hatchery*).
    - **Blue / Cyan**: Tactical Alert / Crucial mechanics (Damage Reflect cleanse checks on *Down on the Farm* / *Caranost Command Post*, or Duo Recommended on *Taurogrim Alliance*).
    - **Gold**: Speedrun routes (~1.5 - 2 min optimal fast farm).
    - **Green**: Completed missions and wrapper goals.
    - **White / Grey**: Standard daily rotation pool missions.

## What's New in v1.3.60

- **Conditional Weekly Reset on Thursday (Preserve Incomplete Wrapper Progress)**:
  - Weekly wrappers ONLY reset on Thursday morning (03:00 Server Time / 10:00 MSK) **if they were fully completed** (`10/10` or `15/15`, green).
  - Incomplete quest progress (e.g., `6/10` or `14/15`, gold/not green) is **NOT reset** and carries over intact into the new week, perfectly matching official LOTRO quest log mechanics.
  - Independent tracking: completing 10/10 while 15/15 is incomplete (e.g. 10/15) resets the 10/10 counter on Thursday while cleanly preserving the 10/15 progress.
  - Cleared legacy hardcoded seed offsets on initialization so fresh zero counts persist accurately.

## What's New in v1.3.59

- **Strict Weekly Lifecycle for Both Delving Counters (10/10 & 15/15)**:
  - Ensured both `Delvings: 10/10` and `Delvings on any difficulty: 15/15` are strictly recognized as **Weekly Wrapper Quests**.
  - Daily reset (every morning at 10:00/11:00 MSK) ONLY advances the rotation day (Mon/Tue/Wed...) and Malice; it does **NOT** reset the 10/10 delving counters.
  - Both delving counters persist across all days (Fri, Sat, Sun, Mon, Tue, Wed) and reset strictly **ONCE A WEEK on Thursday at 03:00 Server Time (10:00 AM MSK)**.

## What's New in v1.3.58

- **Consolidated Reset & Clock Banner Header**:
  - Replaced the single server reset timer with all 4 essential time metrics displayed directly on the top header banner:
    - **Daily Reset**: exact countdown until next daily reset (`10h 28m`).
    - **Weekly Reset**: exact countdown until next Thursday weekly reset (`1d 10h 28m`).
    - **Server**: current LOTRO Server Time and timezone (`16:30 EDT`).
    - **Local**: current player's local computer time (`23:30`).
  - No need to hover to inspect critical reset times — all 4 indicators are permanently visible in real-time.

## What's New in v1.3.57

- **Automated Weekly 10/10 Delvings Lifecycle & Thursday Reset**:
  - Registered official Thursday 03:00 AM Server Time (10:00 AM MSK summer / 11:00 AM MSK winter) weekly reset cycle.
  - When `Completed high tier delvings (tier 6 and higher) (10/10)` triggers, it records the weekly completion and computes the exact countdown until next Thursday morning reset.
  - Automated weekly reset: every Thursday at 03:00 Server Time, weekly progress (`0/15`) and weekly 10 delvings status automatically refresh for the new week.
  - Automated daily reset: every day at 03:00 Server Time (10:00/11:00 MSK), daily counter resets to `0/10` with fresh checkboxes.
  - Reset tooltip now displays live countdown to next Weekly Reset.

## What's New in v1.3.56

- **Fixed Tooltip Layering & In-Window Display**:
  - Embedded the server reset info tooltip directly inside `mainWindow` as a child control with high Z-order (`ZOrder = 9999`).
  - Completely resolved the issue where tooltips appeared behind or partially outside the main plugin window.
  - Hovering either the timer label or the top header banner neatly displays the tooltip directly below the banner inside the window.

## What's New in v1.3.55

- **Fixed ApplyBorder Nil Error on Reset Tooltip**:
  - Added reusable `ApplyBorder` helper function to render clean 1-pixel borders on UI controls.
  - Eliminated runtime nil value exception during tooltip initialization on the reset countdown banner.

## What's New in v1.3.54

- **True LOTRO Server Time & Accurate Reset Countdown**:
  - Implemented accurate calculation of LOTRO Server Time (US Eastern: EDT in summer, EST in winter) from local client time.
  - Automatically handles US Daylight Saving Time (EDT/EST) calendar rules (switching between UTC-4 and UTC-5).
  - Defaults to UTC+3 (Moscow / MSK) with configurable timezone offset (`/delving tz <offset>`).
  - Corrected daily reset time: LOTRO daily reset occurs at 03:00 AM Server Time (10:00 AM MSK in summer / 11:00 AM MSK in winter).
  - Top banner now displays exact Server Time matching `/servertime`, countdown to reset, and local reset time.
  - Hovering the reset countdown banner reveals a detailed tooltip explaining daily & weekly resets, character-specific limits, and commands.

## What's New in v1.3.53

- **Auto-Detection for Daily 10/10 Delvings Wrapper Quests & Deeds**:
  - Integrated listener for wrapper quest and deed progress messages (such as `Completed high tier delvings (tier 6 and higher) (10/10)` or generic `Completed delvings (10/10)`).
  - Automatically updates the daily delvings counter directly to `10/10` (turning the progress indicator bright green) even when some missions were completed outside the plugin's tracking list.
  - Also syncs weekly delvings progress and added support for `Turbine.ChatType.Advancement` channel.

## What's New in v1.3.52

- **Added Tuesday War Room Mission 'Reclaiming the Torrent-spires'**:
  - Registered `Mission: Reclaiming the Torrent-spires` for **Tuesday** (`dayId = 2`) under **Annak-Khurfu (War Room)**.
  - NPC: `Ausma`, objective: plant reclaiming banners across the spires (difficult mission).
  - Styled with special **Red Card Theme** (`highlightColor = "red"`) with crimson background, red border, and red title.
  - Rating: `Hard / Slow (~3.5m)`, advising players to clear hostile mob packs to safely plant banners.

## What's New in v1.3.51

- **Added Tuesday War Room Mission 'A Glutton in the Larder'**:
  - Registered `Mission: A Glutton in the Larder` for **Tuesday** (`dayId = 2`) under **Annak-Khurfu (War Room)**.
  - NPC: `Ausma`, objective: reach the boss and defeat him quickly.
  - Styled with special **Red Card Theme** (`highlightColor = "red"`) with crimson background, red border, and red title.
  - Added warning note: boss is surrounded by trash mobs; burst him down fast before adds overwhelm!

## What's New in v1.3.50

- **Added Tuesday War Room Mission 'The Matron of the Keep'**:
  - Registered `Mission: The Matron of the Keep` for **Tuesday** (`dayId = 2`) under **Annak-Khurfu (War Room)**.
  - NPC: `Horin`, objective: stealth through the keep directly to the boss and defeat her.
  - Fast speedrun route with top writ efficiency rating (`EXTREME ~60 Writs/min`).

## What's New in v1.3.49

- **Day-Specific Favorites & Independent Daily Completions for Repeating Missions**:
  - Independent favorite selection per day (`DH.settings.favorites["<day>:<mission>"]`):
    - Starring a mission on Tuesday stars it specifically for Tuesday.
    - Other rotation days (e.g. Thursday) remain independent unless explicitly favorited.
  - Multi-day mission separation in `[All]` view:
    - Recurring missions across days (such as Tuesday & Thursday runs) now display as separate cards with distinct day tags (`[Tue]`, `[Thu]`).
    - Completing a mission on Tuesday marks ONLY Tuesday completed (`[X]`), leaving Thursday uncompleted (`[ ]`).
  - Chat notifications show the target day when starring/unstarring (`Added to Favorites (Tue): ...`).

## What's New in v1.3.48

- **Added Tuesday Mission 'Tharbad Tower Ascent' (Cardolan)**:
  - Registered `Mission: Tharbad Tower Ascent` for **Tuesday** (`dayId = 2`) in Cardolan (Herne / Tharbad [50.1S, 44.7W], NPC: Mission Giver).
  - Ascend tower ramps in stealth straight to summit boss, eliminate boss, open delve chest.
  - Linked across Tuesday and Thursday rotations (`days = "Tuesday, Thursday"`).

## What's New in v1.3.47

- **Added Tuesday Mission 'The Tearful Tomb' (Cardolan)**:
  - Registered `Mission: The Tearful Tomb` for **Tuesday** (`dayId = 2`) in Cardolan (Andrath [37.6S, 49.8W], NPC: Mission Giver).
  - Infiltrate tomb in stealth, eliminate guardian, open delve chest.
  - Linked across Tuesday and Thursday rotations (`days = "Tuesday, Thursday"`).

## What's New in v1.3.46

- **Added Tuesday Mission 'Stirring of Spirits' (Cardolan)**:
  - Registered `Mission: Stirring of Spirits` for **Tuesday** (`dayId = 2`) in Cardolan (Andrath [37.6S, 49.8W], NPC: Mission Giver).
  - Objective: Infiltrate spirits cavern in stealth and defeat the boss.
  - Linked across Tuesday and Thursday rotations (`days = "Tuesday, Thursday"`).

## What's New in v1.3.45

- **Window Width Expansion & Day Badge Layout Fix**:
  - Expanded plugin window width from `600px` to `660px` for optimal breathing room and zero cramped UI elements.
  - Automatic settings migration: smoothly updates existing character configurations to `winW = 660`.
  - Expanded mission card header badge width to `212px` and enforced single-line rendering (`SetMultiline(false)`):
    - Completely prevents `[Mon, Sat]` day tags from wrapping into two lines or colliding with the `Run Tip` button below.
  - Widened all 8 Day navigation buttons (`All` + `Mon`..`Sun`) from `69px` to `74px` for clearer text and larger click areas.
  - Widened the `[★ Favorites]` hub button to `120px` to comfortably display the golden star icon and label.
  - Adjusted progress steppers and reset button geometry for clean horizontal alignment.

## What's New in v1.3.44

- **Graphical Star Icons for Favorites (Звёздочка Избранного)**:
  - Integrated genuine LOTRO star textures (`star_off.tga` and `star_on.tga`):
    - Unselected missions display the hollow silver star outline matching the in-game UI.
    - Selected favorite missions light up with the bright golden filled star.
  - Added the golden star icon to the `[Favorites]` hub navigation button.
  - Standalone bundled graphics inside `DelvingHelper/` with transparent alpha overlay.

## What's New in v1.3.43

- **Favorites System & Day Filter Integration (Избранное)**:
  - Added star favorite toggle button `[*]` to every mission card:
    - Mark or unmark any mission as a favorite with one click.
    - Persistent across sessions and characters via `DH.settings.favorites`.
  - Added `[* Favorites]` filter button to the Hub filter bar.
  - Added `[All]` button alongside `Mon`..`Sun` day buttons to view favorites and missions across the entire weekly rotation.
  - Day filtering for Favorites:
    - Select a specific day (or today's auto rotation) to see only favorite missions active on that day.
    - Select `All` to view all favorite missions across the entire week, with day tags (e.g. `[Mon]`, `[Mon, Sat]`).
  - Fully synchronized checkboxes: checking off a favorite mission updates daily `Delvings: X/10`, weekly `X/15`, and the floating icon counter.
  - Informative guidance card displayed when no favorites are selected yet for the active day.

## What's New in v1.3.42

- **Added War Room Monday Mission 'The Taurogrim Alliance'**:
  - Registered `Mission: The Taurogrim Alliance` under **Annak-Khurfu (War Room)** for **Monday** (`dayId = 1`).
  - NPC: `Ausma`, objective: defeat 10 Taurogrim.
  - Highlighted with cyan/blue border card style (`highlightColor = "blue"`).
  - Added special note tag: faster to complete as a duo (`Duo Recommended`).

## What's New in v1.3.41

- **Added War Room Monday Mission 'The Heart of Kidzul-kalah'**:
  - Registered `Mission: The Heart of Kidzul-kalah` under **Annak-Khurfu (War Room)** for **Monday** (`dayId = 1`).
  - NPC: `Ausma`, objective: stealth to boss, eliminate boss, and safely collect ground items.
  - Safe 7-bit ASCII representation without `??` rendering errors.

## What's New in v1.3.40

- **Added War Room Monday Mission 'Emissary at the Goblin-gate'**:
  - Registered `Mission: Emissary at the Goblin-gate` under **Annak-Khurfu (War Room)** for **Monday** (`dayId = 1`).
  - NPC: `Ausma`, stealth rush directly to the emissary boss.

## What's New in v1.3.39

- **Added War Room Monday Mission 'Breaking Bekar-zarakh'**:
  - Registered `Mission: Breaking Bekar-zarakh` under **Annak-Khurfu (War Room)** for **Monday** (`dayId = 1`).
  - NPC: `Horin`, speedrun stealth route directly to boss, 7-bit ASCII safe naming.

## What's New in v1.3.38

- **Updated Monday NPC to 'Mission Giver'**:
  - Replaced NPC name `Baglan` with `Mission Giver` across all Monday missions for consistency with Saturday and in-game bestower labels.

## What's New in v1.3.37

- **Added 'The Accursed Flame' to Monday (Day 1)**:
  - Added `Mission: The Accursed Flame` (Herne / Tharbad [50.1S, 44.7W]) to **Monday** rotation pools, copying all parameters, tips, and ratings from Saturday.
  - Linked to day-specific key (`1:The Accursed Flame`).

## What's New in v1.3.36

- **Added Monday (Day 1) Mission Rotation Pool**:
  - Registered 4 active Cardolan (Andrath) missions for **Monday** based on Saturday parameters:
    1. `Mission: Caranost Command Post` (Baglan, Andrath [37.6S, 49.8W])
    2. `Mission: Crown of Caranost` (Baglan, Andrath [37.6S, 49.8W])
    3. `Mission: Down on the Farm` (Baglan, Andrath [37.6S, 49.8W])
    4. `Mission: The Ruins of Amon Firn` (Baglan, Andrath [37.6S, 49.8W])
  - Added to both Burglar Speedrun and Standard rotation pools with dedicated day keys (`1:<shortName>`).

## What's New in v1.3.35

- **Upscaled 42x42 Icon Size**:
  - Re-rendered **Delving Writ Scroll** medallion at enhanced **42x42** resolution.
  - Sized floating icon window and background control to 42x42 for improved clarity, readability, and easier clicking in-game.
  - Adjusted UI popup menu and tooltip placement offsets for 42px icon footprint.

## What's New in v1.3.34

- **New 'Delving Writ & Quest Scroll' Medallion Icon**:
  - Replaced plugin icon with the royal **Delving Writ Scroll** medallion: rolled parchment with crimson wax seal, surrounded by an ornate golden ring and glowing starlight background.
  - Transparent circular alpha mask: floats seamlessly on screen without black corners or rectangular borders.
  - Sized to standard 32x32 TGA (`icon.tga`).

## What's New in v1.3.33

- **Dwarven Key Icon & Removed Gold UI Window Border**:
  - Installed **Dwarven Key (Гномий ключ Дельвингов)** on dark slate stone as 32x32 TGA (`icon.tga`).
  - Removed outer frame from the artwork: pure dark granite slab with glowing golden runic key.
  - Removed UI gold border (`Colors.BorderGold`) around the floating window; icon window resized to exact 32x32.
  - Icon now floats cleanly on screen with zero distracting borders or text counters.

## What's New in v1.3.32

- **Fixed Plugin Unload Handler & Callback Safety**:
  - Replaced legacy class-level `Turbine.Plugin.Unload` assignment with safe instance-level `plugin.Unload` callback wrapped in `pcall`.
  - Upgraded `AddCallback` function to ensure event handlers always remain callable Lua function closures instead of raw arrays.
  - Added clean window hiding on unload (`iconWindow`, `mainWindow`, `quickSettingsWindow`).
  - Resolves LOTRO error `"Plugin script state could not be unloaded"`.

## What's New in v1.3.31

- **New Custom 'Smoky Quartz with Quad-Gemstone Runic Border' Icon**:
  - Authentic in-game Smoky Quartz Delving Gem with custom 4-quarter gemstone runic frame:
    - **Top (1/4)**: Glowing Amethyst Purple (Фиолетовый)
    - **Right (2/4)**: Glowing Emerald Green (Зеленый)
    - **Bottom (3/4)**: Fiery Ruby Red (Красный)
    - **Left (4/4)**: Deep Garnet Dark-Dark-Red (Темно-темно-красный)
  - Carved dwarven runes illuminated with gemstone light and smooth corner transitions.
  - Sized and installed as clean 32x32 TGA (`icon.tga`) without text overlay.

## What's New in v1.3.30

- **New 'Dwarven Compass' Plugin Icon**:
  - Replaced icon with the custom **Dwarven Compass** (Гномий рунический компас) 32x32 TGA icon featuring ancient runic bezel and Delving ruby core.
  - Removed on-icon text counter overlay so the artwork remains completely clean and unobstructed.
  - Daily and weekly progress are cleanly viewable via hover tooltip (`Delvings: 5/10`, `Delving on any difficulty: 9/15`).

## What's New in v1.3.29

- **Refined Floating Icon Tooltip**:
  - Removed server reset countdown timer (`Reset in ...`).
  - Replaced legacy `Writs Progress` label with dedicated `Delvings: X/10` and `Delving on any difficulty: Y/15` tracking lines.
  - Cleaned up mouse hint text line (`Left-click: Window | Right-click: Menu`) for a sleek, unobtrusive overlay.
  - Left-clicking the icon directly opens and focuses the DelvingHelper main window.

## What's New in v1.3.28

- **New 'Stealth Hood' Plugin Icon**:
  - Replaced the placeholder jewel icon with the custom **Stealth Hood** (Капюшон Взломщика) 32x32 TGA icon.
  - Matches the 100% Burglar speedrun theme of the plugin.
  - Displays on the floating on-screen badge and in the LOTRO Plugin Manager.

## What's New in v1.3.27

- **Hard-Capped Counters (No Exceeding 10/10 and 15/15)**:
  - Added strict upper bounds:
    - Daily counter (`Delvings: 0/10`) cannot exceed `10/10` and cannot drop below `0`.
    - Weekly counter (`Delvings on any difficulty: 0/15`) cannot exceed `15/15` and cannot drop below `0`.
  - Stepper `[+]` button disables further incrementing when the maximum cap is reached.
  - Reset and normalized current values to requested `5/10` and `9/15`.

## What's New in v1.3.26

- **Independent Stepper Buttons for Daily and Weekly Counters**:
  - Separated the manual `[-]` and `[+]` controls into two dedicated rows:
    - **Row 1 (`Delvings: 0/10`)**: Own `[-]` and `[+]` buttons to control daily progress.
    - **Row 2 (`Delvings on any difficulty: 0/15`)**: Own `[-]` and `[+]` buttons to control weekly progress.
  - Automatically initializes with your current progress (`5/10` daily and `9/15` weekly).
  - Enhanced chat command `/dh count <daily> <weekly>` (e.g. `/dh count 5 9`) to set both at once.

## What's New in v1.3.25

- **Day-Specific Mission Completion & Added Sunday 'Siege-breaking'**:
  - Added `Siege-breaking` to the **Sunday** mission rotation pool (Cardolan / Herne).
  - Mission completions and checkboxes are now keyed strictly day-by-day (`<DayId>:<MissionName>`).
  - Running a mission on Sunday marks it exclusively on the **Sunday** tab without affecting Friday or any other day.
  - Automatically migrates existing completed records to the active day.

## What's New in v1.3.24

- **Persistent Progress Tracking (No Automatic Reset)**:
  - Removed all automatic daily/weekly counter resets.
  - Completed missions, checkboxes, and counters (`Delvings: 0/10` and `Delvings on any difficulty: 0/15`) now persist indefinitely across days, weeks, and months.
  - Progress only resets when manually triggered by the player via the `Reset Count` button (with confirmation dialog) or manual controls `[-]`/`[+]`.

## What's New in v1.3.23

- **Added 'The Nettinglade' (Cardolan / Andrath - Sunday)**:
  - Bestower: NPC `Baglan` at Andrath in Cardolan (`37.6S, 49.8W`).
  - Active on **Sundays**.
  - Strategy: Stealth through the spider glade, free cocooned hostages, and complete the mission.
  - Full automatic chat tracking support.

## What's New in v1.3.22

- **Added 'The Matron of the High Pass' (Annak-Khurfu / War Room - Sunday)**:
  - Bestower: NPC `Ausma` in Annak-Khurfu (War Room).
  - Active on **Sundays**.
  - Strategy: Stealth through the high pass directly to the boss and assassinate her.
  - Full automatic chat tracking support.

## What's New in v1.3.21

- **Removed Misleading 'TOP SPEED' Badges**:
  - Completely removed artificial speed ratings (`TOP SPEED (~1.5m)`, `EXCELLENT (~3m)`, etc.) from mission cards and tips.
  - Expanded mission title width so long names display clearly without wrapping.
  - Cards now cleanly display the mission name, hub badge, NPC location/coords, strategy tip, and completion checkbox.

## What's New in v1.3.20

- **7 Interactive Day Tiles (Monday to Sunday)**:
  - Replaced the old `< Day` / `Day >` arrow bar with 7 sleek clickable tiles: `[ Mon ]`, `[ Tue ]`, `[ Wed ]`, `[ Thu ]`, `[ Fri ]`, `[ Sat ]`, `[ Sun ]`.
  - **Selected Day**: Illuminated with a brilliant gold border, amber-gold background, and bold gold text.
  - **Today (Server Active)**: Distinctively highlighted with a glowing green border and emerald indicator bar.
  - **Smart Selection**: Clicking any day instantly previews that day's mission pool; clicking today returns to real-time auto tracking.
  - Smooth hover animations and tactile click feedback.

## What's New in v1.3.19

- **Removed 'Top Farms' Filter Checkbox**:
  - Since the plugin is now 100% focused on Burglar missions and stealth speedruns, the redundant `Top Farms (<2.5m)` checkbox has been removed.
  - All curated missions for the selected day/hub are always visible without any hidden filters.
  - The counter row now cleanly presents the daily and weekly Delving counters alongside the manual `[-]` / `[+]` and `Reset Count` controls.

## What's New in v1.3.18

- **Streamlined Day Navigation Bar (Removed 'Set Active' Button)**:
  - Completely removed the redundant `Set Active` button.
  - The day header row is now clean, spacious, and symmetrical: `[ < Day ]` on the left, a large bold centered day title, and `[ Day > ]` on the right.
  - Clicking the day title directly returns the view to today's real-time active rotation.

## What's New in v1.3.17

- **100% Dedicated Burglar Plugin (Removed Route Switcher)**:
  - Completely removed the `Burglar Runs` / `Standard Pools` toggle button.
  - The plugin now exclusively runs Burglar stealth speedrun routes.
  - Cleaner top navigation bar: `< Day` and `Day >` with a wide, bold, centered day title and dedicated `Set Active` button.

## What's New in v1.3.16

- **Redesigned Stepper Buttons & Unified Counter Typography**:
  - Replaced clunky LOTRO buttons with custom, compact dark metallic mini-buttons with glowing gold hover borders.
  - Unified typography: both `Delvings: 0/10` and `Delvings on any difficulty: 0/15` now use the exact same `TrajanProBold14` font and bright gold palette.
  - Perfect right-alignment: both counter numbers align vertically, eliminating visual clutter.

## What's New in v1.3.15

- **Added Manual Counter Adjustments `[-]` and `[+]`**:
  - Mini `[-]` and `[+]` buttons right next to `Delvings: 0/10` to quickly adjust current progress without checking specific missions.
  - Added chat commands `/dh count <N>` and `/delving count <N>` to instantly set the counters to any number (e.g. `/dh count 4`).
  - Perfect for syncing with the in-game Quest Log when earlier missions were run before loading the plugin.

## What's New in v1.3.14

- **Universal Auto-Tracking Across All Tabs & Pools**:
  - The in-game Chat completion listener now checks both Burglar Speedruns and all Standard Daily Rotation Pools universally.
  - Automatically marks completed missions regardless of the active hub tab or selected profile mode.

## What's New in v1.3.13

- **Added Reset Confirmation Dialog Modal**:
  - Clicking `Reset Count` (or reset buttons in QuickSettings / Options) now opens an interactive confirmation dialog.
  - Prompts: "Are you sure you want to reset all completed Delving mission counters to 0?" with `[ Reset ]` and `[ Cancel ]` buttons.
  - Prevents accidental loss of progress counters.

## What's New in v1.3.12

- **Added 'The Great Goblin\'s Treasure' (Annak-Khurfu / War Room - Saturday)**:
  - Bestower: NPC `Ausma` inside Annak-Khurfu (War Room).
  - Active on **Saturdays**.
  - Speedrun rating: `Lever & Boss (~2m)`.
  - Strategy: Stealth to the lever and pull it, sneak to the treasure chest and open it, then assassinate the boss.
  - Enhanced Chat Auto-Tracker with robust apostrophe and quote normalization.

## What's New in v1.3.11

- **Added 'The Snows of Ker Brein' (Annak-Khurfu / War Room - Saturday)**:
  - Bestower: NPC `Horin` inside Annak-Khurfu (War Room).
  - Active on **Saturdays**.
  - Speedrun rating: `Top Speed (~1.5m)`.
  - Strategy: Stealth through the snows of Ker Brein, find and assassinate the boss, claim delving chest.
  - Enhanced Chat Auto-Tracker to normalize accented Welsh/Sindarin characters (`Kêr Bréin` -> `Ker Brein`) seamlessly.

## What's New in v1.3.10

- **Added Weekly 'Delvings on any difficulty: 0/15' Counter**:
  - Displays dual progress counters directly above the missions list:
    - Primary daily/wrapper counter: `Delvings: 0/10`
    - Secondary weekly wrapper counter: `Delvings on any difficulty: 0/15`
  - Turns vibrant green when goal is reached (`>= 10` and `>= 15`).
  - Supports automatic completion tracking from in-game chat and manual checkbox clicks.

## What's New in v1.3.9

- **Added 'The Beast of Misthallow' (Annak-Khurfu / War Room - Saturday)**:
  - Bestower: NPC `Horin` inside Annak-Khurfu (War Room).
  - Active on **Saturdays**.
  - Speedrun rating: `Top Speed (~1.5m)`.
  - Strategy: Stealth through Misthallow, locate and assassinate the beast boss, claim delving chest.

## What's New in v1.3.8

- **Added 'Annak-Khurfu (War Room)' Hub Filter Tab**:
  - Replaced the Swanfleet tab with **Annak-Khurfu (War Room)** in the hub filter bar.
  - Dynamically sized filter buttons (All Hubs, Gundabad, Cardolan, Umbar, Annak-Khurfu) for pixel-perfect layout without text clipping.
  - Ready for newly verified Annak-Khurfu (War Room) Delving speedrun missions.

## What's New in v1.3.7

- **Cleaned Up Unverified Preliminary Missions**:
  - Removed all 20 unverified/test missions from 23.10 list (Gundabad/Mattugard, Urmakh, The Nettinglade, etc.).
  - Preserved all 10 verified, player-tested speedrun routes:
    - **Thursday**: `Stirring of Spirits` (Andrath), `The Tearful Tomb` (Andrath), `Tharbad Tower Ascent` (Herne), `Among the Watch-towers` (Clegur).
    - **Friday**: `Siege-breaking` (Herne).
    - **Saturday**: `The Accursed Flame` (Herne), `Caranost Command Post` [Blue] (Andrath), `Crown of Caranost` (Andrath), `Down on the Farm` [Blue] (Andrath), `The Ruins of Amon Firn` (Andrath).

## What's New in v1.3.6

- **Changed 'Caranost Command Post' to Blue Border**:
  - Border and highlight switched to glowing blue (`Colors.Cyan`).
  - Strategy reminder: Easy if no Damage Reflection malice active! Kill 12 orcs rapidly and assassinate commander.

## What's New in v1.3.5

- **Updated 'The Ruins of Amon Firn' to Andrath (Cardolan - Saturday)**:
  - Bestower: Mission Giver at `[37.6S, 49.8W]` in Andrath.
  - Active on **Saturdays**.
  - Speedrun rating: `Top Speed (~1.5m)`.
  - Strategy: Slay main boss. Even with reflect, pull to safe spot, Riddle CC, go into stealth, purge corruptions if needed, and assassinate!

## What's New in v1.3.4

- **Added 'Down on the Farm' with Blue Border (Cardolan - Andrath / Saturday)**:
  - Bestower: Mission Giver at `[37.6S, 49.8W]` in Andrath.
  - Active on **Saturdays**.
  - Highlighted with a **Glowing Blue Border** (`Colors.Cyan`).
  - Strategy: Cleanse damage reflection immediately if active! Burst boss down rapidly before he flees, or mission must be restarted.

## What's New in v1.3.3

- **Updated 'Crown of Caranost' to Andrath (Cardolan)**:
  - Bestower: Mission Giver at `[37.6S, 49.8W]` in Andrath.
  - Active on **Thursdays & Saturdays**.
  - Strategy: Stealth directly to the citadel boss, assassinate, open delve chest.

## What's New in v1.3.2

- **Added 'Caranost Command Post' with Yellow Highlight (Cardolan - Andrath / Saturday)**:
  - Bestower: Mission Giver at `[37.6S, 49.8W]` in Andrath.
  - Active on **Saturdays**.
  - Highlighted in **Yellow / Gold**: Easy speedrun IF foes have no damage reflection malice!
  - Objective: Defeat 12 orcs and war commander.

## What's New in v1.3.1

- **Added 'The Accursed Flame' Burglar Trick Run (Cardolan - Herne / Saturday)**:
  - Bestower: Mission Giver at `[50.1S, 44.7W]` in Herne (Tharbad road).
  - Active on **Saturdays**.
  - Speedrun rating: `Situational (~1.5m)`.
  - Strategy: Stealth directly to the boss room without triggering the boss. Light the bonfire from maximum range. If disrupted on the first attempt, skip mission!

## What's New in v1.3.0

- **Added 'Siege-breaking' Burglar Speedrun (Cardolan - Herne / Friday)**:
  - Bestower: Mission Giver at `[50.1S, 44.7W]` in Herne (Tharbad road).
  - Active on **Fridays**.
  - Speedrun rating: `Top Speed (~2m)`.
  - Strategy: Infiltrate siege camp in stealth, burn all siege weapons without pulling aggro, loot delving chest.

## What's New in v1.2.9

- **Added 'Among the Watch-towers' Burglar Speedrun (Swanfleet - Clegur)**:
  - Bestower: Mission Giver at `[65.0S, 29.3W]` in Clegur (Swanfleet).
  - Active on **Thursdays**.
  - Speedrun rating: `Top Speed (~2m)`.
  - Strategy: Stealth between watch-towers, detonate 8 barrels without pulling aggro, loot delving chest.

## What's New in v1.2.8

- **Added 'Tharbad Tower Ascent' Burglar Speedrun (Cardolan - Herne)**:
  - Bestower: Mission Giver at `[50.1S, 44.7W]` in Herne (Tharbad road).
  - Active on **Thursdays**.
  - Speedrun rating: `Top Speed (~1.5m)`.
  - Strategy: Stealth up the tower ramps straight to the summit boss, assassinate, open delve chest.

## What's New in v1.2.7

- **Added 'The Tearful Tomb' Burglar Speedrun (Cardolan - Andrath)**:
  - Bestower: Mission Giver at `[37.6S, 49.8W]` in Andrath.
  - Active on **Thursdays**.
  - Speedrun rating: `Top Speed (~1.5m)`.
  - Strategy: Stealth through tomb corridors directly to the inner chamber, assassinate boss, open delve chest.

## What's New in v1.2.6

- **Added 'Stirring of Spirits' Burglar Speedrun (Cardolan - Andrath)**:
  - Bestower: Mission Giver at `[37.6S, 49.8W]` in Andrath.
  - Active on **Thursdays**.
  - Speedrun rating: `Top Speed (~1.5m)`.
  - Strategy: Stealth through shadows past wandering spirits directly to the boss chamber, assassinate boss, claim Delving Writs.

## What's New in v1.2.5

- **Fixed Text Clipping in Header & Mission Cards**:
  - Expanded the Day of Week label width and optimized formatting (`Day 4 (Thursday) (Active)`) so the word `(ACTIVE POOL)` no longer wraps or clips off at the bottom.
  - Expanded the Speedrun/Yield badge width to 165px and streamlined the badge text (`Top Speed (~1.5m)` / `Top Speed (~2m)`), preventing the time estimate from wrapping to a cut-off second line.
  - Cleaned mission titles to short names (`The Shadow of Valdhellir`, `The Chieftains Pack`, etc.) without the redundant `Mission: ` prefix, giving every element plenty of breathing room.
  - Increased spacing between the NPC bestower info and the `[Run Tip]` button.

---

## How to Reload in LOTRO

```text
/plugins unload DelvingHelper
/plugins load DelvingHelper
```
