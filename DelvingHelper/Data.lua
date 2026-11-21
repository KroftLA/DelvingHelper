-- ============================================================================
-- DelvingHelper - Data.lua
-- Dedicated Delving Writs Farming Database, Rotation Pools & Malice Guide
-- Version 1.5.13 (Strict 7-bit ASCII only)
-- ============================================================================

DelvingHelper = DelvingHelper or {};
DelvingHelper.Data = {};

local D = DelvingHelper.Data;

-- ----------------------------------------------------------------------------
-- Delving Writ Yields & Wrappers
-- ----------------------------------------------------------------------------
D.WritYields = {
    { tier = "Tiers 1 - 3",   writsPerRun = "10 - 20 Writs",   difficulty = "Easy",      recommended = "Warm-up / T1 speedrun" },
    { tier = "Tiers 4 - 6",   writsPerRun = "35 - 50 Writs",   difficulty = "Moderate",  recommended = "Fast farming for mid gear" },
    { tier = "Tiers 7 - 9",   writsPerRun = "70 - 90 Writs",   difficulty = "High",      recommended = "Qualifies for 500-Writ Weekly Wrapper" },
    { tier = "Tiers 10 - 12", writsPerRun = "110 - 150 Writs",  difficulty = "Maximum",   recommended = "Top efficiency + 1000-Writ Weekly Wrapper" },
};

-- ----------------------------------------------------------------------------
-- Days & Pools
-- ----------------------------------------------------------------------------
D.Days = {
    [1] = { id = 1, name = "Day 1 (Monday)",    short = "Day 1" },
    [2] = { id = 2, name = "Day 2 (Tuesday)",   short = "Day 2" },
    [3] = { id = 3, name = "Day 3 (Wednesday)", short = "Day 3" },
    [4] = { id = 4, name = "Day 4 (Thursday)",  short = "Day 4" },
    [5] = { id = 5, name = "Day 5 (Friday)",    short = "Day 5" },
    [6] = { id = 6, name = "Day 6 (Saturday)",  short = "Day 6" },
    [7] = { id = 7, name = "Day 7 (Sunday)",    short = "Day 7" },
};

-- ----------------------------------------------------------------------------
-- Hubs (Delving Writ hubs across Cardolan, Gundabad, Umbar & Annak-Khurfu)
-- ----------------------------------------------------------------------------
D.Hubs = {
    { id = "all",       name = "All Delvings" },
    { id = "bloody_eagle", name = "The Bloody Eagle" },
    { id = "cardolan",  name = "Cardolan (Herne/Andrath)" },
    { id = "urmakh",    name = "Umbar (Urmakh)" },
    { id = "warroom",   name = "Annak-Khurfu (War Room)" },
    { id = "favorites", name = "Favorite Missions" },
};

-- ----------------------------------------------------------------------------
-- Fast Travel & Return Maps Destinations (Collapsible Quickslots Tray)
-- ----------------------------------------------------------------------------
D.DefaultTravelSkills = {
    {
        id = "andrath",
        name = "Andrath",
        subName = "Nettinglade",
        skillId = "0x7006323D", -- Return to Andrath
        desc = "Return to Andrath (Swanfleet / Cardolan border)"
    },
    {
        id = "herne",
        name = "Herne",
        subName = "Siege-break",
        skillId = "0x700634AE", -- Return to Cardolan (Herne)
        desc = "Return to Cardolan (Herne / Crossway House / Siege-breaking)"
    },
    {
        id = "bloody_eagle",
        name = "Bloody Eagle",
        subName = "Beast Belfalas",
        skillId = "0x700697F2", -- Return to the Bloody Eagle Tavern
        desc = "Return to the Bloody Eagle Tavern (Umbar Baharbel)"
    },
    {
        id = "warroom",
        name = "War Room",
        subName = "Annak-khurfu",
        skillId = "0x7005856F", -- Return to Annak-khurfu
        desc = "Return to Annak-khurfu (War Room / Gundabad)"
    },
    {
        id = "custom1",
        name = "Custom 1",
        subName = "Drag & Drop",
        skillId = nil,
        desc = "Custom Travel Slot 1: Drag any skill, map item or milestone here"
    },
    {
        id = "custom2",
        name = "Custom 2",
        subName = "Drag & Drop",
        skillId = nil,
        desc = "Custom Travel Slot 2: Drag any skill, map item or milestone here"
    },
};

-- ----------------------------------------------------------------------------
-- Master NPC Locations for Delving Writs
-- ----------------------------------------------------------------------------
D.NPCLocations = {
    {
        name = "Mission Giver (The Bloody Eagle)",
        role = "Umbar Delving Missions Bestower",
        hub = "The Bloody Eagle",
        area = "The Bloody Eagle (Umbar Baharbel)",
        coords = "21.4S, 97.4W",
        travel = "Travel to Umbar Baharbel, enter The Bloody Eagle tavern.",
    },
    {
        name = "Delving Mission Quartermaster (Mattugard)",
        role = "Delving Gems and Writs Barter NPC",
        hub = "Gundabad",
        area = "Mattugard (Near Mission Giver)",
        coords = "45.4S, 114.8W",
        travel = "Barter Delving Writs for Gundabad delve rewards and enhancements.",
    },
    {
        name = "Mission Giver (Herne)",
        role = "Cardolan Delving Missions Bestower",
        hub = "Cardolan",
        area = "Herne (Crossway House)",
        coords = "51.9S, 45.0W",
        travel = "Swift travel from South Bree or Mossward to Herne. Inside the Crossway House.",
    },
    {
        name = "Mission Giver (Herne - Tharbad Road)",
        role = "Cardolan Delving Missions Bestower",
        hub = "Cardolan",
        area = "Herne / Tharbad",
        coords = "50.1S, 44.7W",
        travel = "Located northeast of Herne along the road toward Tharbad.",
    },
    {
        name = "Baglan (Andrath)",
        role = "Cardolan Delving Missions Bestower",
        hub = "Cardolan",
        area = "Andrath",
        coords = "37.6S, 49.8W",
        travel = "Located along the Greenway road at Andrath in north Cardolan.",
    },
    {
        name = "Delving Mission Quartermaster (Herne)",
        role = "Delving Gems and Writs Barter NPC",
        hub = "Cardolan",
        area = "Herne (Next to Mission Giver)",
        coords = "51.9S, 45.0W",
        travel = "Exchange Delving Writs for raid gear, zirakzigil gems, and craft recipes.",
    },
    {
        name = "Mission Giver (Urmakh)",
        role = "Umbar Delving Missions Bestower",
        hub = "Umbar",
        area = "Urmakh / Umbar-mokh",
        coords = "17.9S, 95.2W",
        travel = "Travel to Umbar Baharbel, then proceed to the upper camp at Urmakh.",
    },
    {
        name = "Mission Giver (Clegur)",
        role = "Swanfleet Delving Missions Bestower",
        hub = "Swanfleet",
        area = "Clegur (Central Camp)",
        coords = "65.0S, 26.2W",
        travel = "Swift travel from Herne or Mossward to Clegur.",
    },
    {
        name = "Mission Giver (Clegur - Watch-towers)",
        role = "Swanfleet Delving Missions Bestower",
        hub = "Swanfleet",
        area = "Clegur / Caras Gelebren",
        coords = "65.0S, 29.3W",
        travel = "Located west of Clegur central camp toward the watch-towers.",
    },
    {
        name = "Delving Mission Quartermaster (Bree)",
        role = "Delving Writs Barter at Bree Skirmish Camp",
        hub = "Bree-land",
        area = "South Bree Skirmish Camp",
        coords = "32.2S, 50.3W",
        travel = "South gate of Bree, at the Skirmish Camp quartermaster pavilion.",
    },
};

-- ----------------------------------------------------------------------------
-- Delving Malice Variants (6-Cycle)
-- ----------------------------------------------------------------------------
D.MaliceVariants = {
    [1] = {
        id = 1,
        title = "Variant 1 - Malice of Dread and Flame",
        tagline = "Fiery Puddles and Persistent Dread",
        recommendedPotions = "Fire Defence Scrolls, Hope Tokens",
        tactics = "Avoid orange flame puddles upon monster death. Use Hope tokens if Dread drains your morale.",
        tiers = {
            { range = "T1 - T3",   hazard = "Dread aura (+2 Dread) permanently reduces max morale and increases miss chance." },
            { range = "T4 - T6",   hazard = "Defeated foes burst into lingering flame puddles, ticking fire damage every 2s." },
            { range = "T7 - T9",   hazard = "Minion death triggers explosive fire blast damaging nearby allies within 5m." },
            { range = "T10 - T12", hazard = "Sauron's Flaming Wrath drops meteors periodically on player coordinates." },
        }
    },
    [2] = {
        id = 2,
        title = "Variant 2 - Malice of Corruption and Shadow",
        tagline = "Damage Reflection and Shadow Buffs",
        recommendedPotions = "Corruption Removal Skills, Shadow Mitigation",
        tactics = "Immediately remove Corruption buffs from elites before bursting. Watch for the 15% damage reflect barrier!",
        tiers = {
            { range = "T1 - T3",   hazard = "Enemies periodically gain Corruption stacks (+5% Outgoing Damage per stack)." },
            { range = "T4 - T6",   hazard = "Defeated foes pool lingering shadow mist, slowing movement by 40% and ticking shadow damage." },
            { range = "T7 - T9",   hazard = "Elites activate a Shadow Ward reflecting 15% of all received damage back to the attacker." },
            { range = "T10 - T12", hazard = "Shadow Vortex periodically pulls the player toward the enemy leader." },
        }
    },
    [3] = {
        id = 3,
        title = "Variant 3 - Malice of Disease and Rot",
        tagline = "Healing Debuffs and Spreading Plague",
        recommendedPotions = "Disease Potions and Confections",
        tactics = "Drink Disease Potions as soon as Rot appears. The healing debuff cuts incoming heals by 30%.",
        tiers = {
            { range = "T1 - T3",   hazard = "Basic enemy attacks apply minor disease damage-over-time (stacking up to 3x)." },
            { range = "T4 - T6",   hazard = "Diseased clouds linger on defeat, slashing all incoming and outgoing healing by 30%." },
            { range = "T7 - T9",   hazard = "Virulent Plague jumps between targets, resetting dot timers on player and pets." },
            { range = "T10 - T12", hazard = "Putrefaction pulses pulse every 25s, sapping both Morale and Power rapidly." },
        }
    },
    [4] = {
        id = 4,
        title = "Variant 4 - Malice of Pestilence and Poison",
        tagline = "Lethal Venom and Crevice Eruptions",
        recommendedPotions = "Poison Potions, Acid/Poison Resistance",
        tactics = "Cleanse poison dots immediately. Keep moving away from toxic geysers that erupt from cavern floor.",
        tiers = {
            { range = "T1 - T3",   hazard = "Subtle venom coats enemy daggers, increasing critical strike chance against player." },
            { range = "T4 - T6",   hazard = "Poison puddles erupt from the floor, inflicting heavy Nature/Poison ticks over 12s." },
            { range = "T7 - T9",   hazard = "Poison puddles heal nearby enemies for 2% max morale per tick while damaging you." },
            { range = "T10 - T12", hazard = "Toxic Nova detonates whenever an Elite boss drops below 50% health." },
        }
    },
    [5] = {
        id = 5,
        title = "Variant 5 - Malice of Wounds and Bloodlust",
        tagline = "Enraged Mobs and Hemorrhaging Wounds",
        recommendedPotions = "Wound Potions, Stun/Daze CC",
        tactics = "Stun low-health enemies when they enrage. Cleanse deep gash wounds before sprinting.",
        tiers = {
            { range = "T1 - T3",   hazard = "Critical hits against player inflict Deep Gash wounds that tick physical damage." },
            { range = "T4 - T6",   hazard = "Enemies gain +35% Attack Speed and +25% Damage when reduced below 30% Morale." },
            { range = "T7 - T9",   hazard = "Heavy Arterial Bleed ticks multiply by 2x whenever the player moves or sprints." },
            { range = "T10 - T12", hazard = "Blood Feast: When any minion dies, the nearest Elite heals for 15% max morale." },
        }
    },
    [6] = {
        id = 6,
        title = "Variant 6 - Malice of Fear and Terror",
        tagline = "Stun Roots and Terror Waves",
        recommendedPotions = "Fear Potions, Stun Breaks (Find Footing)",
        tactics = "Keep stun-break skills ready when entering combat. Turn away from Sauron's Gaze immediately!",
        tiers = {
            { range = "T1 - T3",   hazard = "Terror auras cause involuntary trembling, increasing skill induction times by 20%." },
            { range = "T4 - T6",   hazard = "Sudden Dread roots player in place for 3s when combat begins." },
            { range = "T7 - T9",   hazard = "Terror Waves pulse outward from Elites every 20s, draining morale and induction time." },
            { range = "T10 - T12", hazard = "Gaze of Sauron: Stares directly at player. Looking at boss inflicts a 6s petrify stun." },
        }
    },
};

