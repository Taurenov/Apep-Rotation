local addonName, _A = ...
local _G = _A._G
local U = _A.Cache.Utils
local DSL = function(api) return _A.DSL:Get(api) end

local GUI = {
}

local spell_ids = {
    ["Astral Shift"] = 108271, -- Астральный сдвиг (Сейв)
    ["Spiritwalker's Grace"] = 79206, -- Благосклоность предков(Юзать при движении)
    ["Totemic Recall"] = 108285, -- Возвращение тотемов (Ставим 2 тотема лавы)
    ["Lava Burst"] = 51505, -- выброс лавы
    ["Frost Shock"] = 196840, -- Ледяной шок
    ["Lightning Bolt"] = 188196, -- Молния
    ["Ancestral Guidance"] = 108281, -- Наставление предков(Сейв)
    ["Flame Shock"] = 188389, -- огненный шок
    ["Nature's Swiftness"] = 378081, -- природная стримительность
    ["Wind Shear"] = 57994, -- Пронзающий ветер (Кик каста)
    ["Capacitor Totem"] = 192058, -- Тотем конденсации
    ["Chain Lightning"] = 188443, -- цепная молния
    ["Lightning Shield"] = 192106, -- Щит молний(Баф поддерживать)
    ["Earth Elemental"] = 198103, -- Элементаль земли(Сейф)
    ["Earthquake"] = 61882, -- землетрясение
    ["Icefury"] = 210714, -- леденая ярость
    ["Liquid Magma Totem"] = 192222, -- тотем жидкой магмы
    ["Elemental Blast"] = 117014, -- удар духов стихий
    ["Stormkeeper"] = 191634, -- хранитель бурь
    ["Storm Elemental"] = 192249, -- элементаль бури
    ["Ancestral Call"] = 274738, -- Призыв предков (Рассовая)
}
local exeOnLoad = function()
    print("Ротация загруженна")
