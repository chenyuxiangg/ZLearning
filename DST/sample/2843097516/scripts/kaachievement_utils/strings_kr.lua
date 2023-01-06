return { -- Translation Credit: AFS Co. Ltd.
ACCOMPLISHMENTS =
{
    UI =
    {
        TITLE = "도전과제",
        PLAYER_VIEW_TITLE = "{name} 의 도전과제",
        ACHIEVEMENT_VIEW_TITLE = "{name} 의 도전과제 보기",
        DESC = "달성한 도전과제를 돌아봅니다",
        UNLOCKED = "도젼과제 달성!",
        TITLE_MISSING = "제목 없음",
        DESC_MISSING = "설명 없음",
        TITLE_HIDDEN = "숨겨진 도전과제",
        DESC_HIDDEN = "아직 밝혀지지 않은 도전과제입니다.",
        FINISHED_TIME = "%s일",
        FINISHED_TIME_UNKNOWN = "일자 불명",
        FINISHED_IRL_TIME_FMT = "%X %x",  -- https://www.lua.org/pil/22.1.html
        FINISHED_IRL_TIME_UNKNOWN = "달성일 불명",
        ACHIEVEMENT_BUTTON = "도전과제 보기",
        FILTER_BUTTON_ALL = "전부 표시",
        SETTINGS_BUTTON = "설정",
        PROGRESS_FMT = "{num}/{max}",
        ANNOUNCE_TROPHY_FMT = "{who} has accomplished: ",
        PANEL =
        {
            DELETE = "진행 상황 삭제",
        },
        PANEL_SETTING =
        {
            SHOW_TIME = "타임스탬프 표시",
            SHOW_TIME_HOVER = "도전과제를 달성한 시각 표시",

            SHOW_COUNTER = "진행 상황 표시",
            SHOW_COUNTER_HOVER = "도전과제 진행 상황 표시",

            ANNOUNEC_TROPHY = "Announce Trophy",
            ANNOUNEC_TROPHY_HOVER = "Receive accomplishment announcement",

            DELETE = "진행 상황 초기화",
            DELETE_HOVER = "도전과제 진행 상황 초기화",
            DELETE_TITLE = "초기화하시겠습니까?",
            DELETE_DESC = "정말로 도전과제 데이터를 초기화하시겠습니까?\n(이 작업은 되돌릴 수 없습니다.)",

            LANG = "Choose Language",
            HOTKEY = "Bind Hotkey",
            HOTKEY_NONE = "Unbind",
        },
        CLUSTER_PANEL =
        {
            DELETE = "삭제",
            DELETE_TITLE = "삭제하시겠습니까?",
            DELETE_DESC = "정말로 이 데이터를 삭제하시겠습니까?\n(다음 번 서버에 접속할 때 데이터가 삭제되었음을\n서버에서 알리게 될 것입니다.)",
            EMPTY = "아직 달성한 도전과제가 없습니다.",
        },
        SERVER_LIST =
        {
            SERVERNAME_MISSING = "알 수 없는 서버",
            DESC_FMT = "최근 업데이트: %X %x",  -- https://www.lua.org/pil/22.1.html
        },
        CATEGORY =
        {
            MASTERY = "마스터리",
            COMBAT = "전투",
            HUNT = "사냥",
            BOSS = "거인",
            TIME = "시간",
            EXPLORATION = "탐험",
            FARMING = "농사",
            SOCIAL = "사교",
            CHARACTER = "생존자",
            ACTIVITY = "활동",
            MOD = "기타",
        },
        SORT =
        {
            DEFAULT = "정렬: 기본",
            ALPHABETICALLY = "정렬: 가나다순",
            UNLOCKED_LOCKED = "정렬: 달성 우선",
            LOCKED_UNLOCKED = "정렬: 미달성 우선",
        },
    },
    MASTERY =
    {
        GENERIC_LABEL = "달성",

        ALLTROPHY_TITLE = "역경을 견뎌내다",
        ALLTROPHY_DESC = "모든 도전과제 달성. 축하합니다!",

        ALLCOMBAT_TITLE = "불굴의 전사",
        ALLCOMBAT_DESC = "전투 카테고리의 모든 도전과제 달성",

        ALLHUNT_TITLE = "사냥의 전문가",
        ALLHUNT_DESC = "사냥 카테고리의 모든 도전과제 달성",

        ALLBOSS_TITLE = "세계를 죽인 자",
        ALLBOSS_DESC = "거인 카테고리의 모든 도전과제 달성",

        ALLTIME_TITLE = "시간은 감옥이다",
        ALLTIME_DESC = "시간 카테고리의 모든 도전과제 달성",

        ALLEXPLORATION_TITLE = "진정한 탐험가",
        ALLEXPLORATION_DESC = "탐험 카테고리의 모든 도전과제 달성",

        ALLFARMING_TITLE = "느긋하게 앉아서",
        ALLFARMING_DESC = "농사 카테고리의 모든 도전과제 달성",

        ALLSOCIAL_TITLE = "유명인사",
        ALLSOCIAL_DESC = "사교 카테고리의 모든 도전과제 달성",

        ALLCHARACTER_TITLE = "다재다능",
        ALLCHARACTER_DESC = "생존자 카테고리의 모든 도전과제 달성",

        ALLACTIVITY_TITLE = "활동 마스터",
        ALLACTIVITY_DESC = "활동 카테고리의 모든 도전과제 달성",
    },
    COMBAT =
    {
        GENERIC_LABEL = "처치",

        HOUND_TITLE = "사냥개 조련사",
        HOUND_DESC = "사냥개 100마리 처치",

        WORM_TITLE = "지렁이 대재앙",
        WORM_DESC = "동굴 지렁이 100마리 처치",

        PIGMAN_TITLE = "도축장",
        PIGMAN_DESC = "돼지인간 40마리 처치",

        BUNNYMAN_TITLE = "깡총! 깡총!",
        BUNNYMAN_DESC = "토끼인간 40마리 처치",

        KRAMPUS_TITLE = "나쁜 아이, 착한 아이",
        KRAMPUS_DESC = "크람푸스 10마리 처치",

        ROCKY_TITLE = "그냥 돌이 아니라구!",
        ROCKY_DESC = "돌가재 5마리 처치",

        GHOST_TITLE = "유령공포증",
        GHOST_DESC = "보름달 뜬 밤에 유령 처치",

        SHARK_TITLE = "식인 상어",
        SHARK_DESC = "바다 한가운데에서 바위턱상어 처치",

        WALRUSDART_TITLE = "눈에는 눈이라네",
        WALRUSDART_DESC = "맥터스크를 다트로 처치",
    },
    HUNT =
    {
        GENERIC_LABEL = "사냥 완료",

        GENERIC_TITLE = "사냥꾼",
        GENERIC_DESC = "짐승 10마리 사냥",

        GREATHUNTER_TITLE = "명예를 쫓다",
        GREATHUNTER_DESC = "짐승 20마리 사냥",

        KOALEFANTSUMMER_TITLE = "여름날의 사냥",
        KOALEFANTSUMMER_DESC = "코알라판트 사냥",

        KOALEFANTWINTER_TITLE = "밖이 춥구나",
        KOALEFANTWINTER_DESC = "겨울 코알라판트 사냥",

        WARG_TITLE = "큰 멍멍이",
        WARG_DESC = "바르그 사냥",

        SPAT_TITLE = "단조 작업",
        SPAT_DESC = "점액양 사냥",

        LIGHTNINGGOAT_TITLE = "번개 맞은 털",
        LIGHTNINGGOAT_DESC = "번개 염소 사냥",

        PHLEGM_TITLE = "끈적한 곤경",
        PHLEGM_DESC = "다른 사람의 도움을 받아 점액양의 점액 공격 탈출",

        ALLHUNT_TITLE = "사냥 시작!",
        ALLHUNT_DESC = "모든 짐승 사냥",
        ALLHUNT_LABEL = "사냥 성공",
    },
    BOSS =
    {
        GENERIC_LABEL = "처치",

        DEERCLOPS_TITLE = "죽음의 눈길",
        DEERCLOPS_DESC = "외눈사슴 처치",

        MOOSE_TITLE = "바람과 함께 사라지다",
        MOOSE_DESC = "큰사슴거위 처치. 큰거위사슴이 맞나? 뭐지?",

        DRAGONFLY_TITLE = "비행금지구역",
        DRAGONFLY_DESC = "용파리 처치",

        RAGEDRAGONFLY_TITLE = "불꽃 소방대",
        RAGEDRAGONFLY_DESC = "분노한 상태의 용파리 처치",

        MALBATROSS_TITLE = "물새잡이",
        MALBATROSS_DESC = "꽉새치 처치",

        KLAUS_TITLE = "메리 큰일났으마스!",
        KLAUS_DESC = "클로스 처치",

        RAGEKLAUS_TITLE = "죽음이란 선물",
        RAGEKLAUS_DESC = "분노한 클로스 처치",

        SHADOWCHESS_TITLE = "외통수요!",
        SHADOWCHESS_DESC = "그림자 기물 처치",

        MINOTAUR_TITLE = "고대사",
        MINOTAUR_DESC = "고대의 수호자 처치",

        BEARGER_TITLE = "괌전사!",
        BEARGER_DESC = "곰소리 처치",

        BEEQUEEN_TITLE = "내 꿀이 어디 갔지?",
        BEEQUEEN_DESC = "여왕벌 처치",

        ANTLION_TITLE = "개미밥",
        ANTLION_DESC = "개미사자 처치",

        TOADSTOOL_TITLE = "개구리 길 건너기!",
        TOADSTOOL_DESC = "독꺼비버섯 처치",

        MTOADSTOOL_TITLE = "독하다 독해",
        MTOADSTOOL_DESC = "비참해진 독꺼비버섯 처치",
        -- I personally thought this was a good idea, no fun.
        -- TOADSTOOLAXE_TITLE = "Why We Still Here? Just To Suffer?",
        -- TOADSTOOLAXE_DESC = "Defeat a Toadstool with axes.",

        STALKERCAVE_TITLE = "화석이 아니야!",
        STALKERCAVE_DESC = "되살아난 해골 처치",

        STALKERATRIUM_TITLE = "어둠의 구원자",
        STALKERATRIUM_DESC = "고대의 연료직공 처치",

        CRABKING_TITLE = "집게리아",
        CRABKING_DESC = "대게왕 처치",

        SPIDERQUEEN_TITLE = "왕도 살충제 한 방이면",
        SPIDERQUEEN_DESC = "여왕거미 처치",

        LEIF_TITLE = "살아있는 숲",
        LEIF_DESC = "트리가드 처치",

        EYEOFTERROR_TITLE = "지켜보고 있다",
        EYEOFTERROR_DESC = "공포의 눈 처치",

        TWINSOFTERROR_TITLE = "안과의사",
        TWINSOFTERROR_DESC = "공포의 쌍둥이 처치",

        ALTERGUARDIAN_TITLE = "천상의 맹습",
        ALTERGUARDIAN_DESC = "천상의 대변자 처치",

        LORDFRUITFLY_TITLE = "벌레버스터즈",
        LORDFRUITFLY_DESC = "초파리대왕 처치",

        DEERCLOPSYULE_TITLE = "온 세상이 빨개",
        DEERCLOPSYULE_DESC = "겨울 축제 이벤트 동안에 외눈사슴 처치",

        ALLBOSSES_TITLE = "콘스탄트 정복",
        ALLBOSSES_DESC = "모든 거인 처치",
    },
    TIME =
    {
        GENERIC_LABEL = "생존",
        GENERIC_LABEL_PLURAL = "생존",

        FIRSTNIGHT_TITLE = "시작",
        FIRSTNIGHT_DESC = "첫 밤 생존",

        TWENTY_TITLE = "아직 안 죽었다",
        TWENTY_DESC = "20일 연속 생존",

        THIRTYFIVE_TITLE = "아직 살아있다",
        THIRTYFIVE_DESC = "35일 연속 생존",

        FIFTYFIVE_TITLE = "살아남고 만다",
        FIFTYFIVE_DESC = "55일 연속 생존",

        ONEHUNDRED_TITLE = "나는 생존자다",
        ONEHUNDRED_DESC = "100일 연속 생존",

        FIVEHUNDRED_TITLE = "인간 찬가",
        FIVEHUNDRED_DESC = "500일 연속 생존",

        ONETHOUSAND_TITLE = "전설",
        ONETHOUSAND_DESC = "1000일 연속 생존",

        POWCAKE_TITLE = "(대충 클래식 음악)",
        POWCAKE_DESC = "수단 방법이 어찌 됐든 파우더케이크 썩게 하기",
        POWCAKE_LABEL = "썩힘",
    },
    EXPLORATION =
    {
        CAVESBIOME_TITLE = "광산으로!",
        CAVESBIOME_DESC = "동굴에 발을 들임",

        RUINSBIOME_TITLE = "유적털이",
        RUINSBIOME_DESC = "유적에 발을 들임",

        ARCHIVESBIOME_TITLE = "금단의 지식",
        ARCHIVESBIOME_DESC = "기록보관소에 발을 들임",

        DECIDUOUSBIOME_TITLE = "분노의 버치넛",
        DECIDUOUSBIOME_DESC = "낙엽수림에 발을 들임",

        MOSAICBIOME_TITLE = "돌 굴러가유",
        MOSAICBIOME_DESC = "모자이크 지형에 발을 들임",

        SWAMPBIOME_TITLE = "촉수와 모기!",
        SWAMPBIOME_DESC = "늪지대에 발을 들임",

        MUSHROOMBIOME_TITLE = "버섯왕국",
        MUSHROOMBIOME_DESC = "버섯 숲에 발을 들임",

        MOONMUSHBIOME_TITLE = "달밤의 버섯밭",
        MOONMUSHBIOME_DESC = "달 동굴에 발을 들임",

        ALLMUSHBIOME_TITLE = "버섯 탐험가",
        ALLMUSHBIOME_DESC = "버섯 숲 세 곳에 발을 들임",
        ALLMUSHBIOME_LABEL = "탐험 완료",

        LUNARBIOME_TITLE = "달에 가고 싶어요",
        LUNARBIOME_DESC = "달섬에 발을 들임",

        HERMITBIOME_TITLE = "외로운 게",
        HERMITBIOME_DESC = "은둔자의 섬에 발을 들임",

        OASISBIOME_TITLE = "우린 예전에 다 끝났어",
        OASISBIOME_DESC = "사막 한가운데의 수상한 호숫가에 발을 들임",

        MONKEYBIOME_TITLE = "원숭이들의 낙원",
        MONKEYBIOME_DESC = "월숭이 섬에 발을 들임",

        WATERLOGBIOME_TITLE = "떠 다니는 나무",
        WATERLOGBIOME_DESC = "바다 한가운데의 숲에 발을 들임",

        ATRIUMBIOME_TITLE = "저 너머엔 무엇이?",
        ATRIUMBIOME_DESC = "아트리움에 발을 들임",
    },
    FARMING =
    {
        SOWALL_TITLE = "파종기",
        SOWALL_DESC = "모든 종류의 씨앗 심음",
        SOWALL_LABEL = "파종 완료",

        FERTILIZERALL_TITLE = "냄새 확실하네!",
        FERTILIZERALL_DESC = "모든 종류의 거름 사용",
        FERTILIZERALL_LABEL = "사용 완료",

        GROWCROP_TITLE = "식물 돌보미",
        GROWCROP_DESC = "작물 길러내기",

        GROWGIANTCROP_TITLE = "뿌린 대로 거두리라",
        GROWGIANTCROP_DESC = "거대 작물 길러내기",

        KILLWEED_TITLE = "악의 정원",
        KILLWEED_DESC = "잡초의 힘 체험",

        TILLING_TITLE = "많지는 않지만...",
        TILLING_DESC = "200회 괭이질",
        TILLING_LABEL = "회",
        TILLING_LABEL_PLURAL = "회",

        TILLING2_TITLE = "정직한 일꾼",
        TILLING2_DESC = "400회 괭이질",

        ROTCROP_TITLE = "난 식물이 싫어",
        ROTCROP_DESC = "썩은 거대 작물 10개 망치질",
    },
    SOCIAL =
    {
        FIRSTDEATH_TITLE = "굶하!",
        FIRSTDEATH_DESC = "처음으로 죽음",

        TENDEATH_TITLE = "또야?!?!",
        TENDEATH_DESC = "10번 죽음",

        SIXPLAYERS_TITLE = "뭉치면 살고 흩어지면 죽는다!",
        SIXPLAYERS_DESC = "한 월드에 6명의 플레이어 동시 접속",

        SAMECHARACTER_TITLE = "셋은 많다",
        SAMECHARACTER_DESC = "한 월드에 3명 이상의 똑같은 생존자가 동시 존재",

        SOAKPLAYER_TITLE = "여름방학",
        SOAKPLAYER_DESC = "물풍선으로 플레이어 10번 적심",

        GIVEPLAYER_TITLE = "혼자 가기에는 위험하단다!",
        GIVEPLAYER_DESC = "정착지를 만든 뒤 새 플레이어에게 자원 나눠주기",

        BOSSFRIEND_TITLE = "팀워크는 환상이다",
        BOSSFRIEND_DESC = "다른 플레이어의 도움 없이 보스 처치",

        REVIVEPLAYER_TITLE = "마음을 담아서",
        REVIVEPLAYER_DESC = "플레이어를 부활시킴",

        EQUIPALL_TITLE = "깔맞춤",
        EQUIPALL_DESC = "갑옷, 모자, 도구를 동시에 장착",

        KILLPLAYER_TITLE = "못됐어 진짜!",
        KILLPLAYER_DESC = "다른 플레이어 처치",

        SLEEPPLAYER_TITLE = "소리나는 풀",
        SLEEPPLAYER_DESC = "맨드레이크로 다른 플레이어 재움",

        DOEMOTE_TITLE = "자신을 표현하라",
        DOEMOTE_DESC = "감정표현으로 모두에게 진심 표출",

        LITFLARE_TITLE = "하늘 위의 불빛",
        LITFLARE_DESC = "조명탄으로 모두에게 현재 위치 안내",

        HOLDCOMPASS_TITLE = "용감한 탐험가",
        HOLDCOMPASS_DESC = "나침반으로 다른 사람과 위치 공유",
    },
    CHARACTER =
    {
        WILSON1_TITLE = "수염 괴물",
        WILSON1_DESC = "윌슨으로 20일 이상 수염 깎지 말기",
        WILSON2_TITLE = "매끈매끈",
        WILSON2_DESC = "윌슨으로 수염 없이 겨울나기",

        WILLOW1_TITLE = "난연성",
        WILLOW1_DESC = "윌로우로 라이터를 이용해 음식 40개 요리",
        WILLOW1_LABEL = "요리",
        WILLOW2_TITLE = "뜨끈하네",
        WILLOW2_DESC = "윌로우로 1분 동안 몸에 불 붙은 채로 있기",

        WOLFGANG1_TITLE = "나는 강하다!",
        WOLFGANG1_DESC = "볼프강으로 울끈불끈 체육관에서 강인함 최대로 채우기",
        WOLFGANG2_TITLE = "피골상접",
        WOLFGANG2_DESC = "볼프강으로 약골 상태에서 적 40마리 처치",
        WOLFGANG2_LABEL = "처치",

        WENDY1_TITLE = "웬디를 만난 캐스퍼",
        WENDY1_DESC = "웬디로 핍스푹 20마리 돕기",
        WENDY1_LABEL = "도움",
        WENDY2_TITLE = "전장의 자매들",
        WENDY2_DESC = "웬디로 아비게일의 도움을 받아 적 40마리 처치",
        WENDY2_LABEL = "처치",

        WX781_TITLE = "작동 개시",
        WX781_DESC = "WX-78로 모든 스캔 가능한 생물 스캔",
        WX781_LABEL = "스캔 완료",
        WX782_TITLE = "살아있다!!!",
        WX782_DESC = "WX-78로 망가진 시계태엽 룩 수리",

        WICKERBOTTOM1_TITLE = "책벌레",
        WICKERBOTTOM1_DESC = "위커바텀으로 책 40회 읽기",
        WICKERBOTTOM1_LABEL = "읽음",
        WICKERBOTTOM2_TITLE = "지식이 곧 힘이다!",
        WICKERBOTTOM2_DESC = "위커바텀으로 모든 책 개발",
        WICKERBOTTOM2_LABEL = "개발",

        -- I'll miss this one so much...
        -- WICKERBOTTOM2_TITLE = "It's Bedtime",
        -- WICKERBOTTOM2_DESC = "As Wickerbottom, fall asleep.",

        WOODIE1_TITLE = "환경운동가",
        WOODIE1_DESC = "우디로 비버인간 상태에서 나무 500그루 벌목",
        WOODIE1_LABEL = "벌목",
        WOODIE2_TITLE = "라운드 1, 시작!",
        WOODIE2_DESC = "우디로 사슴인간 상태에서 적 40마리 처치",
        WOODIE2_LABEL = "처치",

        WAXWELL1_TITLE = "인형사",
        WAXWELL1_DESC = "맥스웰로 그림자 투사를 이용해 적 40마리 처치",
        WAXWELL1_LABEL = "처치",
        WAXWELL2_TITLE = "그림자 대소동",
        WAXWELL2_DESC = "맥스웰로 3분 동안 광기 상태 유지",

        WES1_TITLE = "풍선당했다!",
        WES1_DESC = "웨스로 풍선에 의해 사망",
        WES2_TITLE = "삐걱대는 부츠",
        WES2_DESC = "웨스로 지진에 의해 사망",

        WATHGRITHR1_TITLE = "발할라의 전사",
        WATHGRITHR1_DESC = "위그프리드로 보스 20마리 처치",
        WATHGRITHR1_LABEL = "처치",
        WATHGRITHR2_TITLE = "브륀힐데의 함성",
        WATHGRITHR2_DESC = "위그프리드로 전투 중에 최소 3종류의 노래 사용",

        WEBBER1_TITLE = "위험한 가족",
        WEBBER1_DESC = "웨버로 거미를 이용해 여왕거미 처치",
        WEBBER2_TITLE = "털북숭이 친구들",
        WEBBER2_DESC = "웨버로 모든 거미들과 친구 되기",
        WEBBER2_LABEL = "Befriended",

        WINONA1_TITLE = "만능 테이프!",
        WINONA1_DESC = "위노나로 테이프를 사용해 40회 수리",
        WINONA2_TITLE = "움직임이 뻔해!",
        WINONA2_DESC = "위노나로 찰리의 공격 5회 회피",

        WORTOX1_TITLE = "이것도 피해보시지!",
        WORTOX1_DESC = "워톡스로 순간이동을 사용해 공격 회피",
        WORTOX2_TITLE = "의사양반!",
        WORTOX2_DESC = "워톡스로 플레이어의 체력 1000 회복",

        WORMWOOD1_TITLE = "평온의 오라",
        WORMWOOD1_DESC = "웜우드로 만개 상태에서 작물 100개 돌봄",
        WORMWOOD2_TITLE = "이제는 봄",
        WORMWOOD2_DESC = "웜우드로 봄에 만개 상태 되기",

        WARLY1_TITLE = "끝내주는 맛",
        WARLY1_DESC = "왈리로 모든 요리 맛보기",
        WARLY1_LABEL = "먹음",
        WARLY2_TITLE = "셰프의 시간",
        WARLY2_DESC = "왈리로 모든 전용 요리 조리",
        WARLY2_LABEL = "요리",

        WURT1_TITLE = "옛날 옛적에...",
        WURT1_DESC = "워트로 모든 동화책 읽기",
        WURT1_LABEL = "읽음",
        WURT2_TITLE = "아옳서 왕?",
        WURT2_DESC = "워트로 어인이 어인왕으로 즉위하는 모습 보기",

        WALTER1_TITLE = "헤드샷!",
        WALTER1_DESC = "월터로 믿음직한 새총을 이용해 적 40마리 처치",
        WALTER2_TITLE = "최고의 친구",
        WALTER2_DESC = "월터로 워비에게 짐 싣기",

        WANDA1_TITLE = "박자가 꼬였네",
        WANDA1_DESC = "완다로 불로의 시계를 이용해 치명적인 일격 무마",
        WANDA2_TITLE = "시간을 거스르는 자",
        WANDA2_DESC = "완다로 노년 상태에서 깜짝시계를 이용해 적 40마리 처치",

        WONKEY1_TITLE = "나나! 나나!",
        WONKEY1_DESC = "우끼끼로 바나나 40개 섭취",
        WONKEY2_TITLE = "잭 도주기",
        WONKEY2_DESC = "우끼끼로 해적 반다나와 커틀리스를 장착하고 1분간 달리기",
    },
    ACTIVITY =
    {
        HERMITQUEST_TITLE = "슈퍼 도우미!",
        HERMITQUEST_DESC = "모든 방법으로 게팍한 은둔자를 도우세요.",

        COOKBOOK_TITLE = "헬스 키친",
        COOKBOOK_DESC = "모든 종류의 음식 조리",
        COOKBOOK_LABEL = "요리 완료",

        FAILEDDISH_TITLE = "요리솥 최악의 날",
        FAILEDDISH_DESC = "요리를 10번 망침",

        CATCHFISH_TITLE = "강태공",
        CATCHFISH_DESC = "모든 종류의 물고기 낚음",
        CATCHFISH_LABEL = "Caught",

        FASTFISH_TITLE = "분노의 낚시",
        FASTFISH_DESC = "찌 던지고 30초 안에 물고기 낚음",
        FASTFISH_LABEL = "Second",
        FASTFISH_LABEL_PLURAL = "Seconds",

        ALLWEAPON_TITLE = "전쟁광",
        ALLWEAPON_DESC = "모든 종류의 무기 장착",
        ALLWEAPON_LABEL = "장착",

        PIGKINGMG_TITLE = "안-돼지 도전자",
        PIGKINGMG_DESC = "돼지왕의 미니게임 승리",

        CRITTER_TITLE = "충직한 반려",
        CRITTER_DESC = "북슬북슬 귀여운 동물친구 입양.",

        BEECROWN_TITLE = "즈언하!",
        BEECROWN_DESC = "여왕벌 왕관을 쓰고 다른 플레이어의 절 받기",

        BONEHELM_TITLE = "광기잇!",
        BONEHELM_DESC = "뼈 투구 장착",

        EYEBRELLA_TITLE = "하늘을 보는 눈!",
        EYEBRELLA_DESC = "눈우산 장착",

        RUINSHAT_TITLE = "나는 귀족이다",
        RUINSHAT_DESC = "툴레사이트 갑옷과 툴레사이트 왕관을 동시에 착용",

        FOODKILL_TITLE = "정크푸드",
        FOODKILL_DESC = "음식을 먹어서 사망",

        STARVATION_TITLE = "굶지마",
        STARVATION_DESC = "굶어서 죽음",

        WINTERHEAT_TITLE = "너무 더워!",
        WINTERHEAT_DESC = "겨울에 열사병으로 사망",

        SUMMERFREEZE_TITLE = "적당히 좀!",
        SUMMERFREEZE_DESC = "여름에 저체온증으로 사망",

        GRIMGALETTE_TITLE = "장의사",
        GRIMGALETTE_DESC = "음침한 갈레트를 먹고 사망",

        ORANGESTAFF_TITLE = "하나, 둘, 셋, 얍!",
        ORANGESTAFF_DESC = "게으른 탐험가로 순간도약",

        GREENAMULET_TITLE = "반값 세일!",
        GREENAMULET_DESC = "건설의 부적을 사용하여 아이템 제작",

        ALCHEMY_TITLE = "과학의 주인",
        ALCHEMY_DESC = "연금술 엔진 건설",

        PRESTIHATI_TITLE = "해트트릭",
        PRESTIHATI_DESC = "요술모자 장치 건설",

        SMANIPULATOR_TITLE = "그림자의 주인",
        SMANIPULATOR_DESC = "그림자 조작기 건설",

        PIGKING_TITLE = "금빛 줄기",
        PIGKING_DESC = "돼지왕과 파격적인 조건에 거래",

        PLANTFLOWER_TITLE = "정말 멋진 날이야",
        PLANTFLOWER_DESC = "꽃 심기. 아구 귀여워라.",

        PIGFOLLOWER_TITLE = "돼지우리",
        PIGFOLLOWER_DESC = "돼지 추종자 6마리를 동시에 보유. 아고 붐벼라!",

        BUNNYFOLLOWER_TITLE = "북슬북슬 친구들",
        BUNNYFOLLOWER_DESC = "토끼인간 추종자 6마리를 동시에 보유. 혼란하다, 혼란해!",

        LOBSTERFOLLOWER_TITLE = "터프가이 모임",
        LOBSTERFOLLOWER_DESC = "돌가재 추종자 4마리를 동시에 보유. 꼬집꼬집!",

        SMALLBIRD_TITLE = "네 엄마 아니거든",
        SMALLBIRD_DESC = "키다리새가 엄마가 되는 경이로운 광경을 목격",

        ARCHIVESPOWER_TITLE = "불 좀 켜 줄래?",
        ARCHIVESPOWER_DESC = "기록보관소의 전원 켜기",

        SOOTHTREE_TITLE = "나무와의 대화",
        SOOTHTREE_DESC = "화난 트리가드를 진정시키기",

        BIGTENTACLE_TITLE = "촉수특급",
        BIGTENTACLE_DESC = "전혀 멋지지 못한 방법으로 이동",

        WORMHOLE_TITLE = "벌레의 길을 따라",
        WORMHOLE_DESC = "징그러운 구멍 속으로 뛰어들기",

        TURTLE_TITLE = "거북이 거북하다!",
        TURTLE_DESC = "스너틀 껍데기와 껍데기 투구를 동시에 장착",

        DBEEFALO_TITLE = "끝없는 식욕의 짐승",
        DBEEFALO_DESC = "야생 비팔로 길들이기",

        PANDORASCHEST_TITLE = "엄청난 보물!",
        PANDORASCHEST_DESC = "유적의 미궁 속에 있는 상자 열기",

        POTATOCUP_TITLE = "그 이름하여...",
        POTATOCUP_DESC = "전설의 감자 컵 획득",

        EYETURRET_TITLE = "뚫리지 않는 방패",
        EYETURRET_DESC = "하운디우스 슈티우스 건설",

        ONEHP_TITLE = "아깝기는 무슨!",
        ONEHP_DESC = "공격을 맞고 체력 1만 남기고 생존",

        BEEBOX_TITLE = "바쁜 벌꿀",
        BEEBOX_DESC = "가득 찬 벌통에서 달콤하디 달콤한 꿀 수확",

        OPALSTAFF_TITLE = "달에 타락하다",
        OPALSTAFF_DESC = "지팡이에 달의 힘이 내리는 광경을 목격",

        CHESTER_TITLE = "변화 인자",
        CHESTER_DESC = "보름달에 체스터를 변신시키기",

        HUTCH_TITLE = "주크박스",
        HUTCH_DESC = "허치를 걸어다니는 음악상자로 변신시키기",

        SLURPER_TITLE = "생체 모자",
        SLURPER_DESC = "슬러퍼를 동굴에서 지상까지 이동",

        SEWITEM_TITLE = "신속과 골무",
        SEWITEM_DESC = "가공할 바느질 기술 선보이기",

        GLOMMER_TITLE = "브즈즈즓!",
        GLOMMER_DESC = "보름달 뜬 밤에 글로머의 꽃 발견",

        KRAMPUS_TITLE = "넌 나쁜 아이로군",
        KRAMPUS_DESC = "크람푸스 소환",

        LUNARPOTION_TITLE = "달 실험",
        LUNARPOTION_DESC = "우러난 달의 정수로 아무 거나 변이 성공",

        PURPLESTAFF_TITLE = "공간을 넘어",
        PURPLESTAFF_DESC = "순간이동 지팡이로 순간이동",

        ROSEFLOWER_TITLE = "따가워라",
        ROSEFLOWER_DESC = "꽃을 꺾다가 가시에 찔리기",

        WEREPIG_TITLE = "변신술사",
        WEREPIG_DESC = "돼지인간의 진정한 모습 발견하기",

        TUMBLEWEED_TITLE = "석양이 진다",
        TUMBLEWEED_DESC = "회전초 20개 채취",

        LIGHTNING_TITLE = "토르의 분노",
        LIGHTNING_DESC = "번개 맞기.",

        SHAVEBEEFALO_TITLE = "이발사",
        SHAVEBEEFALO_DESC = "불쌍한 동물에게 가공할 이발 솜씨 보여주기",

        KRAMPUSSACK_TITLE = "운수 좋은 날!",
        KRAMPUSSACK_DESC = "크람푸스 가방 획득. 운수 좋고!",

        ALLRELIC_TITLE = "유물 수집가",
        ALLRELIC_DESC = "모든 획득 가능한 유적 유물 청사진 획득",
        ALLRELIC_LABEL = "배움",

        LIVINGLOG_TITLE = "비명이 울린다",
        LIVINGLOG_DESC = "생목에 감춰진 비밀 발견",
    },
}
}