-- ----------------------------------------------------------------------------
-- CURATED BURGLAR STEALTH WRIT MISSIONS (Verified Speedrun Routes)
-- Specifically tailored for Burglar stealth skipping trash to maximize Delving Writs
-- ----------------------------------------------------------------------------
D.BurglarMissions = {
    -- THE BLOODY EAGLE (UMBAR)
    {
        name = "Mission: The Beast of Belfalas",
        shortName = "The Beast of Belfalas",
        hub = "bloody_eagle",
        hubName = "The Bloody Eagle",
        days = "All Days",
        dayId = 0,
        dayIds = { 1, 2, 3, 4, 5, 6, 7 },
        npc = "Mission Giver",
        coords = "21.4S, 97.4W",
        location = "The Bloody Eagle",
        isSpeedrun = true,
        writRating = "Fast (~2m)",
        estTime = "~2 min",
        objective = "Navigate through the shadows, defeat the beast boss, and open the delving chest.",
        tip = "BURGLAR RUSH: Stealth through the shadows directly to the beast boss, assassinate it and claim the delving chest."
    },
    -- THURSDAY PRIME RUNS
    {
        name = "Mission: Stirring of Spirits",
        shortName = "Stirring of Spirits",
        hub = "cardolan",
        hubName = "Cardolan (Andrath)",
        days = "Monday, Tuesday, Wednesday, Thursday, Saturday",
        dayId = 4,
        dayIds = { 1, 2, 3, 4, 6 },
        npc = "Mission Giver",
        coords = "37.6S, 49.8W",
        location = "Andrath",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Infiltrate spirits cavern in stealth, defeat shadow boss.",
        tip = "BURGLAR RUSH: Stealth through shadows past roaming spirits directly to boss, assassinate, open delve chest."
    },
    {
        name = "Mission: The Tearful Tomb",
        shortName = "The Tearful Tomb",
        hub = "cardolan",
        hubName = "Cardolan (Andrath)",
        days = "Monday, Tuesday, Wednesday, Thursday, Saturday",
        dayId = 4,
        dayIds = { 1, 2, 3, 4, 6 },
        npc = "Mission Giver",
        coords = "37.6S, 49.8W",
        location = "Andrath",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Infiltrate tomb in stealth, defeat tomb guardian.",
        tip = "BURGLAR RUSH: Stealth through tomb corridors directly to the inner chamber, assassinate boss, open delve chest."
    },
    {
        name = "Mission: The Nettinglade",
        shortName = "The Nettinglade",
        hub = "cardolan",
        hubName = "Cardolan (Andrath)",
        days = "Tuesday, Thursday, Friday, Saturday, Sunday",
        dayId = 4,
        dayIds = { 2, 4, 5, 6, 7 },
        npc = "Mission Giver",
        coords = "37.6S, 49.8W",
        location = "Andrath",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5-2m)",
        estTime = "~1.5-2 min",
        objective = "Free 8 elves from spider cocoons.",
        tip = "BURGLAR TRICK: Stealth through the spider glade, free the 8 cocooned elves without aggroing extra spiders, and claim the delving chest."
    },
    {
        name = "Mission: Siege-breaking",
        shortName = "Siege-breaking",
        hub = "cardolan",
        hubName = "Cardolan (Herne)",
        days = "Tuesday, Thursday, Friday, Saturday, Sunday",
        dayId = 4,
        dayIds = { 2, 4, 5, 6, 7 },
        npc = "Hithriel",
        coords = "50.1S, 44.7W",
        location = "Herne (Crossway House)",
        isSpeedrun = true,
        writRating = "Top Speed (~2m)",
        estTime = "~2 min",
        objective = "Reach the siege engines, defeat 2 siege masters.",
        tip = "BURGLAR TRICK: Stealth past all trash mobs directly to the 2 siege masters, assassinate them."
    },
    {
        name = "Mission: Reclaiming the Vale-watch",
        shortName = "Reclaiming the Vale-watch",
        hub = "warroom",
        hubName = "Annak-Khurfu (War Room)",
        days = "Thursday",
        dayId = 4,
        npc = "Horin",
        coords = "",
        location = "Annak-Khurfu (War Room)",
        isSpeedrun = true,
        writRating = "Mound Interactions (~2m)",
        estTime = "~2 min",
        objective = "Search and interact with earth mounds throughout the Vale-watch.",
        tip = "BURGLAR TRICK: Stealth between earth mounds, interact with all mounds while avoiding mob detection, loot delve chest."
    },
    {
        name = "Mission: The Bloody Ritual",
        shortName = "The Bloody Ritual",
        hub = "warroom",
        hubName = "Annak-Khurfu (War Room)",
        days = "Thursday",
        dayId = 4,
        npc = "Horin",
        coords = "",
        location = "Annak-Khurfu (War Room)",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Stealth to the ritual sites and destroy 2 blood obelisks.",
        tip = "BURGLAR RUSH: Stealth through the ritual grounds directly to both obelisks, destroy them to disrupt the ritual, and claim the delving chest."
    },
    {
        name = "Mission: Two Heads are Deadlier",
        shortName = "Two Heads are Deadlier",
        hub = "warroom",
        hubName = "Annak-Khurfu (War Room)",
        days = "Thursday",
        dayId = 4,
        npc = "Ausma",
        coords = "",
        location = "Annak-Khurfu (War Room)",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Stealth directly to the two-headed ettin boss and defeat him.",
        tip = "BURGLAR RUSH: Stealth through the area straight to the two-headed boss, assassinate him, and claim the delving chest."
    },

    -- FRIDAY RUNS
    {
        name = "Mission: The Vale-watch Rescue",
        shortName = "The Vale-watch Rescue",
        hub = "warroom",
        hubName = "Annak-Khurfu (War Room)",
        days = "Friday",
        dayId = 5,
        npc = "Horin",
        coords = "",
        location = "Annak-Khurfu (War Room)",
        isSpeedrun = true,
        writRating = "Rescue (~2m)",
        estTime = "~2 min",
        objective = "Free and rescue 4 captured dwarves.",
        tip = "BURGLAR TRICK: Move in stealth between cages and enemy groups, rescue all 4 captive dwarves, and claim the delving chest."
    },
    {
        name = "Mission: Raiders From Gundabad",
        shortName = "Raiders From Gundabad",
        hub = "warroom",
        hubName = "Annak-Khurfu (War Room)",
        days = "Friday",
        dayId = 5,
        npc = "Horin",
        coords = "",
        location = "Annak-Khurfu (War Room)",
        isSpeedrun = true,
        writRating = "Boss Only (~1.5m)",
        estTime = "~1.5-2 min",
        objective = "Reach bottom clearing, wait for boss Marshun without engaging arriving adds, and defeat him.",
        tip = "BURGLAR TRICK: Move in stealth to the very bottom of the glade. Do not pull arriving waves of mobs! Wait for boss Marshun to arrive, assassinate him, and loot the delving chest."
    },
    {
        name = "Mission: Siege-breaking",
        shortName = "Siege-breaking",
        hub = "cardolan",
        hubName = "Cardolan (Herne)",
        days = "Tuesday, Thursday, Friday, Saturday, Sunday",
        dayId = 2,
        dayIds = { 2, 4, 5, 6, 7 },
        npc = "Hithriel",
        coords = "50.1S, 44.7W",
        location = "Herne (Crossway House)",
        isSpeedrun = true,
        writRating = "Top Speed (~2m)",
        estTime = "~2 min",
        objective = "Reach the siege engines, defeat 2 siege masters.",
        tip = "BURGLAR TRICK: Stealth past all trash mobs directly to the 2 siege masters, assassinate them."
    },

    -- SATURDAY RUNS
    {
        name = "Mission: Stirring of Spirits",
        shortName = "Stirring of Spirits",
        hub = "cardolan",
        hubName = "Cardolan (Andrath)",
        days = "Monday, Tuesday, Wednesday, Thursday, Saturday",
        dayId = 6,
        dayIds = { 1, 2, 3, 4, 6 },
        npc = "Mission Giver",
        coords = "37.6S, 49.8W",
        location = "Andrath",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Infiltrate spirits cavern in stealth, defeat shadow boss.",
        tip = "BURGLAR RUSH: Stealth through shadows past roaming spirits directly to boss, assassinate, open delve chest."
    },
    {
        name = "Mission: The Tearful Tomb",
        shortName = "The Tearful Tomb",
        hub = "cardolan",
        hubName = "Cardolan (Andrath)",
        days = "Monday, Tuesday, Wednesday, Thursday, Saturday",
        dayId = 6,
        dayIds = { 1, 2, 3, 4, 6 },
        npc = "Mission Giver",
        coords = "37.6S, 49.8W",
        location = "Andrath",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Infiltrate tomb in stealth, defeat tomb guardian.",
        tip = "BURGLAR RUSH: Stealth through tomb corridors directly to the inner chamber, assassinate boss, open delve chest."
    },
    {
        name = "Mission: Caranost Command Post",
        shortName = "Caranost Command Post",
        hub = "cardolan",
        hubName = "Cardolan (Andrath)",
        days = "Monday, Saturday",
        dayId = 6,
        dayIds = { 1, 6 },
        npc = "Mission Giver",
        coords = "37.6S, 49.8W",
        location = "Andrath",
        isSpeedrun = true,
        highlightColor = "blue",
        writRating = "Easy (No Reflect)",
        estTime = "~2 min",
        objective = "Defeat 12 orcs and the war commander.",
        tip = "BURGLAR TRICK (BLUE BORDER): Very easy if foes have NO damage reflection! Kill 12 orcs rapidly and assassinate commander."
    },
    {
        name = "Mission: The Nettinglade",
        shortName = "The Nettinglade",
        hub = "cardolan",
        hubName = "Cardolan (Andrath)",
        days = "Tuesday, Thursday, Friday, Saturday, Sunday",
        dayId = 6,
        dayIds = { 2, 4, 5, 6, 7 },
        npc = "Mission Giver",
        coords = "37.6S, 49.8W",
        location = "Andrath",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5-2m)",
        estTime = "~1.5-2 min",
        objective = "Free 8 elves from spider cocoons.",
        tip = "BURGLAR TRICK: Stealth through the spider glade, free the 8 cocooned elves without aggroing extra spiders, and claim the delving chest."
    },
    {
        name = "Mission: Siege-breaking",
        shortName = "Siege-breaking",
        hub = "cardolan",
        hubName = "Cardolan (Herne)",
        days = "Tuesday, Thursday, Friday, Saturday, Sunday",
        dayId = 6,
        dayIds = { 2, 4, 5, 6, 7 },
        npc = "Hithriel",
        coords = "50.1S, 44.7W",
        location = "Herne (Crossway House)",
        isSpeedrun = true,
        writRating = "Top Speed (~2m)",
        estTime = "~2 min",
        objective = "Reach the siege engines, defeat 2 siege masters.",
        tip = "BURGLAR TRICK: Stealth past all trash mobs directly to the 2 siege masters, assassinate them."
    },
    {
        name = "Mission: The Beast of Misthallow",
        shortName = "The Beast of Misthallow",
        hub = "warroom",
        hubName = "Annak-Khurfu (War Room)",
        days = "Saturday",
        dayId = 6,
        npc = "Horin",
        coords = "",
        location = "Annak-Khurfu (War Room)",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Find and defeat the beast boss in Misthallow.",
        tip = "BURGLAR RUSH: Stealth through Misthallow, locate and assassinate the beast boss, claim delving chest."
    },
    {
        name = "Mission: The Snows of Ker Brein",
        shortName = "The Snows of Ker Brein",
        hub = "warroom",
        hubName = "Annak-Khurfu (War Room)",
        days = "Saturday",
        dayId = 6,
        npc = "Horin",
        coords = "",
        location = "Annak-Khurfu (War Room)",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Find and defeat the boss in Ker Brein.",
        tip = "BURGLAR RUSH: Stealth through the snows of Ker Brein, find and assassinate the boss, claim delving chest."
    },
    {
        name = "Mission: The Great Goblin's Treasure",
        shortName = "The Great Goblin's Treasure",
        hub = "warroom",
        hubName = "Annak-Khurfu (War Room)",
        days = "Saturday",
        dayId = 6,
        npc = "Ausma",
        coords = "",
        location = "Annak-Khurfu (War Room)",
        isSpeedrun = true,
        writRating = "Lever & Boss (~2m)",
        estTime = "~2 min",
        objective = "Pull lever, open treasure chest, then defeat boss.",
        tip = "BURGLAR TRICK: Stealth to the lever and pull it, sneak to the treasure chest and open it, then assassinate the boss!"
    },
    -- SUNDAY RUNS
    {
        name = "Mission: The Matron of the High Pass",
        shortName = "The Matron of the High Pass",
        hub = "warroom",
        hubName = "Annak-Khurfu (War Room)",
        days = "Sunday",
        dayId = 7,
        npc = "Ausma",
        coords = "",
        location = "Annak-Khurfu (War Room)",
        isSpeedrun = true,
        objective = "Stealth to the boss and defeat her.",
        tip = "BURGLAR RUSH: Stealth through the high pass directly to the boss and assassinate her."
    },
    {
        name = "Mission: The Nettinglade",
        shortName = "The Nettinglade",
        hub = "cardolan",
        hubName = "Cardolan (Andrath)",
        days = "Tuesday, Thursday, Friday, Saturday, Sunday",
        dayId = 5,
        dayIds = { 2, 4, 5, 6, 7 },
        npc = "Mission Giver",
        coords = "37.6S, 49.8W",
        location = "Andrath",
        isSpeedrun = true,
        objective = "Free 8 elves from spider cocoons.",
        tip = "BURGLAR TRICK: Stealth through the spider glade, free the 8 cocooned elves without aggroing extra spiders, and claim the delving chest."
    },
    {
        name = "Mission: Siege-breaking",
        shortName = "Siege-breaking",
        hub = "cardolan",
        hubName = "Cardolan (Herne)",
        days = "Tuesday, Thursday, Friday, Saturday, Sunday",
        dayId = 7,
        dayIds = { 2, 4, 5, 6, 7 },
        npc = "Hithriel",
        coords = "50.1S, 44.7W",
        location = "Herne (Crossway House)",
        isSpeedrun = true,
        objective = "Reach the siege engines, defeat 2 siege masters.",
        tip = "BURGLAR TRICK: Stealth past all trash mobs directly to the 2 siege masters, assassinate them."
    },
    {
        name = "Mission: Crown of Caranost",
        shortName = "Crown of Caranost",
        hub = "cardolan",
        hubName = "Cardolan (Andrath)",
        days = "Monday, Wednesday, Thursday, Friday, Saturday, Sunday",
        dayId = 7,
        dayIds = { 1, 3, 4, 5, 6, 7 },
        npc = "Mission Giver",
        coords = "37.6S, 49.8W",
        location = "Andrath",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Reach the boss and defeat him.",
        tip = "BURGLAR RUSH: Stealth directly to the main boss and assassinate him."
    },
    {
        name = "Mission: Down on the Farm",
        shortName = "Down on the Farm",
        hub = "cardolan",
        hubName = "Cardolan (Andrath)",
        days = "Monday, Wednesday, Friday, Saturday, Sunday",
        dayId = 7,
        dayIds = { 1, 3, 5, 6, 7 },
        npc = "Mission Giver",
        coords = "37.6S, 49.8W",
        location = "Andrath",
        isSpeedrun = true,
        highlightColor = "blue",
        writRating = "Burst Boss (~1.5m)",
        estTime = "~1.5 min",
        objective = "Assassinate the farm boss before he escapes.",
        tip = "BURGLAR TRICK (BLUE BORDER): Cleanse Damage Reflect immediately if active! Must burst boss down fast before he flees, or mission must be restarted."
    },
    {
        name = "Mission: The Ruins of Amon Firn",
        shortName = "The Ruins of Amon Firn",
        hub = "cardolan",
        hubName = "Cardolan (Andrath)",
        days = "Monday, Wednesday, Friday, Saturday, Sunday",
        dayId = 7,
        dayIds = { 1, 3, 5, 6, 7 },
        npc = "Mission Giver",
        coords = "37.6S, 49.8W",
        location = "Andrath",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Assassinate the main boss in a safe spot.",
        tip = "BURGLAR TRICK: Slay main boss. Even with Reflect, pull to safe spot, Riddle CC, go into stealth, purge corruptions, and assassinate!"
    },
    -- MONDAY RUNS
    {
        name = "Mission: Stirring of Spirits",
        shortName = "Stirring of Spirits",
        hub = "cardolan",
        hubName = "Cardolan (Andrath)",
        days = "Monday, Tuesday, Wednesday, Thursday, Saturday",
        dayId = 1,
        dayIds = { 1, 2, 3, 4, 6 },
        npc = "Mission Giver",
        coords = "37.6S, 49.8W",
        location = "Andrath",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Infiltrate spirits cavern in stealth, defeat shadow boss.",
        tip = "BURGLAR RUSH: Stealth through shadows past roaming spirits directly to boss, assassinate, open delve chest."
    },
    {
        name = "Mission: The Tearful Tomb",
        shortName = "The Tearful Tomb",
        hub = "cardolan",
        hubName = "Cardolan (Andrath)",
        days = "Monday, Tuesday, Wednesday, Thursday, Saturday",
        dayId = 1,
        dayIds = { 1, 2, 3, 4, 6 },
        npc = "Mission Giver",
        coords = "37.6S, 49.8W",
        location = "Andrath",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Infiltrate tomb in stealth, defeat tomb guardian.",
        tip = "BURGLAR RUSH: Stealth through tomb corridors directly to the inner chamber, assassinate boss, open delve chest."
    },
    {
        name = "Mission: The Accursed Flame",
        shortName = "The Accursed Flame",
        hub = "cardolan",
        hubName = "Cardolan (Herne)",
        days = "Monday, Wednesday, Friday, Saturday",
        dayId = 1,
        dayIds = { 1, 3, 5, 6 },
        npc = "Mission Giver",
        coords = "50.1S, 44.7W",
        location = "Herne (Tharbad)",
        isSpeedrun = true,
        writRating = "Situational (~1.5m)",
        estTime = "~1.5 min",
        objective = "Reach the cursed pyre in stealth, ignite bonfire without triggering boss.",
        tip = "BURGLAR TRICK: Stealth to boss room without aggroing boss. Ignite bonfire from max range. If detected or disrupted on 1st try, skip mission!"
    },
    {
        name = "Mission: Caranost Command Post",
        shortName = "Caranost Command Post",
        hub = "cardolan",
        hubName = "Cardolan (Andrath)",
        days = "Monday, Saturday",
        dayId = 1,
        npc = "Mission Giver",
        coords = "37.6S, 49.8W",
        location = "Andrath",
        isSpeedrun = true,
        highlightColor = "blue",
        writRating = "Easy (No Reflect)",
        estTime = "~2 min",
        objective = "Defeat 12 orcs and the war commander.",
        tip = "BURGLAR TRICK (BLUE BORDER): Very easy if foes have NO damage reflection! Kill 12 orcs rapidly and assassinate commander."
    },
    {
        name = "Mission: Crown of Caranost",
        shortName = "Crown of Caranost",
        hub = "cardolan",
        hubName = "Cardolan (Andrath)",
        days = "Monday, Wednesday, Thursday, Friday, Saturday, Sunday",
        dayId = 1,
        dayIds = { 1, 3, 4, 5, 6, 7 },
        npc = "Mission Giver",
        coords = "37.6S, 49.8W",
        location = "Andrath",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Reach the boss and defeat him.",
        tip = "BURGLAR RUSH: Stealth directly to the main boss and assassinate him."
    },
    {
        name = "Mission: Down on the Farm",
        shortName = "Down on the Farm",
        hub = "cardolan",
        hubName = "Cardolan (Andrath)",
        days = "Monday, Wednesday, Friday, Saturday, Sunday",
        dayId = 1,
        dayIds = { 1, 3, 5, 6, 7 },
        npc = "Mission Giver",
        coords = "37.6S, 49.8W",
        location = "Andrath",
        isSpeedrun = true,
        highlightColor = "blue",
        writRating = "Burst Boss (~1.5m)",
        estTime = "~1.5 min",
        objective = "Assassinate the farm boss before he escapes.",
        tip = "BURGLAR TRICK (BLUE BORDER): Cleanse Damage Reflect immediately if active! Must burst boss down fast before he flees, or mission must be restarted."
    },
    {
        name = "Mission: The Ruins of Amon Firn",
        shortName = "The Ruins of Amon Firn",
        hub = "cardolan",
        hubName = "Cardolan (Andrath)",
        days = "Monday, Wednesday, Friday, Saturday, Sunday",
        dayId = 1,
        dayIds = { 1, 3, 5, 6, 7 },
        npc = "Mission Giver",
        coords = "37.6S, 49.8W",
        location = "Andrath",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Assassinate the main boss in a safe spot.",
        tip = "BURGLAR TRICK: Slay main boss. Even with Reflect, pull to safe spot, Riddle CC, go into stealth, purge corruptions, and assassinate!"
    },
    {
        name = "Mission: Breaking Bekar-zarakh",
        shortName = "Breaking Bekar-zarakh",
        hub = "warroom",
        hubName = "Annak-Khurfu (War Room)",
        days = "Monday",
        dayId = 1,
        npc = "Horin",
        coords = "",
        location = "Annak-Khurfu (War Room)",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Stealth to the boss and defeat him.",
        tip = "BURGLAR RUSH: Stealth through Bekar-zarakh directly to the boss, assassinate him, and claim the delving chest."
    },
    {
        name = "Mission: Emissary at the Goblin-gate",
        shortName = "Emissary at the Goblin-gate",
        hub = "warroom",
        hubName = "Annak-Khurfu (War Room)",
        days = "Monday",
        dayId = 1,
        npc = "Ausma",
        coords = "",
        location = "Annak-Khurfu (War Room)",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Stealth to the boss and defeat him.",
        tip = "BURGLAR RUSH: Stealth through Goblin-gate directly to the emissary boss, assassinate him, and claim the delving chest."
    },
    {
        name = "Mission: The Heart of Kidzul-kalah",
        shortName = "The Heart of Kidzul-kalah",
        hub = "warroom",
        hubName = "Annak-Khurfu (War Room)",
        days = "Monday",
        dayId = 1,
        npc = "Ausma",
        coords = "",
        location = "Annak-Khurfu (War Room)",
        isSpeedrun = true,
        writRating = "Boss & Loot (~2m)",
        estTime = "~2 min",
        objective = "Stealth to the boss, defeat him, and collect ground relics.",
        tip = "BURGLAR TRICK: Stealth through Kidzul-kalah directly to the boss, eliminate him, loot the ground objects in safety, and claim the delving chest."
    },

    -- TUESDAY RUNS
    {
        name = "Mission: Stirring of Spirits",
        shortName = "Stirring of Spirits",
        hub = "cardolan",
        hubName = "Cardolan (Andrath)",
        days = "Monday, Tuesday, Wednesday, Thursday, Saturday",
        dayId = 2,
        dayIds = { 1, 2, 3, 4, 6 },
        npc = "Mission Giver",
        coords = "37.6S, 49.8W",
        location = "Andrath",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Stealth through shadows to boss and defeat him.",
        tip = "BURGLAR RUSH: Stealth through shadows past roaming spirits directly to boss, assassinate, open delve chest."
    },
    {
        name = "Mission: The Tearful Tomb",
        shortName = "The Tearful Tomb",
        hub = "cardolan",
        hubName = "Cardolan (Andrath)",
        days = "Monday, Tuesday, Wednesday, Thursday, Saturday",
        dayId = 2,
        dayIds = { 1, 2, 3, 4, 6 },
        npc = "Mission Giver",
        coords = "37.6S, 49.8W",
        location = "Andrath",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Infiltrate tomb in stealth, defeat tomb guardian.",
        tip = "BURGLAR RUSH: Stealth through tomb corridors directly to the inner chamber, assassinate boss, open delve chest."
    },
    {
        name = "Mission: The Matron of the Keep",
        shortName = "The Matron of the Keep",
        hub = "warroom",
        hubName = "Annak-Khurfu (War Room)",
        days = "Tuesday",
        dayId = 2,
        npc = "Horin",
        coords = "",
        location = "Annak-Khurfu (War Room)",
        isSpeedrun = true,
        writRating = "EXTREME (~60 Writs/min)",
        estTime = "~1.5 min",
        objective = "Stealth through the keep directly to the boss and defeat her.",
        tip = "BURGLAR RUSH: Stealth through the keep past all defenders directly to the boss, assassinate, open delve chest."
    },

    {
        name = "Mission: Reclaiming the Torrent-spires",
        shortName = "Reclaiming the Torrent-spires",
        hub = "warroom",
        hubName = "Annak-Khurfu (War Room)",
        days = "Tuesday",
        dayId = 2,
        npc = "Ausma",
        coords = "",
        location = "Annak-Khurfu (War Room)",
        isSpeedrun = false,
        highlightColor = "red",
        writRating = "Hard / Slow (~3.5m)",
        estTime = "~3.5 min",
        objective = "Plant reclaiming banners across the spires (Difficult mission).",
        tip = "RED BORDER ALERT: Difficult mission. Clear hostile mobs to safely interact and plant all required banners."
    },

    -- WEDNESDAY RUNS
    {
        name = "Mission: Stirring of Spirits",
        shortName = "Stirring of Spirits",
        hub = "cardolan",
        hubName = "Cardolan (Andrath)",
        days = "Monday, Tuesday, Wednesday, Thursday, Saturday",
        dayId = 3,
        dayIds = { 1, 2, 3, 4, 6 },
        npc = "Mission Giver",
        coords = "37.6S, 49.8W",
        location = "Andrath",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Infiltrate spirits cavern in stealth, defeat shadow boss.",
        tip = "BURGLAR RUSH: Stealth through shadows past roaming spirits directly to boss, assassinate, open delve chest."
    },
    {
        name = "Mission: The Tearful Tomb",
        shortName = "The Tearful Tomb",
        hub = "cardolan",
        hubName = "Cardolan (Andrath)",
        days = "Monday, Tuesday, Wednesday, Thursday, Saturday",
        dayId = 3,
        dayIds = { 1, 2, 3, 4, 6 },
        npc = "Mission Giver",
        coords = "37.6S, 49.8W",
        location = "Andrath",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Infiltrate tomb in stealth, defeat tomb guardian.",
        tip = "BURGLAR RUSH: Stealth through tomb corridors directly to the inner chamber, assassinate boss, open delve chest."
    },
    {
        name = "Mission: Son of the Chieftain",
        shortName = "Son of the Chieftain",
        hub = "warroom",
        hubName = "Annak-Khurfu (War Room)",
        days = "Wednesday",
        dayId = 3,
        npc = "Horin",
        coords = "",
        location = "Annak-Khurfu (War Room)",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Stealth directly to the warg boss and defeat him.",
        tip = "BURGLAR RUSH: Stealth through the area directly to the warg boss, assassinate him, and claim the delving chest."
    },
    {
        name = "Mission: The Goblins for Gorgar",
        shortName = "The Goblins for Gorgar",
        hub = "warroom",
        hubName = "Annak-Khurfu (War Room)",
        days = "Wednesday",
        dayId = 3,
        npc = "Horin",
        coords = "",
        location = "Annak-Khurfu (War Room)",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Stealth to the boss and defeat goblin leader Gorgar.",
        tip = "BURGLAR RUSH: Stealth through the goblin encampment directly to Gorgar, assassinate him, and claim the delving chest."
    },
    {
        name = "Mission: The Throne of Tharrazhar",
        shortName = "The Throne of Tharrazhar",
        hub = "warroom",
        hubName = "Annak-Khurfu (War Room)",
        days = "Wednesday",
        dayId = 3,
        npc = "Horin",
        coords = "",
        location = "Annak-Khurfu (War Room)",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Stealth to the throne room and defeat orc leader Graznul.",
        tip = "BURGLAR RUSH: Stealth through Tharrazhar directly to the throne room, assassinate Graznul, and claim the delving chest."
    },
    {
        name = "Mission: Blockade at Glimmerdeep",
        shortName = "Blockade at Glimmerdeep",
        hub = "warroom",
        hubName = "Annak-Khurfu (War Room)",
        days = "Wednesday",
        dayId = 3,
        npc = "Ausma",
        coords = "",
        location = "Annak-Khurfu (War Room)",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Stealth past the blockade into Glimmerdeep and defeat troll leader Magathlug.",
        tip = "BURGLAR RUSH: Stealth through the blockade barricades directly to the troll boss Magathlug, assassinate him, and claim the delving chest."
    },
    {
        name = "Mission: The Hand of Gorgar",
        shortName = "The Hand of Gorgar",
        hub = "warroom",
        hubName = "Annak-Khurfu (War Room)",
        days = "Wednesday",
        dayId = 3,
        npc = "Ausma",
        coords = "",
        location = "Annak-Khurfu (War Room)",
        isSpeedrun = true,
        writRating = "Top Speed (~1.5m)",
        estTime = "~1.5 min",
        objective = "Stealth to the boss room and defeat orc leader Hand of Gorgar.",
        tip = "BURGLAR RUSH: Stealth through the fortress directly to the Hand of Gorgar, assassinate him, and claim the delving chest."
    },
};