end
local SelfProtect = {
}
local SelfProtectAlly = {
}
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
local RotationZeis = {
    --===SOLO===--
    --===Природная стримительность===--
    {"&Spiritwalker's Grace", "spell.ready && player.moving"},
    --===Хранитель бурь===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Stormkeeper"]) then
            if not cache.aoe then
                if not _A.DSL:Get("buff")("player", 191634) then      
                    _A.Cast(spell_ids["Stormkeeper"], "player")
                end
            end
        end
    end,},
    --===Леденая ярость===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Icefury"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if not cache.aoe then
                    if _A.DSL:Get("los")(Obj.key) then
                        if not _A.DSL:Get("buff")("player", 210714) then
                            if _A.DSL:Get("range")(Obj.key) <= 40 then    
                                _A.Cast(spell_ids["Icefury"], "target")
                            end
                        end
                    end
                end
            end
        end
    end,},
    --===Рассовая способность===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Ancestral Call"]) then
            if not cache.aoe then    
                _A.Cast(spell_ids["Ancestral Call"], "player")
            end
        end
    end,},
    --===Природная стримительность===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Nature's Swiftness"]) then
            if not cache.aoe then    
                _A.Cast(spell_ids["Nature's Swiftness"], "player")
            end
        end
    end,},
    --===Элементаль бури===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Storm Elemental"]) then
            if not cache.aoe then    
                _A.Cast(spell_ids["Storm Elemental"], "player")
            end
        end
    end,},
    --===Тотем жидеой магмы===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Liquid Magma Totem"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if not cache.aoe then
                    if DSL("range")(Obj.key) <= 40 then      
                        _A.Cast(spell_ids["Liquid Magma Totem"], "target")
                        _A.ClickPosition(_A.ObjectPosition(Obj.key))
                    end
                end
            end
        end
    end,},
    --===Возврат тотемов===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Totemic Recall"]) then
            if not cache.aoe then    
                _A.Cast(spell_ids["Totemic Recall"], "player")
            end
        end
    end,},
    --===Огненный шок===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Flame Shock"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if not cache.aoe then
                    if _A.DSL:Get("los")(Obj.key) then
                        if not _A.DSL:Get("debuff")(Obj.key, 188389) then      
                            if _A.DSL:Get("range")(Obj.key) <= 40 then
                                _A.Cast(spell_ids["Flame Shock"], Obj.key)
                            end
                        end
                    end
                end
            end
        end
    end,},
    --===Ледяной шок===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Frost Shock"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if not cache.aoe then
                    if _A.DSL:Get("los")(Obj.key) then
                        if not _A.DSL:Get("debuff")(Obj.key, 196840) then      
                            if _A.DSL:Get("range")(Obj.key) <= 40 then
                                _A.Cast(spell_ids["Frost Shock"], Obj.key)
                            end
                        end
                    end
                end
            end
        end
    end,},
    --===Удар духов стихий(Прок)===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Elemental Blast"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if not cache.aoe then
                    if _A.DSL:Get("los")(Obj.key) then
                        if _A.DSL:Get("buff")("player", 260734) then
                            if _A.DSL:Get("range")(Obj.key) <= 40 then    
                                _A.Cast(spell_ids["Elemental Blast"], Obj.key)
                            end
                        end
                    end
                end
            end
        end
    end,},
    --===Молния(Прок)===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Lightning Bolt"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if not cache.aoe then
                    if _A.DSL:Get("los")(Obj.key) then
                        if _A.DSL:Get("buff")("player", 191877) then
                            if _A.DSL:Get("range")(Obj.key) <= 40 then    
                                _A.Cast(spell_ids["Lightning Bolt"], Obj.key)
                            end
                        end
                    end
                end
            end
        end
    end,},
    --===Выброс лавы===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Lava Burst"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            if not cache.aoe then
                for _,Obj in pairs(Enemy) do
                    if _A.DSL:Get("los")(Obj.key) then
                        if _A.DSL:Get("range")(Obj.key) <= 40 then    
                            _A.Cast(spell_ids["Lava Burst"], Obj.key)
                        end
                    end
                end
            end
        end
    end,},
    --===Удар духов стихий==--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Elemental Blast"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if not cache.aoe then
                    if _A.DSL:Get("los")(Obj.key) then
                        if _A.DSL:Get("range")(Obj.key) <= 40 then    
                            _A.Cast(spell_ids["Elemental Blast"], Obj.key)
                        end
                    end
                end
            end
        end
    end,},
    --==Молния==--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Lightning Bolt"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if not cache.aoe then
                    if _A.DSL:Get("los")(Obj.key) then
                        if _A.DSL:Get("range")(Obj.key) <= 40 then    
                            _A.Cast(spell_ids["Lightning Bolt"], Obj.key)
                        end
                    end
                end
            end
        end
    end,},
--===АОЕ===--
--===Природная стримительность===--
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Ancestral Call"]) then
        if cache.aoe then
            if _A.DSL:Get("moving")("player") then  
                _A.Cast(spell_ids["Ancestral Call"], "player")
            end
        end
    end
end,},
--===Хранитель бурь===--
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Stormkeeper"]) then
        if cache.aoe then
            if not _A.DSL:Get("buff")("player", 191634) then      
                _A.Cast(spell_ids["Stormkeeper"], "player")
            end
        end
    end
end,},
--===Леденая ярость===--
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Icefury"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if cache.aoe then
                if _A.DSL:Get("los")(Obj.key) then
                    if not _A.DSL:Get("buff")("player", 210714) then
                        if _A.DSL:Get("range")(Obj.key) <= 40 then    
                            _A.Cast(spell_ids["Icefury"], "target")
                        end
                    end
                end
            end
        end
    end
end,},
--===Рассовая способность===--
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Ancestral Call"]) then
        if cache.aoe then    
            _A.Cast(spell_ids["Ancestral Call"], "player")
        end
    end
end,},
--===Природная стримительность===--
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Nature's Swiftness"]) then
        if cache.aoe then    
            _A.Cast(spell_ids["Nature's Swiftness"], "player")
        end
    end
end,},
--===Элементаль бури===--
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Storm Elemental"]) then
        if cache.aoe then    
            _A.Cast(spell_ids["Storm Elemental"], "player")
        end
    end
