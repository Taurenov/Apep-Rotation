local addonName, _A = ...
local _G = _A._G
local U = _A.Cache.Utils
local DSL = function(api) return _A.DSL:Get(api) end


local routine_mode = {
	{key = '1', text = 'RAID'},
	{key = '2', text = 'M+'},
}

local GUI = {
    {type = 'combo', default = '2', key = 'routine_mode', list = routine_mode, width = 50},
}
local spell_ids = {
    ["Rend"] = 772, -- кровопускание
    ["Avatar"] = 107574, -- аватар
    ["Colossus Smash"] = 167105, -- Удар колосса
    ["Mortal Strike"] = 12294, -- Смертельный удар
    ["Thunderous Roar"] = 384318, -- громогласный рык
    ["Execute"] = 281000, -- Казнь
    ["Overpower"] = 7384, -- Превосходство
    ["Ignore Pain"] = 190456, -- стойкость к боли
    ["Whirlwind"] = 1680, -- Вихрь
    ["Slam"] = 1464, -- Мощный удар
    ["Warbreaker"] = 262161, -- Миротворец
    ["Thunder Clap"] = 396719, -- Удар грома
    ["Bladestorm"] = 389774, -- Вихрь клинков
    ["Sweeping Strikes"] = 260708, -- Размашистые удары
    ["Cleave"] = 845, -- Рассекающий удар
}
local exeOnLoad = function()
    print("Ротация загружена")
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
local RotationR = {
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Rend"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if _A.DSL:Get("los")("target") then
                    if not _A.DSL:Get("debuff")("target", 388539) then      
                        if _A.DSL:Get("range")("target") < 3 then
                            _A.Cast(spell_ids["Rend"], "target")
                        end
                    end
                end
            end
        end
    end,},
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Avatar"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if _A.DSL:Get("los")("target") then   
                    if _A.DSL:Get("range")("target") < 3 then
                        _A.Cast(spell_ids["Avatar"], "target")
                    end
                end
            end
        end
    end,},
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Colossus Smash"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if _A.DSL:Get("los")("target") then   
                    if _A.DSL:Get("range")("target") < 3 then
                        _A.Cast(spell_ids["Colossus Smash"], "target")
                    end
                end
            end
        end
    end,},
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Mortal Strike"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if _A.DSL:Get("los")("target") then   
                    if _A.DSL:Get("range")("target") < 3 then
                        _A.Cast(spell_ids["Mortal Strike"], "target")
                    end
                end
            end
        end
    end,},
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Thunderous Roar"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if _A.DSL:Get("los")("target") then   
                    if _A.DSL:Get("range")("target") < 3 then
                        _A.Cast(spell_ids["Thunderous Roar"], "target")
                    end
                end
            end
        end
    end,},
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Execute"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if _A.DSL:Get("los")("target") then   
                    if _A.DSL:Get("range")("target") < 3 then
                        _A.Cast(spell_ids["Execute"], "target")
                    end
                end
            end
        end
    end,},
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Overpower"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if _A.DSL:Get("los")("target") then   
                    if _A.DSL:Get("range")("target") < 3 then
                        _A.Cast(spell_ids["Overpower"], "target")
                    end
                end
            end
        end
    end,},
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Ignore Pain"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if not _A.DSL:Get("buff")("player", 190456) then   
                    if _A.DSL:Get("range")("target") < 3 then
                        _A.Cast(spell_ids["Ignore Pain"], "target")
                    end
                end
            end
        end
    end,},
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Whirlwind"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if _A.DSL:Get("los")("target") then   
                    if _A.DSL:Get("range")("target") < 3 then
                        _A.Cast(spell_ids["Whirlwind"], "target")
                    end
                end
            end
        end
    end,},
    {function()
        if _A.DSL:Get("spell.ready")(_, spell_ids["Slam"]) then
            local Enemy = _A.OM:Get('EnemyCombat')
            for _,Obj in pairs(Enemy) do
                if _A.DSL:Get("los")("target") then   
                    if _A.DSL:Get("range")("target") < 3 then
                        _A.Cast(spell_ids["Slam"], "target")
                    end
                end
            end
        end
    end,},
}
local RotationM = {
----------AOE M+-------------------
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Thunder Clap"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if cache.aoe then
                if _A.DSL:Get("los")(Obj.key) then
                    if not _A.DSL:Get("debuff")(Obj.key, 388539) then    
                        if _A.DSL:Get("range")(Obj.key) < 3 then
                            _A.Cast(spell_ids["Thunder Clap"], Obj.key)
                        end
                    end
                end
            end
        end
    end
end,},
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Warbreaker"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if cache.aoe then
                if _A.DSL:Get("los")(Obj.key) then   
                    if _A.DSL:Get("range")(Obj.key) < 3 then
                        _A.Cast(spell_ids["Warbreaker"], Obj.key)
                    end
                end
            end
        end
    end
end,},
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Avatar"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if cache.aoe then
                if _A.DSL:Get("los")(Obj.key) then   
                    if _A.DSL:Get("range")(Obj.key) < 3 then
                        _A.Cast(spell_ids["Avatar"], Obj.key)
                    end
                end
            end
        end
    end
end,},
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Whirlwind"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if cache.aoe then
                if _A.DSL:Get("los")(Obj.key) then   
                    if _A.DSL:Get("range")(Obj.key) < 3 then
                        _A.Cast(spell_ids["Whirlwind"], Obj.key)
                    end
                end
            end
        end
    end