-- ----------------------------------------------------------------------------
-- Delving Writ Missions Rotation Pools (Swanfleet & Cardolan)
-- ----------------------------------------------------------------------------
D.DailyMissions = {
    [1] = {
        {
            name = "Mission: The Beast of Belfalas",
            shortName = "The Beast of Belfalas",
            hub = "bloody_eagle",
            hubName = "The Bloody Eagle",
            npc = "Mission Giver",
            coords = "21.4S, 97.4W",
            location = "The Bloody Eagle",
            isSpeedrun = true,
            writRating = "Fast (~2m)",
            estTime = "~2 min",
            objective = "Navigate through the shadows, defeat the beast boss, and open the delving chest.",
            tip = "Stealth or fight through shadows directly to the beast boss, defeat it, and claim the delving chest."
        },
        {
            name = "Mission: The Heart of Kidzul-kalah",
            shortName = "The Heart of Kidzul-kalah",
            hub = "warroom",
            hubName = "Annak-Khurfu (War Room)",
            npc = "Ausma",
            coords = "",
            location = "Annak-Khurfu (War Room)",
            isSpeedrun = true,
            writRating = "HIGH (~45 Writs/min)",
            estTime = "~2 min",
            objective = "Stealth to the boss, defeat him, and collect ground relics.",
            tip = "Stealth directly to the boss, eliminate him, and collect ground relics."
        },
        {
            name = "Mission: Emissary at the Goblin-gate",
            shortName = "Emissary at the Goblin-gate",
            hub = "warroom",
            hubName = "Annak-Khurfu (War Room)",
            npc = "Ausma",
            coords = "",
            location = "Annak-Khurfu (War Room)",
            isSpeedrun = true,
            writRating = "EXTREME (~60 Writs/min)",
            estTime = "~1.5 min",
            objective = "Stealth to the boss and defeat him.",
            tip = "Stealth through Goblin-gate directly to the emissary boss and assassinate him."
        },
        {
            name = "Mission: Breaking Bekar-zarakh",
            shortName = "Breaking Bekar-zarakh",
            hub = "warroom",
            hubName = "Annak-Khurfu (War Room)",
            npc = "Horin",
            coords = "",
            location = "Annak-Khurfu (War Room)",
            isSpeedrun = true,
            writRating = "EXTREME (~60 Writs/min)",
            estTime = "~1.5 min",
            objective = "Stealth to the boss and defeat him.",
            tip = "Stealth through Bekar-zarakh directly to the boss and assassinate him."
        },
        {
            name = "Mission: The Accursed Flame",
            shortName = "The Accursed Flame",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "50.1S, 44.7W",
            location = "Herne (Tharbad)",
            isSpeedrun = true,
            writRating = "Situational (~1.5m)",
            estTime = "~1.5 min",
            objective = "Reach the cursed pyre in stealth, ignite bonfire without triggering boss.",
            tip = "Stealth to boss room without aggroing boss. Ignite bonfire from max range."
        },
        {
            name = "Mission: Caranost Command Post",
            shortName = "Caranost Command Post",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            writRating = "HIGH (~45 Writs/min)",
            estTime = "~2 min",
            objective = "Defeat 12 orcs and the war commander.",
            tip = "Very easy if foes have NO damage reflection. Kill 12 orcs rapidly and assassinate commander."
        },
        {
            name = "Mission: Crown of Caranost",
            shortName = "Crown of Caranost",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            writRating = "EXTREME (~60 Writs/min)",
            estTime = "~1.5 min",
            objective = "Reach the boss and defeat him.",
            tip = "Stealth directly to the main boss and assassinate him."
        },
        {
            name = "Mission: Down on the Farm",
            shortName = "Down on the Farm",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            writRating = "HIGH (~45 Writs/min)",
            estTime = "~1.5 min",
            objective = "Assassinate the farm boss before he escapes.",
            tip = "Cleanse Damage Reflect immediately if active! Burst boss down fast before he flees."
        },
        {
            name = "Mission: The Ruins of Amon Firn",
            shortName = "The Ruins of Amon Firn",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            writRating = "EXTREME (~60 Writs/min)",
            estTime = "~1.5 min",
            objective = "Assassinate the main boss in a safe spot.",
            tip = "Pull boss to safe spot, Riddle CC, go into stealth, purge corruptions, and assassinate!"
        },
        {
            name = "Mission: The Forgotten Cache",
            shortName = "The Forgotten Cache",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = true,
            writRating = "EXTREME (~60 Writs/min)",
            estTime = "~1.5-2 min",
            objective = "Rush into bandit cavern, open ancient chest, defeat chieftain.",
            tip = "BEST DELVING WRIT RUN. Hug right wall, skip trash, burn boss."
        },
        {
            name = "Mission: The Rescue of the Scribe",
            shortName = "The Rescue of the Scribe",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = true,
            writRating = "HIGH (~45 Writs/min)",
            estTime = "~2-2.5 min",
            objective = "Free captured scholar from cage, defeat jailor.",
            tip = "Clear jailor immediately, open cage. Very high writ output."
        },
        {
            name = "Mission: A Day in the City",
            shortName = "A Day in the City",
            hub = "clegur",
            hubName = "Swanfleet (Clegur)",
            npc = "Mission Giver",
            coords = "65.0S, 26.2W",
            location = "Clegur",
            isSpeedrun = true,
            writRating = "HIGH (~40 Writs/min)",
            estTime = "~2.5 min",
            objective = "Patrol ancient city ruins, defeat scout patrols and leader.",
            tip = "Open space. Group packs together for rapid AoE cleave."
        },
        {
            name = "Mission: Danger on the Southway",
            shortName = "Danger on the Southway",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = false,
            writRating = "MODERATE (~25 Writs/min)",
            estTime = "~3.5 min",
            objective = "Clear 3 highway ambushes and defeat highwayman boss.",
            tip = "Spread out along road. Mount up between packs if possible."
        },
        {
            name = "Mission: What Was Lost",
            shortName = "What Was Lost",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = false,
            writRating = "POOR (~18 Writs/min)",
            estTime = "~5 min",
            objective = "Collect 10 scattered relics across multi-level ruins.",
            tip = "Slow relic collection. Skip for speed farming if in a hurry."
        },
        {
            name = "Mission: Stirring of Spirits",
            shortName = "Stirring of Spirits",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            writRating = "Top Speed (~1.5m)",
            estTime = "~1.5 min",
            objective = "Infiltrate spirits cavern in stealth, defeat shadow boss.",
            tip = "Compact underground layout. Run directly to the boss chamber, eliminate boss, and loot the delving chest."
        },
        {
            name = "Mission: The Tearful Tomb",
            shortName = "The Tearful Tomb",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            writRating = "Top Speed (~1.5m)",
            estTime = "~1.5 min",
            objective = "Infiltrate tomb in stealth, defeat tomb guardian.",
            tip = "Compact tomb layout. Stealth straight to the inner sanctum, eliminate tomb guardian, and claim delve chest."
        }
    },
    [2] = {
        {
            name = "Mission: The Beast of Belfalas",
            shortName = "The Beast of Belfalas",
            hub = "bloody_eagle",
            hubName = "The Bloody Eagle",
            npc = "Mission Giver",
            coords = "21.4S, 97.4W",
            location = "The Bloody Eagle",
            isSpeedrun = true,
            writRating = "Fast (~2m)",
            estTime = "~2 min",
            objective = "Navigate through the shadows, defeat the beast boss, and open the delving chest.",
            tip = "Stealth or fight through shadows directly to the beast boss, defeat it, and claim the delving chest."
        },
        {
            name = "Mission: Siege-breaking",
            shortName = "Siege-breaking",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "50.1S, 44.7W",
            location = "Herne (Tharbad)",
            isSpeedrun = true,
            writRating = "Top Speed (~2m)",
            estTime = "~2 min",
            objective = "Infiltrate siege camp in stealth, burn all siege engines.",
            tip = "BURGLAR RUSH: Stealth through camp between patrollers, burn all siege weapons without pulling aggro, loot delve chest."
        },
        {
            name = "Mission: Stirring of Spirits",
            shortName = "Stirring of Spirits",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            writRating = "Top Speed (~1.5m)",
            estTime = "~1.5 min",
            objective = "Stealth through shadows to boss and defeat him.",
            tip = "BURGLAR RUSH: Stealth through shadows past roaming spirits directly to boss, assassinate, open delve chest."
        },
        {
            name = "Mission: The Tearful Tomb",
            shortName = "The Tearful Tomb",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            writRating = "Top Speed (~1.5m)",
            estTime = "~1.5 min",
            objective = "Infiltrate tomb in stealth, defeat tomb guardian.",
            tip = "BURGLAR RUSH: Stealth through tomb corridors directly to the inner chamber, assassinate boss, open delve chest."
        },
        {
            name = "Mission: The Matron of the Keep",
            shortName = "The Matron of the Keep",
            hub = "warroom",
            hubName = "Annak-Khurfu (War Room)",
            npc = "Horin",
            coords = "",
            location = "Annak-Khurfu (War Room)",
            isSpeedrun = true,
            writRating = "EXTREME (~60 Writs/min)",
            estTime = "~1.5 min",
            objective = "Stealth through the keep directly to the boss and defeat her.",
            tip = "BURGLAR RUSH: Stealth through the keep past all defenders directly to the boss, assassinate, open delve chest."
        },

        {
            name = "Mission: Reclaiming the Torrent-spires",
            shortName = "Reclaiming the Torrent-spires",
            hub = "warroom",
            hubName = "Annak-Khurfu (War Room)",
            days = "Tuesday",
            dayId = 2,
            npc = "Ausma",
            coords = "",
            location = "Annak-Khurfu (War Room)",
            isSpeedrun = false,
            highlightColor = "red",
            writRating = "Hard / Slow (~3.5m)",
            estTime = "~3.5 min",
            objective = "Plant reclaiming banners across the spires (Difficult mission).",
            tip = "RED BORDER ALERT: Difficult mission. Clear hostile mobs to safely interact and plant all required banners."
        },
        {
            name = "Mission: The Nettinglade",
            shortName = "The Nettinglade",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            writRating = "EXTREME (~55 Writs/min)",
            estTime = "~1.5-2 min",
            objective = "Free 8 elves from spider cocoons.",
            tip = "Stealth or fight through the spider glade, free 8 cocooned elves, and claim the delving chest."
        },
        {
            name = "Mission: The Vale of the Dead",
            shortName = "The Vale of the Dead",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = true,
            writRating = "HIGH (~45 Writs/min)",
            estTime = "~2 min",
            objective = "Defeat 8 wights and wight lord.",
            tip = "Use Westernesse damage or oils. Wights melt to Light/Fire."
        },
        {
            name = "Mission: The Defence of Caras Gelebren",
            shortName = "The Defence of Caras Gelebren",
            hub = "clegur",
            hubName = "Swanfleet (Clegur)",
            npc = "Mission Giver",
            coords = "65.0S, 26.2W",
            location = "Clegur",
            isSpeedrun = true,
            writRating = "HIGH (~40 Writs/min)",
            estTime = "~2.5 min",
            objective = "Defend gatehouse against 3 orc waves.",
            tip = "Camp the gate choke point. Drop ground AoE on spawn points."
        },
        {
            name = "Mission: The Ruins of Sirlond",
            shortName = "The Ruins of Sirlond",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = false,
            writRating = "MODERATE (~25 Writs/min)",
            estTime = "~3.5 min",
            objective = "Clear courtyard and defeat drakeling boss.",
            tip = "Drakes fly up and take time to land. Pull with ranged."
        },
        {
            name = "Mission: Patrol the South Downs",
            shortName = "Patrol the South Downs",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = false,
            writRating = "POOR (~20 Writs/min)",
            estTime = "~4.5 min",
            objective = "Patrol 5 beacon towers across open terrain.",
            tip = "Extensive travel distance between beacons."
        }
    },
    [3] = {
        {
            name = "Mission: The Beast of Belfalas",
            shortName = "The Beast of Belfalas",
            hub = "bloody_eagle",
            hubName = "The Bloody Eagle",
            npc = "Mission Giver",
            coords = "21.4S, 97.4W",
            location = "The Bloody Eagle",
            isSpeedrun = true,
            writRating = "Fast (~2m)",
            estTime = "~2 min",
            objective = "Navigate through the shadows, defeat the beast boss, and open the delving chest.",
            tip = "Stealth or fight through shadows directly to the beast boss, defeat it, and claim the delving chest."
        },
        {
            name = "Mission: Crown of Caranost",
            shortName = "Crown of Caranost",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            writRating = "Top Speed (~1.5m)",
            estTime = "~1.5 min",
            objective = "Reach the boss and defeat him.",
            tip = "BURGLAR RUSH: Stealth directly to the main boss and assassinate him."
        },
        {
            name = "Mission: Stirring of Spirits",
            shortName = "Stirring of Spirits",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            writRating = "Top Speed (~1.5m)",
            estTime = "~1.5 min",
            objective = "Infiltrate spirits cavern in stealth, defeat shadow boss.",
            tip = "Compact underground layout. Run directly to the boss chamber, eliminate boss, and loot the delving chest."
        },
        {
            name = "Mission: The Tearful Tomb",
            shortName = "The Tearful Tomb",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            writRating = "Top Speed (~1.5m)",
            estTime = "~1.5 min",
            objective = "Infiltrate tomb in stealth, defeat tomb guardian.",
            tip = "Compact tomb layout. Stealth straight to the inner sanctum, eliminate tomb guardian, and claim delve chest."
        },
        {
            name = "Mission: Down on the Farm",
            shortName = "Down on the Farm",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            highlightColor = "blue",
            writRating = "Burst Boss (~1.5m)",
            estTime = "~1.5 min",
            objective = "Assassinate the farm boss before he escapes.",
            tip = "BURGLAR TRICK (BLUE BORDER): Cleanse Damage Reflect immediately if active! Must burst boss down fast before he flees, or mission must be restarted."
        },
        {
            name = "Mission: The Ruins of Amon Firn",
            shortName = "The Ruins of Amon Firn",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            writRating = "Top Speed (~1.5m)",
            estTime = "~1.5 min",
            objective = "Assassinate the main boss in a safe spot.",
            tip = "BURGLAR TRICK: Slay main boss. Even with Reflect, pull to safe spot, Riddle CC, go into stealth, purge corruptions, and assassinate!"
        },
        {
            name = "Mission: The Accursed Flame",
            shortName = "The Accursed Flame",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "50.1S, 44.7W",
            location = "Herne (Tharbad)",
            isSpeedrun = true,
            writRating = "Situational (~1.5m)",
            estTime = "~1.5 min",
            objective = "Reach the cursed pyre in stealth, ignite bonfire without triggering boss.",
            tip = "BURGLAR TRICK: Stealth to boss room without aggroing boss. Ignite bonfire from max range. If detected or disrupted on 1st try, skip mission!"
        },
        {
            name = "Mission: Son of the Chieftain",
            shortName = "Son of the Chieftain",
            hub = "warroom",
            hubName = "Annak-Khurfu (War Room)",
            npc = "Horin",
            coords = "",
            location = "Annak-Khurfu (War Room)",
            isSpeedrun = true,
            writRating = "EXTREME (~60 Writs/min)",
            estTime = "~1.5 min",
            objective = "Stealth directly to the warg boss and defeat him.",
            tip = "Stealth directly to the warg boss, assassinate him, and claim the delving chest."
        },
        {
            name = "Mission: The Goblins for Gorgar",
            shortName = "The Goblins for Gorgar",
            hub = "warroom",
            hubName = "Annak-Khurfu (War Room)",
            npc = "Horin",
            coords = "",
            location = "Annak-Khurfu (War Room)",
            isSpeedrun = true,
            writRating = "EXTREME (~60 Writs/min)",
            estTime = "~1.5 min",
            objective = "Stealth to the boss and defeat goblin leader Gorgar.",
            tip = "Stealth through the goblin encampment directly to Gorgar, assassinate him, and claim the delving chest."
        },
        {
            name = "Mission: The Throne of Tharrazhar",
            shortName = "The Throne of Tharrazhar",
            hub = "warroom",
            hubName = "Annak-Khurfu (War Room)",
            npc = "Horin",
            coords = "",
            location = "Annak-Khurfu (War Room)",
            isSpeedrun = true,
            writRating = "EXTREME (~60 Writs/min)",
            estTime = "~1.5 min",
            objective = "Stealth to the throne room and defeat orc leader Graznul.",
            tip = "Stealth through Tharrazhar directly to the throne room, assassinate Graznul, and claim the delving chest."
        },
        {
            name = "Mission: Blockade at Glimmerdeep",
            shortName = "Blockade at Glimmerdeep",
            hub = "warroom",
            hubName = "Annak-Khurfu (War Room)",
            npc = "Ausma",
            coords = "",
            location = "Annak-Khurfu (War Room)",
            isSpeedrun = true,
            writRating = "EXTREME (~60 Writs/min)",
            estTime = "~1.5 min",
            objective = "Stealth past the blockade into Glimmerdeep and defeat troll leader Magathlug.",
            tip = "Stealth through the blockade barricades directly to the troll boss Magathlug, assassinate him, and claim the delving chest."
        },
        {
            name = "Mission: The Hand of Gorgar",
            shortName = "The Hand of Gorgar",
            hub = "warroom",
            hubName = "Annak-Khurfu (War Room)",
            npc = "Ausma",
            coords = "",
            location = "Annak-Khurfu (War Room)",
            isSpeedrun = true,
            writRating = "EXTREME (~60 Writs/min)",
            estTime = "~1.5 min",
            objective = "Stealth to the boss room and defeat orc leader Hand of Gorgar.",
            tip = "Stealth through the fortress directly to the Hand of Gorgar, assassinate him, and claim the delving chest."
        },
        {
            name = "Mission: Dangerous Pastures",
            shortName = "Dangerous Pastures",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = true,
            writRating = "EXTREME (~60 Writs/min)",
            estTime = "~1.5 min",
            objective = "Rescue 4 farm cows, slay alpha wolf.",
            tip = "Sprint between animal pens, mount pull to alpha wolf."
        },
        {
            name = "Mission: In the Shadow of Caranost",
            shortName = "In the Shadow of Caranost",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = true,
            writRating = "HIGH (~45 Writs/min)",
            estTime = "~2 min",
            objective = "Infiltrate lower bailey, kill 8 orcs, defeat captain.",
            tip = "Pull 2 packs together, AoE cleave, burn captain."
        },
        {
            name = "Mission: Safe Passage to Mossward",
            shortName = "Safe Passage to Mossward",
            hub = "clegur",
            hubName = "Swanfleet (Clegur)",
            npc = "Mission Giver",
            coords = "65.0S, 26.2W",
            location = "Clegur",
            isSpeedrun = true,
            writRating = "HIGH (~40 Writs/min)",
            estTime = "~2.5 min",
            objective = "Clear goblin barricades along the trade route.",
            tip = "Barricades break quickly with basic melee clicks."
        },
        {
            name = "Mission: Sifting the Rubble",
            shortName = "Sifting the Rubble",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = false,
            writRating = "MODERATE (~25 Writs/min)",
            estTime = "~3.5 min",
            objective = "Unearth 6 lost artifacts from stone mounds.",
            tip = "Digging inductions can be interrupted by roaming mobs."
        },
        {
            name = "Mission: The Gloom of Dol Ernil",
            shortName = "The Gloom of Dol Ernil",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = false,
            writRating = "POOR (~18 Writs/min)",
            estTime = "~5 min",
            objective = "Navigate winding catacombs to extinguish 6 ritual braziers.",
            tip = "Confusing maze layout with heavy dread penalty."
        }
    },
    [4] = {
        {
            name = "Mission: The Beast of Belfalas",
            shortName = "The Beast of Belfalas",
            hub = "bloody_eagle",
            hubName = "The Bloody Eagle",
            npc = "Mission Giver",
            coords = "21.4S, 97.4W",
            location = "The Bloody Eagle",
            isSpeedrun = true,
            writRating = "Fast (~2m)",
            estTime = "~2 min",
            objective = "Navigate through the shadows, defeat the beast boss, and open the delving chest.",
            tip = "Stealth or fight through shadows directly to the beast boss, defeat it, and claim the delving chest."
        },
        {
            name = "Mission: The Bridge to Caras Gelebren",
            shortName = "The Bridge to Caras Gelebren",
            hub = "clegur",
            hubName = "Swanfleet (Clegur)",
            npc = "Mission Giver",
            coords = "65.0S, 26.2W",
            location = "Clegur",
            isSpeedrun = true,
            writRating = "EXTREME (~60 Writs/min)",
            estTime = "~1.5 min",
            objective = "Charge down bridge, defeat commander at far archway.",
            tip = "Linear straight line. Run to end, gather all on boss, burst down."
        },
        {
            name = "Mission: Crown of Caranost",
            shortName = "Crown of Caranost",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = true,
            writRating = "EXTREME (~55 Writs/min)",
            estTime = "~1.5-2 min",
            objective = "Fight through inner citadel, defeat warlord on high platform.",
            tip = "Hug stairs, avoid side corridors, burst warlord on top."
        },
        {
            name = "Mission: Reclaiming the Vale-watch",
            shortName = "Reclaiming the Vale-watch",
            hub = "warroom",
            hubName = "Annak-Khurfu (War Room)",
            npc = "Horin",
            coords = "",
            location = "Annak-Khurfu (War Room)",
            isSpeedrun = true,
            writRating = "HIGH (~45 Writs/min)",
            estTime = "~2 min",
            objective = "Search and interact with earth mounds throughout the Vale-watch.",
            tip = "Stealth between earth mounds, interact with all mounds while avoiding mob detection, loot delve chest."
        },
        {
            name = "Mission: The Bloody Ritual",
            shortName = "The Bloody Ritual",
            hub = "warroom",
            hubName = "Annak-Khurfu (War Room)",
            npc = "Horin",
            coords = "",
            location = "Annak-Khurfu (War Room)",
            isSpeedrun = true,
            writRating = "EXTREME (~60 Writs/min)",
            estTime = "~1.5 min",
            objective = "Stealth to the ritual sites and destroy 2 blood obelisks.",
            tip = "Stealth through the ritual grounds directly to both obelisks, destroy them to disrupt the ritual, and claim the delving chest."
        },
        {
            name = "Mission: Two Heads are Deadlier",
            shortName = "Two Heads are Deadlier",
            hub = "warroom",
            hubName = "Annak-Khurfu (War Room)",
            npc = "Ausma",
            coords = "",
            location = "Annak-Khurfu (War Room)",
            isSpeedrun = true,
            writRating = "EXTREME (~60 Writs/min)",
            estTime = "~1.5 min",
            objective = "Stealth directly to the two-headed ettin boss and defeat him.",
            tip = "Stealth through the area straight to the two-headed boss, assassinate him, and claim the delving chest."
        },
        {
            name = "Mission: The Wolves of the Heath",
            shortName = "The Wolves of the Heath",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = true,
            writRating = "HIGH (~40 Writs/min)",
            estTime = "~2.5 min",
            objective = "Defeat 12 wolves and alpha pack leader.",
            tip = "Wolves are squishy and run into melee range immediately."
        },
        {
            name = "Mission: In the Web of the Spider",
            shortName = "In the Web of the Spider",
            hub = "clegur",
            hubName = "Swanfleet (Clegur)",
            npc = "Mission Giver",
            coords = "65.0S, 26.2W",
            location = "Clegur",
            isSpeedrun = false,
            writRating = "MODERATE (~25 Writs/min)",
            estTime = "~3.5 min",
            objective = "Free 5 cocooned scouts and defeat spider guardian.",
            tip = "Freeing scouts requires individual click inductions."
        },
        {
            name = "Mission: Secrets of the Hill-men",
            shortName = "Secrets of the Hill-men",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = false,
            writRating = "POOR (~18 Writs/min)",
            estTime = "~4.5 min",
            objective = "Search 4 Hill-men camps for stolen maps.",
            tip = "Hill-men use defensive stances that slow combat down."
        },
        {
            name = "Mission: The Nettinglade",
            shortName = "The Nettinglade",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            writRating = "EXTREME (~55 Writs/min)",
            estTime = "~1.5-2 min",
            objective = "Free 8 elves from spider cocoons.",
            tip = "Stealth or fight through the spider glade, free 8 cocooned elves, and claim the delving chest."
        },
        {
            name = "Mission: Siege-breaking",
            shortName = "Siege-breaking",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Hithriel",
            coords = "50.1S, 44.7W",
            location = "Herne (Crossway House)",
            isSpeedrun = true,
            writRating = "Top Speed (~2m)",
            estTime = "~2 min",
            objective = "Reach the siege engines, defeat 2 siege masters.",
            tip = "Stealth past trash mobs directly to the 2 siege masters, assassinate them."
        }
    },
    [5] = {
        {
            name = "Mission: The Beast of Belfalas",
            shortName = "The Beast of Belfalas",
            hub = "bloody_eagle",
            hubName = "The Bloody Eagle",
            npc = "Mission Giver",
            coords = "21.4S, 97.4W",
            location = "The Bloody Eagle",
            isSpeedrun = true,
            writRating = "Fast (~2m)",
            estTime = "~2 min",
            objective = "Navigate through the shadows, defeat the beast boss, and open the delving chest.",
            tip = "Stealth or fight through shadows directly to the beast boss, defeat it, and claim the delving chest."
        },
        {
            name = "Mission: The Vale-watch Rescue",
            shortName = "The Vale-watch Rescue",
            hub = "warroom",
            hubName = "Annak-Khurfu (War Room)",
            days = "Friday",
            dayId = 5,
            npc = "Horin",
            coords = "",
            location = "Annak-Khurfu (War Room)",
            isSpeedrun = true,
            writRating = "Rescue (~2m)",
            estTime = "~2 min",
            objective = "Free and rescue 4 captured dwarves.",
            tip = "Move through enemy groups, rescue all 4 captive dwarves, and claim the delving chest."
        },
        {
            name = "Mission: Raiders From Gundabad",
            shortName = "Raiders From Gundabad",
            hub = "warroom",
            hubName = "Annak-Khurfu (War Room)",
            days = "Friday",
            dayId = 5,
            npc = "Horin",
            coords = "",
            location = "Annak-Khurfu (War Room)",
            isSpeedrun = true,
            writRating = "Boss Only (~1.5m)",
            estTime = "~1.5-2 min",
            objective = "Reach bottom clearing, wait for boss Marshun without engaging arriving adds, and defeat him.",
            tip = "Go straight to the bottom of the clearing. Avoid fighting arriving mob waves! Wait for boss Marshun, defeat him, and claim the delving chest."
        },
        {
            name = "Mission: The Nettinglade",
            shortName = "The Nettinglade",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            writRating = "EXTREME (~55 Writs/min)",
            estTime = "~1.5-2 min",
            objective = "Free 8 elves from spider cocoons.",
            tip = "Stealth or fight through the spider glade, free 8 cocooned elves, and claim the delving chest."
        },
        {
            name = "Mission: Crown of Caranost",
            shortName = "Crown of Caranost",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            writRating = "Top Speed (~1.5m)",
            estTime = "~1.5 min",
            objective = "Reach the boss and defeat him.",
            tip = "BURGLAR RUSH: Stealth directly to the main boss and assassinate him."
        },
        {
            name = "Mission: Down on the Farm",
            shortName = "Down on the Farm",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            highlightColor = "blue",
            writRating = "Burst Boss (~1.5m)",
            estTime = "~1.5 min",
            objective = "Assassinate the farm boss before he escapes.",
            tip = "BURGLAR TRICK (BLUE BORDER): Cleanse Damage Reflect immediately if active! Must burst boss down fast before he flees, or mission must be restarted."
        },
        {
            name = "Mission: The Ruins of Amon Firn",
            shortName = "The Ruins of Amon Firn",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            writRating = "Top Speed (~1.5m)",
            estTime = "~1.5 min",
            objective = "Assassinate the main boss in a safe spot.",
            tip = "BURGLAR TRICK: Slay main boss. Even with Reflect, pull to safe spot, Riddle CC, go into stealth, purge corruptions, and assassinate!"
        },
        {
            name = "Mission: The Accursed Flame",
            shortName = "The Accursed Flame",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "50.1S, 44.7W",
            location = "Herne (Tharbad)",
            isSpeedrun = true,
            writRating = "Situational (~1.5m)",
            estTime = "~1.5 min",
            objective = "Reach the cursed pyre in stealth, ignite bonfire without triggering boss.",
            tip = "BURGLAR TRICK: Stealth to boss room without aggroing boss. Ignite bonfire from max range. If detected or disrupted on 1st try, skip mission!"
        },
        {
            name = "Mission: The Wights of the Barrow",
            shortName = "The Wights of the Barrow",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = true,
            writRating = "HIGH (~50 Writs/min)",
            estTime = "~2 min",
            objective = "Cleanse ancient burial mound, defeat barrow lord.",
            tip = "Compact underground layout. Boss stands right at entrance hall."
        },
        {
            name = "Mission: Clear the Greenway",
            shortName = "Clear the Greenway",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = true,
            writRating = "HIGH (~45 Writs/min)",
            estTime = "~2 min",
            objective = "Break 3 highway barricades and eliminate brigand gang.",
            tip = "Follow road north. Clear barricades sequentially."
        },
        {
            name = "Mission: The Marsh-trolls of Swanfleet",
            shortName = "The Marsh-trolls of Swanfleet",
            hub = "clegur",
            hubName = "Swanfleet (Clegur)",
            npc = "Mission Giver",
            coords = "65.0S, 26.2W",
            location = "Clegur",
            isSpeedrun = true,
            writRating = "HIGH (~40 Writs/min)",
            estTime = "~2.5 min",
            objective = "Defeat 4 marsh-trolls and troll elder.",
            tip = "Trolls have high morale but there are only 5 mobs total!"
        },
        {
            name = "Mission: The Bandit Stronghold",
            shortName = "The Bandit Stronghold",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = false,
            writRating = "MODERATE (~25 Writs/min)",
            estTime = "~3.5 min",
            objective = "Infiltrate palisade fort, burn 3 weapon racks, defeat boss.",
            tip = "Palisade gate guards use heavy stuns."
        },
        {
            name = "Mission: Tracking the Deserters",
            shortName = "Tracking the Deserters",
            hub = "clegur",
            hubName = "Swanfleet (Clegur)",
            npc = "Mission Giver",
            coords = "65.0S, 26.2W",
            location = "Clegur",
            isSpeedrun = false,
            writRating = "POOR (~18 Writs/min)",
            estTime = "~4.5 min",
            objective = "Track footprint trails across reeds to find deserter camp.",
            tip = "Tedious clue-clicking mechanic with long pathing."
        }
    },
    [6] = {
        {
            name = "Mission: The Beast of Belfalas",
            shortName = "The Beast of Belfalas",
            hub = "bloody_eagle",
            hubName = "The Bloody Eagle",
            npc = "Mission Giver",
            coords = "21.4S, 97.4W",
            location = "The Bloody Eagle",
            isSpeedrun = true,
            writRating = "Fast (~2m)",
            estTime = "~2 min",
            objective = "Navigate through the shadows, defeat the beast boss, and open the delving chest.",
            tip = "Stealth or fight through shadows directly to the beast boss, defeat it, and claim the delving chest."
        },
        {
            name = "Mission: Stirring of Spirits",
            shortName = "Stirring of Spirits",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            writRating = "EXTREME (~65 Writs/min)",
            estTime = "~1.5 min",
            objective = "Infiltrate spirits cavern in stealth, defeat shadow boss.",
            tip = "Compact underground layout. Run directly to the boss chamber, eliminate boss, and loot the delving chest."
        },
        {
            name = "Mission: The Tearful Tomb",
            shortName = "The Tearful Tomb",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            writRating = "EXTREME (~65 Writs/min)",
            estTime = "~1.5 min",
            objective = "Infiltrate tomb in stealth, defeat tomb guardian.",
            tip = "Compact tomb layout. Stealth straight to the inner sanctum, eliminate tomb guardian, and claim delve chest."
        },
        {
            name = "Mission: The Nettinglade",
            shortName = "The Nettinglade",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            writRating = "EXTREME (~55 Writs/min)",
            estTime = "~1.5-2 min",
            objective = "Free 8 elves from spider cocoons.",
            tip = "Stealth or fight through the spider glade, free 8 cocooned elves, and claim the delving chest."
        },
        {
            name = "Mission: Siege-breaking",
            shortName = "Siege-breaking",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Hithriel",
            coords = "50.1S, 44.7W",
            location = "Herne (Crossway House)",
            isSpeedrun = true,
            writRating = "Top Speed (~2m)",
            estTime = "~2 min",
            objective = "Reach the siege engines, defeat 2 siege masters.",
            tip = "Stealth past trash mobs directly to the 2 siege masters, assassinate them."
        },
        {
            name = "Mission: Ruins of Amon Fir",
            shortName = "Ruins of Amon Fir",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = true,
            writRating = "EXTREME (~60 Writs/min)",
            estTime = "~1.5 min",
            objective = "Sprint into tower courtyard, eliminate orc captain.",
            tip = "RUSH ROUTE: Mount/sprint to courtyard, boss spawns in 10s."
        },
        {
            name = "Mission: Crown of Caranost",
            shortName = "Crown of Caranost",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = true,
            writRating = "EXTREME (~55 Writs/min)",
            estTime = "~1.5-2 min",
            objective = "Climb Caranost ramparts, eliminate warlord.",
            tip = "Skip side wings, take center spiral ramp to top."
        },
        {
            name = "Mission: The Siege of Wadrom",
            shortName = "The Siege of Wadrom",
            hub = "clegur",
            hubName = "Swanfleet (Clegur)",
            npc = "Mission Giver",
            coords = "65.0S, 26.2W",
            location = "Clegur",
            isSpeedrun = true,
            writRating = "HIGH (~40 Writs/min)",
            estTime = "~2.5 min",
            objective = "Defend village square against 3 waves of marauders.",
            tip = "Stay centered in town square. Aggro mobs as they enter."
        },
        {
            name = "Mission: The Stolen Livestock",
            shortName = "The Stolen Livestock",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = false,
            writRating = "MODERATE (~25 Writs/min)",
            estTime = "~3.5 min",
            objective = "Guide 3 sheep back to stable while fighting off wolves.",
            tip = "Escort mechanics slow run speed considerably."
        },
        {
            name = "Mission: The Silent Halls",
            shortName = "The Silent Halls",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = false,
            writRating = "POOR (~18 Writs/min)",
            estTime = "~5 min",
            objective = "Collect 8 parchment fragments in dark underground halls.",
            tip = "Pitch black cavern with many dead ends."
        }
    },
    [7] = {
        {
            name = "Mission: The Beast of Belfalas",
            shortName = "The Beast of Belfalas",
            hub = "bloody_eagle",
            hubName = "The Bloody Eagle",
            npc = "Mission Giver",
            coords = "21.4S, 97.4W",
            location = "The Bloody Eagle",
            isSpeedrun = true,
            writRating = "Fast (~2m)",
            estTime = "~2 min",
            objective = "Navigate through the shadows, defeat the beast boss, and open the delving chest.",
            tip = "Stealth or fight through shadows directly to the beast boss, defeat it, and claim the delving chest."
        },
        {
            name = "Mission: The Deserter Camp",
            shortName = "The Deserter Camp",
            hub = "clegur",
            hubName = "Swanfleet (Clegur)",
            npc = "Mission Giver",
            coords = "65.0S, 26.2W",
            location = "Clegur",
            isSpeedrun = true,
            writRating = "HIGH (~45 Writs/min)",
            estTime = "~2 min",
            objective = "Assault camp, defeat 10 deserters and leader.",
            tip = "Mobs densely clustered. Massive AoE pull finishes in 90 seconds."
        },
        {
            name = "Mission: The Lost Messenger",
            shortName = "The Lost Messenger",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = true,
            writRating = "HIGH (~40 Writs/min)",
            estTime = "~2.5 min",
            objective = "Find fallen scout, recover pouch, defeat orc tracker.",
            tip = "Scout is located at first bend of valley."
        },
        {
            name = "Mission: The Haunting of Minhiriath",
            shortName = "The Haunting of Minhiriath",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = true,
            writRating = "HIGH (~40 Writs/min)",
            estTime = "~2.5 min",
            objective = "Cleanse 3 haunted altars and banish shade lord.",
            tip = "Altars cleanse on click; ignore surrounding trash."
        },
        {
            name = "Mission: The River Crossing",
            shortName = "The River Crossing",
            hub = "clegur",
            hubName = "Swanfleet (Clegur)",
            npc = "Mission Giver",
            coords = "65.0S, 26.2W",
            location = "Clegur",
            isSpeedrun = false,
            writRating = "MODERATE (~25 Writs/min)",
            estTime = "~3.5 min",
            objective = "Secure bridgeheads on both sides of river.",
            tip = "Swimming or fording river slows movement."
        },
        {
            name = "Mission: Shadows of the Past",
            shortName = "Shadows of the Past",
            hub = "cardolan",
            hubName = "Cardolan (Herne)",
            npc = "Mission Giver",
            coords = "51.9S, 45.0W",
            location = "Herne (Crossway House)",
            isSpeedrun = false,
            writRating = "POOR (~18 Writs/min)",
            estTime = "~4.5 min",
            objective = "Investigate 5 ancient markings across hills.",
            tip = "Large mountainous terrain with long climbing paths."
        },
        {
            name = "Mission: Crown of Caranost",
            shortName = "Crown of Caranost",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            writRating = "HIGH (~40 Writs/min)",
            estTime = "~2 min",
            objective = "Climb Caranost ramparts, eliminate warlord.",
            tip = "Skip side wings, take center spiral ramp to top."
        },
        {
            name = "Mission: Down on the Farm",
            shortName = "Down on the Farm",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            highlightColor = "blue",
            writRating = "Burst Boss (~1.5m)",
            estTime = "~1.5 min",
            objective = "Assassinate the farm boss before he escapes.",
            tip = "BURGLAR TRICK (BLUE BORDER): Cleanse Damage Reflect immediately if active! Must burst boss down fast before he flees, or mission must be restarted."
        },
        {
            name = "Mission: The Ruins of Amon Firn",
            shortName = "The Ruins of Amon Firn",
            hub = "cardolan",
            hubName = "Cardolan (Andrath)",
            npc = "Mission Giver",
            coords = "37.6S, 49.8W",
            location = "Andrath",
            isSpeedrun = true,
            writRating = "Top Speed (~1.5m)",
            estTime = "~1.5 min",
            objective = "Assassinate the main boss in a safe spot.",
            tip = "BURGLAR TRICK: Slay main boss. Even with Reflect, pull to safe spot, Riddle CC, go into stealth, purge corruptions, and assassinate!"
        }
    }
};

