return {
ACCOMPLISHMENTS =
{
    UI =
    {
        TITLE = "Accomplishments",
        PLAYER_VIEW_TITLE = "{name}'s Accomplishments",
        ACHIEVEMENT_VIEW_TITLE = "View {name}'s Accomplishments",
        DESC = "A review of your achievements",
        UNLOCKED = "Accomplishment Unlocked!",
        TITLE_MISSING = "Missing Title",
        DESC_MISSING = "Missing Description.",
        TITLE_HIDDEN = "Concealed Accomplishment",
        DESC_HIDDEN = "This accomplishment is yet to be discovered.",
        FINISHED_TIME = "Day %s",
        FINISHED_TIME_UNKNOWN = "Day Unknown",
        FINISHED_IRL_TIME_FMT = "%X %x",  -- https://www.lua.org/pil/22.1.html
        FINISHED_IRL_TIME_UNKNOWN = "Date Unknown",
        ACHIEVEMENT_BUTTON = "View Accomplishments",
        FILTER_BUTTON_ALL = "Show All",
        SETTINGS_BUTTON = "Settings",
        PROGRESS_FMT = "{num}/{max}",
        ANNOUNCE_TROPHY_FMT = "{who} has accomplished: ",
        PANEL =
        {
            DELETE = "Delete your progress",
        },
        PANEL_SETTING =
        {
            SHOW_TIME = "Show Timestamps",
            SHOW_TIME_HOVER = "Show accomplished time",

            SHOW_COUNTER = "Show Progress",
            SHOW_COUNTER_HOVER = "Show accomplishment progress",

            ANNOUNEC_TROPHY = "Announce Trophy",
            ANNOUNEC_TROPHY_HOVER = "Receive accomplishment announcement",

            DELETE = "Reset Progress",
            DELETE_HOVER = "Reset accomplishment progress",
            DELETE_TITLE = "Reset?",
            DELETE_DESC = "Are you sure you want to reset your accomplishments data?\n(This action cannot be undone.)",

            LANG = "Choose Language",
            HOTKEY = "Bind Hotkey",
            HOTKEY_NONE = "Unbind",
        },
        CLUSTER_PANEL =
        {
            DELETE = "Delete",
            DELETE_TITLE = "Delete?",
            DELETE_DESC = "Are you sure you want to delete this data?\n(This will also notify the server to reset your data\nwhen you next time join the server.)",
            EMPTY = "You don't have any Accomplishments yet.",
        },
        SERVER_LIST =
        {
            SERVERNAME_MISSING = "Unknown Server",
            DESC_FMT = "Last updated: %X %x",  -- https://www.lua.org/pil/22.1.html
        },
        CATEGORY =
        {
            MASTERY = "Mastery",
            COMBAT = "Combat",
            HUNT = "Hunting",
            BOSS = "Giants",
            TIME = "Time",
            EXPLORATION = "Exploration",
            FARMING = "Farming",
            SOCIAL = "Social",
            CHARACTER = "Survivor",
            ACTIVITY = "Activity",
            MOD = "Others",
        },
        SORT =
        {
            DEFAULT = "Sort: Default",
            ALPHABETICALLY = "Sort: Alphabetically",
            UNLOCKED_LOCKED = "Sort: Unlocked/Locked",
            LOCKED_UNLOCKED = "Sort: Locked/Unlocked",
        },
    },
    MASTERY =
    {
        GENERIC_LABEL = "Accomplished",

        ALLTROPHY_TITLE = "Defier of Odds",
        ALLTROPHY_DESC = "Get all the Accomplishments. Congratulations!",

        ALLCOMBAT_TITLE = "Undefeated Warrior",
        ALLCOMBAT_DESC = "Get all the Accomplishments from Combat Category.",

        ALLHUNT_TITLE = "Professional Hunter",
        ALLHUNT_DESC = "Get all the Accomplishments from Hunting Category.",

        ALLBOSS_TITLE = "Slayer of Worlds",
        ALLBOSS_DESC = "Get all the Accomplishments from Giants Category.",

        ALLTIME_TITLE = "Time Is a Prison",
        ALLTIME_DESC = "Get all the Accomplishments from Time Category.",

        ALLEXPLORATION_TITLE = "True Explorer",
        ALLEXPLORATION_DESC = "Get all the Accomplishments from Exploration Category.",

        ALLFARMING_TITLE = "Sit and Relax",
        ALLFARMING_DESC = "Get all the Accomplishments from Farming Category.",

        ALLSOCIAL_TITLE = "Social Celebrity",
        ALLSOCIAL_DESC = "Get all the Accomplishments from Social Category.",

        ALLCHARACTER_TITLE = "Jack of All Trades",
        ALLCHARACTER_DESC = "Get all the Accomplishments from Survivor Category.",

        ALLACTIVITY_TITLE = "Master of Activities",
        ALLACTIVITY_DESC = "Get all the Accomplishments from Activity Category.",
    },
    COMBAT =
    {
        GENERIC_LABEL = "Defeated",

        HOUND_TITLE = "The Houndmaster",
        HOUND_DESC = "Defeat a total of 100 Hounds.",

        WORM_TITLE = "Worms Armageddon",
        WORM_DESC = "Defeat a total of 100 Depths Worms.",

        PIGMAN_TITLE = "Slaughterhouse",
        PIGMAN_DESC = "Defeat a total of 40 Pig Men.",

        BUNNYMAN_TITLE = "Hop! Hop! Hop!",
        BUNNYMAN_DESC = "Defeat a total of 40 Bunnymen.",

        KRAMPUS_TITLE = "Naughty And Nice",
        KRAMPUS_DESC = "Defeat a total of 10 Krampii.",

        ROCKY_TITLE = "It's Not A Rock!",
        ROCKY_DESC = "Defeat a total of 5 Rock Lobsters.",

        GHOST_TITLE = "Phasmophobia",
        GHOST_DESC = "Defeat a Ghost during a Full Moon night.",

        SHARK_TITLE = "Maneater",
        SHARK_DESC = "Defeat a Rockjaw in the middle of the ocean.",

        WALRUSDART_TITLE = "Back To You, Friend",
        WALRUSDART_DESC = "Defeat a Mac Tusk with a Blow Dart.",
    },
    HUNT =
    {
        GENERIC_LABEL = "Hunted",

        GENERIC_TITLE = "Hunter",
        GENERIC_DESC = "Hunt down a total of 10 Beasts.",

        GREATHUNTER_TITLE = "The Pridestalker",
        GREATHUNTER_DESC = "Hunt down a total of 20 Beasts.",

        KOALEFANTSUMMER_TITLE = "Summertime Hunting",
        KOALEFANTSUMMER_DESC = "Hunt down a Koalefant.",

        KOALEFANTWINTER_TITLE = "It's Cold Outside",
        KOALEFANTWINTER_DESC = "Hunt down a Winter Koalefant.",

        WARG_TITLE = "Big Puppy",
        WARG_DESC = "Hunt down a Varg.",

        SPAT_TITLE = "Tempering Steel",
        SPAT_DESC = "Hunt down an Ewecus.",

        LIGHTNINGGOAT_TITLE = "Lightning Bluff",
        LIGHTNINGGOAT_DESC = "Hunt down a Volt Goat.",

        PHLEGM_TITLE = "Sticky Situation",
        PHLEGM_DESC = "Free yourself from Ewecus mucus with someone's assistance.",

        ALLHUNT_TITLE = "The Hunt Is On!",
        ALLHUNT_DESC = "Hunt down every Beast.",
        ALLHUNT_LABEL = "Hunted",
    },
    BOSS =
    {
        GENERIC_LABEL = "Defeated",

        DEERCLOPS_TITLE = "Death Perception",
        DEERCLOPS_DESC = "Defeat a Deerclops.",

        MOOSE_TITLE = "Gone South",
        MOOSE_DESC = "Defeat a Moose. Or a Goose. Or both?",

        DRAGONFLY_TITLE = "No Fly Zone",
        DRAGONFLY_DESC = "Defeat a Dragonfly.",

        RAGEDRAGONFLY_TITLE = "Fire Force",
        RAGEDRAGONFLY_DESC = "Defeat a Dragonfly while its enraged.",

        MALBATROSS_TITLE = "Waterfowl Hunting",
        MALBATROSS_DESC = "Defeat a Malbatross.",

        KLAUS_TITLE = "Merry Doom!",
        KLAUS_DESC = "Defeat a Klaus.",

        RAGEKLAUS_TITLE = "Gifted to Death",
        RAGEKLAUS_DESC = "Defeat an Enraged Klaus.",

        SHADOWCHESS_TITLE = "Checkmate!",
        SHADOWCHESS_DESC = "Defeat the Shadow Pieces.",

        MINOTAUR_TITLE = "Ancient History",
        MINOTAUR_DESC = "Defeat the Ancient Guardian.",

        BEARGER_TITLE = "BEARserker!",
        BEARGER_DESC = "Defeat a Bearger.",

        BEEQUEEN_TITLE = "Where's My Honey?",
        BEEQUEEN_DESC = "Defeat a Bee Queen.",

        ANTLION_TITLE = "Ant Fodder",
        ANTLION_DESC = "Defeat the Antlion.",

        TOADSTOOL_TITLE = "Froggers!",
        TOADSTOOL_DESC = "Defeat a Toadstool.",

        MTOADSTOOL_TITLE = "Toxicity",
        MTOADSTOOL_DESC = "Defeat a Misery Toadstool.",
        -- I personally thought this was a good idea, no fun.
        -- TOADSTOOLAXE_TITLE = "Why We Still Here? Just To Suffer?",
        -- TOADSTOOLAXE_DESC = "Defeat a Toadstool with axes.",

        STALKERCAVE_TITLE = "It's Not A Fossil!",
        STALKERCAVE_DESC = "Defeat a Reanimated Skeleton.",

        STALKERATRIUM_TITLE = "Shadow Redeemer",
        STALKERATRIUM_DESC = "Defeat the Ancient Fuelweaver.",

        CRABKING_TITLE = "Krusty Krab",
        CRABKING_DESC = "Defeat the Crab King.",

        SPIDERQUEEN_TITLE = "Insecticide Regicide",
        SPIDERQUEEN_DESC = "Defeat a Spider Queen.",

        LEIF_TITLE = "Alive Forest",
        LEIF_DESC = "Defeat a Treeguard.",

        EYEOFTERROR_TITLE = "Eye On You",
        EYEOFTERROR_DESC = "Defeat the Eye of Terror.",

        TWINSOFTERROR_TITLE = "Ophthalmologist",
        TWINSOFTERROR_DESC = "Defeat the Twins of Terror.",

        ALTERGUARDIAN_TITLE = "Celestial Onslaught",
        ALTERGUARDIAN_DESC = "Defeat the Celestial Champion.",

        LORDFRUITFLY_TITLE = "Bugbusters",
        LORDFRUITFLY_DESC = "Defeat the Lord of the Fruit Flies.",

        DEERCLOPSYULE_TITLE = "I See Red",
        DEERCLOPSYULE_DESC = "Defeat a Deerclops during the Winter's Feast event.",

        ALLBOSSES_TITLE = "Conqueror of The Constant",
        ALLBOSSES_DESC = "Defeat all Giants.",
    },
    TIME =
    {
        GENERIC_LABEL = "Day",
        GENERIC_LABEL_PLURAL = "Days",

        FIRSTNIGHT_TITLE = "The Beginning",
        FIRSTNIGHT_DESC = "Survive your first night.",

        TWENTY_TITLE = "Not Dead Yet",
        TWENTY_DESC = "Survive 20 consecutive days.",

        THIRTYFIVE_TITLE = "Stayin' Alive",
        THIRTYFIVE_DESC = "Survive 35 consecutive days.",

        FIFTYFIVE_TITLE = "I Will Survive",
        FIFTYFIVE_DESC = "Survive 55 consecutive days.",

        ONEHUNDRED_TITLE = "I'm A Survivor",
        ONEHUNDRED_DESC = "Survive 100 consecutive days.",

        FIVEHUNDRED_TITLE = "Enthusiast",
        FIVEHUNDRED_DESC = "Survive 500 consecutive days.",

        ONETHOUSAND_TITLE = "Legend",
        ONETHOUSAND_DESC = "Survive 1000 consecutive days.",

        POWCAKE_TITLE = "* Elevator Music *",
        POWCAKE_DESC = "Spoil a Powdercake, with or without assistance.",
        POWCAKE_LABEL = "Spoiled",
    },
    EXPLORATION =
    {
        CAVESBIOME_TITLE = "To the Mines!",
        CAVESBIOME_DESC = "Go to the Caves for the first time.",

        RUINSBIOME_TITLE = "Ruins Raider",
        RUINSBIOME_DESC = "Breach the Ruins for the first time.",

        ARCHIVESBIOME_TITLE = "Forbidden Knowledge",
        ARCHIVESBIOME_DESC = "Breach the Archives for the first time.",

        DECIDUOUSBIOME_TITLE = "Birchnutter",
        DECIDUOUSBIOME_DESC = "Discover the Deciduous Forest for the first time.",

        MOSAICBIOME_TITLE = "Rocks n' Rolls",
        MOSAICBIOME_DESC = "Discover the Mosaic for the first time.",

        SWAMPBIOME_TITLE = "Tentacles and Mosquitos!",
        SWAMPBIOME_DESC = "Discover the Swamp for the first time.",

        MUSHROOMBIOME_TITLE = "Mushroom Kingdom",
        MUSHROOMBIOME_DESC = "Discover a Mushroom Forest for the first time.",

        MOONMUSHBIOME_TITLE = "Moonshine Mushrooms",
        MOONMUSHBIOME_DESC = "Discover the Lunar Grotto for the first time.",

        ALLMUSHBIOME_TITLE = "Mushy Explorer",
        ALLMUSHBIOME_DESC = "Discover the three Mushroom Forests.",
        ALLMUSHBIOME_LABEL = "Discovered",

        LUNARBIOME_TITLE = "Fly Me To The Moon",
        LUNARBIOME_DESC = "Discover the Lunar Island for the first time.",

        HERMITBIOME_TITLE = "A Lonely Crab",
        HERMITBIOME_DESC = "Discover the Hermit's Island for the first time.",

        OASISBIOME_TITLE = "Wonderwall",
        OASISBIOME_DESC = "Find a mysterious lake in the middle of a desert.",

        MONKEYBIOME_TITLE = "Monkey Paradise",
        MONKEYBIOME_DESC = "Breach the Moon Quay Island for the first time.",

        WATERLOGBIOME_TITLE = "Drifting Woods",
        WATERLOGBIOME_DESC = "Find a drifting forest in the middle of the ocean.",

        ATRIUMBIOME_TITLE = "What Lies Beyond?",
        ATRIUMBIOME_DESC = "Breach the Atrium for the first time.",
    },
    FARMING =
    {
        SOWALL_TITLE = "Sowing Machine",
        SOWALL_DESC = "Sow every type of seed.",
        SOWALL_LABEL = "Planted",

        FERTILIZERALL_TITLE = "That Smells For Sure!",
        FERTILIZERALL_DESC = "Use every type of fertilizer.",
        FERTILIZERALL_LABEL = "Used",

        GROWCROP_TITLE = "Plant Caretaker",
        GROWCROP_DESC = "Grow up a Crop.",

        GROWGIANTCROP_TITLE = "Reap What You Sow",
        GROWGIANTCROP_DESC = "Grow up a Giant Crop.",

        KILLWEED_TITLE = "Evil Garden",
        KILLWEED_DESC = "Witness the strength of a Weed.",

        TILLING_TITLE = "It Ain't Much, But...",
        TILLING_DESC = "Till a total of 200 times.",
        TILLING_LABEL = "Time",
        TILLING_LABEL_PLURAL = "Times",

        TILLING2_TITLE = "It's Honest Work",
        TILLING2_DESC = "Till a total of 400 times.",

        ROTCROP_TITLE = "I Hate Plants",
        ROTCROP_DESC = "Smash down 10 Rotten Giant Crops.",
    },
    SOCIAL =
    {
        FIRSTDEATH_TITLE = "Welcome!",
        FIRSTDEATH_DESC = "Die for the first time.",

        TENDEATH_TITLE = "Again?!?!",
        TENDEATH_DESC = "Die for the 10th time.",

        SIXPLAYERS_TITLE = "We Play Together, We Die Together!",
        SIXPLAYERS_DESC = "Play in a world with 6 simultaneous Players.",

        SAMECHARACTER_TITLE = "Three's Company",
        SAMECHARACTER_DESC = "Have at least 3 of the same survivor in the world.",

        SOAKPLAYER_TITLE = "Summer Vacation",
        SOAKPLAYER_DESC = "Soak a Player a total of 10 times using Water Balloons.",

        GIVEPLAYER_TITLE = "It's Dangerous To Go Alone!",
        GIVEPLAYER_DESC = "Give resources to a new Player after establishing yourself.",

        BOSSFRIEND_TITLE = "Teamwork Is Dreamwork",
        BOSSFRIEND_DESC = "Defeat a Boss with another Player.",

        REVIVEPLAYER_TITLE = "A Giving Heart",
        REVIVEPLAYER_DESC = "Bring a Player back from the dead.",

        EQUIPALL_TITLE = "Matching Attire",
        EQUIPALL_DESC = "Equip an Armor, a Hat and a Hand item, at the same time.",

        KILLPLAYER_TITLE = "You're So Mean!",
        KILLPLAYER_DESC = "Defeat another Player.",

        SLEEPPLAYER_TITLE = "Soniferous",
        SLEEPPLAYER_DESC = "Cause a Player to sleep with a Mandrake.",

        DOEMOTE_TITLE = "Express Yourself",
        DOEMOTE_DESC = "Show everyone your true feelings with an emote.",

        LITFLARE_TITLE = "Lights On The Sky",
        LITFLARE_DESC = "Show everyone your current location with a Flare.",

        HOLDCOMPASS_TITLE = "Intrepid Explorers",
        HOLDCOMPASS_DESC = "Share your current location with someone using a Compass.",
    },
    CHARACTER =
    {
        WILSON1_TITLE = "The Beard Monster",
        WILSON1_DESC = "As Wilson, don't shave your beard during 20 days.",
        WILSON2_TITLE = "Beardless",
        WILSON2_DESC = "As Wilson, survive the Winter without your beard.",

        WILLOW1_TITLE = "Inflammable",
        WILLOW1_DESC = "As Willow, cook a total of 40 items with Willow's Lighter.",
        WILLOW1_LABEL = "Cooked",
        WILLOW2_TITLE = "This Is Fine",
        WILLOW2_DESC = "As Willow, get caught on fire for 1 minute.",

        WOLFGANG1_TITLE = "I am Mighty!",
        WOLFGANG1_DESC = "As Wolfgang, reach maximum Mightness while in the Mighty Gym.",
        WOLFGANG2_TITLE = "Empty Stomach",
        WOLFGANG2_DESC = "As Wolfgang, defeat a total of 40 mobs while on Wimpy Form.",
        WOLFGANG2_LABEL = "Defeated",

        WENDY1_TITLE = "Casper Meets Wendy",
        WENDY1_DESC = "As Wendy, assist a total of 20 Pipspooks.",
        WENDY1_LABEL = "Assisted",
        WENDY2_TITLE = "Battle Sisters",
        WENDY2_DESC = "As Wendy, defeat a total of 40 mobs with Abigail's assistance.",
        WENDY2_LABEL = "Defeated",

        WX781_TITLE = "FIRE UP AND READY TO SERVE",
        WX781_DESC = "As WX-78, scan every creature possible with the Bio Scanalyzer.",
        WX781_LABEL = "Scanned",
        WX782_TITLE = "IT'S ALIVE!!!",
        WX782_DESC = "As WX-78, repair a Broken Clockwork.",

        WICKERBOTTOM1_TITLE = "Bookworm",
        WICKERBOTTOM1_DESC = "As Wickerbottom, read Books a total of 40 times.",
        WICKERBOTTOM1_LABEL = "Read",
        WICKERBOTTOM2_TITLE = "Knowledge Is Power!",
        WICKERBOTTOM2_DESC = "As Wickerbottom, learn every Book possible.",
        WICKERBOTTOM2_LABEL = "Learned",

        -- I'll miss this one so much...
        -- WICKERBOTTOM2_TITLE = "It's Bedtime",
        -- WICKERBOTTOM2_DESC = "As Wickerbottom, fall asleep.",

        WOODIE1_TITLE = "Tree Hugger",
        WOODIE1_DESC = "As Woodie, chop down a total of 500 trees with the Werebeaver.",
        WOODIE1_LABEL = "Chopped",
        WOODIE2_TITLE = "Round 1, Fight!",
        WOODIE2_DESC = "As Woodie, defeat a total of 40 mobs with the Weremoose.",
        WOODIE2_LABEL = "Defeated",

        WAXWELL1_TITLE = "The Puppetmaster",
        WAXWELL1_DESC = "As Maxwell, defeat a total of 40 mobs with the Shadow Duelists.",
        WAXWELL1_LABEL = "Defeated",
        WAXWELL2_TITLE = "Total Shadow Mayhem",
        WAXWELL2_DESC = "As Maxwell, stay Insane for 3 minutes.",

        WES1_TITLE = "Balloonmized!",
        WES1_DESC = "As Wes, die by a Balloon.",
        WES2_TITLE = "Quakin' in My Boots",
        WES2_DESC = "As Wes, die during an Earthquake.",

        WATHGRITHR1_TITLE = "Valhalla Combatant",
        WATHGRITHR1_DESC = "As Wigfrid, defeat a total of 20 Giants.",
        WATHGRITHR1_LABEL = "Defeated",
        WATHGRITHR2_TITLE = "Brunhild's Battlecry",
        WATHGRITHR2_DESC = "As Wigfrid, use at least 3 different songs during a battle.",

        WEBBER1_TITLE = "Deadly Family",
        WEBBER1_DESC = "As Webber, defeat a Spider Queen with Spiders.",
        WEBBER2_TITLE = "Fuzzy Friends",
        WEBBER2_DESC = "As Webber, befriend every type of Spider.",
        WEBBER2_LABEL = "Befriended",

        WINONA1_TITLE = "FLEX TAPE!",
        WINONA1_DESC = "As Winona, use the Trusty Tape to patch up a total of 40 items.",
        WINONA2_TITLE = "I Know Your Moves!",
        WINONA2_DESC = "As Winona, avoid 5 hits from Charlie.",

        WORTOX1_TITLE = "Dodge This!",
        WORTOX1_DESC = "As Wortox, avoid getting hit using your teleportation skills.",
        WORTOX2_TITLE = "Medic!",
        WORTOX2_DESC = "As Wortox, heal a total of 1000 Health Points of a Player.",

        WORMWOOD1_TITLE = "Soothing Aura",
        WORMWOOD1_DESC = "As Wormwood, tend a total of 100 Crops while Blooming.",
        WORMWOOD2_TITLE = "Spring Is Now",
        WORMWOOD2_DESC = "As Wormwood, bloom out of Spring season.",

        WARLY1_TITLE = "Delightful Taste",
        WARLY1_DESC = "As Warly, eat every dish available in the menu.",
        WARLY1_LABEL = "Eaten",
        WARLY2_TITLE = "Chef's Hour",
        WARLY2_DESC = "As Warly, cook every of the exclusive dishes.",
        WARLY2_LABEL = "Cooked",

        WURT1_TITLE = "Once Upon a Time...",
        WURT1_DESC = "As Wurt, read every fairy story book possible.",
        WURT1_LABEL = "Read",
        WURT2_TITLE = "King Mermthur?",
        WURT2_DESC = "As Wurt, witness a Merm's coronation to King of the Merms.",

        WALTER1_TITLE = "Head Shot!",
        WALTER1_DESC = "As Walter, defeat a total of 40 Mobs with the Trusty Slinghshot.",
        WALTER2_TITLE = "Best Friends Forever",
        WALTER2_DESC = "As Walter, carry something with Woby's assistance.",

        WANDA1_TITLE = "Twisted Tempo",
        WANDA1_DESC = "As Wanda, avoid a fatal hit with the Ageless Watch.",
        WANDA2_TITLE = "Timewinder",
        WANDA2_DESC = "As Wanda, defeat a total of 40 mobs while elderly, with the Alarming Clock.",

        WONKEY1_TITLE = "Nanas! Nanas!",
        WONKEY1_DESC = "As Wonkey, eat a total of 40 Bananas.",
        WONKEY2_TITLE = "Jack's Run",
        WONKEY2_DESC = "As Wonkey, run for 1 minute wearing a Pirate's Bandana and a Cutless.",
    },
    ACTIVITY =
    {
        HERMITQUEST_TITLE = "Supreme Helper Minion!",
        HERMITQUEST_DESC = "Complete every task from Crabby Hermit.",

        COOKBOOK_TITLE = "Hell's Kitchen",
        COOKBOOK_DESC = "Cook every dish possible.",
        COOKBOOK_LABEL = "Cooked",

        FAILEDDISH_TITLE = "Bad Cooker Day",
        FAILEDDISH_DESC = "Fail a total of 10 times when trying to cook something.",

        CATCHFISH_TITLE = "Masterfisher",
        CATCHFISH_DESC = "Catch every fish possible.",
        CATCHFISH_LABEL = "Caught",

        FASTFISH_TITLE = "Fast and Fishious",
        FASTFISH_DESC = "Catch an ocean fish under 30 seconds.",
        FASTFISH_LABEL = "Second",
        FASTFISH_LABEL_PLURAL = "Seconds",

        ALLWEAPON_TITLE = "Warmaster",
        ALLWEAPON_DESC = "Equip every weapon possible.",
        ALLWEAPON_LABEL = "Equipped",

        PIGKINGMG_TITLE = "Unpig Challenger",
        PIGKINGMG_DESC = "Win Pig King's minigame.",

        CRITTER_TITLE = "A Loyal Companion",
        CRITTER_DESC = "Adopt for yourself a fuzzy and cute, little critter.",

        BEECROWN_TITLE = "My Liege!",
        BEECROWN_DESC = "Wear a Bee Queen Crown and have someone to bow to you.",

        BONEHELM_TITLE = "Insanity!",
        BONEHELM_DESC = "Wear a Bone Helm.",

        EYEBRELLA_TITLE = "Eye To The Sky!",
        EYEBRELLA_DESC = "Wear an Eyebrella.",

        RUINSHAT_TITLE = "I am Royalty",
        RUINSHAT_DESC = "Wear a Thulecite Suit and a Thulecite Crown at the same time.",

        FOODKILL_TITLE = "Junk Food",
        FOODKILL_DESC = "Kill yourself by eating food.",

        STARVATION_TITLE = "Don't Starve",
        STARVATION_DESC = "Die by starvation.",

        WINTERHEAT_TITLE = "Too Warm!",
        WINTERHEAT_DESC = "Die by heat during the Winter.",

        SUMMERFREEZE_TITLE = "Cool It!",
        SUMMERFREEZE_DESC = "Die by freezing during the Summer.",

        GRIMGALETTE_TITLE = "The Undertaker",
        GRIMGALETTE_DESC = "Die by eating a Grim Galette.",

        ORANGESTAFF_TITLE = "And... Poof!",
        ORANGESTAFF_DESC = "Telepoof yourself with The Lazy Explorer.",

        GREENAMULET_TITLE = "50% OFF!",
        GREENAMULET_DESC = "Craft something with the Construction Amulet.",

        ALCHEMY_TITLE = "Master of Science",
        ALCHEMY_DESC = "Build an Alchemy Engine.",

        PRESTIHATI_TITLE = "Hat Trick",
        PRESTIHATI_DESC = "Build a Prestihatitator.",

        SMANIPULATOR_TITLE = "Master of Shadows",
        SMANIPULATOR_DESC = "Build a Shadow Manipulator.",

        PIGKING_TITLE = "Golden Shower",
        PIGKING_DESC = "Strike a deal with Pig King.",

        PLANTFLOWER_TITLE = "What a Lovely Day",
        PLANTFLOWER_DESC = "Grow a pretty Flower. Aww.",

        PIGFOLLOWER_TITLE = "Pig Pen",
        PIGFOLLOWER_DESC = "Have 6 simultaneous Pig Man followers. What a party!",

        BUNNYFOLLOWER_TITLE = "Fluffy Followers",
        BUNNYFOLLOWER_DESC = "Have 6 simultaneous Bunnyman followers. Chaotic!",

        LOBSTERFOLLOWER_TITLE = "Tough Crowd",
        LOBSTERFOLLOWER_DESC = "Have 4 simultaneos Rock Lobster followers. Snappy!",

        SMALLBIRD_TITLE = "Not Your Momma",
        SMALLBIRD_DESC = "Witness the miracle of Tallbird motherhood.",

        ARCHIVESPOWER_TITLE = "Turn On The Lights!",
        ARCHIVESPOWER_DESC = "Turn on the Archives power.",

        SOOTHTREE_TITLE = "Tree Whisperer",
        SOOTHTREE_DESC = "Sooth an enraged Treeguard.",

        BIGTENTACLE_TITLE = "Tentacle Express",
        BIGTENTACLE_DESC = "Travel in the exact opposite of style.",

        WORMHOLE_TITLE = "Worming My Way In",
        WORMHOLE_DESC = "Jump down a gross hole.",

        TURTLE_TITLE = "Turtle Turtling!",
        TURTLE_DESC = "Wear a Snurtle Shell Armor and a Shelmet at the same time.",

        DBEEFALO_TITLE = "Beast of the Bottomless Stomach",
        DBEEFALO_DESC = "Domesticate a wild Beefalo.",

        PANDORASCHEST_TITLE = "Big Bounty!",
        PANDORASCHEST_DESC = "Open one of the Chests found in the Ruins Maze.",

        POTATOCUP_TITLE = "There Are Some Who Call Him...",
        POTATOCUP_DESC = "Obtain the legendary Potato Cup.",

        EYETURRET_TITLE = "Impenetrable Defense",
        EYETURRET_DESC = "Build a Houndius Shootius.",

        ONEHP_TITLE = "Not Even Close, Baby!",
        ONEHP_DESC = "Survive an attack with 1 Heath points.",

        BEEBOX_TITLE = "Busy Bee",
        BEEBOX_DESC = "Harvest some sweet, sweet honey from an overflowing beebox.",

        OPALSTAFF_TITLE = "Corrupted by The Moon",
        OPALSTAFF_DESC = "Witness the power of The Moon descend into a staff.",

        CHESTER_TITLE = "Transmutagen",
        CHESTER_DESC = "Transform Chester during a Full Moon night.",

        HUTCH_TITLE = "Jukebox",
        HUTCH_DESC = "Transform Hutch into a walking music box.",

        SLURPER_TITLE = "Living Hat",
        SLURPER_DESC = "Bring a Slurper from the Caves to the Surface.",

        SEWITEM_TITLE = "Quick And Thimble",
        SEWITEM_DESC = "Demonstrate your formidable sewing skills.",

        GLOMMER_TITLE = "Bzzort!",
        GLOMMER_DESC = "Discover Glommer's Flower during a Full Moon night.",

        KRAMPUS_TITLE = "You've Been Naughty",
        KRAMPUS_DESC = "Summon Krampus for the first time.",

        LUNARPOTION_TITLE = "Lunar Experiment",
        LUNARPOTION_DESC = "Transform something using the Steeped Lunar Essence.",

        PURPLESTAFF_TITLE = "Travelling Through Space",
        PURPLESTAFF_DESC = "Teleport yourself with the Telelocator Staff.",

        ROSEFLOWER_TITLE = "It's Pricky",
        ROSEFLOWER_DESC = "Thorn your finger picking up a Flower.",

        WEREPIG_TITLE = "The Shapeshifter",
        WEREPIG_DESC = "Witness a Pig Man reveal his secret identity.",

        TUMBLEWEED_TITLE = "High Noon",
        TUMBLEWEED_DESC = "Pick a total of 20 Tumbleweeds.",

        LIGHTNING_TITLE = "Thor's Wrath",
        LIGHTNING_DESC = "Get struck by a Lightning.",

        SHAVEBEEFALO_TITLE = "Haircutter",
        SHAVEBEEFALO_DESC = "Demonstrate your formidable shaving skills on a poor animal.",

        KRAMPUSSACK_TITLE = "Ma' Lucky Day!",
        KRAMPUSSACK_DESC = "Get a Krampus Sack. Lucky!",

        ALLRELIC_TITLE = "Relic Collector",
        ALLRELIC_DESC = "Get every blueprint possible for the Ruins Relics.",
        ALLRELIC_LABEL = "Learned",

        LIVINGLOG_TITLE = "Echoing Screams",
        LIVINGLOG_DESC = "Discover the secret behind the Living Log.",
    },
}
}