end,},
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Bladestorm"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if cache.aoe then
                if _A.DSL:Get("los")(Obj.key) then   
                    if _A.DSL:Get("range")(Obj.key) < 3 then
                        _A.Cast(spell_ids["Bladestorm"], Obj.key)
                   end
                end
            end
        end
    end
end,},
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Thunderous Roar"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if cache.aoe then
                if _A.DSL:Get("los")(Obj.key) then   
                    if _A.DSL:Get("range")(Obj.key) < 3 then
                        _A.Cast(spell_ids["Thunderous Roar"], Obj.key)
                    end
                end
            end
        end
    end
end,},
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Sweeping Strikes"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if cache.aoe then
                if _A.DSL:Get("los")(Obj.key) then   
                    if _A.DSL:Get("range")(Obj.key) < 3 then
                        _A.Cast(spell_ids["Sweeping Strikes"], Obj.key)
                    end
                end
            end
        end
    end
end,},
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Execute"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if cache.aoe then
                if _A.DSL:Get("los")(Obj.key) then   
                    if _A.DSL:Get("range")(Obj.key) < 3 then
                        _A.Cast(spell_ids["Execute"], Obj.key)
                    end
                end
            end
        end
    end
end,},
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Mortal Strike"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if cache.aoe then
                if _A.DSL:Get("los")(Obj.key) then   
                    if _A.DSL:Get("range")(Obj.key) < 3 then
                        _A.Cast(spell_ids["Mortal Strike"], Obj.key)
                    end
                end
            end
        end
    end
end,},
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Cleave"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if cache.aoe then 
                if _A.DSL:Get("los")(Obj.key) then   
                    if _A.DSL:Get("range")(Obj.key) < 3 then
                        _A.Cast(spell_ids["Cleave"], Obj.key)
                    end
                end
            end
        end
    end
end,},
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Overpower"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if cache.aoe then
                if _A.DSL:Get("los")(Obj.key) then   
                    if _A.DSL:Get("range")(Obj.key) < 3 then
                        _A.Cast(spell_ids["Overpower"], Obj.key)
                    end
                end
            end
        end
    end
end,},
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Rend"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if _A.DSL:Get("los")(Obj.key) then
                if not cache.aoe then
                    if not _A.DSL:Get("debuff")(Obj.key, 388539) then      
                        if _A.DSL:Get("range")(Obj.key) < 3 then
                            _A.Cast(spell_ids["Rend"], Obj.key)
                        end
                    end
                end
            end
        end
    end
end,},
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Avatar"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if not cache.aoe then
                if _A.DSL:Get("los")(Obj.key) then   
                    if _A.DSL:Get("range")(Obj.key) < 3 then
                        _A.Cast(spell_ids["Avatar"], Obj.key)
                    end
                end
            end
        end
    end
end,},
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Warbreaker"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if not cache.aoe then
                if _A.DSL:Get("los")(Obj.key) then   
                    if _A.DSL:Get("range")(Obj.key) < 3 then
                        _A.Cast(spell_ids["Warbreaker"], Obj.key)
                    end
                end
            end
        end
    end
end,},
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Mortal Strike"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if not cache.aoe then
                if _A.DSL:Get("los")(Obj.key) then   
                    if _A.DSL:Get("range")(Obj.key) < 3 then
                        _A.Cast(spell_ids["Mortal Strike"], Obj.key)
                    end
                end
            end
        end
    end
end,},
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Thunderous Roar"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if not cache.aoe then
                if _A.DSL:Get("los")(Obj.key) then   
                    if _A.DSL:Get("range")(Obj.key) < 3 then
                        _A.Cast(spell_ids["Thunderous Roar"], Obj.key)
                    end
                end
            end
        end
    end
end,},
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Execute"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if not cache.aoe then
                if _A.DSL:Get("los")(Obj.key) then   
                    if _A.DSL:Get("range")(Obj.key) < 3 then
                        _A.Cast(spell_ids["Execute"], Obj.key)
                    end
                end
            end
        end
    end
end,},
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Overpower"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if not cache.aoe then
                if _A.DSL:Get("los")(Obj.key) then   
                    if _A.DSL:Get("range")(Obj.key) < 3 then
                        _A.Cast(spell_ids["Overpower"], Obj.key)
                    end
                end
            end
        end
    end
end,},
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Ignore Pain"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if not cache.aoe then
                if not _A.DSL:Get("buff")("player", 190456) then   
                    if _A.DSL:Get("range")(Obj.key) < 3 then
                        _A.Cast(spell_ids["Ignore Pain"], Obj.key)
                    end
                end
            end
        end
    end
end,},
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Whirlwind"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if not cache.aoe then
                if _A.DSL:Get("los")(Obj.key) then   
                    if _A.DSL:Get("range")(Obj.key) < 3 then
                        _A.Cast(spell_ids["Whirlwind"], Obj.key)
                    end
                end
            end
        end
    end
end,},
{function()
    if _A.DSL:Get("spell.ready")(_, spell_ids["Slam"]) then
        local Enemy = _A.OM:Get('EnemyCombat')
        for _,Obj in pairs(Enemy) do
            if not cache.aoe then
                if _A.DSL:Get("los")(Obj.key) then   
                    if _A.DSL:Get("range")(Obj.key) < 3 then
                        _A.Cast(spell_ids["Slam"], Obj.key)
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
    {RotationR, 'UI(routine_mode)==1'},
    {RotationM, 'UI(routine_mode)==2'},
}
local outOfCombat = {
}

_A.CR:Add(71, {
    name = "[ARMS(BETA)]",
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
    wow_ver = "10.1.7",
    apep_ver = "1.1",
    unload = function()
        print("Unload function executed")
        exeOnUnload()
    end
})