-- ----------------------------------------------------------------------------
-- Burglar Missions Filter / Retrieval
-- ----------------------------------------------------------------------------
local dayNames = {
    [1] = "Monday",
    [2] = "Tuesday",
    [3] = "Wednesday",
    [4] = "Thursday",
    [5] = "Friday",
    [6] = "Saturday",
    [7] = "Sunday",
};

function D.MatchesDay(m, targetDay)
    if not m then return false end
    if targetDay == 0 or targetDay == -1 or targetDay == "all" then
        return true;
    end
    if m.dayId == 0 then
        return true;
    end
    if m.dayId == targetDay then
        return true;
    end
    if m.dayIds then
        for _, d in ipairs(m.dayIds) do
            if d == targetDay then return true end
        end
    end
    if m.days and dayNames[targetDay] then
        if string.find(m.days, dayNames[targetDay], 1, true) then
            return true;
        end
    end
    return false;
end

function D.GetBurglarMissions(dayId, hubFilter, speedrunOnly, favorites)
    dayId = dayId or 4;
    hubFilter = hubFilter or "all";
    local result = {};
    local added = {};

    -- Helper to check if mission is favorited for its day
    local function CheckFav(mDay, mName)
        if not favorites then return false end
        local dKey = tostring(mDay or 0) .. ":" .. mName;
        if favorites[dKey] ~= nil then
            return (favorites[dKey] == true);
        end
        return (favorites[mName] == true);
    end

    local isAllDays = (dayId == 0 or dayId == -1 or dayId == "all");

    if not isAllDays then
        -- Single Day View (e.g. Wednesday, Thursday, etc.)
        -- Each unique mission shortName appears at most once on this day's tab
        for _, m in ipairs(D.BurglarMissions) do
            if D.MatchesDay(m, dayId) then
                local hubMatch = false;
                if hubFilter == "all" then
                    hubMatch = true;
                elseif hubFilter == "favorites" then
                    hubMatch = CheckFav(dayId, m.shortName);
                elseif hubFilter == "warroom" or hubFilter == "annak_khurfu" then
                    hubMatch = (m.hub == "warroom" or m.hub == "annak_khurfu");
                elseif hubFilter == "bloody_eagle" or hubFilter == "the_bloody_eagle" then
                    hubMatch = (m.hub == "bloody_eagle" or m.hub == "the_bloody_eagle");
                else
                    hubMatch = (m.hub == hubFilter);
                end

                local speedMatch = (not speedrunOnly) or m.isSpeedrun;
                local itemKey = m.shortName;

                if hubMatch and speedMatch and not added[itemKey] then
                    local entry = m;
                    if m.dayId ~= dayId then
                        entry = {};
                        for k, v in pairs(m) do entry[k] = v; end
                        entry.dayId = dayId;
                    end
                    table.insert(result, entry);
                    added[itemKey] = true;
                end
            end
        end

        -- Fallback check in DailyMissions for favorited missions if not already in result
        if hubFilter == "favorites" and favorites and D.DailyMissions and D.DailyMissions[dayId] then
            for _, m in ipairs(D.DailyMissions[dayId]) do
                local isFav = CheckFav(dayId, m.shortName);
                local itemKey = m.shortName;
                if isFav and not added[itemKey] then
                    local copy = {};
                    for k, v in pairs(m) do copy[k] = v; end
                    copy.dayId = dayId;
                    table.insert(result, copy);
                    added[itemKey] = true;
                end
            end
        end
    else
        -- All Days View (dayId == -1 or "all")
        -- Each day has its own separate card with dayId and badge!
        for d = 1, 7 do
            for _, m in ipairs(D.BurglarMissions) do
                if D.MatchesDay(m, d) then
                    local hubMatch = false;
                    if hubFilter == "all" then
                        hubMatch = true;
                    elseif hubFilter == "favorites" then
                        hubMatch = CheckFav(d, m.shortName);
                    elseif hubFilter == "warroom" or hubFilter == "annak_khurfu" then
                        hubMatch = (m.hub == "warroom" or m.hub == "annak_khurfu");
                    elseif hubFilter == "bloody_eagle" or hubFilter == "the_bloody_eagle" then
                        hubMatch = (m.hub == "bloody_eagle" or m.hub == "the_bloody_eagle");
                    else
                        hubMatch = (m.hub == hubFilter);
                    end

                    local speedMatch = (not speedrunOnly) or m.isSpeedrun;
                    local itemKey = tostring(d) .. ":" .. m.shortName;

                    if hubMatch and speedMatch and not added[itemKey] then
                        local entry = {};
                        for k, v in pairs(m) do entry[k] = v; end
                        entry.dayId = d;
                        table.insert(result, entry);
                        added[itemKey] = true;
                    end
                end
            end

            if hubFilter == "favorites" and favorites and D.DailyMissions and D.DailyMissions[d] then
                for _, m in ipairs(D.DailyMissions[d]) do
                    local isFav = CheckFav(d, m.shortName);
                    local itemKey = tostring(d) .. ":" .. m.shortName;
                    if isFav and not added[itemKey] then
                        local copy = {};
                        for k, v in pairs(m) do copy[k] = v; end
                        copy.dayId = d;
                        table.insert(result, copy);
                        added[itemKey] = true;
                    end
                end
            end
        end
    end

    return result;
