local addonName, _A = ...
local _G = _A._G
local U = _A.Cache.Utils
local DSL = function(api) return _A.DSL:Get(api) end

local GUI = {
    { type = "texture", texture =  "Interface\\AddOns\\Apofis\\Rotations\\Shaman\\images.blp", height = 380, width = 480, offset =0, y = -180, align = "center"},
    { type = "spacer", size = 300}
    }

local spell_ids = {
    --===Сейф===--
    ["Astral Shift"] = 108271, -- Астральный сдвиг
    ["Ancestral Guidance"] = 108281, -- Наставление предков
    ["Earth Elemental"] = 198103, -- Элементаль земли
    ["Earth Shield"] = 974, -- Щит земли
    ["Cleanse Spirit"] = 51886, -- Очищение духа
    ["Purge"] = 370, -- Развеивание магии
    --===КикКасты===--
    ["Wind Shear"] = 57994, -- Пронзающий ветер
    ["Capacitor Totem"] = 192058, -- Тотем конденсации
    --===Баффы===--
    ["Lightning Shield"] = 192106, -- Щит молний
    ["Windfury Weapon"] = 33757, -- Оружие Ветра
    ["Flametongue Weapon"] = 318038, -- Оружие Пламени
    ["Windfury Totem"] = 8512, -- Тотем неистовства ветра
    --===Урон===--
    ["Flame Shock"] = 188389, -- огненный шок
    ["Frost Shock"] = 196840, -- Ледяной шок
    ["Lava Burst"] = 51505, -- выброс лавы
    ["Lightning Bolt"] = 188196, -- Молния
    ["Chain Lightning"] = 188443, -- цепная молния
    ["Lava Lash"] = 60103, -- Вскипание лавы
    ["Stormstrike"] = 17364, -- Удар бури
    ["Ice Strike"] = 342240, -- Ледяной клинок
    ["Crash Lightning"] = 187874, -- сокрушающая молния
    ["Feral Spirit"] = 51533, --Дух дикого зверя
    ["Primordial Wave"] = 375982, -- Первозданная волна
    ["Sundering"] = 197214, -- Расскол
}
local exeOnLoad = function()
    print("Погнали НАХУЙ!")
end
local cache = {
    aoe = false,
  }
  local RotationCache = {
  {function()
    cache.aoe = false
    local count = 0
    local enemy = _A.OM:Get('EnemyCombat')
    for _,Obj in pairs(enemy) do
      if DSL("range")(Obj.key) < 5 then
        count = count + 1
      end
    end
    if count > 1 then
      cache.aoe = true
    end
  end,},
  }
