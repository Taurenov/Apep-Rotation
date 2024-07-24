local addonName, _A = ...
local _G = _A._G
local U = _A.Cache.Utils
local DSL = function(api) return _A.DSL:Get(api) end

local GUI = {
}

local spell_ids = {
        --===Сейф===--
        ["Ice Block"] = 414658, -- Леденая глыба
        ["Greater Invisibility"] = 110959, -- Великая невидимость
        ["Mass Barrier"] = 414660, -- Массовая преграда
        ["Remove Curse"] = 475, -- Снятие проклятия
        ["Time Manipulation"] = 342245, -- Манипуляции со временем
        ["Spellsteal"] = 30449, -- Чарокрад
        --===КикКаста===--
        ["Counterspell"] = 2139, -- Антимагия
        --===Баффы===--
        ["Arcane Intellect"] = 1459, -- Чародейский интилект
        ["Ice Barrier"] = 11426, -- Леденая преграда
        ["Time Warp"] = 80353, -- Искажение времени
        --===Урон===--
        ["Mirror Image"] = 55342, -- Зеркальные изабражения
        ["Frostbolt"] = 116, -- Леденая стрела
        ["Shifting Power"] = 382440, -- Переходящая сила
        ["Comet Storm"] = 153595, -- Кометная буря
        ["Ice Lance"] = 30455, -- Ледяное копьё
        ["Blizzard"] = 190356, -- Снежная буря
        ["Flurry"] = 44614, -- Шквал
        ["Ice Nova"] = 157997, -- Кольцо обледенения
        ["Glacial Spike"] = 199786, -- Ледовый шип
        ["Frozen Orb"] = 84714, -- Ледяной шар
        ["Icy Veins"] = 12472, -- Стылая кровь
        ["Cold Snap"] = 235219, -- холодная хватка
        ["Cone of Cold"] = 120, -- Конус холода
}
local exeOnLoad = function()
    print("Ротация включена!") -- Напишите своё
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
    --===Чародейский интилект===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Arcane Intellect"]) then
            if not _A.DSL:Get("buff")("player", 1459) then      
                _A.Cast(spell_ids["Arcane Intellect"], "player")
            end
        end
    end,},
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Ice Barrier"]) then
            if not _A.DSL:Get("buff")("player", 11426) then
                if _A.DSL:Get("health")("player") <= 80 then      
                    _A.Cast(spell_ids["Ice Barrier"], "player")
                end
            end
        end
    end,},
}
local SelfProtect = {
    --===Леденая глыба===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Ice Block"]) then
            if _A.DSL:Get("health")("player") <= 30 then
                if not _A.DSL:Get("debuff")("player", 41425) then      
                    _A.Cast(spell_ids["Ice Block"], "player")
                end
            end
        end
    end,},
    --===Великая невидимость===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Greater Invisibility"]) then
            if _A.DSL:Get("health")("player") <= 20 then      
                _A.Cast(spell_ids["Greater Invisibility"], "player")
            end
        end
    end,},
    --===Массовый барьер===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Mass Barrier"]) then
            if _A.DSL:Get("health")("player") <= 50 then      
                _A.Cast(spell_ids["Mass Barrier"], "player")
            end
        end
    end,},
    --===Манипулации со временем===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Time Manipulation"]) then
            if _A.DSL:Get("health")("player") <= 65 then
                if not _A.DSL:Get("buff")("player", 342246) then       
                    _A.Cast(spell_ids["Time Manipulation"], "player")
                end
            end
        end
    end,},
}
local SelfProtectAlly = {
}
local Rotation = {
    --===AOE===--
    --===Ледяной шар===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Frozen Orb"]) then
            if cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 39 then
                        _A.Cast(spell_ids["Frozen Orb"], "target")
                    end
                end 
            end
        end
    end,},
    --===Стылая кровь===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Icy Veins"]) then
            if cache.aoe then
                if not _A.DSL:Get("buff")("player", 12472) then      
                    _A.Cast(spell_ids["Icy Veins"], "player")
                end
            end
        end
    end,},
    --===Снежная буря===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Blizzard"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if cache.aoe then
                    if DSL("range")(Obj.key) < 39 then    
                        _A.Cast(spell_ids["Blizzard"], "target")
                        _A.ClickPosition(_A.ObjectPosition(Obj.key))
                    end
                end
            end
        end
    end,},
    ---===Кометная буря===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Comet Storm"]) then
            if cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 39 then
                        _A.Cast(spell_ids["Comet Storm"], "target")
                    end
                end 
            end
        end
    end,},
    --===Конус холода===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Cone of Cold"]) then
            if cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 10 then
                        _A.Cast(spell_ids["Cone of Cold"], "target")
                    end
                end 
            end
        end
    end,},
    --===Переходящия сила===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Shifting Power"]) then
            if cache.aoe then
                if not _A.DSL:Get("spell.ready")(_, spell_ids["Icy Veins"]) then
                    if not _A.DSL:Get("buff")("player", 12472) then      
                        _A.Cast(spell_ids["Shifting Power"], "player")
                    end
                end
            end
        end
    end,},
    --===Ледовый шип===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Glacial Spike"]) then
            if cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 39 then
                        _A.Cast(spell_ids["Glacial Spike"], "target")
                    end
                end 
            end
        end
    end,},
    --===Кольцо обледенения===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Ice Nova"]) then
            if cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 39 then
                        _A.Cast(spell_ids["Ice Nova"], "target")
                    end
                end 
            end
        end
    end,},
    ---===Шквал прок(Обморожение)===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Frozen Orb"]) then
            if cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 39 then
                        if _A.DSL:Get("buff")("player", 190446) then
                            _A.Cast(spell_ids["Frozen Orb"], "target")
                        end
                    end
                end 
            end
        end
    end,},
    --====Ледяное копьё===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Ice Lance"]) then
            if cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 39 then
                        if _A.DSL:Get("buff")("player", 44544) then
                            _A.Cast(spell_ids["Ice Lance"], "target")
                        end
                    end
                end 
            end
        end
    end,},
    --===Леденая стрела===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Frostbolt"]) then
            if cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 39 then
                        _A.Cast(spell_ids["Frostbolt"], "target")
                    end
                end 
            end
        end
    end,},
    ---===SOLO===---
    --===Стылая кровь===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Icy Veins"]) then
            if not cache.aoe then
                if not _A.DSL:Get("buff")("player", 12472) then      
                    _A.Cast(spell_ids["Icy Veins"], "player")
                end
            end
        end
    end,},
    ---===Кометная буря===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Comet Storm"]) then
            if not cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 39 then
                        _A.Cast(spell_ids["Comet Storm"], "target")
                    end
                end 
            end
        end
    end,},
    --===Ледовый шип===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Glacial Spike"]) then
            if not cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 39 then
                        _A.Cast(spell_ids["Glacial Spike"], "target")
                    end
                end 
            end
        end
    end,},
    --===Ледяной шар===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Frozen Orb"]) then
            if not cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 39 then
                        _A.Cast(spell_ids["Frozen Orb"], "target")
                    end
                end 
            end
        end
    end,},
    --====Ледяное копьё(Прок)===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Ice Lance"]) then
            if not cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 39 then
                        if _A.DSL:Get("buff")("player", 44544) then
                            _A.Cast(spell_ids["Ice Lance"], "target")
                        end
                    end
                end 
            end
        end
    end,},
    ---===Шквал прок(Обморожение)===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Frozen Orb"]) then
            if not cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 39 then
                        if _A.DSL:Get("buff")("player", 190446) then
                            _A.Cast(spell_ids["Frozen Orb"], "target")
                        end
                    end
                end 
            end
        end
    end,},
    --===Леденая стрела===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Frostbolt"]) then
            if not cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 39 then
                        _A.Cast(spell_ids["Frostbolt"], "target")
                    end
                end 
            end
        end
    end,},
    ---===Шквал===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Frozen Orb"]) then
            if not cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 39 then
                        _A.Cast(spell_ids["Frozen Orb"], "target")
                    end
                end 
            end
        end
    end,},
    --====Ледяное копьё===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Ice Lance"]) then
            if not cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 39 then
                        _A.Cast(spell_ids["Ice Lance"], "target")
                    end
                end 
            end
        end
    end,},
}
local Interrupts = {
    {function()
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if _A.DSL:Get("spell.ready")(_, spell_ids["Counterspell"]) then
                if _A.DSL:Get("los")(Obj.key) then              
                    if _A.DSL:Get("range")(Obj.key) < 39 then
                        if _A.DSL:Get("interruptible")(Obj.key) then    
                            _A.Cast(spell_ids["Counterspell"], Obj.key)
                        end
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
    {buff},
}
local outOfCombat = {
    {buff},
}

_A.CR:Add(64, {
    name = "Frost mage by Tayrenov",
    load = function()
        print("Load function executed")
        exeOnLoad()
    end,
    gui = GUI,
    gui_st = {title="Frost mage by Ackerman", color="1EFF0C", width="400", height="500"},
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