end

-- ----------------------------------------------------------------------------
-- Comprehensive Mission Lookup Across All Days & Pools
-- ----------------------------------------------------------------------------
function D.FindMissionInDatabase(normTarget, normalizeFunc, activeDay)
    if not normTarget or normTarget == "" then return nil end
    local norm = normalizeFunc or function(s) return string.lower(s or "") end;

    local fallbackMission = nil;

    -- 1. Check BurglarMissions first
    if D.BurglarMissions then
        for _, m in ipairs(D.BurglarMissions) do
            if norm(m.shortName) == normTarget or norm(m.name) == normTarget then
                if activeDay and (D.MatchesDay(m, activeDay) or m.dayId == activeDay or m.dayId == 0) then
                    return m;
                end
                if not fallbackMission then
                    fallbackMission = m;
                end
            end
        end
    end

    -- 2. Check DailyMissions across all 7 days
    if D.DailyMissions then
        if activeDay and D.DailyMissions[activeDay] then
            for _, m in ipairs(D.DailyMissions[activeDay]) do
                if norm(m.shortName) == normTarget or norm(m.name) == normTarget then
                    return m;
                end
            end
        end
        for dayId = 1, 7 do
            if D.DailyMissions[dayId] then
                for _, m in ipairs(D.DailyMissions[dayId]) do
                    if norm(m.shortName) == normTarget or norm(m.name) == normTarget then
                        if not fallbackMission then
                            fallbackMission = m;
                        end
                    end
                end
            end
        end
    end

    return fallbackMission;
