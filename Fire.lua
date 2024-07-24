local addonName, _A = ...
local _G = _A._G
local U = _A.Cache.Utils
local DSL = function(api) return _A.DSL:Get(api) end

local GUI = {
}

local spell_ids = {
    --===Сейф===--
    ["Ice Block"] = 45438, -- Леденая глыба
    ["Greater Invisibility"] = 110959, -- Великая невидимость
    ["Mass Barrier"] = 414660, -- Массовая преграда
    ["Remove Curse"] = 475, -- Снятие проклятия
    ["Time Manipulation"] = 342245, -- Манипуляции со временем
    ["Spellsteal"] = 30449, -- Чарокрад
    --===КикКаста===--
    ["Counterspell"] = 2139, -- Антимагия
    --===Баффы===--
    ["Arcane Intellect"] = 1459, -- Чародейский интилект
    ["Blazing Barrier"] = 235313, -- Пылающая преграда
    ["Time Warp"] = 80353, -- Искажение времени
    --===Урон===--
    ["Mirror Image"] = 55342, -- Зеркальные изабражения
    ["Shifting Power"] = 382440, -- Переходящая сила
    ["Combustion"] = 190319, -- Возгорание
    ["Meteor"] = 153561, -- Метеорит
    ["Pyroblast"] = 11366, -- Огненная глыба
    ["Fire Blast"] = 108853, -- Огненный взрыв
    ["Fireball"] = 133, -- Огненный шар
    ["Scorch"] = 2948, -- Ожог
    ["Phoenix's Flames"] = 257541, -- Пламя феникса
    ["Dragon's Breath"] = 31661, -- Дыхание дракона
    ["Flamestrike"] = 2120, -- Огненный столб
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
    --===Чародейский интилект===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Arcane Intellect"]) then
            if not _A.DSL:Get("buff")("player", 1459) then      
                _A.Cast(spell_ids["Arcane Intellect"], "player")
            end
        end
    end,},
    --===Огненный барьер===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Blazing Barrier"]) then
            if not _A.DSL:Get("buff")("player", 235313) then
                if _A.DSL:Get("health")("player") <= 85 then     
                    _A.Cast(spell_ids["Blazing Barrier"], "player")
                end
            end
        end
    end,},
}
local SelfProtect = {
    --===Леденая глыба===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Ice Block"]) then
            if _A.DSL:Get("health")("player") <= 10 then
                if not _A.DSL:Get("debuff")("player", 41425) then      
                    _A.Cast(spell_ids["Ice Block"], "player")
                end
            end
        end
    end,},
    --===Великая невидимость===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Greater Invisibility"]) then
            if _A.DSL:Get("health")("player") <= 30 then      
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
            if _A.DSL:Get("health")("player") <= 70 then
                if not _A.DSL:Get("buff")("player", 342246) then       
                    _A.Cast(spell_ids["Time Manipulation"], "player")
                end
            end
        end
    end,},
    --{function()
        --if _A.DSL:Get("spell.ready")(_, spell_ids["Spellsteal"]) then
            --if _A.DSL:Get("los")("target") then         
                --if _A.DSL:Get("range")("target") < 39 then
                    --if _A.DSL:Get("buff")("target") then      
                       -- _A.Cast(spell_ids["Spellsteal"], "target")
                   -- end
               -- end
           -- end
      --  end
   -- end,},
}
local SelfProtectAlly = {
}
local Rotation = {
    ---===AOE===---
    --===АКТИВАЦИЯ БУРСТА===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Flamestrike"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if cache.aoe then
                    if DSL("range")(Obj.key) < 39 then
                        if _A.DSL:Get("buff")("player", 383883) then
                            if not _A.DSL:Get("buff")("player", 48108) then     
                                _A.Cast(spell_ids["Flamestrike"], "target")
                                _A.ClickPosition(_A.ObjectPosition(Obj.key))
                            end
                        end
                    end
                end
            end
        end
    end,},
    ---===Огненный столб===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Flamestrike"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if cache.aoe then
                    if DSL("range")(Obj.key) < 39 then
                        if _A.DSL:Get("buff")("player", 48108) then     
                            _A.Cast(spell_ids["Flamestrike"], "target")
                            _A.ClickPosition(_A.ObjectPosition(Obj.key))
                        end
                    end
                end
            end
        end
    end,},
    --===Пламя феникса===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Phoenix's Flames"]) then
            if cache.aoe then
                if _A.DSL:Get("buff")("player", 48107) then
                    if _A.DSL:Get("los")("target") then         
                        if _A.DSL:Get("range")("target") < 39 then
                            _A.Cast(spell_ids["Phoenix's Flames"], "target")
                        end
                    end
                end 
            end
        end
    end,},
    --===Дыхание дракона===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Dragon's Breath"]) then
            if cache.aoe then
                if _A.DSL:Get("buff")("player", 48107) then
                    if _A.DSL:Get("los")("target") then         
                        if _A.DSL:Get("range")("target") < 8 then
                            _A.Cast(spell_ids["Dragon's Breath"], "target")
                        end
                    end
                end 
            end
        end
    end,},
    --===Огненный взрыв===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Fire Blast"]) then
            if cache.aoe then
                if _A.DSL:Get("buff")("player", 48107) then
                    if _A.DSL:Get("los")("target") then         
                        if _A.DSL:Get("range")("target") < 39 then
                            _A.Cast(spell_ids["Fire Blast"], "target")
                        end
                    end
                end 
            end
        end
    end,},
    --===Метеорит===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Meteor"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if cache.aoe then
                    if DSL("range")(Obj.key) < 39 then     
                        _A.Cast(spell_ids["Meteor"], "target")
                        _A.ClickPosition(_A.ObjectPosition(Obj.key))
                    end
                end 
            end
        end
    end,},
    ---===Возгорание===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Combustion"]) then
            if cache.aoe then
                if not _A.DSL:Get("buff")("player", 190319) then      
                    _A.Cast(spell_ids["Combustion"], "player")
                end
            end
        end
    end,},
    --===Переходящия сила===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Shifting Power"]) then
            if cache.aoe then
                if not _A.DSL:Get("spell.ready")(_, spell_ids["Combustion"]) then
                    if not _A.DSL:Get("buff")("player", 190319) then      
                        _A.Cast(spell_ids["Shifting Power"], "player")
                    end
                end
            end
        end
    end,},
    --===Зеркальное изабражение===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Mirror Image"]) then
            if cache.aoe then   
                _A.Cast(spell_ids["Mirror Image"], "player")
            end
        end
    end,},
    --===Ожог при 30%===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Dragon's Breath"]) then
            if cache.aoe then
                if _A.DSL:Get("health")("target") <=30 then
                    if _A.DSL:Get("los")("target") then         
                        if _A.DSL:Get("range")("target") < 39 then
                            _A.Cast(spell_ids["Dragon's Breath"], "target")
                        end
                    end
                end 
            end
        end
    end,},
    --===Пламя феникса===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Phoenix's Flames"]) then
            if cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 39 then
                         _A.Cast(spell_ids["Phoenix's Flames"], "target")
                    end
                end 
            end
        end
    end,},
    --===Дыхание дракона===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Dragon's Breath"]) then
            if cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 8 then
                        _A.Cast(spell_ids["Dragon's Breath"], "target")
                    end
                end 
            end
        end
    end,},
    --===Огненный взрыв===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Fire Blast"]) then
            if cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 39 then
                        _A.Cast(spell_ids["Fire Blast"], "target")
                    end
                end 
            end
        end
    end,},
    --===Огненный шар===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Fireball"]) then
            if cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 39 then
                        _A.Cast(spell_ids["Fireball"], "target")
                    end
                end 
            end
        end
    end,},
    ---===SOLO===---
    --===АКТИВАЦИЯ БУРСТА===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Pyroblast"]) then
            if not cache.aoe then
                if _A.DSL:Get("los")("target") then
                    if _A.DSL:Get("buff")("player", 383883) then
                        if not _A.DSL:Get("buff")("player", 48108) then       
                            if _A.DSL:Get("range")("target") < 39 then
                                _A.Cast(spell_ids["Pyroblast"], "target")
                            end
                        end
                    end
                end 
            end
        end
    end,},
    --===Огненная глыба===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Pyroblast"]) then
            if not cache.aoe then
                if _A.DSL:Get("los")("target") then
                    if _A.DSL:Get("buff")("player", 48108) then       
                        if _A.DSL:Get("range")("target") < 39 then
                            _A.Cast(spell_ids["Pyroblast"], "target")
                        end
                    end
                end 
            end
        end
    end,},
    --===Пламя феникса(прок)===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Phoenix's Flames"]) then
            if not cache.aoe then
                if _A.DSL:Get("buff")("player", 48107) then
                    if _A.DSL:Get("los")("target") then         
                        if _A.DSL:Get("range")("target") < 39 then
                            _A.Cast(spell_ids["Phoenix's Flames"], "target")
                        end
                    end
                end 
            end
        end
    end,},
    --===Дыхание дракона(прок)===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Dragon's Breath"]) then
            if not cache.aoe then
                if _A.DSL:Get("buff")("player", 48107) then
                    if _A.DSL:Get("los")("target") then         
                        if _A.DSL:Get("range")("target") < 8 then
                            _A.Cast(spell_ids["Dragon's Breath"], "target")
                        end
                    end
                end 
            end
        end
    end,},
    --===Огненный взрыв(прок)===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Fire Blast"]) then
            if not cache.aoe then
                if _A.DSL:Get("buff")("player", 48107) then
                    if _A.DSL:Get("los")("target") then         
                        if _A.DSL:Get("range")("target") < 39 then
                            _A.Cast(spell_ids["Fire Blast"], "target")
                        end
                    end
                end 
            end
        end
    end,},
    --===Метеорит===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Meteor"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if not cache.aoe then
                    if DSL("range")(Obj.key) < 39 then     
                        _A.Cast(spell_ids["Meteor"], "target")
                        _A.ClickPosition(_A.ObjectPosition(Obj.key))
                    end
                end 
            end
        end
    end,},
    ---===Возгорание===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Combustion"]) then
            if not cache.aoe then
                if not _A.DSL:Get("buff")("player", 190319) then      
                    _A.Cast(spell_ids["Combustion"], "player")
                end
            end
        end
    end,},
    --===Переходящия сила===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Shifting Power"]) then
            if not cache.aoe then
                if not _A.DSL:Get("spell.ready")(_, spell_ids["Combustion"]) then
                    if not _A.DSL:Get("buff")("player", 190319) then      
                        _A.Cast(spell_ids["Shifting Power"], "player")
                    end
                end
            end
        end
    end,},
    --===Зеркальное изабражение===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Mirror Image"]) then
            if not cache.aoe then   
                _A.Cast(spell_ids["Mirror Image"], "player")
            end
        end
    end,},
    --===Ожог при 30%===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Dragon's Breath"]) then
            if not cache.aoe then
                if _A.DSL:Get("health")("target") <=30 then
                    if _A.DSL:Get("los")("target") then         
                        if _A.DSL:Get("range")("target") < 39 then
                            _A.Cast(spell_ids["Dragon's Breath"], "target")
                        end
                    end
                end 
            end
        end
    end,},
    --===Пламя феникса(Без прока)===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Phoenix's Flames"]) then
            if not cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 39 then
                         _A.Cast(spell_ids["Phoenix's Flames"], "target")
                    end
                end 
            end
        end
    end,},
    --===Дыхание дракона(Без прока)===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Dragon's Breath"]) then
            if not cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 8 then
                        _A.Cast(spell_ids["Dragon's Breath"], "target")
                    end
                end 
            end
        end
    end,},
    --===Огненный взрыв(Без прока)===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Fire Blast"]) then
            if not cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 39 then
                        _A.Cast(spell_ids["Fire Blast"], "target")
                    end
                end 
            end
        end
    end,},
    --===Огненный шар===--
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Fireball"]) then
            if not cache.aoe then
                if _A.DSL:Get("los")("target") then         
                    if _A.DSL:Get("range")("target") < 39 then
                        _A.Cast(spell_ids["Fireball"], "target")
                    end
                end 
            end
        end
    end,},
    --===Ожог при движении===--
    {"&Scorch", "spell.ready && player.moving"},
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

_A.CR:Add(63, {
    name = "Fire mage by Ackerman",
    load = function()
        print("Load function executed")
        exeOnLoad()
    end,
    gui = GUI,
    gui_st = {title="Fire mage by Ackerman", color="1EFF0C", width="400", height="500"},
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