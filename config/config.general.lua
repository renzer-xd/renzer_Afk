--[[ 
██████╗ ███████╗███╗   ██╗███████╗███████╗██████╗     ███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
██╔══██╗██╔════╝████╗  ██║╚══███╔╝██╔════╝██╔══██╗    ██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
██████╔╝█████╗  ██╔██╗ ██║  ███╔╝ █████╗  ██████╔╝    █████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
██╔══██╗██╔══╝  ██║╚██╗██║ ███╔╝  ██╔══╝  ██╔══██╗    ██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
██║  ██║███████╗██║ ╚████║███████╗███████╗██║  ██║    ██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝╚══════╝╚══════╝╚═╝  ╚═╝    ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
]]

RZ = {}
RZ.Base = {
    getSharedObject = 'esx:getSharedObject'
}

RZ.Font = 'athiti'

RZ.EnableHeadText = true        --[[ false = ปิดข้อความกลางจอ ]]

RZ.EnabelAutoKick = false       --[[ หากต้องการเปิดระบบป้องกันการ Afk นอกจุดให้ปรับ true ]]

RZ.TimeKick = 1                 --[[ ห้าม Afk เกินกี่นาที ]]

RZ.DisableControl = {                       --[[ ปุ่มที่จะให้ บล็อค ]]
    'LEFTSHIFT' ,
    '-' ,
    'T' ,
    'F9' ,
    'Q' ,
    'H' ,
    'L' ,
    'Y' 

}

RZ.Zone = {
    Pos = {                                 --[[ จุด AFK ]]
        x = -792.25,
        y = -1324.88,
        z = 5.00, 
        Radius = 99                         --[[ ความกว้างของวง ]]
    },
    Blips = {
        Enabel = true,                      --[[ false = ปิด Blips ]]
        Id = 685,
        Size = 0.8,
        Color = 2,
        Text = 'Mercury AFK Zone'
    },
    Marker = {
        Type = 1,
        Size = {x = 2.0,y = 2.0,z = 1.0},
        Color = {r = 255, g = 255,b = 255,a = 255}
    },
}

RZ.Reward = {
    TimeReward = 1,             --[[ จะให้ได้ของรางวัลทุกกี่นาที ]]
    Item = {
        Name = 'ticket_akf_1',  --[[ ไอเท็มที่จะได ]]
        Count = 1,              --[[ จำนวน ]]
        Bonus = {
            {
                Item = 'gasha_akf_1', --[[ ไอเท็มโบนัสที่จะได้ ]]
                Count = 1,      --[[ จำนวน ]]
                Percent = 30    --[[ โอกาสที่จะได้รับ ]]
            },
        }
    }
}

RZ.Animation = {
    {lib = 'custom@rickroll',anim = 'rickroll'},
    {lib = 'custom@orangejusom@renegade',anim = 'renegade'},
    {lib = 'custom@savage',anim = 'savage'},
    {lib = 'custom@sayso',anim = 'sayso'},
    {lib = 'custom@take_l',anim = 'take_l'},
    {lib = 'custom@rickrolltice',anim = 'orangejustice'},
    {lib = 'custom@floss',anim = 'floss'},
    {lib = 'custom@crossbounce',anim = 'crossbounce'},
    {lib = 'custom@toosie_slide',anim = 'toosie_slide'},
}