end

-- ----------------------------------------------------------------------------
-- Rotation Date Math & True Server Time (US Eastern)
-- ----------------------------------------------------------------------------
function D.CalculateDayOfWeek(year, month, day)
    local a = math.floor((14 - month) / 12);
    local y = year - a;
    local m = month + 12 * a - 2;
    local d = (day + y + math.floor(y / 4) - math.floor(y / 100) + math.floor(y / 400) + math.floor((31 * m) / 12)) % 7;
    if d == 0 then
        return 7;
    end
    return d;
end

function D.DaysInMonth(year, month)
    local days = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
    if month == 2 and ((year % 4 == 0 and year % 100 ~= 0) or (year % 400 == 0)) then
        return 29;
    end
    return days[month] or 30;
end

function D.IsUSDaylightSavingTime(year, month, day)
    if month < 3 or month > 11 then return false; end
    if month > 3 and month < 11 then return true; end

    if month == 3 then
        local dow1 = D.CalculateDayOfWeek(year, 3, 1);
        local firstSun = (dow1 == 7) and 1 or ((7 - dow1) + 1);
        local secondSun = firstSun + 7;
        return day >= secondSun;
    elseif month == 11 then
        local dow1 = D.CalculateDayOfWeek(year, 11, 1);
        local firstSun = (dow1 == 7) and 1 or ((7 - dow1) + 1);
        return day < firstSun;
    end
    return false;
