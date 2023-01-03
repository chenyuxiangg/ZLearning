return { -- Translation Credit: 抹茶拿鐵
ACCOMPLISHMENTS =
{
    UI =
    {
        TITLE = "成就列表",
        PLAYER_VIEW_TITLE = "{name} 的成就",
        ACHIEVEMENT_VIEW_TITLE = "查看 {name} 的成就",
        DESC = "回顧你的成就。",
        UNLOCKED = "成就已解鎖！",
        TITLE_MISSING = "未知的成就",
        DESC_MISSING = "未知的成就描述。",
        TITLE_HIDDEN = "隱藏成就",
        DESC_HIDDEN = "這是一個隱藏成就。",
        FINISHED_TIME = "第 %s 天",
        FINISHED_TIME_UNKNOWN = "天數不明",
        FINISHED_IRL_TIME_FMT = "%X %x",  -- https://www.lua.org/pil/22.1.html
        FINISHED_IRL_TIME_UNKNOWN = "日期不明",
        ACHIEVEMENT_BUTTON = "檢視成就",
        FILTER_BUTTON_ALL = "顯示全部",
        SETTINGS_BUTTON = "設定",
        PROGRESS_FMT = "{num}/{max}",
        ANNOUNCE_TROPHY_FMT = "{who} 達成了成就：",
        PANEL =
        {
            DELETE = "刪除你目前的進度",
        },
        PANEL_SETTING =
        {
            SHOW_TIME = "顯示時間戳記",
            SHOW_TIME_HOVER = "顯示成就完成的時間",

            SHOW_COUNTER = "顯示成就進度",
            SHOW_COUNTER_HOVER = "顯示成就目前的進度",

            ANNOUNEC_TROPHY = "顯示成就公告",
            ANNOUNEC_TROPHY_HOVER = "顯示玩家成就達成公告",

            DELETE = "重置進度",
            DELETE_HOVER = "重置你的成就進度",
            DELETE_TITLE = "是否重置？",
            DELETE_DESC = "你確定要刪除你的成就資料嗎?\n（一旦重置便無法復原）。",

            LANG = "選擇語言",
            HOTKEY = "設定快捷鍵",
            HOTKEY_NONE = "未設定快捷鍵",
        },
        CLUSTER_PANEL =
        {
            DELETE = "刪除",
            DELETE_TITLE = "是否刪除？",
            DELETE_DESC = "你確定要刪除這個資料嗎?\n（在下次進入這個伺服器的時候，將會通知此伺服器重置你的成就進度。）。",
            EMPTY = "你還尚未獲得過任何成就。",
        },
        SERVER_LIST =
        {
            SERVERNAME_MISSING = "未知的伺服器",
            DESC_FMT = "最後更新日期：%X %x",  -- https://www.lua.org/pil/22.1.html
        },
        CATEGORY =
        {
            MASTERY = "專精",
            COMBAT = "戰鬥",
            HUNT = "狩獵",
            BOSS = "頭目",
            TIME = "時間",
            EXPLORATION = "探索",
            FARMING = "農耕",
            SOCIAL = "社交",
            CHARACTER = "角色",
            ACTIVITY = "活動",
            MOD = "其它",
        },
        SORT =
        {
            DEFAULT = "排序：預設",
            ALPHABETICALLY = "排序：字母順序",
            UNLOCKED_LOCKED = "排序：已解鎖/未解鎖",
            LOCKED_UNLOCKED = "排序：未解鎖/已解鎖",
        },
    },
    MASTERY =
    {
        GENERIC_LABEL = "已完成",

        ALLTROPHY_TITLE = "戰勝所有的不可能",
        ALLTROPHY_DESC = "恭喜你獲得所有成就！",

        ALLCOMBAT_TITLE = "不敗鬥士",
        ALLCOMBAT_DESC = "獲得所有【戰鬥】項目的成就。",

        ALLHUNT_TITLE = "狩獵達人",
        ALLHUNT_DESC = "獲得所有【狩獵】項目的成就。",

        ALLBOSS_TITLE = "頭目殺手",
        ALLBOSS_DESC = "獲得所有【頭目】項目的成就。",

        ALLTIME_TITLE = "精神時光屋",
        ALLTIME_DESC = "獲得所有【時間】項目的成就。",

        ALLEXPLORATION_TITLE = "真正的探險家",
        ALLEXPLORATION_DESC = "獲得所有【探索】項目的成就。",

        ALLFARMING_TITLE = "坐下來喘口氣",
        ALLFARMING_DESC = "獲得所有【農耕】項目的成就。",

        ALLSOCIAL_TITLE = "社交名流",
        ALLSOCIAL_DESC = "獲得所有【社交】項目的成就。",

        ALLCHARACTER_TITLE = "你角色系？",
        ALLCHARACTER_DESC = "獲得所有【角色】項目的成就。",

        ALLACTIVITY_TITLE = "資深玩家",
        ALLACTIVITY_DESC = "獲得所有【活動】項目的成就。",
    },
    COMBAT =
    {
        GENERIC_LABEL = "已擊殺",

        HOUND_TITLE = "獵犬專家",
        HOUND_DESC = "總共擊殺 100 隻獵犬。",

        WORM_TITLE = "百戰地蟲",
        WORM_DESC = "總共擊殺 100 隻深淵蠕蟲。",

        PIGMAN_TITLE = "屠夫",
        PIGMAN_DESC = "總共擊殺 40 隻豬人。",

        BUNNYMAN_TITLE = "再跳！你再跳！",
        BUNNYMAN_DESC = "總共擊殺 40 隻兔人。",

        KRAMPUS_TITLE = "壞壞惹人愛",
        KRAMPUS_DESC = "總共擊殺 10 隻坎普斯。",

        ROCKY_TITLE = "原來是顆石頭，差點以為是龍蝦呢！",
        ROCKY_DESC = "總共擊殺 5 隻石龍蝦。",

        GHOST_TITLE = "不怕阿飄",
        GHOST_DESC = "在月圓的夜晚殺死 1 個鬼魂。",

        SHARK_TITLE = "摸魚摸到大白鯊",
        SHARK_DESC = "在大海之中殺死 1 隻巨岩鯊。",

        WALRUSDART_TITLE = "以牙還牙",
        WALRUSDART_DESC = "使用吹箭殺死 1 隻海象。",
    },
    HUNT =
    {
        GENERIC_LABEL = "已獵殺",

        GENERIC_TITLE = "成為獵人",
        GENERIC_DESC = "總共獵殺 10 隻野獸。",

        GREATHUNTER_TITLE = "專業打野",
        GREATHUNTER_DESC = "總共獵殺 20 隻野獸。",

        KOALEFANTSUMMER_TITLE = "夏日打野趣",
        KOALEFANTSUMMER_DESC = "獵殺 1 隻無尾象。",

        KOALEFANTWINTER_TITLE = "外面很冷",
        KOALEFANTWINTER_DESC = "獵殺 1 隻無尾冬象。",

        WARG_TITLE = "前面有一隻超可愛的狗勾！",
        WARG_DESC = "獵殺 1 隻座狼。",

        SPAT_TITLE = "打鐵 Night",
        SPAT_DESC = "獵殺 1 隻鋼鐵羊。",

        LIGHTNINGGOAT_TITLE = "叭～",
        LIGHTNINGGOAT_DESC = "獵殺 1 隻伏特山羊。",

        PHLEGM_TITLE = "這事有點黏手",
        PHLEGM_DESC = "在其它人的幫助下，從鋼鐵羊的黏液中掙脫。",

        ALLHUNT_TITLE = "狩獵才剛要開始！",
        ALLHUNT_DESC = "獵殺每一種野獸。",
        ALLHUNT_LABEL = "已獵殺",
    },
    BOSS =
    {
        GENERIC_LABEL = "已擊敗",

        DEERCLOPS_TITLE = "死亡視角",
        DEERCLOPS_DESC = "擊敗獨眼巨鹿。",

        MOOSE_TITLE = "鵝鵝鵝鵝鵝鵝～爛機車發不動～",
        MOOSE_DESC = "擊敗麋鹿鵝，或者鵝麋鹿，到底是哪個？",

        DRAGONFLY_TITLE = "禁飛區",
        DRAGONFLY_DESC = "擊敗龍蠅。",

        RAGEDRAGONFLY_TITLE = "火力壓制",
        RAGEDRAGONFLY_DESC = "擊敗處於暴怒狀態的龍蠅。",

        MALBATROSS_TITLE = "水鳥？可以吃嗎？",
        MALBATROSS_DESC = "擊敗邪天翁。",

        KLAUS_TITLE = "聖袋節快樂！",
        KLAUS_DESC = "擊敗克勞斯。",

        RAGEKLAUS_TITLE = "帶來死亡的禮物",
        RAGEKLAUS_DESC = "擊敗狂暴化的克勞斯。",

        SHADOWCHESS_TITLE = "將軍",
        SHADOWCHESS_DESC = "擊敗暗影西洋軍。",

        MINOTAUR_TITLE = "很久很久以前，有一個守護者",
        MINOTAUR_DESC = "擊敗遠古守護者。",

        BEARGER_TITLE = "為什麼要殺阿秋！",
        BEARGER_DESC = "擊敗熊貛。",

        BEEQUEEN_TITLE = "我的蜂蜜呢？",
        BEEQUEEN_DESC = "擊敗女王蜂。",

        ANTLION_TITLE = "胃結石不痛了",
        ANTLION_DESC = "擊敗蟻獅。",

        TOADSTOOL_TITLE = "忽有龐然大物",
        TOADSTOOL_DESC = "擊敗毒菌蟾蜍。",

        MTOADSTOOL_TITLE = "悲慘世界",
        MTOADSTOOL_DESC = "擊敗苦難蟾蜍。",
        -- I personally thought this was a good idea, no fun.
        -- TOADSTOOLAXE_TITLE = "Why We Still Here? Just To Suffer?",
        -- TOADSTOOLAXE_DESC = "Defeat a Toadstool with axes.。",

        STALKERCAVE_TITLE = "它還活著！",
        STALKERCAVE_DESC = "擊敗復活骸骨。",

        STALKERATRIUM_TITLE = "我要送你一朵玫瑰花",
        STALKERATRIUM_DESC = "擊敗遠古織影者。",

        CRABKING_TITLE = "蟹老闆的冒牌貨",
        CRABKING_DESC = "擊敗帝王蟹。",

        SPIDERQUEEN_TITLE = "阿辣哥與他的好夥伴",
        SPIDERQUEEN_DESC = "擊敗蜘蛛女王。",

        LEIF_TITLE = "活著的樹木",
        LEIF_DESC = "擊敗樹人守衛。",

        EYEOFTERROR_TITLE = "我在看著你",
        EYEOFTERROR_DESC = "擊敗恐怖之眼。",

        TWINSOFTERROR_TITLE = "驗光師覺得不行",
        TWINSOFTERROR_DESC = "擊敗雙子魔眼。",

        ALTERGUARDIAN_TITLE = "天界",
        ALTERGUARDIAN_DESC = "擊敗天體英雄。",

        LORDFRUITFLY_TITLE = "除蟲大師",
        LORDFRUITFLY_DESC = "擊敗果蠅王。",

        DEERCLOPSYULE_TITLE = "我看到處都是紅的",
        DEERCLOPSYULE_DESC = "在冬季盛宴期間擊敗冬王。",

        ALLBOSSES_TITLE = "征服者入侵",
        ALLBOSSES_DESC = "擊敗所有頭目。",
    },
    TIME =
    {
        GENERIC_LABEL = "天",
        GENERIC_LABEL_PLURAL = "天",

        FIRSTNIGHT_TITLE = "開端",
        FIRSTNIGHT_DESC = "成功活過你的第一個夜晚。",

        TWENTY_TITLE = "還沒死",
        TWENTY_DESC = "生存 20 天。",

        THIRTYFIVE_TITLE = "依然活著",
        THIRTYFIVE_DESC = "生存 35 天。",

        FIFTYFIVE_TITLE = "我會活下去",
        FIFTYFIVE_DESC = "生存 55 天。",

        ONEHUNDRED_TITLE = "我是倖存者！",
        ONEHUNDRED_DESC = "生存 100 天。",

        FIVEHUNDRED_TITLE = "熱忱的活著",
        FIVEHUNDRED_DESC = "生存 500 天。",

        ONETHOUSAND_TITLE = "跟鬼一樣",
        ONETHOUSAND_DESC = "生存 1000 天。",

        POWCAKE_TITLE = "別等到一千年以後",
        POWCAKE_DESC = "讓一個粉末蛋糕腐壞，無論用什麼方法。",
        POWCAKE_LABEL = "已腐壞",
    },
    EXPLORATION =
    {
        CAVESBIOME_TITLE = "洞穴探險",
        CAVESBIOME_DESC = "第一次進入洞穴。",

        RUINSBIOME_TITLE = "闖入遺跡",
        RUINSBIOME_DESC = "第一次到達遠古遺跡。",

        ARCHIVESBIOME_TITLE = "封印的知識",
        ARCHIVESBIOME_DESC = "第一次到達遠古檔案室。",

        DECIDUOUSBIOME_TITLE = "劉姥姥逛樺樹果園",
        DECIDUOUSBIOME_DESC = "第一次發現樺木森林。",

        MOSAICBIOME_TITLE = "東拼拼西湊湊",
        MOSAICBIOME_DESC = "第一次發現馬賽克地形。",

        SWAMPBIOME_TITLE = "觸手、沼澤和蚊子",
        SWAMPBIOME_DESC = "第一次發現沼澤。",

        MUSHROOMBIOME_TITLE = "蘑菇王國",
        MUSHROOMBIOME_DESC = "第一次發現一個蘑菇森林。",

        MOONMUSHBIOME_TITLE = "月光蘑菇",
        MOONMUSHBIOME_DESC = "第一次發現月亮石窟。",

        ALLMUSHBIOME_TITLE = "蘑菇發掘者",
        ALLMUSHBIOME_DESC = "發現三種蘑菇森林。",
        ALLMUSHBIOME_LABEL = "已發現",

        LUNARBIOME_TITLE = "踏上月球表面",
        LUNARBIOME_DESC = "第一次踏上月島。",

        HERMITBIOME_TITLE = "一隻孤單的螃蟹",
        HERMITBIOME_DESC = "第一次踏上隱士之島。",

        OASISBIOME_TITLE = "柳暗花明又一村",
        OASISBIOME_DESC = "在沙漠中央發現一座神秘的湖泊。",

        MONKEYBIOME_TITLE = "猴子樂園",
        MONKEYBIOME_DESC = "第一次到達月亮碼頭島。",

        WATERLOGBIOME_TITLE = "漂流樹林",
        WATERLOGBIOME_DESC = "在大海之中發現一座浮在水上的森林。",

        ATRIUMBIOME_TITLE = "這通往哪裡？",
        ATRIUMBIOME_DESC = "第一次到達中庭。",
    },
    FARMING =
    {
        SOWALL_TITLE = "鋤禾日當午，汗滴禾下土",
        SOWALL_DESC = "種下每一種種子。",
        SOWALL_LABEL = "已種植",

        FERTILIZERALL_TITLE = "聞起來很特別",
        FERTILIZERALL_DESC = "用每一種肥料施肥。",
        FERTILIZERALL_LABEL = "已使用",

        GROWCROP_TITLE = "溫室管理員",
        GROWCROP_DESC = "養大 1 個作物。",

        GROWGIANTCROP_TITLE = "要怎麼收穫，先怎麼栽。",
        GROWGIANTCROP_DESC = "種出 1 個巨大作物。",

        KILLWEED_TITLE = "有心機的草",
        KILLWEED_DESC = "見識到雜草的力量。",

        TILLING_TITLE = "阿公仔舉鋤頭欲掘芋",
        TILLING_DESC = "總共鋤地 200 次。",
        TILLING_LABEL = "次",
        TILLING_LABEL_PLURAL = "次",

        TILLING2_TITLE = "掘啊掘，掘啊掘",
        TILLING2_DESC = "總共鋤地 400 次。",

        ROTCROP_TITLE = "不種了！不種了！",
        ROTCROP_DESC = "用槌子敲掉 10 個腐爛的巨大作物。",
    },
    SOCIAL =
    {
        FIRSTDEATH_TITLE = "歡迎光臨！",
        FIRSTDEATH_DESC = "第一次死亡。",

        TENDEATH_TITLE = "還來呀？",
        TENDEATH_DESC = "總共死過 10 次。",

        SIXPLAYERS_TITLE = "不求同年同月同日生，但願同年同月同日死",
        SIXPLAYERS_DESC = "在同時有 6 個玩家的世界遊玩。",

        SAMECHARACTER_TITLE = "三人成行",
        SAMECHARACTER_DESC = "在世界上有至少 3 個相同的角色。",

        SOAKPLAYER_TITLE = "潑水節",
        SOAKPLAYER_DESC = "用水球潑溼其他玩家 10 次。",

        GIVEPLAYER_TITLE = "一個人去很危險！",
        GIVEPLAYER_DESC = "在能確保你自己的生存之後，把一些資源送給一個新來的玩家。",

        BOSSFRIEND_TITLE = "團結就是力量",
        BOSSFRIEND_DESC = "和其他玩家一起擊敗一隻王。",

        REVIVEPLAYER_TITLE = "一顆奉獻的心",
        REVIVEPLAYER_DESC = "復活一個死去的玩家。",

        EQUIPALL_TITLE = "行頭全部要帶齊，點名！",
        EQUIPALL_DESC = "同時在身體、頭部和手部裝備物品。",

        KILLPLAYER_TITLE = "你太卑鄙了！",
        KILLPLAYER_DESC = "殺死另一個玩家。",

        SLEEPPLAYER_TITLE = "啵～啵囉囉啵～啵哩～啵～啵哩啵～",
        SLEEPPLAYER_DESC = "用曼德拉草使其他玩家睡著。",

        DOEMOTE_TITLE = "肢體語言",
        DOEMOTE_DESC = "用表情動作向其他人表達你的真實心情。",

        LITFLARE_TITLE = "就是這個光！就是這個光，一起唱！",
        LITFLARE_DESC = "用信號彈向所有人顯示你的位置。",

        HOLDCOMPASS_TITLE = "收到請回答，Over！",
        HOLDCOMPASS_DESC = "用羅盤告訴其他玩家你所在的位置。",
    },
    CHARACTER =
    {
        WILSON1_TITLE = "鬍子怪",
        WILSON1_DESC = "使用威爾森時，超過 20 天不刮鬍子。",
        WILSON2_TITLE = "嘴上無毛，辦事不牢！",
        WILSON2_DESC = "使用威爾森時，在沒有蓄鬍子的狀況下活過冬天。",

        WILLOW1_TITLE = "烤熟了再上",
        WILLOW1_DESC = "使用薇洛時，用你的打火機烤 40 個食物。",
        WILLOW1_LABEL = "已烤過",
        WILLOW2_TITLE = "我很好，沒事！",
        WILLOW2_DESC = "使用薇洛時，讓自己著火 1 分鐘。",

        WOLFGANG1_TITLE = "頭好壯壯",
        WOLFGANG1_DESC = "使用沃爾夫岡時，用健身房鍛鍊到最大力量。",
        WOLFGANG2_TITLE = "飢腸轆轆",
        WOLFGANG2_DESC = "使用沃爾夫岡時，在瘦弱狀態下殺死 40 隻生物。",
        WOLFGANG2_LABEL = "已殺死",

        WENDY1_TITLE = "幻想好朋友",
        WENDY1_DESC = "使用溫蒂時，幫助 20 個小驚嚇。",
        WENDY1_LABEL = "已幫助",
        WENDY2_TITLE = "全靠姐姐",
        WENDY2_DESC = "使用溫蒂時，在阿比蓋爾的幫助下殺死 40 隻生物。",
        WENDY2_LABEL = "已殺死",

        WX781_TITLE = "不好意思掃一下實名制哦！",
        WX781_DESC = "使用 WX-78 時，習得每一種能夠掃描的生物模組。",
        WX781_LABEL = "已掃描",
        WX782_TITLE = "站起來了！",
        WX782_DESC = "使用 WX-78 時，修復一個破損的齒輪機器。",

        WICKERBOTTOM1_TITLE = "書蟲",
        WICKERBOTTOM1_DESC = "使用薇克伯頓時，總共唸 40 次書。",
        WICKERBOTTOM1_LABEL = "已唸過",
        WICKERBOTTOM2_TITLE = "知識就是力量！",
        WICKERBOTTOM2_DESC = "使用薇克伯頓時，學會製作每一種書。",
        WICKERBOTTOM2_LABEL = "已學習",

        -- I'll miss this one so much...
        -- WICKERBOTTOM2_TITLE = "It's Bedtime",
        -- WICKERBOTTOM2_DESC = "As Wickerbottom, fall asleep.。",

        WOODIE1_TITLE = "我愛樹",
        WOODIE1_DESC = "使用伍迪時，以海狸型態砍斷 500 顆樹。",
        WOODIE1_LABEL = "已砍斷",
        WOODIE2_TITLE = "第一回合，開始！",
        WOODIE2_DESC = "使用伍迪時，以鹿型態殺死 40 隻生物。",
        WOODIE2_LABEL = "已殺死",

        WAXWELL1_TITLE = "傀儡大師",
        WAXWELL1_DESC = "使用麥斯威爾時，用暗影鬥士殺死 40 隻生物。",
        WAXWELL1_LABEL = "已殺死",
        WAXWELL2_TITLE = "暗影生物大發生",
        WAXWELL2_DESC = "使用麥斯威爾時，讓理智維持在瘋狂狀態至少 3 分鐘。",

        WES1_TITLE = "氣球炸彈！",
        WES1_DESC = "使用維斯時，被氣球殺死。",
        WES2_TITLE = "落石恐懼震",
        WES2_DESC = "使用維斯時，在地震之中死去。",

        WATHGRITHR1_TITLE = "英靈殿的勇士",
        WATHGRITHR1_DESC = "使用薇格弗德時，擊敗 20 隻王。",
        WATHGRITHR1_LABEL = "已擊敗",
        WATHGRITHR2_TITLE = "女武神的戰吼",
        WATHGRITHR2_DESC = "使用薇格弗德時，在戰鬥中使用 3 種不同的戰歌。",

        WEBBER1_TITLE = "大義滅親",
        WEBBER1_DESC = "使用韋伯時，和你的蜘蛛朋友一起殺死一隻蜘蛛女王。",
        WEBBER2_TITLE = "毛茸茸的快樂夥伴",
        WEBBER2_DESC = "使用韋伯時，和每一種蜘蛛做過朋友。",
        WEBBER2_LABEL = "已交友",

        WINONA1_TITLE = "名牌膠帶！",
        WINONA1_DESC = "使用薇諾娜時，用可靠的膠帶修理 40 個物品。",
        WINONA2_TITLE = "我看著妳長大的！",
        WINONA2_DESC = "使用薇諾娜時，躲過查理的攻擊 5 次。",

        WORTOX1_TITLE = "打不到咧",
        WORTOX1_DESC = "使用沃拓克斯時，利用你的傳送能力躲過攻擊。",
        WORTOX2_TITLE = "救護車來了",
        WORTOX2_DESC = "使用沃拓克斯時，總共治療 1000 點血量。",

        WORMWOOD1_TITLE = "舒心花香",
        WORMWOOD1_DESC = "使用沃姆伍德時，在開花期間關心 100 個作物。",
        WORMWOOD2_TITLE = "四季如春",
        WORMWOOD2_DESC = "使用沃姆伍德時，開花直到春天過後。",

        WARLY1_TITLE = "美食饗宴",
        WARLY1_DESC = "使用沃利時，吃過所有在他菜單上的料理。",
        WARLY1_LABEL = "已吃過",
        WARLY2_TITLE = "烹飪時間",
        WARLY2_DESC = "使用沃利時，煮出每一種他的專屬料理。",
        WARLY2_LABEL = "已烹煮",

        WURT1_TITLE = "從前從前...",
        WURT1_DESC = "使用沃特時，讀過每一本故事書。",
        WURT1_LABEL = "已閱讀",
        WURT2_TITLE = "參見魚人王",
        WURT2_DESC = "使用沃特時，見證一個魚人加冕為魚人王。",

        WALTER1_TITLE = "正中紅心！",
        WALTER1_DESC = "使用沃爾特時，用可靠的彈弓殺死 40 隻生物。",
        WALTER2_TITLE = "永遠的好朋友",
        WALTER2_DESC = "使用沃爾特時，讓沃比幫你拿東西。",

        WANDA1_TITLE = "扭轉命運",
        WANDA1_DESC = "使用旺達時，用回春懷錶抵銷致命的攻擊。",
        WANDA2_TITLE = "時間操縱者",
        WANDA2_DESC = "使用旺達時，在年老的狀態用警鈴懷錶殺死 40 隻生物。",

        WONKEY1_TITLE = "蕉給我！",
        WONKEY1_DESC = "使用 Wonkey 時，吃下 40 個香蕉。",
        WONKEY2_TITLE = "跑呀！傑克船長！",
        WONKEY2_DESC = "使用 Wonkey 時，戴著海盜頭巾和木劍，連續跑步 1 分鐘。",
    },
    ACTIVITY =
    {
        HERMITQUEST_TITLE = "究極工具人！",
        HERMITQUEST_DESC = "完成螃蟹隱士的每一項任務。",

        COOKBOOK_TITLE = "地獄廚房",
        COOKBOOK_DESC = "煮過每一種料理。",
        COOKBOOK_LABEL = "已煮過",

        FAILEDDISH_TITLE = "今天是不適合煮飯的一天",
        FAILEDDISH_DESC = "烹飪的時候，總共煮出 10 次失敗料理。",

        CATCHFISH_TITLE = "釣魚大師",
        CATCHFISH_DESC = "釣到每一種魚。",
        CATCHFISH_LABEL = "已釣過",

        FASTFISH_TITLE = "釣魚不摸魚",
        FASTFISH_DESC = "在 30 秒內釣起一隻魚。",
        FASTFISH_LABEL = "秒",
        FASTFISH_LABEL_PLURAL = "秒",

        ALLWEAPON_TITLE = "軍火商",
        ALLWEAPON_DESC = "裝備過每一種武器。",
        ALLWEAPON_LABEL = "已裝備",

        PIGKINGMG_TITLE = "最後贏家：非豬人",
        PIGKINGMG_DESC = "在豬王的小遊戲中贏得勝利。",

        CRITTER_TITLE = "忠實的夥伴",
        CRITTER_DESC = "領養一隻毛茸茸的可愛小寵物。",

        BEECROWN_TITLE = "國王陛下！",
        BEECROWN_DESC = "有其他玩家對戴著蜂王冠的你鞠躬。",

        BONEHELM_TITLE = "我瘋了！",
        BONEHELM_DESC = "戴上骸骨頭盔。",

        EYEBRELLA_TITLE = "仰望天空",
        EYEBRELLA_DESC = "戴上眼球傘。",

        RUINSHAT_TITLE = "滿城盡帶黃金甲",
        RUINSHAT_DESC = "同時穿戴圖勒盔甲和圖勒皇冠。",

        FOODKILL_TITLE = "垃圾食物",
        FOODKILL_DESC = "靠吃東西自殺。",

        STARVATION_TITLE = "別挨餓",
        STARVATION_DESC = "死於飢餓。",

        WINTERHEAT_TITLE = "還不夠冷",
        WINTERHEAT_DESC = "在冬天熱死。",

        SUMMERFREEZE_TITLE = "還不夠熱",
        SUMMERFREEZE_DESC = "在夏天凍死。",

        GRIMGALETTE_TITLE = "靈魂不怎麼好吃",
        GRIMGALETTE_DESC = "死因：夢魘派。",

        ORANGESTAFF_TITLE = "閃現",
        ORANGESTAFF_DESC = "用橙寶石法杖進行瞬移。",

        GREENAMULET_TITLE = "半價優惠！",
        GREENAMULET_DESC = "用綠寶石護符製作東西。",

        ALCHEMY_TITLE = "科學家",
        ALCHEMY_DESC = "建造一個煉金引擎。",

        PRESTIHATI_TITLE = "帽子戲法",
        PRESTIHATI_DESC = "建造一個魔法帽子。",

        SMANIPULATOR_TITLE = "暗影大師",
        SMANIPULATOR_DESC = "建造一個暗影操縱儀。",

        PIGKING_TITLE = "怎麼有黃金從天上掉下來",
        PIGKING_DESC = "和豬王交易。",

        PLANTFLOWER_TITLE = "美好的一天",
        PLANTFLOWER_DESC = "種一朵漂亮的花，真香。",

        PIGFOLLOWER_TITLE = "豬圈",
        PIGFOLLOWER_DESC = "同時擁有 6 個豬人跟隨者，開派對囉！",

        BUNNYFOLLOWER_TITLE = "毛茸茸的跟隨者",
        BUNNYFOLLOWER_DESC = "同時擁有 6 個兔人跟隨者，太混亂啦！",

        LOBSTERFOLLOWER_TITLE = "硬漢朋友",
        LOBSTERFOLLOWER_DESC = "同時擁有 4 個石龍蝦跟隨者，硬啦！",

        SMALLBIRD_TITLE = "你的媽媽不是你的媽媽",
        SMALLBIRD_DESC = "見證高腳鳥媽媽母愛的奇蹟。",

        ARCHIVESPOWER_TITLE = "又是我第一個到辦公室",
        ARCHIVESPOWER_DESC = "喚醒遠古檔案室的力量。",

        SOOTHTREE_TITLE = "別打我，我是環保人士。",
        SOOTHTREE_DESC = "安撫一個生氣的樹人守衛。",

        BIGTENTACLE_TITLE = "觸手特快車",
        BIGTENTACLE_DESC = "用最不時髦的方式旅行。",

        WORMHOLE_TITLE = "我又跳出來啦！",
        WORMHOLE_DESC = "跳入一個噁心的洞。",

        TURTLE_TITLE = "我要一步一步往上爬",
        TURTLE_DESC = "同時穿戴蝸牛盔甲和甲殼頭盔。",

        DBEEFALO_TITLE = "有車階級",
        DBEEFALO_DESC = "馴化一頭野生的牛。",

        PANDORASCHEST_TITLE = "開箱！",
        PANDORASCHEST_DESC = "開啟一個遺跡迷宮裡的箱子。",

        POTATOCUP_TITLE = "Nome 的收藏",
        POTATOCUP_DESC = "取得傳說中的馬鈴薯杯。",

        EYETURRET_TITLE = "固若金湯",
        EYETURRET_DESC = "建造一個狗狗射射塔。",

        ONEHP_TITLE = "最後一滴血",
        ONEHP_DESC = "在受到攻擊後血量剩下 1 點。",

        BEEBOX_TITLE = "嗡嗡嗡",
        BEEBOX_DESC = "從滿出來的蜂箱採收一些蜂蜜。",

        OPALSTAFF_TITLE = "隱藏著黑暗力量的鑰匙啊...",
        OPALSTAFF_DESC = "見證月亮的力量降臨到一支法杖上。",

        CHESTER_TITLE = "華麗轉身",
        CHESTER_DESC = "在月圓的夜晚轉化切斯特。",

        HUTCH_TITLE = "點唱機",
        HUTCH_DESC = "讓哈奇變成一個移動音樂盒。",

        SLURPER_TITLE = "活生生的帽子",
        SLURPER_DESC = "把一隻啜食獸從洞穴帶到地表。",

        SEWITEM_TITLE = "慈母手中線",
        SEWITEM_DESC = "展現你驚人的裁縫技巧。",

        GLOMMER_TITLE = "噗滋噗滋",
        GLOMMER_DESC = "在月圓的夜晚發現格羅姆之花。",

        KRAMPUS_TITLE = "你這個小壞蛋",
        KRAMPUS_DESC = "第一次召喚坎普斯。",

        LUNARPOTION_TITLE = "月亮實驗",
        LUNARPOTION_DESC = "用月亮精華液轉化一樣東西。",

        PURPLESTAFF_TITLE = "時空旅行",
        PURPLESTAFF_DESC = "用紫寶石法杖傳送自己。",

        ROSEFLOWER_TITLE = "它有刺！",
        ROSEFLOWER_DESC = "在拔花的時候刺到自己的手指。",

        WEREPIG_TITLE = "牠會變身！",
        WEREPIG_DESC = "看到一個豬人顯露它的祕密身分。",

        TUMBLEWEED_TITLE = "日正當中",
        TUMBLEWEED_DESC = "撿起 20 個風滾草。",

        LIGHTNING_TITLE = "索爾氣氣氣",
        LIGHTNING_DESC = "被閃電劈中。",

        SHAVEBEEFALO_TITLE = "理髮師",
        SHAVEBEEFALO_DESC = "用某個可憐的動物來展示你驚人的剃毛技巧。",

        KRAMPUSSACK_TITLE = "超爽der 撿到一個包包咧",
        KRAMPUSSACK_DESC = "獲得一個坎普斯背包，太幸運啦!。",

        ALLRELIC_TITLE = "住新厝，毋免考慮",
        ALLRELIC_DESC = "學會所有遺跡家具的藍圖。",
        ALLRELIC_LABEL = "已學習",

        LIVINGLOG_TITLE = "迴響的尖叫",
        LIVINGLOG_DESC = "發現活木的秘密。",
    },
}
}