local buff = {
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Lightning Shield"]) then
            if not _A.DSL:Get("buff")("player", 192106) then      
                _A.Cast(spell_ids["Lightning Shield"], "player")
            end
        end
    end,},
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Windfury Weapon"]) then
            if _A.DSL:Get("mainHand.EnchantID")()~=5401 then   
                _A.Macro("/use "..GetSpellInfo(spell_ids["Windfury Weapon"]))
            end
        end
    end,},
    {function()
       if _A.DSL:Get("spell.ready")(_, spell_ids["Flametongue Weapon"]) then
            if _A.DSL:Get("offHand.EnchantID")()~=5400 then     
                _A.Macro("/use "..GetSpellInfo(spell_ids["Flametongue Weapon"]))
           end
       end
    end,},
    
}
local SelfProtect = {
    --===Астральный сдвиг===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Astral Shift"]) then
            if _A.DSL:Get("health")("player") <= 20 then      
                _A.Cast(spell_ids["Astral Shift"], "player")
            end
        end
    end,},
    --===Элеменаль земли===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Earth Elemental"]) then
            if _A.DSL:Get("health")("player") <= 35 then  
                _A.Cast(spell_ids["Earth Elemental"], "player")
            end
        end
    end,},
    --===Наставление предков===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Ancestral Guidance"]) then
            if _A.DSL:Get("health")("player") <= 50 then      
                _A.Cast(spell_ids["Ancestral Guidance"], "player")
            end
        end
    end,},
    --===Щит земли===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Earth Shield"]) then
            if _A.DSL:Get("health")("player") <= 25 then
                if not _A.DSL:Get("buff")("player", 974) then      
                    _A.Cast(spell_ids["Earth Shield"], "player")
                end
            end
        end
    end,},
   -- {function()
       -- if DSL("spell.ready")(_, spell_ids["Cleanse Spirit"]) then
           -- local roster = _A.OM:Get('Roster')
            --for _,Obj in pairs(roster) do
               -- if DSL("los")(Obj.key) then
                    --if DSL("range")(Obj.key) < 39 then
                       -- for i=1,40 do
                           -- local _, _, _, debuffType = UnitDebuff(Obj.key,i);
                            --if debuffType == "Magic" then 
                                --_A.Cast(spell_ids["Cleanse Spirit"], Obj.key)
                                --return true;
                           -- end
                       -- end
                   -- end
               -- end
           -- end
       -- end
   -- end,},
}
local SelfProtectAlly = {
}
local Rotation = {
    ---===============--
    ---======АОЕ======--
    ---===============--
    --===Тотем Бури===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Windfury Totem"]) then
            if cache.aoe then
                if not _A.DSL:Get("buff")("player", 327942) then      
                    _A.Cast(spell_ids["Windfury Totem"], "player")
                end
            end
        end
    end,},
    --===Дух Дикого зверя===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Feral Spirit"]) then
            if cache.aoe then            
                if _A.DSL:Get("los")("target") then              
                    if _A.DSL:Get("range")("target") < 5 then
                        _A.Cast(spell_ids["Feral Spirit"], "target")
                    end
                end
            end
        end
    end,},
    --===Первозданная волна===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Primordial Wave"]) then
            if cache.aoe then            
                if _A.DSL:Get("los")("target") then              
                    if _A.DSL:Get("range")("target") < 5 then
                        _A.Cast(spell_ids["Primordial Wave"], "target")
                    end
                end
            end
        end
    end,},
    --===Огненный Шок===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Flame Shock"]) then
            if cache.aoe then
                if not _A.DSL:Get("debuff")("target", 188389) then           
                    if _A.DSL:Get("los")("target") then              
                        if _A.DSL:Get("range")("target") < 5 then
                            _A.Cast(spell_ids["Flame Shock"], "target")
                        end
                    end
                end
            end
        end
    end,},
    --===Вскипание лавы===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Lava Lash"]) then
            if cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 5 then
                        _A.Cast(spell_ids["Lava Lash"], "target")
                    end
                end 
            end
        end
    end,},
    --===Расскол===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Sundering"]) then
            if cache.aoe then            
                if _A.DSL:Get("los")("target") then              
                    if _A.DSL:Get("range")("target") < 5 then
                        _A.Cast(spell_ids["Sundering"], "target")
                    end
                end
            end
        end
    end,},
    --===Молния===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Lightning Bolt"]) then
            if cache.aoe then
                if _A.DSL:Get("buff.stack")("player", 344179) > 9 then
                    if _A.DSL:Get("los")("target") then         
                        if _A.DSL:Get("range")("target") < 5 then
                            _A.Cast(spell_ids["Lightning Bolt"], "target")
                        end
                    end
                end 
            end
        end
    end,},
    --===Цепная молния===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Chain Lightning"]) then
            if cache.aoe then
                if _A.DSL:Get("buff.stack")("player", 344179) > 9 then
                    if _A.DSL:Get("los")("target") then         
                        if _A.DSL:Get("range")("target") < 5 then
                            _A.Cast(spell_ids["Chain Lightning"], "target")
                        end
                    end
                end 
            end
        end
    end,},
    --===Сокрушающая молния===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Crash Lightning"]) then
            if cache.aoe then           
                if _A.DSL:Get("los")("target") then              
                    if _A.DSL:Get("range")("target") < 5 then
                        _A.Cast(spell_ids["Crash Lightning"], "target")
                    end
                end
            end
        end
    end,},
    --===Леденой клинок===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Ice Strike"]) then
            if cache.aoe then           
                if _A.DSL:Get("los")("target") then              
                    if _A.DSL:Get("range")("target") < 5 then
                        _A.Cast(spell_ids["Ice Strike"], "target")
                    end
                end
            end
        end
    end,},
    --===Леденой шок===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Frost Shock"]) then
            if cache.aoe then            
                if _A.DSL:Get("los")("target") then              
                    if _A.DSL:Get("range")("target") < 5 then
                        _A.Cast(spell_ids["Frost Shock"], "target")
                    end
                end
            end
        end
    end,},
    --===Удары бури===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Stormstrike"]) then 
            if cache.aoe then           
                if _A.DSL:Get("los")("target") then              
                    if _A.DSL:Get("range")("target") < 5 then
                        _A.Cast(spell_ids["Stormstrike"], "target")
                    end
                end
            end
        end
    end,},
    ---===============--
    ---=====SOLO=====--
    ---===============--
    --===Тотем Бури===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Windfury Totem"]) then
            if not cache.aoe then
                if not _A.DSL:Get("buff")("player", 327942) then      
                    _A.Cast(spell_ids["Windfury Totem"], "player")
                end
            end
        end
    end,},
    --===Дух Дикого зверя===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Feral Spirit"]) then
            if not cache.aoe then            
                if _A.DSL:Get("los")("target") then              
                    if _A.DSL:Get("range")("target") < 5 then
                        _A.Cast(spell_ids["Feral Spirit"], "target")
                    end
                end
            end
        end
    end,},
    --===Расскол===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Sundering"]) then
            if not cache.aoe then            
                if _A.DSL:Get("los")("target") then              
                    if _A.DSL:Get("range")("target") < 5 then
                         _A.Cast(spell_ids["Sundering"], "target")
                    end
                end
            end
        end
    end,},
    --===Удары бури===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Stormstrike"]) then 
            if not cache.aoe then           
                if _A.DSL:Get("los")("target") then              
                    if _A.DSL:Get("range")("target") < 5 then
                        _A.Cast(spell_ids["Stormstrike"], "target")
                    end
                end
            end
        end
    end,},
    --===Выьрос лавы===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Lava Burst"]) then
            if not cache.aoe then
                if _A.DSL:Get("buff.stack")("player", 344179) > 4 then
                    if _A.DSL:Get("los")("target") then         
                        if _A.DSL:Get("range")("target") < 5 then
                            _A.Cast(spell_ids["Lava Burst"], "target")
                        end
                    end
                end 
            end
        end
    end,},
    --===Цепная молния===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Chain Lightning"]) then
            if not cache.aoe then
                if _A.DSL:Get("buff.stack")("player", 344179) > 4 then
                    if _A.DSL:Get("los")("target") then         
                        if _A.DSL:Get("range")("target") < 5 then
                            _A.Cast(spell_ids["Chain Lightning"], "target")
                        end
                    end
                end 
            end
        end
    end,},
    --===Первозданная волна===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Primordial Wave"]) then
            if not cache.aoe then            
                if _A.DSL:Get("los")("target") then              
                    if _A.DSL:Get("range")("target") < 5 then
                        _A.Cast(spell_ids["Primordial Wave"], "target")
                    end
                end
            end
        end
    end,},
    --===Молния===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Lightning Bolt"]) then
            if not cache.aoe then
                if _A.DSL:Get("buff.stack")("player", 344179) > 4 then
                    if _A.DSL:Get("los")("target") then         
                        if _A.DSL:Get("range")("target") < 5 then
                            _A.Cast(spell_ids["Lightning Bolt"], "target")
                        end
                    end
                end 
            end
        end
    end,},
    --===Леденой клинок===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Ice Strike"]) then
            if not cache.aoe then           
                if _A.DSL:Get("los")("target") then              
                    if _A.DSL:Get("range")("target") < 5 then
                        _A.Cast(spell_ids["Ice Strike"], "target")
                    end
                end
            end
        end
    end,},
    --===Огненный Шок===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Flame Shock"]) then
            if not cache.aoe then
                if not _A.DSL:Get("debuff")("target", 188389) then           
                    if _A.DSL:Get("los")("target") then              
                        if _A.DSL:Get("range")("target") < 5 then
                            _A.Cast(spell_ids["Flame Shock"], "target")
                        end
                    end
                end
            end
        end
    end,},
    --===Вскипание лавы===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Lava Lash"]) then
            if not cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 5 then
                        _A.Cast(spell_ids["Lava Lash"], "target")
                    end
                end 
            end
        end
    end,},
    --===Леденой шок===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Frost Shock"]) then
            if not cache.aoe then            
                if _A.DSL:Get("los")("target") then              
                    if _A.DSL:Get("range")("target") < 5 then
                        _A.Cast(spell_ids["Frost Shock"], "target")
                    end
                end
            end
        end
    end,},
}
local Interrupts = {
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Wind Shear"]) then
            if _A.DSL:Get("interruptible")("target") then    
                _A.Cast(spell_ids["Wind Shear"], "target")
            end
        end
    end,},
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Capacitor Totem"]) then
            local Enemy = _A.OM:Get('Enemy')
            for _,Obj in pairs(Enemy) do
                if DSL("range")(Obj.key) < 3 then
                    if _A.DSL:Get("custom.stuns")("target") then    
                        _A.Cast(spell_ids["Capacitor Totem"], "target")
                        _A.ClickPosition(_A.ObjectPosition(Obj.key))
                    end
                end
            end
        end
    end,},
}
local Cooldowns = {
}
local inCombat = {
    {SelfProtect},
    {RotationCache},
    {Rotation},
    {Interrupts},
}
local outOfCombat = {
    {buff},
}

_A.CR:Add(263, {
    name = "Энх by Ackerman",
    load = function()
        print("Load function executed")
        exeOnLoad()
    end,
    gui = GUI,
    gui_st = {title="Совершенство by Ackerman", color="1EFF0C", width="400", height="500"},
    ids = spell_ids,
    ic = inCombat,
    ooc = outOfCombat,
    blacklist = blacklist,  
    --unload = exeOnUnload,
    wow_ver = "10.1.7",
    apep_ver = "1.1",
    unload = function()
        print("Unload function executed")
        exeOnUnload()
    end
})