end

function D.GetServerTimeTable(localTime, clientUtcOffset)
    clientUtcOffset = clientUtcOffset or 3; -- Default UTC+3 (MSK)
    local y = localTime.Year;
    local m = localTime.Month;
    local d = localTime.Day;
    local h = localTime.Hour;
    local min = localTime.Minute;
    local s = localTime.Second;

    local isDst = D.IsUSDaylightSavingTime(y, m, d);
    local serverUtcOffset = isDst and -4 or -5;
    local diffHours = serverUtcOffset - clientUtcOffset;

    h = h + diffHours;
    if h < 0 then
        h = h + 24;
        d = d - 1;
        if d < 1 then
            m = m - 1;
            if m < 1 then
                m = 12;
                y = y - 1;
            end
            d = D.DaysInMonth(y, m);
        end
    elseif h >= 24 then
        h = h - 24;
        d = d + 1;
        local dim = D.DaysInMonth(y, m);
        if d > dim then
            d = 1;
            m = m + 1;
            if m > 12 then
                m = 1;
                y = y + 1;
            end
        end
    end

    local localResetHour = (3 - diffHours) % 24;

    return {
        Year = y,
        Month = m,
        Day = d,
        Hour = h,
        Minute = min,
        Second = s,
        isDst = isDst,
        tzName = isDst and "EDT" or "EST",
        diffHours = diffHours,
        serverUtcOffset = serverUtcOffset,
        localResetHour = localResetHour,
        localTime = localTime
    };
