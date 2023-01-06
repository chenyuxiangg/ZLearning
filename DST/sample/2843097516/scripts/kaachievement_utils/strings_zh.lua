return { -- Translation Credit: 去码头整点薯条
ACCOMPLISHMENTS =
{
    UI =
    {
        TITLE = "成就大全",
        PLAYER_VIEW_TITLE = "{name} 的成就",
        ACHIEVEMENT_VIEW_TITLE = "查看 {name} 的成就",
        DESC = "回顾你的成就",
        UNLOCKED = "成就解锁！",
        TITLE_MISSING = "缺少标题",
        DESC_MISSING = "缺少说明。",
        TITLE_HIDDEN = "隐藏的成就",
        DESC_HIDDEN = "这一成就还有待发现。",
        FINISHED_TIME = "日期 %s",
        FINISHED_TIME_UNKNOWN = "未知日",
        FINISHED_IRL_TIME_FMT = "%X %x",  -- https://www.lua.org/pil/22.1.html
        FINISHED_IRL_TIME_UNKNOWN = "日期未知",
        ACHIEVEMENT_BUTTON = "查看成就",
        FILTER_BUTTON_ALL = "显示所有",
        SETTINGS_BUTTON = "设置",
        PROGRESS_FMT = "{num}/{max}",
        ANNOUNCE_TROPHY_FMT = "{who} 达成了成就：",
        PANEL =
        {
            DELETE = "删除您的进度",
        },
        PANEL_SETTING =
        {
            SHOW_TIME = "显示时间戳记",
            SHOW_TIME_HOVER = "显示成就完成的时间",

            SHOW_COUNTER = "显示成就进度",
            SHOW_COUNTER_HOVER = "显示成就目前的进度",

            ANNOUNEC_TROPHY = "显示成就公告",
            ANNOUNEC_TROPHY_HOVER = "显示玩家成就达成公告",

            DELETE = "重置进度",
            DELETE_HOVER = "重置成就进度",
            DELETE_TITLE = "重置?",
            DELETE_DESC = "您确定要重置您的成就数据吗？\n（此操作无法撤消。）",

            LANG = "选择语言",
            HOTKEY = "设定热键",
            HOTKEY_NONE = "未设定热键",
        },
        CLUSTER_PANEL =
        {
            DELETE = "删除",
            DELETE_TITLE = "删除?",
            DELETE_DESC = "您确定要删除此数据吗？\n（这也会在您下次加入服务器时通知服务器重置您的数据。）",
            EMPTY = "您还没有任何成就。",
        },
        SERVER_LIST =
        {
            SERVERNAME_MISSING = "未知服务器",
            DESC_FMT = "最后更新：%X %x",  -- https://www.lua.org/pil/22.1.html
        },
        CATEGORY =
        {
            MASTERY = "精通",
            COMBAT = "战斗",
            HUNT = "狩猎",
            BOSS = "巨兽",
            TIME = "时间",
            EXPLORATION = "探索",
            FARMING = "农业",
            SOCIAL = "农业",
            CHARACTER = "幸存者",
            ACTIVITY = "活动",
            MOD = "其他",
        },
        SORT =
        {
            DEFAULT = "排序：默认",
            ALPHABETICALLY = "排序：按字母顺序",
            UNLOCKED_LOCKED = "排序：解锁/锁定",
            LOCKED_UNLOCKED = "排序：锁定/解锁",
        },
    },
    MASTERY =
    {
        GENERIC_LABEL = "已完成",

        ALLTROPHY_TITLE = "几率挑战者",
        ALLTROPHY_DESC = "获得所有成就。恭喜！",

        ALLCOMBAT_TITLE = "不败的战士",
        ALLCOMBAT_DESC = "获得【战斗】类别的所有成就。",

        ALLHUNT_TITLE = "职业猎人",
        ALLHUNT_DESC = "获得【狩猎】类别的所有成就。",

        ALLBOSS_TITLE = "巨兽杀手",
        ALLBOSS_DESC = "获得【巨兽】类别的所有成就。",

        ALLTIME_TITLE = "时间就是监狱",
        ALLTIME_DESC = "获得【时间】类别的所有成就。",

        ALLEXPLORATION_TITLE = "真正的探险家",
        ALLEXPLORATION_DESC = "获得【探索】类别的所有成就。",

        ALLFARMING_TITLE = "坐下来放松",
        ALLFARMING_DESC = "获得【农业】类别的所有成就。",

        ALLSOCIAL_TITLE = "社会名人",
        ALLSOCIAL_DESC = "获得【社交】类别的所有成就。",

        ALLCHARACTER_TITLE = "万事通",
        ALLCHARACTER_DESC = "获得【幸存者】类别的所有成就。",

        ALLACTIVITY_TITLE = "活动大师",
        ALLACTIVITY_DESC = "获得【活动】类别的所有成就。",
    },
    COMBAT =
    {
        GENERIC_LABEL = "已击败",

        HOUND_TITLE = "驯犬师",
        HOUND_DESC = "总共击败 100 只猎犬。",

        WORM_TITLE = "蠕虫的世界末日",
        WORM_DESC = "总共击败 100 只深渊蠕虫。",

        PIGMAN_TITLE = "屠宰场",
        PIGMAN_DESC = "总共击败 40 个猪人。",

        BUNNYMAN_TITLE = "跳！跳！跳！",
        BUNNYMAN_DESC = "总共击败 40 个兔人。",

        KRAMPUS_TITLE = "淘气又可爱",
        KRAMPUS_DESC = "总共击败 10 个 坎普斯",

        ROCKY_TITLE = "这不是一块岩石！",
        ROCKY_DESC = "总共击败 5 只岩龙虾。",

        GHOST_TITLE = "恐惧症",
        GHOST_DESC = "在满月之夜击败一只幽灵。",

        SHARK_TITLE = "食人兽",
        SHARK_DESC = "在海洋中击败岩石大白鲨。",

        WALRUSDART_TITLE = "回到你身边，朋友",
        WALRUSDART_DESC = "使用吹镖击海象爸爸。",
    },
    HUNT =
    {
        GENERIC_LABEL = "已猎杀",

        GENERIC_TITLE = "猎人",
        GENERIC_DESC = "总共猎杀 10 只野兽。",

        GREATHUNTER_TITLE = "傲慢者",
        GREATHUNTER_DESC = "总共猎杀 20 只野兽。",

        KOALEFANTSUMMER_TITLE = "夏季狩猎",
        KOALEFANTSUMMER_DESC = "追捕一只考拉象。",

        KOALEFANTWINTER_TITLE = "外面很冷",
        KOALEFANTWINTER_DESC = "猎杀一只冬季考拉象。",

        WARG_TITLE = "大大的小狗",
        WARG_DESC = "追捕一个座狼。",

        SPAT_TITLE = "钢羊猎手",
        SPAT_DESC = "追捕一只钢羊。",

        LIGHTNINGGOAT_TITLE = "闪电？虚张声势！",
        LIGHTNINGGOAT_DESC = "追捕一只伏特山羊。",

        PHLEGM_TITLE = "棘手的情况",
        PHLEGM_DESC = "在某人的帮助下将你自己从钢羊粘液中解放出来。",

        ALLHUNT_TITLE = "狩猎开始！",
        ALLHUNT_DESC = "猎杀所有野兽。",
        ALLHUNT_LABEL = "已猎杀",
    },
    BOSS =
    {
        GENERIC_LABEL = "已击败",

        DEERCLOPS_TITLE = "死亡感知",
        DEERCLOPS_DESC = "击败鹿角羚。",

        MOOSE_TITLE = "往南走",
        MOOSE_DESC = "击败驼鹿或鹅，或两者兼而有之？",

        DRAGONFLY_TITLE = "禁飞区",
        DRAGONFLY_DESC = "击败蜻蜓。",

        RAGEDRAGONFLY_TITLE = "火力压制",
        RAGEDRAGONFLY_DESC = "在蜻蜓被激怒时击败它。",

        MALBATROSS_TITLE = "水禽狩猎",
        MALBATROSS_DESC = "击败一只邪天翁。",

        KLAUS_TITLE = "末日快乐！",
        KLAUS_DESC = "击败一只克劳斯。",

        RAGEKLAUS_TITLE = "生不如死",
        RAGEKLAUS_DESC = "击败愤怒的地表最强克劳斯。",

        SHADOWCHESS_TITLE = "将死！",
        SHADOWCHESS_DESC = "击败暗影棋子。",

        MINOTAUR_TITLE = "远古巨兽",
        MINOTAUR_DESC = "击败远古守护者。",

        BEARGER_TITLE = "永别了！伐木工",
        BEARGER_DESC = "击败熊。",

        BEEQUEEN_TITLE = "我的蜂蜜呢？,",
        BEEQUEEN_DESC = "击败蜂王。",

        ANTLION_TITLE = "蚂蚁饲料",
        ANTLION_DESC = "击败蚁狮。",

        TOADSTOOL_TITLE = "地下大青蛙！",
        TOADSTOOL_DESC = "击败毒菌蟾蜍。",

        MTOADSTOOL_TITLE = "以毒攻毒",
        MTOADSTOOL_DESC = "击败一只悲剧蟾蜍。",
        -- I personally thought this was a good idea, no fun.
        -- TOADSTOOLAXE_TITLE = "Why We Still Here? Just To Suffer?",
        -- TOADSTOOLAXE_DESC = "Defeat a Toadstool with axes.",

        STALKERCAVE_TITLE = "这不是化石！",
        STALKERCAVE_DESC = "击败复活的骨架",

        STALKERATRIUM_TITLE = "暗影救赎者",
        STALKERATRIUM_DESC = "击败远古编制者。",

        CRABKING_TITLE = "脆皮蟹",
        CRABKING_DESC = "击败蟹王。",

        SPIDERQUEEN_TITLE = "弑虫者",
        SPIDERQUEEN_DESC = "击败蜘蛛女王。",

        LEIF_TITLE = "生机勃勃的森林",
        LEIF_DESC = "击败树人守卫。",

        EYEOFTERROR_TITLE = "我盯着你",
        EYEOFTERROR_DESC = "击败恐惧之眼。",

        TWINSOFTERROR_TITLE = "巨型眼科医生",
        TWINSOFTERROR_DESC = "击败恐怖双胞胎。",

        ALTERGUARDIAN_TITLE = "来自天界的猛攻",
        ALTERGUARDIAN_DESC = "击败天界勇士。",

        LORDFRUITFLY_TITLE = "杀虫剂",
        LORDFRUITFLY_DESC = "击败果蝇之王。",

        DEERCLOPSYULE_TITLE = "我看到红色",
        DEERCLOPSYULE_DESC = "在冬季盛宴活动中击败巨鹿。",

        ALLBOSSES_TITLE = "巨兽征服者",
        ALLBOSSES_DESC = "击败所有巨人。",
    },
    TIME =
    {
        GENERIC_LABEL = "天",
        GENERIC_LABEL_PLURAL = "天",

        FIRSTNIGHT_TITLE = "开始",
        FIRSTNIGHT_DESC = "度过你的第一个夜晚。",

        TWENTY_TITLE = "还没死",
        TWENTY_DESC = "连续生存 20 天。",

        THIRTYFIVE_TITLE = "保持活力",
        THIRTYFIVE_DESC = "连续生存 35 天。",

        FIFTYFIVE_TITLE = "我会活下来",
        FIFTYFIVE_DESC = "连续生存 55 天。",

        ONEHUNDRED_TITLE = "我是幸存者",
        ONEHUNDRED_DESC = "连续生存 100 天。",

        FIVEHUNDRED_TITLE = "爱好者",
        FIVEHUNDRED_DESC = "连续生存 500 天。",

        ONETHOUSAND_TITLE = "传奇",
        ONETHOUSAND_DESC = "连续生存 1000 天。",

        POWCAKE_TITLE = "*电音*",
        POWCAKE_DESC = "在有或没有帮助的情况下破坏粉状蛋糕。",
        POWCAKE_LABEL = "已腐坏",
    },
    EXPLORATION =
    {
        CAVESBIOME_TITLE = "去矿井！",
        CAVESBIOME_DESC = "第一次去洞穴。",

        RUINSBIOME_TITLE = "废墟入侵者",
        RUINSBIOME_DESC = "第一次突破遗迹。",

        ARCHIVESBIOME_TITLE = "禁止的知识",
        ARCHIVESBIOME_DESC = "第一次破坏远古档案馆。",

        DECIDUOUSBIOME_TITLE = "桦栗果",
        DECIDUOUSBIOME_DESC = "第一次发现该地形。",

        MOSAICBIOME_TITLE = "岩石路",
        MOSAICBIOME_DESC = "第一次发现混合地形。",

        SWAMPBIOME_TITLE = "触手和蚊子！",
        SWAMPBIOME_DESC = "第一次发现沼泽。",

        MUSHROOMBIOME_TITLE = "蘑菇王国",
        MUSHROOMBIOME_DESC = "第一次发现蘑菇林。",

        MOONMUSHBIOME_TITLE = "月光蘑菇",
        MOONMUSHBIOME_DESC = "第一次发现月球石窟。",

        ALLMUSHBIOME_TITLE = "糊状探险家",
        ALLMUSHBIOME_DESC = "发现三个蘑菇森林。",
        ALLMUSHBIOME_LABEL = "已探索",

        LUNARBIOME_TITLE = "带我飞向月球",
        LUNARBIOME_DESC = "第一次发现月岛。",

        HERMITBIOME_TITLE = "一只孤独的螃蟹",
        HERMITBIOME_DESC = "第一次发现隐士岛。",

        OASISBIOME_TITLE = "绿洲的救赎",
        OASISBIOME_DESC = "在沙漠中找到一个神秘的湖泊。",

        MONKEYBIOME_TITLE = "猴子乐园",
        MONKEYBIOME_DESC = "第一次突破月亮码头岛。",

        WATERLOGBIOME_TITLE = "海上森林",
        WATERLOGBIOME_DESC = "在海洋中央找到一片漂流森林。",

        ATRIUMBIOME_TITLE = "后面是什么？",
        ATRIUMBIOME_DESC = "第一次突破中庭。",
    },
    FARMING =
    {
        SOWALL_TITLE = "播种机",
        SOWALL_DESC = "播种各种种子。",
        SOWALL_LABEL = "已种植",

        FERTILIZERALL_TITLE = "那肯定有味道！",
        FERTILIZERALL_DESC = "使用各种肥料。",
        FERTILIZERALL_LABEL = "已使用",

        GROWCROP_TITLE = "植物管理员",
        GROWCROP_DESC = "种植作物。",

        GROWGIANTCROP_TITLE = "收获你所播种的",
        GROWGIANTCROP_DESC = "种出一株巨型作物。",

        KILLWEED_TITLE = "邪恶花园",
        KILLWEED_DESC = "见证野草的力量。",

        TILLING_TITLE = "虽然不多，但是...",
        TILLING_DESC = "总共 200 次。",
        TILLING_LABEL = "次",
        TILLING_LABEL_PLURAL = "次",

        TILLING2_TITLE = "这是诚实的工作",
        TILLING2_DESC = "总共 400 次。",

        ROTCROP_TITLE = "我讨厌植物",
        ROTCROP_DESC = "粉碎 10 个腐烂的巨型作物。",
    },
    SOCIAL =
    {
        FIRSTDEATH_TITLE = "欢迎！",
        FIRSTDEATH_DESC = "第一次死。",

        TENDEATH_TITLE = "又一次？！？！",
        TENDEATH_DESC = "第 10 次死亡。",

        SIXPLAYERS_TITLE = "我们一起玩，我们一起死！",
        SIXPLAYERS_DESC = "在一个同时有 6 名玩家的世界中进行游戏。",

        SAMECHARACTER_TITLE = "三连",
        SAMECHARACTER_DESC = "世界上至少有 3 个相同的幸存者。",

        SOAKPLAYER_TITLE = "打水仗",
        SOAKPLAYER_DESC = "使用水气球浸泡玩家总共 10 次。",

        GIVEPLAYER_TITLE = "一个人去很危险！",
        GIVEPLAYER_DESC = "建立自己后将资源提供给新玩家。",

        BOSSFRIEND_TITLE = "团队合作就是梦想",
        BOSSFRIEND_DESC = "与其他玩家一起击败 Boss。",

        REVIVEPLAYER_TITLE = "一颗奉献的心",
        REVIVEPLAYER_DESC = "让一名玩家起死回生。",

        EQUIPALL_TITLE = "配套服装",
        EQUIPALL_DESC = "同时装备一件盔甲、一顶帽子和一件手部物品。",

        KILLPLAYER_TITLE = "你太卑鄙了！",
        KILLPLAYER_DESC = "击败其他玩家。",

        SLEEPPLAYER_TITLE = "有你真好！",
        SLEEPPLAYER_DESC = "让玩家和曼德拉草一起睡觉。",

        DOEMOTE_TITLE = "表达自己",
        DOEMOTE_DESC = "用表情向大家展示你的真实感受。",

        LITFLARE_TITLE = "天空之光",
        LITFLARE_DESC = "用信号弹向所有人展示您的当前位置。",

        HOLDCOMPASS_TITLE = "无畏的探险家",
        HOLDCOMPASS_DESC = "与使用指南针的人分享您的当前位置。",
    },
    CHARACTER =
    {
        WILSON1_TITLE = "胡须怪物",
        WILSON1_DESC = "作为威尔逊，20 天内不要刮胡子。",
        WILSON2_TITLE = "无胡子",
        WILSON2_DESC = "扮演威尔逊，在没有胡子的情况下度过冬天。",

        WILLOW1_TITLE = "易燃",
        WILLOW1_DESC = "作为薇洛，打火机烹饪总共 40 件物品。",
        WILLOW1_LABEL = "已烹饪",
        WILLOW2_TITLE = "这很好",
        WILLOW2_DESC = "作为薇洛，着火 1 分钟。",

        WOLFGANG1_TITLE = "我很强大！",
        WOLFGANG1_DESC = "作为沃尔夫冈，在强大的道馆中达到最大力量。",
        WOLFGANG2_TITLE = "空腹",
        WOLFGANG2_DESC = "作为沃尔夫冈，在懦弱形态下总共击败 40 个怪物。",
        WOLFGANG2_LABEL = "已击败",

        WENDY1_TITLE = "卡斯帕遇见温蒂",
        WENDY1_DESC = "作为温蒂，总共协助 20 个小精灵。",
        WENDY1_LABEL = "已协助",
        WENDY2_TITLE = "战斗姐妹",
        WENDY2_DESC = "作为温蒂，在阿比盖尔的协助下总共击败 40 只怪物。",
        WENDY2_LABEL = "已击败",

        WX781_TITLE = "启动并准备服务",
        WX781_DESC = "作为 WX-78，使用生物扫描仪扫描所有可能的生物。",
        WX781_LABEL = "已扫描",
        WX782_TITLE = "它还活着！！！",
        WX782_DESC = "作为 WX-78，修理损坏的发条。",

        WICKERBOTTOM1_TITLE = "书虫",
        WICKERBOTTOM1_DESC = "作为老奶奶，总共阅读书籍 40 次。",
        WICKERBOTTOM1_LABEL = "已阅读",
        WICKERBOTTOM2_TITLE = "知识就是力量！",
        WICKERBOTTOM2_DESC = "作为老奶奶尽可能学习每一本书。",
        WICKERBOTTOM2_LABEL = "已学习",

        -- I'll miss this one so much...
        -- WICKERBOTTOM2_TITLE = "It's Bedtime",
        -- WICKERBOTTOM2_DESC = "As Wickerbottom, fall asleep.",

        WOODIE1_TITLE = "树拥抱者",
        WOODIE1_DESC = "作为伍迪，用海狸砍伐总共 500 棵树。",
        WOODIE1_LABEL = "已砍伐",
        WOODIE2_TITLE = "第一轮，战斗！",
        WOODIE2_DESC = "作为伍迪，使用 鹿像 击败总共 40 只怪物。",
        WOODIE2_LABEL = "已击败",

        WAXWELL1_TITLE = "木偶大师",
        WAXWELL1_DESC = "作为麦克斯韦，使用暗影决斗者总共击败 40 个怪物。",
        WAXWELL1_LABEL = "已击败",
        WAXWELL2_TITLE = "全面暗影混乱",
        WAXWELL2_DESC = "作为麦克斯韦，保持疯狂 3 分钟。",

        WES1_TITLE = "气球化了！",
        WES1_DESC = "作为韦斯，死于气球。",
        WES2_TITLE = "足下的震撼",
        WES2_DESC = "作为韦斯，在地震中死去。",

        WATHGRITHR1_TITLE = "英灵殿斗士",
        WATHGRITHR1_DESC = "作为女武神，总共击败 20 个 Boss。",
        WATHGRITHR1_LABEL = "已击败",
        WATHGRITHR2_TITLE = "布伦希尔德的战吼",
        WATHGRITHR2_DESC = "作为女武神，在战斗中使用至少 3 首不同的歌曲。",

        WEBBER1_TITLE = "致命的家庭",
        WEBBER1_DESC = "作为韦伯，和蜘蛛朋友一同击败蜘蛛女王。",
        WEBBER2_TITLE = "模糊朋友",
        WEBBER2_DESC = "作为韦伯，与各种蜘蛛交朋友。",
        WEBBER2_LABEL = "已交友",

        WINONA1_TITLE = "柔性胶带！",
        WINONA1_DESC = "作为薇诺娜，使用信任胶带修补总共 40 件物品。",
        WINONA2_TITLE = "我知道你的动作！",
        WINONA2_DESC = "作为薇诺娜，躲避查理的 5 次攻击。",

        WORTOX1_TITLE = "躲开这个！",
        WORTOX1_DESC = "作为小恶魔，使用你的传送技能避免被击中。",
        WORTOX2_TITLE = "医生！",
        WORTOX2_DESC = "作为小恶魔，为一名玩家治疗总计 1000 点生命值。",

        WORMWOOD1_TITLE = "舒缓光环",
        WORMWOOD1_DESC = "作为艾草，在开花期间总共照料 100 种作物。",
        WORMWOOD2_TITLE = "春天来了",
        WORMWOOD2_DESC = "作为艾草，开花度过春季。",

        WARLY1_TITLE = "令人愉快的味道",
        WARLY1_DESC = "作为沃利，吃掉菜单上的每一道菜。",
        WARLY1_LABEL = "已吃过",
        WARLY2_TITLE = "厨师时间",
        WARLY2_DESC = "作为沃利，烹饪每一道独家菜肴。",
        WARLY2_LABEL = "已烹饪",

        WURT1_TITLE = "从前从前...",
        WURT1_DESC = "作为沃特，阅读所有可能的童话书。",
        WURT1_LABEL = "已阅读",
        WURT2_TITLE = "梅姆图尔国王？",
        WURT2_DESC = "作为沃特，见证人鱼向鱼人之王加冕。",

        WALTER1_TITLE = "爆头！",
        WALTER1_DESC = "作为沃尔特，使用可信赖的弹弓总共击败 40 个怪物。",
        WALTER2_TITLE = "永远的好朋友",
        WALTER2_DESC = "作为沃尔特，在沃比的帮助下搬运一些东西。",

        WANDA1_TITLE = "扭曲的节奏",
        WANDA1_DESC = "作为旺达，用永恒守望避免致命一击。",
        WANDA2_TITLE = "时间绕线器",
        WANDA2_DESC = "作为旺达，在年老的时候用闹钟打败总共 40 只怪物。",

        WONKEY1_TITLE = "娜娜！娜娜！",
        WONKEY1_DESC = "作为旺基，总共吃掉 40 根香蕉。",
        WONKEY2_TITLE = "杰克奔跑",
        WONKEY2_DESC = "作为 Wonkey，穿着海盗头巾和无皮手套跑 1 分钟。",
    },
    ACTIVITY =
    {
        HERMITQUEST_TITLE = "最高助手奴才！",
        HERMITQUEST_DESC = "完成螃蟹隐士的所有任务。",

        COOKBOOK_TITLE = "地狱厨房",
        COOKBOOK_DESC = "尽可能烹制每一道菜。",
        COOKBOOK_LABEL = "已烹饪",

        FAILEDDISH_TITLE = "糟糕的炊具日",
        FAILEDDISH_DESC = "尝试烹饪时总共失败了 10 次。",

        CATCHFISH_TITLE = "钓鱼大师",
        CATCHFISH_DESC = "抓住所有可能的鱼。",
        CATCHFISH_LABEL = "已钓过",

        FASTFISH_TITLE = "又快又好鱼",
        FASTFISH_DESC = "在 30 秒内钓到一条海鱼。",
        FASTFISH_LABEL = "秒",
        FASTFISH_LABEL_PLURAL = "秒",

        ALLWEAPON_TITLE = "战帅",
        ALLWEAPON_DESC = "装备所有可能的武器。",
        ALLWEAPON_LABEL = "已装备",

        PIGKINGMG_TITLE = "解猪挑战者",
        PIGKINGMG_DESC = "赢得猪王的小游戏。",

        CRITTER_TITLE = "忠诚的伙伴",
        CRITTER_DESC = "收养一个毛茸茸的可爱小动物。",

        BEECROWN_TITLE = "我的君主！",
        BEECROWN_DESC = "戴上蜂王冠，有人向你鞠躬。",

        BONEHELM_TITLE = "疯狂！",
        BONEHELM_DESC = "戴上骨头盔。",

        EYEBRELLA_TITLE = "仰望天空！",
        EYEBRELLA_DESC = "戴上眼镜。",

        RUINSHAT_TITLE = "我是皇室成员",
        RUINSHAT_DESC = "同时穿戴图勒套装和图勒王冠。",

        FOODKILL_TITLE = "垃圾食品",
        FOODKILL_DESC = "吃东西自杀。",

        STARVATION_TITLE = "不要饿死",
        STARVATION_DESC = "饿死。",

        WINTERHEAT_TITLE = "太热了！",
        WINTERHEAT_DESC = "冬天死于高温。",

        SUMMERFREEZE_TITLE = "冷！",
        SUMMERFREEZE_DESC = "夏天冻死。",

        GRIMGALETTE_TITLE = "承办者",
        GRIMGALETTE_DESC = "死于吃冷面饼。",

        ORANGESTAFF_TITLE = "还有...噗！",
        ORANGESTAFF_DESC = "用懒惰的探险家传送自己。",

        GREENAMULET_TITLE = "50% 折扣！",
        GREENAMULET_DESC = "用建筑护身符制作一些东西。",

        ALCHEMY_TITLE = "理学硕士",
        ALCHEMY_DESC = "构建炼金引擎。",

        PRESTIHATI_TITLE = "帽子戏法",
        PRESTIHATI_DESC = "建立一个灵子分解器",

        SMANIPULATOR_TITLE = "阴影大师",
        SMANIPULATOR_DESC = "建造一个影子操纵器。",

        PIGKING_TITLE = "金色淋浴",
        PIGKING_DESC = "与猪王达成协议。",

        PLANTFLOWER_TITLE = "多么美好的一天",
        PLANTFLOWER_DESC = "种一朵漂亮的花。哇。",

        PIGFOLLOWER_TITLE = "猪圈",
        PIGFOLLOWER_DESC = "同时拥有 6 名猪人追随者。真是一场派对！",

        BUNNYFOLLOWER_TITLE = "毛茸茸的追随者",
        BUNNYFOLLOWER_DESC = "同时拥有 6 个兔人追随者。混乱！",

        LOBSTERFOLLOWER_TITLE = "艰难的人群",
        LOBSTERFOLLOWER_DESC = "同时拥有 4 名岩龙虾追随者。活泼！",

        SMALLBIRD_TITLE = "不是你妈妈",
        SMALLBIRD_DESC = "见证高鸟妈妈的奇迹。",

        ARCHIVESPOWER_TITLE = "打开灯！",
        ARCHIVESPOWER_DESC = "打开存档电源。",

        SOOTHTREE_TITLE = "树语者",
        SOOTHTREE_DESC = "安抚被激怒的树人守卫。",

        BIGTENTACLE_TITLE = "触手快递",
        BIGTENTACLE_DESC = "以完全相反的方式旅行。",

        WORMHOLE_TITLE = "未知的冒险",
        WORMHOLE_DESC = "跳下一个大洞。",

        TURTLE_TITLE = "龟龟龟！",
        TURTLE_DESC = "同时穿戴 蜗壳护甲 和 背壳头盔",

        DBEEFALO_TITLE = "无底胃兽",
        DBEEFALO_DESC = "驯化野牛。",

        PANDORASCHEST_TITLE = "大赏金！",
        PANDORASCHEST_DESC = "打开废墟迷宫中的一个箱子。",

        POTATOCUP_TITLE = "有人称他为...",
        POTATOCUP_DESC = "获得传说中的土豆杯。",

        EYETURRET_TITLE = "进攻就是最好的防御",
        EYETURRET_DESC = "建造一个眼睛炮塔。",

        ONEHP_TITLE = "还没接近，宝贝！",
        ONEHP_DESC = "在一次攻击中仅剩 1 生命值。",

        BEEBOX_TITLE = "忙碌的蜜蜂",
        BEEBOX_DESC = "从溢出的蜂箱中采集一些甜甜的蜂蜜。",

        OPALSTAFF_TITLE = "被月亮腐蚀",
        OPALSTAFF_DESC = "见证月亮下降到海平面。",

        CHESTER_TITLE = "变形剂",
        CHESTER_DESC = "在满月之夜变身切斯特。",

        HUTCH_TITLE = "点唱机",
        HUTCH_DESC = "将哈奇变成一个行走的音乐盒。",

        SLURPER_TITLE = "活帽",
        SLURPER_DESC = "把一个吸食者从洞穴带到地表。",

        SEWITEM_TITLE = "快速顶针",
        SEWITEM_DESC = "展示你强大的缝纫技能。",

        GLOMMER_TITLE = "丑的可爱！",
        GLOMMER_DESC = "在满月之夜发现格罗姆之花。",

        KRAMPUS_TITLE = "你太淘气了",
        KRAMPUS_DESC = "第一次召唤坎普斯。",

        LUNARPOTION_TITLE = "月球实验",
        LUNARPOTION_DESC = "使用浸泡的月之精华改变某物。",

        PURPLESTAFF_TITLE = "太空旅行",
        PURPLESTAFF_DESC = "用传送法杖传送你自己。",

        ROSEFLOWER_TITLE = "它很棘手",
        ROSEFLOWER_DESC = "捡到一朵花的手指被刺了。",

        WEREPIG_TITLE = "变形者",
        WEREPIG_DESC = "见证一个猪人，揭露他的秘密身份。",

        TUMBLEWEED_TITLE = "正午",
        TUMBLEWEED_DESC = "总共挑选 20 株风滚草。",

        LIGHTNING_TITLE = "雷神之怒",
        LIGHTNING_DESC = "被闪电击中。",

        SHAVEBEEFALO_TITLE = "理发师",
        SHAVEBEEFALO_DESC = "向可怜的动物展示你强大的剃须技巧。",

        KRAMPUSSACK_TITLE = "妈妈的幸运日！",
        KRAMPUSSACK_DESC = "得到一个坎普斯的背包。幸运！",

        ALLRELIC_TITLE = "遗物收藏家",
        ALLRELIC_DESC = "获取废墟遗迹的所有蓝图。",
        ALLRELIC_LABEL = "已获取",

        LIVINGLOG_TITLE = "回声尖叫",
        LIVINGLOG_DESC = "发现生活日志背后的秘密。",
    },
}
}