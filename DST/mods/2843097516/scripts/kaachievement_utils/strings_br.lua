return { -- Translation Credit: Kyno
ACCOMPLISHMENTS =
{
    UI =
    {
        TITLE = "Conquistas",
        PLAYER_VIEW_TITLE = "Conquistas de {name}",
        ACHIEVEMENT_VIEW_TITLE = "Ver Conquistas de {name}",
        DESC = "Uma revisão de suas realizações",
        UNLOCKED = "Conquista Desbloqueada!",
        TITLE_MISSING = "Título Não Encontrado",
        DESC_MISSING = "Descrição não encontrada.",
        TITLE_HIDDEN = "Conquista Oculta",
        DESC_HIDDEN = "Esta conquista anda está para ser revelada.",
        FINISHED_TIME = "Dia %s",
        FINISHED_TIME_UNKNOWN = "Dia Desconhecido",
        FINISHED_IRL_TIME_FMT = "%X %x",  -- https://www.lua.org/pil/22.1.html
        FINISHED_IRL_TIME_UNKNOWN = "Data Desconhecida",
        ACHIEVEMENT_BUTTON = "Ver Conquistas",
        FILTER_BUTTON_ALL = "Mostrar Tudo",
        SETTINGS_BUTTON = "Configurações",
        PROGRESS_FMT = "{num} de {max}",
        ANNOUNCE_TROPHY_FMT = "{who} acaba de conquistar: ",
        PANEL =
        {
            DELETE = "Deletar seu Progresso",
        },
        PANEL_SETTING =
        {
            SHOW_TIME = "Ver Conclusão",
            SHOW_TIME_HOVER = "Mostrar tempo concluído",

            SHOW_COUNTER = "Ver Progresso",
            SHOW_COUNTER_HOVER = "Mostrar progresso de conquista",

            ANNOUNEC_TROPHY = "Anunciar Conquista",
            ANNOUNEC_TROPHY_HOVER = "Anunciar conquista no bate-papo",

            DELETE = "Resetar Progresso",
            DELETE_HOVER = "Resetar progresso das conquistas",
            DELETE_TITLE = "Resetar?",
            DELETE_DESC = "Você tem certeza que quer resetar suas conquistas?\n(Essa ação não pode ser desfeita.)",

            LANG = "Selecionar Linguagem",
            HOTKEY = "Vincular Atalho",
            HOTKEY_NONE = "Desvincular",
        },
        CLUSTER_PANEL =
        {
            DELETE = "Deletar",
            DELETE_TITLE = "Deletar?",
            DELETE_DESC = "Você tem certeza que quer deletar seus dados?\n(Isso irá notificar o sistema para resetar seus dados\nna próxima vez que entrar no servidor.)",
            EMPTY = "Você não possui conquistas ainda.",
        },
        SERVER_LIST =
        {
            SERVERNAME_MISSING = "Servidor Desconhecido",
            DESC_FMT = "Última vez atualizado: %X %x",  -- https://www.lua.org/pil/22.1.html
        },
        CATEGORY =
        {
            MASTERY = "Maestria",
            COMBAT = "Combate",
            HUNT = "Caça",
            BOSS = "Gigantes",
            TIME = "Tempo",
            EXPLORATION = "Exploração",
            FARMING = "Agricultura",
            SOCIAL = "Social",
            CHARACTER = "Sobrevivente",
            ACTIVITY = "Atividade",
            MOD = "Outros",
        },
        SORT =
        {
            DEFAULT = "Filtrar: Padrão",
            ALPHABETICALLY = "Filtrar: Alfabeticamente",
            UNLOCKED_LOCKED = "Filtrar: Desbloqueado/Bloqueado",
            LOCKED_UNLOCKED = "Filtrar: Bloqueado/Desbloqueado",
        },
    },
    MASTERY =
    {
        GENERIC_LABEL = "Conquistado",

        ALLTROPHY_TITLE = "Desafiador de Probabilidades",
        ALLTROPHY_DESC = "Consiga todas as conquistas. Parabéns!",

        ALLCOMBAT_TITLE = "Guerreiro Invencível",
        ALLCOMBAT_DESC = "Consiga todas as conquistas da categoria Combate.",

        ALLHUNT_TITLE = "Caçador Profissional",
        ALLHUNT_DESC = "Consiga todas as conquistas da categoria Caça.",

        ALLBOSS_TITLE = "Destruidor de Mundos",
        ALLBOSS_DESC = "Consiga todas as conquistas da categoria Gigntes.",

        ALLTIME_TITLE = "Tempo É Uma Prisão",
        ALLTIME_DESC = "Consiga todas as conquistas da categoria Tempo.",

        ALLEXPLORATION_TITLE = "Verdadeiro Explorador",
        ALLEXPLORATION_DESC = "Consiga todas as conquistas da categoria Exploração.",

        ALLFARMING_TITLE = "Sente e Relaxe",
        ALLFARMING_DESC = "Consiga todas as conquistas da categoria Agricultura.",

        ALLSOCIAL_TITLE = "Celebridade Social",
        ALLSOCIAL_DESC = "Consiga todas as conquistas da categoria Social.",

        ALLCHARACTER_TITLE = "Polivalente",
        ALLCHARACTER_DESC = "Consiga todas as conquistas da categoria Sobrevivente",

        ALLACTIVITY_TITLE = "Mestre de Atividades",
        ALLACTIVITY_DESC = "Consiga todas as conquistas da categoria Atividade.",
    },
    COMBAT =
    {
        GENERIC_LABEL = "Derrotado",

        HOUND_TITLE = "Mestre das Feras",
        HOUND_DESC = "Derrote um total de 100 Hounds.",

        WORM_TITLE = "Armageddon de Minhocas",
        WORM_DESC = "Derrote um total de 100 Depth Worms.",

        PIGMAN_TITLE = "Abatedouro",
        PIGMAN_DESC = "Derrote um total de 40 Pig Men.",

        BUNNYMAN_TITLE = "Hop! Hop! Hop!",
        BUNNYMAN_DESC = "Derrote um total de 40 Bunnymen.",

        KRAMPUS_TITLE = "Perverso e Bom",
        KRAMPUS_DESC = "Derrote um total de 10 Krampii.",

        ROCKY_TITLE = "Não É Uma Rocha!",
        ROCKY_DESC = "Derrote um total de 5 Rock Lobsters.",

        GHOST_TITLE = "Phasmophobia",
        GHOST_DESC = "Derrote um Ghost durante uma noite de Lua Cheia.",

        SHARK_TITLE = "Comedor de Homens",
        SHARK_DESC = "Derrote um Rockjaw no meio do vasto oceano.",

        WALRUSDART_TITLE = "De Volta Para Você, Amigo",
        WALRUSDART_DESC = "Derrote um Mac Tusk usando um Blow Dart.",
    },
    HUNT =
    {
        GENERIC_LABEL = "Caçado",

        GENERIC_TITLE = "Caçador",
        GENERIC_DESC = "Cace um total de 10 Bestas.",

        GREATHUNTER_TITLE = "Caçador Orgulhoso",
        GREATHUNTER_DESC = "Cace um total de 20 Bestas.",

        KOALEFANTSUMMER_TITLE = "Caça de Veraão",
        KOALEFANTSUMMER_DESC = "Cace um Koalefant.",

        KOALEFANTWINTER_TITLE = "Está Frio Lá Fora",
        KOALEFANTWINTER_DESC = "Cace um Winter Koalefant.",

        WARG_TITLE = "Filhote Grande",
        WARG_DESC = "Cace um Varg.",

        SPAT_TITLE = "Aço Temperado",
        SPAT_DESC = "Cace uma Ewecus.",

        LIGHTNINGGOAT_TITLE = "Relâmpago Impetuoso",
        LIGHTNINGGOAT_DESC = "Cace uma Volt Goat.",

        PHLEGM_TITLE = "Situação Pegajosa",
        PHLEGM_DESC = "Livre-se do muco da Ewecus com a assistência de algúem.",

        ALLHUNT_TITLE = "A Caçada Começou!",
        ALLHUNT_DESC = "Cace todas as Bestas possíveis.",
        ALLHUNT_LABEL = "Caçado",
    },
    BOSS =
    {
        GENERIC_LABEL = "Derrotado",

        DEERCLOPS_TITLE = "Percepção de Morte",
        DEERCLOPS_DESC = "Derrote um Deerclops.",

        MOOSE_TITLE = "Para o Sul",
        MOOSE_DESC = "Derrote um Moose. Ou um Goose. Ou ambos?",

        DRAGONFLY_TITLE = "Exclusão Aérea",
        DRAGONFLY_DESC = "Derrote um Dragonfly",

        RAGEDRAGONFLY_TITLE = "Bombeiro",
        RAGEDRAGONFLY_DESC = "Derrote um Dragonfly enquanto estiver enfurecido.",

        MALBATROSS_TITLE = "Caça Aquática",
        MALBATROSS_DESC = "Derrote um Malbatross.",

        KLAUS_TITLE = "Feliz Desgraça!",
        KLAUS_DESC = "Derrote um Klaus",

        RAGEKLAUS_TITLE = "Presenteado Para Morte",
        RAGEKLAUS_DESC = "Derrote um Klaus enfurecido.",

        SHADOWCHESS_TITLE = "Checkmate!",
        SHADOWCHESS_DESC = "Derrote as Shadow Pieces.",

        MINOTAUR_TITLE = "História Anciã",
        MINOTAUR_DESC = "Derrote o Ancient Guardian.",

        BEARGER_TITLE = "BEARserker!",
        BEARGER_DESC = "Derrote um Bearger.",

        BEEQUEEN_TITLE = "Cade Meu Mel?",
        BEEQUEEN_DESC = "Derrote uma Bee Queen.",

        ANTLION_TITLE = "Comida de Minhoca",
        ANTLION_DESC = "Derrote um Antlion.",

        TOADSTOOL_TITLE = "Froggers!",
        TOADSTOOL_DESC = "Derrote um Toadstool.",

        MTOADSTOOL_TITLE = "Toxicidade Extrema",
        MTOADSTOOL_DESC = "Derrote um Misery Toadstool.",
        -- I personally thought this was a good idea, no fun.
        -- TOADSTOOLAXE_TITLE = "Why We Still Here? Just To Suffer?",
        -- TOADSTOOLAXE_DESC = "Defeat a Toadstool with axes.",

        STALKERCAVE_TITLE = "Não É Um Fóssil!",
        STALKERCAVE_DESC = "Derrote um Reanimated Skeleton.",

        STALKERATRIUM_TITLE = "Redentor das Trevas",
        STALKERATRIUM_DESC = "Derrote o Ancient Fuelweaver.",

        CRABKING_TITLE = "Siri Cascudo",
        CRABKING_DESC = "Derrote o Crab King",

        SPIDERQUEEN_TITLE = "Inseticida Regicida",
        SPIDERQUEEN_DESC = "Derrote uma Spider Queen.",

        LEIF_TITLE = "Floresta Viva",
        LEIF_DESC = "Derrote um Treeguard.",

        EYEOFTERROR_TITLE = "De Olho Em Você",
        EYEOFTERROR_DESC = "Derrote o Eye of Terror.",

        TWINSOFTERROR_TITLE = "Oftamologista",
        TWINSOFTERROR_DESC = "Derrote os Twins of Terror.",

        ALTERGUARDIAN_TITLE = "Massacre Celestial",
        ALTERGUARDIAN_DESC = "Derrote o Celestial Champion.",

        LORDFRUITFLY_TITLE = "Caça-Insetos",
        LORDFRUITFLY_DESC = "Derrote o Lord of the Fruit Flies.",

        DEERCLOPSYULE_TITLE = "Eu Vejo Em Vermelho",
        DEERCLOPSYULE_DESC = "Derrote um Deerclops durante o evento Winter's Feast.",

        ALLBOSSES_TITLE = "Conquistador do The Constant",
        ALLBOSSES_DESC = "Derrote todos os Gigantes.",
    },
    TIME =
    {
        GENERIC_LABEL = "Dia",
        GENERIC_LABEL_PLURAL = "Dias",

        FIRSTNIGHT_TITLE = "O Começo",
        FIRSTNIGHT_DESC = "Sobreviva sua primeira noite.",

        TWENTY_TITLE = "Ainda Não Estou Morto",
        TWENTY_DESC = "Sobreviva 20 dias consecutivos.",

        THIRTYFIVE_TITLE = "Se Mantendo Vivo",
        THIRTYFIVE_DESC = "Sobreviva 35 dias consecutivos.",

        FIFTYFIVE_TITLE = "Eu Vou Sobreviver",
        FIFTYFIVE_DESC = "Sobreviva 55 dias consecutivos.",

        ONEHUNDRED_TITLE = "Sobrevivente Nato",
        ONEHUNDRED_DESC = "Sobreviva 100 dias consecutivos.",

        FIVEHUNDRED_TITLE = "Entusiasta",
        FIVEHUNDRED_DESC = "Sobreviva 500 dias consecutivos.",

        ONETHOUSAND_TITLE = "Lenda",
        ONETHOUSAND_DESC = "Sobreviva 1000 dias consecutivos.",

        POWCAKE_TITLE = "* Música de Elevador *",
        POWCAKE_DESC = "Apodreça um Powdercake, com ou sem assistência.",
        POWCAKE_LABEL = "Apodrecido",
    },
    EXPLORATION =
    {
        CAVESBIOME_TITLE = "Para As Minas!",
        CAVESBIOME_DESC = "Vá para as Cavernas pela primeira vez.",

        RUINSBIOME_TITLE = "Corsário de Ruínas",
        RUINSBIOME_DESC = "Invada as Ruins pela primeira vez.",

        ARCHIVESBIOME_TITLE = "Conhecimento Proíbido",
        ARCHIVESBIOME_DESC = "Invada os Archives pela primeira vez.",

        DECIDUOUSBIOME_TITLE = "Birchnutter",
        DECIDUOUSBIOME_DESC = "Descubra a Deciduous Florest pela primeira vez.",

        MOSAICBIOME_TITLE = "Rocks n' Rolls",
        MOSAICBIOME_DESC = "Descubra o Mosaic pela primeira vez.",

        SWAMPBIOME_TITLE = "Tentáculos and Mosquitos!",
        SWAMPBIOME_DESC = "Descubra o Swamp pela primeira vez.",

        MUSHROOMBIOME_TITLE = "Reino Cogumelo",
        MUSHROOMBIOME_DESC = "Descubra uma Mushroom Forest pela primeira vez.",

        MOONMUSHBIOME_TITLE = "Cogumelos Moonshine",
        MOONMUSHBIOME_DESC = "Descubra o Lunar Grotto pela primeira vez.",

        ALLMUSHBIOME_TITLE = "Explorador Cogumelístico",
        ALLMUSHBIOME_DESC = "Descubra as três Msuhroom Forests.",
        ALLMUSHBIOME_LABEL = "Descoberto",

        LUNARBIOME_TITLE = "Fly Me To The Moon",
        LUNARBIOME_DESC = "Descubra a Lunar Island pela primeira vez.",

        HERMITBIOME_TITLE = "Carangueijo Solitário",
        HERMITBIOME_DESC = "Descubra a Hermit's Island pela primeira vez.",

        OASISBIOME_TITLE = "Wonderwall",
        OASISBIOME_DESC = "Encontra um misterioso lago no meio de um deserto.",

        MONKEYBIOME_TITLE = "Paraíso de Macacos",
        MONKEYBIOME_DESC = "Invada a Moon Quay Island pela primeira vez.",

        WATERLOGBIOME_TITLE = "Floresta à Deriva",
        WATERLOGBIOME_DESC = "Encontre uma floresta à deriva no meio do vasto oceano.",

        ATRIUMBIOME_TITLE = "O Que Há Além?",
        ATRIUMBIOME_DESC = "Invada o Atrium pela primeira vez.",
    },
    FARMING =
    {
        SOWALL_TITLE = "Máquina Semeadora",
        SOWALL_DESC = "Semeia todos os tipos de Sementes.",
        SOWALL_LABEL = "Plantado",

        FERTILIZERALL_TITLE = "Isso Fede!",
        FERTILIZERALL_DESC = "Utilize todos os tipos de Fertilizante.",
        FERTILIZERALL_LABEL = "Utilizado",

        GROWCROP_TITLE = "Zelador de Plantas",
        GROWCROP_DESC = "Cresca uma Safra.",

        GROWGIANTCROP_TITLE = "Colha O Que Planta",
        GROWGIANTCROP_DESC = "Cresca uma Safra Gigante.",

        KILLWEED_TITLE = "Jardim Maligno",
        KILLWEED_DESC = "Testemunhe a força de uma Erva Daninha.",

        TILLING_TITLE = "Não É Muito Mas...",
        TILLING_DESC = "Are um total de 200 vezes.",
        TILLING_LABEL = "Vez",
        TILLING_LABEL_PLURAL = "Vezes",

        TILLING2_TITLE = "É Trabalho Honesto",
        TILLING2_DESC = "Are um total de 400 vezes.",

        ROTCROP_TITLE = "Eu Odeio Plantas",
        ROTCROP_DESC = "Esmague 10 Safras Gigantes estragadas.",
    },
    SOCIAL =
    {
        FIRSTDEATH_TITLE = "Bem-vindo!",
        FIRSTDEATH_DESC = "Morra pela primeira vez.",

        TENDEATH_TITLE = "Novamente?!?!",
        TENDEATH_DESC = "Morra pela 10º vez.",

        SIXPLAYERS_TITLE = "Jogamos Juntos, Morremos Juntos!",
        SIXPLAYERS_DESC = "Jogue em um mundo com 6 Jogadores simultâneos.",

        SAMECHARACTER_TITLE = "Dois É Bom, Três é Demais",
        SAMECHARACTER_DESC = "Tenha pelo menos 3 do mesmo sobrevivente no mundo.",

        SOAKPLAYER_TITLE = "Férias de Verão",
        SOAKPLAYER_DESC = "Molhe um Jogador um total de 10 vezes com Water Balloon.",

        GIVEPLAYER_TITLE = "É Perigoso Ir Sozinho!",
        GIVEPLAYER_DESC = "Dê recursos à outro Jogador depois de ter se estabelecido.",

        BOSSFRIEND_TITLE = "Trabalho Em Equipe É Tudo",
        BOSSFRIEND_DESC = "Derrote um Gigante com outro Jogador.",

        REVIVEPLAYER_TITLE = "Segunda Chance",
        REVIVEPLAYER_DESC = "Traga um Jogador de volta dos mortos.",

        EQUIPALL_TITLE = "Totalmente Trajado",
        EQUIPALL_DESC = "Equipe uma Armadura, um Chápeu e um Item de mão, ao mesmo tempo.",

        KILLPLAYER_TITLE = "Você É Tão Cruel!",
        KILLPLAYER_DESC = "Derrote outro Jogador.",

        SLEEPPLAYER_TITLE = "Sonífero",
        SLEEPPLAYER_DESC = "Faça com que um Jogador durma com uma Mandrake.",

        DOEMOTE_TITLE = "Se Expresse-se",
        DOEMOTE_DESC = "Mostre a todos como você se sente com um emote.",

        LITFLARE_TITLE = "Luzes No Céu",
        LITFLARE_DESC = "Mostre a todos sua localização atual com um Flare.",

        HOLDCOMPASS_TITLE = "Exploradores Intrépidos",
        HOLDCOMPASS_DESC = "Compartilhe sua localização com alguém com uma Bússola.",
    },
    CHARACTER =
    {
        WILSON1_TITLE = "O Monstro da Barba",
        WILSON1_DESC = "Como Wilson, Não se barbeia por 20 dias consecutivos.",
        WILSON2_TITLE = "Sem Barba",
        WILSON2_DESC = "Como Wilson, sobreviva ao Inverno sem sua barba.",

        WILLOW1_TITLE = "Inflamável",
        WILLOW1_DESC = "Como Willow, cozinhe um total de 40 itens com o Willow's Lighter.",
        WILLOW1_LABEL = "Cozinhado",
        WILLOW2_TITLE = "Está Tudo Bem",
        WILLOW2_DESC = "Como Wilow, pegue fogo sem parar durante 1 minuto.",

        WOLFGANG1_TITLE = "Eu Sou Forte!",
        WOLFGANG1_DESC = "Como Wolfgang, alcance o máximo de Mightness enquanto estiver no Mighty Gym.",
        WOLFGANG2_TITLE = "Estômago Vazio",
        WOLFGANG2_DESC = "Como Wolfgang, derrote um total de 40 criaturas enquanto na forma Wimpy.",
        WOLFGANG2_LABEL = "Derrotado",

        WENDY1_TITLE = "Gasparzinho Encontra Wendy",
        WENDY1_DESC = "Como Wendy, ajude 20 Pipspooks.",
        WENDY1_LABEL = "Ajudado",
        WENDY2_TITLE = "Irmãs de Batalha",
        WENDY2_DESC = "Como Wendy, derrote um total de 40 criaturas com ajuda da Abigail.",
        WENDY2_LABEL = "Derrotado",

        WX781_TITLE = "ENERGIZADO E PRONTO PARA SERVIR",
        WX781_DESC = "Como WX-78, escaneia toda criatura possível com o Bio Scanalyzer.",
        WX781_LABEL = "Escaneado",
        WX782_TITLE = "ESTÁ VIVO!!!",
        WX782_DESC = "Como WX-78, repare um Broken Clockwork.",

        WICKERBOTTOM1_TITLE = "Leitora Ávida",
        WICKERBOTTOM1_DESC = "Como Wickerbottom, leia livros um total de 40 vezes.",
        WICKERBOTTOM1_LABEL = "Lido",
        WICKERBOTTOM2_TITLE = "Conhecimento É Poder!",
        WICKERBOTTOM2_DESC = "Como Wickerbottom, aprenda todo livro possível.",
        WICKERBOTTOM2_LABEL = "Aprendido",

        -- I'll miss this one so much...
        -- WICKERBOTTOM2_TITLE = "It's Bedtime",
        -- WICKERBOTTOM2_DESC = "As Wickerbottom, fall asleep.",

        WOODIE1_TITLE = "Abraçador de Árvores",
        WOODIE1_DESC = "Como Woodie, corte um total de 500 árvores com o Werebeaver.",
        WOODIE1_LABEL = "Cortado",
        WOODIE2_TITLE = "Rodada 1, Lute!",
        WOODIE2_DESC = "Como Woodie, derrote um total de 40 criaturas com o Weremoose.",
        WOODIE2_LABEL = "Derrotado",

        WAXWELL1_TITLE = "Mestre de Marionetes",
        WAXWELL1_DESC = "Como Maxwell, derrote um total de 40 criaturas com os Shadow Duelists.",
        WAXWELL1_LABEL = "Derrotado",
        WAXWELL2_TITLE = "Caos Total de Sombras",
        WAXWELL2_DESC = "Como Maxwell, fique insano durante 3 minutos.",

        WES1_TITLE = "Balãomizado!",
        WES1_DESC = "Como Wes, morra para um Balloon.",
        WES2_TITLE = "Tremendo Nas Minhas Botas",
        WES2_DESC = "Como Wes, morra durante um terremoto.",

        WATHGRITHR1_TITLE = "Combatente de Valhalla",
        WATHGRITHR1_DESC = "Como Wigfrid, derrote um total de 20 Gigantes.",
        WATHGRITHR1_LABEL = "Derrotado",
        WATHGRITHR2_TITLE = "Grito de Guerra de Brunhild",
        WATHGRITHR2_DESC = "Como Wigfrid, utilize pelo menos 3 músicas diferentes durante uma batalha.",

        WEBBER1_TITLE = "Família Mortal",
        WEBBER1_DESC = "Como Webber, derrote uma Spider Queen com Spiders.",
        WEBBER2_TITLE = "Amigos Felpudos",
        WEBBER2_DESC = "Como Webber, faça amizade com todos os tipos de Spiders.",
        WEBBER2_LABEL = "Amigável",

        WINONA1_TITLE = "FLEX TAPE!",
        WINONA1_DESC = "Como Winona, utilize a Trusty Tape para reparar um total de 40 itens.",
        WINONA2_TITLE = "Eu Conheço Seus Movimentos!",
        WINONA2_DESC = "Como Winona, desvie de 5 ataques da Charlie.",

        WORTOX1_TITLE = "Desvia Dessa!",
        WORTOX1_DESC = "Como Wortox, desvie de um ataque utilizando suas habilidades de teleporte.",
        WORTOX2_TITLE = "Medico!",
        WORTOX2_DESC = "Como Wortox, cure um total de 1000 Pontos de Vida de um Jogador.",

        WORMWOOD1_TITLE = "Aura Suavizante",
        WORMWOOD1_DESC = "Como Wormwood, cuide de um total de 100 Safras enquanto estiver Florescido.",
        WORMWOOD2_TITLE = "A Primavera É Agora",
        WORMWOOD2_DESC = "Como Wormwood, Floresça fora da Primavera.",

        WARLY1_TITLE = "Sabores Deliciosso",
        WARLY1_DESC = "Como Warly, deguste todos os pratos disponíveis do menu.",
        WARLY1_LABEL = "Degustado",
        WARLY2_TITLE = "Hora do Chef",
        WARLY2_DESC = "Como Warly, cozinhe todos os pratos exclusivos.",
        WARLY2_LABEL = "Cozinhado",

        WURT1_TITLE = "Era Uma Vez...",
        WURT1_DESC = "Como Wurt, leia todos os livros de contos de fadas possíveis.",
        WURT1_LABEL = "Lido",
        WURT2_TITLE = "Rei Mermthur?",
        WURT2_DESC = "Como Wurt, testemunhe a coroação de um Merm para King of the Merms.",

        WALTER1_TITLE = "Head Shot!",
        WALTER1_DESC = "Como Walter, derrote um total de 40 criaturas com o Trusty Slingshot.",
        WALTER2_TITLE = "Melhores Amigos Para Sempre",
        WALTER2_DESC = "Como Walter, carregue algo com a assistência da Woby.",

        WANDA1_TITLE = "Tempo Retorcido",
        WANDA1_DESC = "Como Wanda, evite um ataque fatal utilizando o Ageless Watch.",
        WANDA2_TITLE = "Cronoquebra",
        WANDA2_DESC = "Como Wanda, derrote um total de 40 criaturas enquanto estiver velha com o Alarming Clock.",

        WONKEY1_TITLE = "Nanas! Nanas!",
        WONKEY1_DESC = "Como Wonkey, coma um total de 40 Bananas.",
        WONKEY2_TITLE = "Corrida do Jack",
        WONKEY2_DESC = "Como Wonkey, corra por 1 minuto utilizando uma Pirate's Bandana e uma Cutless.",
    },
    ACTIVITY =
    {
        HERMITQUEST_TITLE = "Servo Auxiliar Supremo!",
        HERMITQUEST_DESC = "Complete todas as tarefas da Crabby Hermit",

        COOKBOOK_TITLE = "Pesadelo Na Cozinha",
        COOKBOOK_DESC = "Cozinhe todos os pratos possíveis.",
        COOKBOOK_LABEL = "Cozinhado",

        FAILEDDISH_TITLE = "Panela Com Defeito",
        FAILEDDISH_DESC = "Falhe um total de 10 vezes tentando cozinhar algo.",

        CATCHFISH_TITLE = "Mestre-pescador",
        CATCHFISH_DESC = "Capture todos os peixes possíveis.",
        CATCHFISH_LABEL = "Capturado",

        FASTFISH_TITLE = "Velozes e Peixeosos",
        FASTFISH_DESC = "Capture um peixe do oceano com menos de 30 segundos.",
        FASTFISH_LABEL = "Segundo",
        FASTFISH_LABEL_PLURAL = "Segundos",

        ALLWEAPON_TITLE = "Mestre da Guerra",
        ALLWEAPON_DESC = "Equipe todas as armas possíveis.",
        ALLWEAPON_LABEL = "Equipado",

        PIGKINGMG_TITLE = "Desafiante",
        PIGKINGMG_DESC = "Venca o mini-game do Pig King.",

        CRITTER_TITLE = "Companheiro Leal",
        CRITTER_DESC = "Adote para si um pet felpudo e fofo.",

        BEECROWN_TITLE = "Sua Majestade!",
        BEECROWN_DESC = "Vista uma Bee Queen Crown e faça alguém reverênciar você.",

        BONEHELM_TITLE = "Insanidade!",
        BONEHELM_DESC = "Vista um Bone Helm.",

        EYEBRELLA_TITLE = "De Olho No Céu",
        EYEBRELLA_DESC = "Vista um Eyebrella.",

        RUINSHAT_TITLE = "Realeza",
        RUINSHAT_DESC = "Vista uma Thulecite Suit e uma Thulecite Crown ao mesmo tempo.",

        FOODKILL_TITLE = "Comida Podre",
        FOODKILL_DESC = "Se mate de tanto comer.",

        STARVATION_TITLE = "Don't Starve",
        STARVATION_DESC = "Morra de fome.",

        WINTERHEAT_TITLE = "Muito Quente!",
        WINTERHEAT_DESC = "Morra de calor durante o Inverno.",

        SUMMERFREEZE_TITLE = "Congele!",
        SUMMERFREEZE_DESC = "Morra de frio durante o Verão.",

        GRIMGALETTE_TITLE = "Agente Funerário",
        GRIMGALETTE_DESC = "Morra ao comer um Grim Galette",

        ORANGESTAFF_TITLE = "E... Poof!",
        ORANGESTAFF_DESC = "Se teleporte utilizando o The Lazy Explorer.",

        GREENAMULET_TITLE = "DESCONTASSO DE 50%!",
        GREENAMULET_DESC = "Crie algo utilizando o Construction Amulet.",

        ALCHEMY_TITLE = "Mestre da Ciência",
        ALCHEMY_DESC = "Construa uma Alchemy Engine.",

        PRESTIHATI_TITLE = "Carta Na Manga",
        PRESTIHATI_DESC = "Construa um Prestihatitator.",

        SMANIPULATOR_TITLE = "Mastre das Sombras",
        SMANIPULATOR_DESC = "Construa um Shadow Manipulator.",

        PIGKING_TITLE = "Golden Shower",
        PIGKING_DESC = "Faça uma negociação com o Pig King.",

        PLANTFLOWER_TITLE = "Que Belo Dia",
        PLANTFLOWER_DESC = "Cresca uma linda Flor. Aww.",

        PIGFOLLOWER_TITLE = "Cercado de Porcos",
        PIGFOLLOWER_DESC = "Tenha 6 Pig Man seguindo você simultaneamente. Que Festa!",

        BUNNYFOLLOWER_TITLE = "Seguidores Felpudos",
        BUNNYFOLLOWER_DESC = "Tenha 6 Bunnyman seguindo você simultaneamente. Caótico!",

        LOBSTERFOLLOWER_TITLE = "Multidão Durona",
        LOBSTERFOLLOWER_DESC = "Tenha 4 Rock Lobster seguindo você simultaneamente. Que Firmeza!",

        SMALLBIRD_TITLE = "Não É Sua Mãe",
        SMALLBIRD_DESC = "Testemunhe o milagre da maternidade de um Tallbird.",

        ARCHIVESPOWER_TITLE = "Acenda As Luzes!",
        ARCHIVESPOWER_DESC = "Ligue a energia dos Archives",

        SOOTHTREE_TITLE = "Sussurando Para Uma Árvore",
        SOOTHTREE_DESC = "Acalme um Treeguard enfurecido.",

        BIGTENTACLE_TITLE = "Expresso Tentáculoso",
        BIGTENTACLE_DESC = "Viaje no exato oposto de estilo.",

        WORMHOLE_TITLE = "Minhocando Meu Caminho",
        WORMHOLE_DESC = "Pule em um buraco nojento.",

        TURTLE_TITLE = "Tartaruga Tartarugando!",
        TURTLE_DESC = "Vista uma Snurtle Shell Armor e um Shelmet ao mesmo tempo.",

        DBEEFALO_TITLE = "Besta do Estômago Sem Fim",
        DBEEFALO_DESC = "Domestique um Beefalo selvagem.",

        PANDORASCHEST_TITLE = "Grande Recompensa!",
        PANDORASCHEST_DESC = "Abra um dos baús encontrados nos labirintos.",

        POTATOCUP_TITLE = "Alguns o Chamam de..",
        POTATOCUP_DESC = "Obtenha o lendário Potato Cup.",

        EYETURRET_TITLE = "Defesa Impenetrável",
        EYETURRET_DESC = "Construa um Houndius Shootius.",

        ONEHP_TITLE = "Nem Senti Nada!",
        ONEHP_DESC = "Sobreviva a um ataque com 1 Ponto de Vida restante.",

        BEEBOX_TITLE = "Abelha Ocupada",
        BEEBOX_DESC = "Colha um doce, doce mel de uma colmeia transbordando.",

        OPALSTAFF_TITLE = "Corrompido Pela Lua",
        OPALSTAFF_DESC = "Testemunhe o poder da Lua descender em uma Staff.",

        CHESTER_TITLE = "Transmutação",
        CHESTER_DESC = "Transforme o Chester durante uma noite de Lua Cheia.",

        HUTCH_TITLE = "Jukebox",
        HUTCH_DESC = "Transforme o Hutch em uma caixa de música ambulante.",

        SLURPER_TITLE = "Chápeu Vivo",
        SLURPER_DESC = "Traga um Slurper das Cavernas para a Superfície.",

        SEWITEM_TITLE = "Rápido e Dedal",
        SEWITEM_DESC = "Demonstre suas habilidades formidáveis de costura.",

        GLOMMER_TITLE = "Bzzort!",
        GLOMMER_DESC = "Descubra a Glommer's Flower durante uma noite de Lua Cheia.",

        KRAMPUS_TITLE = "Você Tem Sido Cruel",
        KRAMPUS_DESC = "Invoque o Krampus pela primeira vez.",

        LUNARPOTION_TITLE = "Experimento Lunar",
        LUNARPOTION_DESC = "Transforme algo utilizando a Steeped Lunar Essence.",

        PURPLESTAFF_TITLE = "Viajando Pelo Espaço-tempo",
        PURPLESTAFF_DESC = "Se teleporte com a Telelocator Staff.",

        ROSEFLOWER_TITLE = "É Espinhoso",
        ROSEFLOWER_DESC = "Espete seu dedo ao pegar uma Flor.",

        WEREPIG_TITLE = "O Metamorfo",
        WEREPIG_DESC = "Testemunhe um Pig Man revela sua identidade secreta.",

        TUMBLEWEED_TITLE = "Velho Oeste",
        TUMBLEWEED_DESC = "Pegue um total de 20 Tumbleweeds.",

        LIGHTNING_TITLE = "Ira de Tor",
        LIGHTNING_DESC = "Seja atingido por um Raio.",

        SHAVEBEEFALO_TITLE = "Cabeleleiro? Cabelereiro.",
        SHAVEBEEFALO_DESC = "Demonstre suas habilidades formidáveis de corte em um pobre animal.",

        KRAMPUSSACK_TITLE = "Meu Dia de Sorte!",
        KRAMPUSSACK_DESC = "Consiga uma Krampus Sack. Sortudo!",

        ALLRELIC_TITLE = "Colecionador de Relíquias",
        ALLRELIC_DESC = "Consiga todas as blueprint possíveis para as Ruins Relics.",
        ALLRELIC_LABEL = "Aprendida",

        LIVINGLOG_TITLE = "Gritos Ecoantes",
        LIVINGLOG_DESC = "Descubra o segredo por trás da Living Log.",
    },
}
}