end

function D.GetSecondsUntilWeeklyReset(serverTimeTable)
    local dow = D.CalculateDayOfWeek(serverTimeTable.Year, serverTimeTable.Month, serverTimeTable.Day);
    local h = serverTimeTable.Hour;
    local min = serverTimeTable.Minute;
    local s = serverTimeTable.Second;

    local daysUntilThu = 0;
    if dow < 4 then
        daysUntilThu = 4 - dow;
    elseif dow == 4 then
        if h < 3 then
            daysUntilThu = 0;
        else
            daysUntilThu = 7;
        end
    else
        daysUntilThu = (7 - dow) + 4;
    end

    local currentSec = h * 3600 + min * 60 + s;
    local resetSec = 3 * 3600;
    return (daysUntilThu * 86400) + (resetSec - currentSec);
end

function D.FormatWeeklyDuration(seconds)
    if not seconds or seconds < 0 then return "0h 00m"; end
    local days = math.floor(seconds / 86400);
    local rem = seconds % 86400;
    local h = math.floor(rem / 3600);
    local m = math.floor((rem % 3600) / 60);
    if days > 0 then
        return string.format("%dd %02dh %02dm", days, h, m);
    end
    return string.format("%02dh %02dm", h, m);
end

function D.GetLotroWeekKey(serverTimeTable)
    local y = serverTimeTable.Year;
    local m = serverTimeTable.Month;
    local d = serverTimeTable.Day;
    local h = serverTimeTable.Hour;

    if h < 3 then
        d = d - 1;
        if d < 1 then
            m = m - 1;
            if m < 1 then
                m = 12;
                y = y - 1;
            end
            d = D.DaysInMonth(y, m);
        end
    end

    local dow = D.CalculateDayOfWeek(y, m, d);
    local daysSinceThu = (dow >= 4) and (dow - 4) or (dow + 3);
    d = d - daysSinceThu;
    if d < 1 then
        m = m - 1;
        if m < 1 then
            m = 12;
            y = y - 1;
        end
        d = D.DaysInMonth(y, m) + d;
    end

    return string.format("%04d-%02d-%02d", y, m, d);
end

function D.DateToJulianDay(year, month, day)
    local a = math.floor((14 - month) / 12);
    local y = year + 4800 - a;
    local m = month + 12 * a - 3;
    return day + math.floor((153 * m + 2) / 5) + 365 * y + math.floor(y / 4) - math.floor(y / 100) + math.floor(y / 400) - 32045;
end

function D.GetActiveRotationDay(timeTable, resetHour)
    resetHour = resetHour or 3;
    local y = timeTable.Year;
    local m = timeTable.Month;
    local d = timeTable.Day;
    local h = timeTable.Hour;

    if h < resetHour then
        d = d - 1;
        if d < 1 then
            m = m - 1;
            if m < 1 then
                m = 12;
                y = y - 1;
            end
            local daysInMonth = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
            if (y % 4 == 0 and y % 100 ~= 0) or (y % 400 == 0) then
                daysInMonth[2] = 29;
            end
            d = daysInMonth[m];
        end
    end

    return D.CalculateDayOfWeek(y, m, d);
end

function D.GetMaliceVariant(timeTable, resetHour)
    resetHour = resetHour or 3;
    local y = timeTable.Year;
    local m = timeTable.Month;
    local d = timeTable.Day;
    local h = timeTable.Hour;

    if h < resetHour then
        d = d - 1;
    end
    local jd = D.DateToJulianDay(y, m, d);
    local variantId = (jd % 6) + 1;
    return D.MaliceVariants[variantId] or D.MaliceVariants[1];
end