end,},
--===Тотем жидеой магмы===--
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Liquid Magma Totem"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if cache.aoe then
                if DSL("range")(Obj.key) <= 40 then      
                    _A.Cast(spell_ids["Liquid Magma Totem"], "target")
                    _A.ClickPosition(_A.ObjectPosition(Obj.key))
                end
            end
        end
    end
end,},
--===Возврат тотемов===--
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Totemic Recall"]) then
        if cache.aoe then    
            _A.Cast(spell_ids["Totemic Recall"], "player")
        end
    end
end,},
--===Ледяной шок===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Frost Shock"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if cache.aoe then
                    if _A.DSL:Get("los")(Obj.key) then
                        if not _A.DSL:Get("debuff")(Obj.key, 196840) then      
                            if _A.DSL:Get("range")(Obj.key) <= 40 then
                                _A.Cast(spell_ids["Frost Shock"], Obj.key)
                            end
                        end
                    end
                end
            end
        end
    end,},
--===Удар духов стихий(Прок)===--
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Elemental Blast"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if cache.aoe then
                if _A.DSL:Get("los")(Obj.key) then
                    if _A.DSL:Get("buff")("player", 260734) then
                        if _A.DSL:Get("range")(Obj.key) <= 40 then    
                            _A.Cast(spell_ids["Elemental Blast"], Obj.key)
                        end
                    end
                end
            end
        end
    end
end,},
--===Цепная молния(Прок)===--
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Chain Lightning"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if cache.aoe then
                if _A.DSL:Get("los")(Obj.key) then
                    if _A.DSL:Get("buff")("player", 191877) then
                        if _A.DSL:Get("range")(Obj.key) <= 40 then    
                            _A.Cast(spell_ids["Chain Lightning"], Obj.key)
                        end
                    end
                end
            end
        end
    end
end,},
--===Землятресение(Прок)===--
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Earthquake"]) then
        local Enemy = _A.OM:Get('Enemy')
        for _,Obj in pairs(Enemy) do
            if cache.aoe then
                if _A.DSL:Get("buff")("player", 384088) then  
                    if DSL("range")(Obj.key) <= 40 then      
                        _A.Cast(spell_ids["Earthquake"], "target")
                        _A.ClickPosition(_A.ObjectPosition(Obj.key))
                    end
                end
            end
        end
    end
end,},
--===Выброс лавы===--
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Lava Burst"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        if cache.aoe then
            for _,Obj in pairs(Enemy) do
                if _A.DSL:Get("los")(Obj.key) then
                    if _A.DSL:Get("range")(Obj.key) <= 40 then    
                        _A.Cast(spell_ids["Lava Burst"], Obj.key)
                    end
                end
            end
        end
    end
end,},
--===Землятресение===--
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Earthquake"]) then
        local Enemy = _A.OM:Get('Enemy')
        for _,Obj in pairs(Enemy) do
            if cache.aoe then
                if DSL("range")(Obj.key) <= 40 then      
                    _A.Cast(spell_ids["Earthquake"], "target")
                    _A.ClickPosition(_A.ObjectPosition(Obj.key))
                end
            end
        end
    end
end,},
--==Цепная молния==--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Chain Lightning"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if not cache.aoe then
                    if _A.DSL:Get("los")(Obj.key) then
                        if _A.DSL:Get("range")(Obj.key) <= 40 then    
                            _A.Cast(spell_ids["Chain Lightning"], Obj.key)
                        end
                    end
                end
            end
        end
    end,},
}
local Interrupts = {
}
local Cooldowns = {
}
local inCombat = {
    {RotationCache},
    {RotationZeis},
}
local outOfCombat = {
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Lightning Shield"]) then
            if not _A.DSL:Get("buff")("player", 192106) then      
                _A.Cast(spell_ids["Lightning Shield"], "player")
            end
        end
    end,},
}

_A.CR:Add(262, {
    name = "[Elem by Ackerman]",
    load = function()
        print("Load function executed")
        exeOnLoad()
    end,
    gui = GUI,
    ids = spell_ids,
    ic = inCombat,
    ooc = outOfCombat,
    blacklist = blacklist,  
    --unload = exeOnUnload,
    wow_ver = "9.2.7",
    apep_ver = "1.4",
    unload = function()
        print("Unload function executed")
        exeOnUnload()
    end
})