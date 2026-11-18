-- Cole o link onde este script está hospedado (para reabrir sozinho após trocar de server)
local LINK="https://raw.githubusercontent.com/werllesontinoco2-hub/Tsao/main/KaitunVoxHub.lua"

pcall(function()
    if queue_on_teleport and LINK~="https://raw.githubusercontent.com/werllesontinoco2-hub/Tsao/main/KaitunVoxHub.lua" then
        queue_on_teleport('loadstring(game:HttpGet("'..LINK..'"))()')
    end
end)

local ok,err=pcall(function()
local CF={Mastery=400,MaxLvl=2800}
local EX={Stats=true,Buso=true,SafeHP=0.35,FPS=true,Rejoin=true,Frutas=true,Chests=true,
          Raca=true,Bounty=true,BountyAposEstilos=true,BountyHop=true}

local Players=game:GetService("Players")
local P=Players.LocalPlayer
local PG=P:WaitForChild("PlayerGui")
local TS=game:GetService("TweenService")
local RS=game:GetService("ReplicatedStorage")
local VU=game:GetService("VirtualUser")
local CS=game:GetService("CollectionService")
local UIS=game:GetService("UserInputService")
local TPS=game:GetService("TeleportService")
local CommF=RS:WaitForChild("Remotes"):WaitForChild("CommF_")

P.Idled:Connect(function() VU:CaptureController() VU:ClickButton1(Vector2.new()) end)

-- UI
local gui=Instance.new("ScreenGui") gui.Name="Kaitun" gui.ResetOnSpawn=false gui.Parent=PG
local fr=Instance.new("Frame",gui) fr.Size=UDim2.new(0,280,0,90) fr.Position=UDim2.new(0,10,0,60)
fr.BackgroundColor3=Color3.fromRGB(20,20,25) fr.BackgroundTransparency=0.2
Instance.new("UICorner",fr)
local l1=Instance.new("TextLabel",fr) l1.Size=UDim2.new(1,-10,0,40) l1.Position=UDim2.new(0,5,0,5)
l1.BackgroundTransparency=1 l1.TextColor3=Color3.new(1,1,1) l1.TextSize=14 l1.TextWrapped=true l1.Text="Iniciando..."
local l2=l1:Clone() l2.Parent=fr l2.Position=UDim2.new(0,5,0,48) l2.TextSize=12 l2.TextColor3=Color3.fromRGB(180,180,180)
local cores={ok=Color3.fromRGB(80,220,120),warn=Color3.fromRGB(255,200,60),error=Color3.fromRGB(255,90,90)}
local function SETT(m,k) l1.Text=m l1.TextColor3=cores[k] or Color3.new(1,1,1) end

-- DADOS E HELPERS
local function getData()
    local d=P:FindFirstChild("Data")
    local lvl,beli,frag=0,0,0
    if d then
        if d:FindFirstChild("Level") then lvl=d.Level.Value end
        if d:FindFirstChild("Beli") then beli=d.Beli.Value end
        if d:FindFirstChild("Fragments") then frag=d.Fragments.Value end
    end
    return lvl,beli,frag
end
local function UP()
    local lvl,beli,frag=getData()
    local ls=P:FindFirstChild("leaderstats")
    local b=ls and (ls:FindFirstChild("Bounty/Honor") or ls:FindFirstChild("Bounty"))
    l2.Text=("Lv %d | Beli %d | Frags %d%s"):format(lvl,beli,frag,b and (" | Bounty "..b.Value) or "")
end
local function GR() return P.Character and P.Character:FindFirstChild("HumanoidRootPart") end
local function GH() return P.Character and P.Character:FindFirstChildOfClass("Humanoid") end
local function getTool(n)
    local c,bp=P.Character,P:FindFirstChild("Backpack")
    return (c and c:FindFirstChild(n)) or (bp and bp:FindFirstChild(n))
end
local function getMastery(n)
    local t=getTool(n) local l=t and t:FindFirstChild("Level")
    return l and l.Value or 0
end
local function equipar(n)
    local t,h=getTool(n),GH()
    if t and h and t.Parent~=P.Character then pcall(function() h:EquipTool(t) end) end
end

-- MARES
local SEAS={[2753915549]=1,[4442272183]=2,[7449423635]=3}
local mar=SEAS[game.PlaceId] or 1
local function marDoLvl(lvl) return lvl>=1500 and 3 or (lvl>=700 and 2 or 1) end

-- QUESTS {nivelMin, mob, quest, indice}
local Q={
{0,"Bandit","BanditQuest1",1},{10,"Monkey","JungleQuest",1},{15,"Gorilla","JungleQuest",2},
{30,"Pirate","BuggyQuest1",1},{40,"Brute","BuggyQuest1",2},{60,"Desert Bandit","DesertQuest",1},
{75,"Desert Officer","DesertQuest",2},{90,"Snow Bandit","SnowQuest",1},{100,"Snowman","SnowQuest",2},
{120,"Chief Petty Officer","MarineQuest2",1},{150,"Sky Bandit","SkyQuest",1},{175,"Dark Master","SkyQuest",2},
{190,"Prisoner","PrisonerQuest",1},{210,"Dangerous Prisoner","PrisonerQuest",2},{250,"Toga Warrior","ColosseumQuest",1},
{275,"Gladiator","ColosseumQuest",2},{300,"Military Soldier","MagmaQuest",1},{325,"Military Spy","MagmaQuest",2},
{375,"Fishman Warrior","FishmanQuest",1},{400,"Fishman Commando","FishmanQuest",2},{450,"God's Guard","SkyExp1Quest",1},
{475,"Shanda","SkyExp1Quest",2},{525,"Royal Squad","SkyExp2Quest",1},{550,"Royal Soldier","SkyExp2Quest",2},
{625,"Galley Pirate","FountainQuest",1},{650,"Galley Captain","FountainQuest",2},
{700,"Raider","Area1Quest",1},{725,"Mercenary","Area1Quest",2},{775,"Swan Pirate","Area2Quest",1},
{800,"Factory Staff","Area2Quest",2},{875,"Marine Lieutenant","MarineQuest3",1},{900,"Marine Captain","MarineQuest3",2},
{950,"Zombie","ZombieQuest",1},{975,"Vampire","ZombieQuest",2},{1000,"Snow Trooper","SnowMountainQuest",1},
{1050,"Winter Warrior","SnowMountainQuest",2},{1100,"Lab Subordinate","IceSideQuest",1},{1125,"Horned Warrior","IceSideQuest",2},
{1175,"Magma Ninja","FireSideQuest",1},{1200,"Lava Pirate","FireSideQuest",2},{1250,"Ship Deckhand","ShipQuest1",1},
{1275,"Ship Engineer","ShipQuest1",2},{1300,"Ship Steward","ShipQuest2",1},{1325,"Ship Officer","ShipQuest2",2},
{1350,"Arctic Warrior","FrostQuest",1},{1375,"Snow Lurker","FrostQuest",2},{1425,"Sea Soldier","ForgottenQuest",1},
{1450,"Water Fighter","ForgottenQuest",2},
{1500,"Pirate Millionaire","PiratePortQuest",1},{1525,"Pistol Billionaire","PiratePortQuest",2},
{1575,"Dragon Crew Warrior","AmazonQuest",1},{1600,"Dragon Crew Archer","AmazonQuest",2},
{1625,"Female Islander","AmazonQuest2",1},{1650,"Giant Islander","AmazonQuest2",2},
{1700,"Marine Commodore","MarineTreeIsland",1},{1725,"Marine Rear Admiral","MarineTreeIsland",2},
{1775,"Fishman Raider","DeepForestIsland3",1},{1800,"Fishman Captain","DeepForestIsland3",2},
{1825,"Forest Pirate","DeepForestIsland",1},{1850,"Mythological Pirate","DeepForestIsland",2},
{1900,"Jungle Pirate","DeepForestIsland2",1},{1925,"Musketeer Pirate","DeepForestIsland2",2},
{1975,"Reborn Skeleton","HauntedQuest1",1},{2000,"Living Zombie","HauntedQuest1",2},
{2025,"Demonic Soul","HauntedQuest2",1},{2050,"Posessed Mummy","HauntedQuest2",2},
{2075,"Peanut Scout","NutsIslandQuest",1},{2100,"Peanut President","NutsIslandQuest",2},
{2125,"Ice Cream Chef","IceCreamIslandQuest",1},{2150,"Ice Cream Commander","IceCreamIslandQuest",2},
{2200,"Cookie Crafter","CakeQuest1",1},{2225,"Cake Guard","CakeQuest1",2},
{2250,"Baking Staff","CakeQuest2",1},{2275,"Head Baker","CakeQuest2",2},
{2300,"Cocoa Warrior","ChocQuest1",1},{2325,"Chocolate Bar Battler","ChocQuest1",2},
{2350,"Sweet Thief","ChocQuest2",1},{2375,"Candy Rebel","ChocQuest2",2},
{2400,"Candy Pirate","CandyQuest1",1},{2425,"Snow Demon","CandyQuest1",2},
{2450,"Isle Outlaw","TikiQuest1",1},{2475,"Island Boy","TikiQuest1",2},
{2525,"Sun-kissed Warrior","TikiQuest2",1},{2550,"Isle Champion","TikiQuest2",2},
{2600,"Serpent Hunter","TikiQuest3",1},{2625,"Skull Slayer","TikiQuest3",2},
}
local function getQuest(lvl)
    local r
    for _,q in ipairs(Q) do if lvl>=q[1] then r=q end end
    return r
end

-- POSIÇÕES DOS NPCs (aperte K perto do NPC e cole aqui)
local QuestPos={
    -- ["BanditQuest1"]=Vector3.new(x,y,z),
}

-- ESTILOS (ordem da cadeia do God Human)
local Estilos={
    {"Black Leg","BuyBlackLeg"},{"Electro","BuyElectro"},{"Fishman Karate","BuyFishmanKarate"},{"Dragon Claw","BuyDragonClaw"},
    {"Superhuman","BuySuperhuman"},{"Death Step","BuyDeathStep"},{"Sharkman Karate","BuySharkmanKarate"},
    {"Electric Claw","BuyElectricClaw"},{"Dragon Talon","BuyDragonTalon"},
}
local ultimaCompra=0
local function estiloAtual()
    for _,e in ipairs(Estilos) do
        if getTool(e[1]) and getMastery(e[1])<CF.Mastery then return e[1] end
    end
    if tick()-ultimaCompra>20 then
        ultimaCompra=tick()
        for _,e in ipairs(Estilos) do
            if not getTool(e[1]) then
                pcall(function() CommF:InvokeServer(e[2]) end)
                task.wait(1)
                if getTool(e[1]) then return e[1] end
                break
            end
        end
    end
    return nil
end
local function todosProntos()
    for _,e in ipairs(Estilos) do if getMastery(e[1])<CF.Mastery then return false end end
    return true
end

-- VOO
local function voarPara(pos,speed)
    speed=speed or 250
    local hrp,h=GR(),GH()
    if not hrp or not h then return end
    local d=(pos-hrp.Position).Magnitude
    if d<15 then return end
    local tw=TS:Create(hrp,TweenInfo.new(d/speed,Enum.EasingStyle.Linear),{CFrame=CFrame.new(pos)})
    tw:Play()
    local t0=tick()
    while tick()-t0<d/speed+3 and hrp.Parent and (pos-hrp.Position).Magnitude>15 do task.wait(0.1) end
    pcall(function() tw:Cancel() end)
end
local function irAoNPC(nomeQuest)
    local p=QuestPos[nomeQuest]
    if p then voarPara(p+Vector3.new(0,3,0),300) end
end

-- INIMIGOS E COMBATE
local function acharMob(nome)
    local best,bd
    local hrp=GR()
    local en=workspace:FindFirstChild("Enemies")
    if not en or not hrp then return end
    for _,m in ipairs(en:GetChildren()) do
        local h=m:FindFirstChildOfClass("Humanoid") local r=m:FindFirstChild("HumanoidRootPart")
        if m.Name==nome and h and r and h.Health>0 then
            local d=(r.Position-hrp.Position).Magnitude
            if not bd or d<bd then best,bd=m,d end
        end
    end
    return best
end
local function acharSpawn(nome)
    local wo=workspace:FindFirstChild("_WorldOrigin")
    local sp=wo and wo:FindFirstChild("EnemySpawns")
    local hrp=GR()
    if not sp or not hrp then return end
    local best,bd
    for _,s in ipairs(sp:GetChildren()) do
        if s:IsA("BasePart") and s.Name:find(nome,1,true) then
            local d=(s.Position-hrp.Position).Magnitude
            if not bd or d<bd then best,bd=s,d end
        end
    end
    return best
end
local function questAtiva()
    local m=PG:FindFirstChild("Main") local q=m and m:FindFirstChild("Quest")
    return q and q.Visible
end
local function atacar(estilo)
    equipar(estilo)
    pcall(function()
        VU:CaptureController() VU:ClickButton1(Vector2.new(900,500))
        local t=P.Character and P.Character:FindFirstChildOfClass("Tool")
        if t then t:Activate() end
    end)
end

-- VIDA SEGURA
local function vidaSegura()
    local h,r=GH(),GR()
    if not h or not r or h.Health/h.MaxHealth>=EX.SafeHP then return false end
    SETT("Vida baixa, regenerando...","warn")
    local base=r.Position
    h.PlatformStand=true
    while h.Parent and h.Health>0 and h.Health/h.MaxHealth<0.85 do
        r=GR() if not r then break end
        r.CFrame=CFrame.new(base.X,base.Y+250,base.Z)
        r.AssemblyLinearVelocity=Vector3.zero
        task.wait(0.5)
    end
    h.PlatformStand=false
    return true
end

-- BAÚS
local function coletarBaus()
    local lista=CS:GetTagged("_ChestTagged")
    local hrp=GR()
    if #lista==0 or not hrp then return end
    table.sort(lista,function(a,b)
        return (a.Position-hrp.Position).Magnitude<(b.Position-hrp.Position).Magnitude
    end)
    local n=0
    for _,c in ipairs(lista) do
        if n>=5 then break end
        if c:IsA("BasePart") and c.Parent then
            SETT("Coletando baú...","warn")
            voarPara(c.Position,300)
            local r=GR()
            if r then r.CFrame=c.CFrame task.wait(0.4) end
            n=n+1
        end
    end
end

-- LOOPS PARALELOS (status, buso, frutas, rejoin, fps)
task.spawn(function()
    while EX.Stats do
        task.wait(5)
        local pts=P:FindFirstChild("Data") and P.Data:FindFirstChild("Points")
        if pts and pts.Value>0 then
            local n=pts.Value local m=math.floor(n/2)
            pcall(function() CommF:InvokeServer("AddPoint","Melee",m) end)
            pcall(function() CommF:InvokeServer("AddPoint","Defense",n-m) end)
        end
    end
end)
task.spawn(function()
    while EX.Buso do
        task.wait(4)
        local c=P.Character
        if c and not c:FindFirstChild("HasBuso") then pcall(function() CommF:InvokeServer("Buso") end) end
    end
end)
task.spawn(function()
    while EX.Frutas do
        task.wait(10)
        local bp=P:FindFirstChild("Backpack")
        if bp then
            for _,t in ipairs(bp:GetChildren()) do
                if t:IsA("Tool") and t.Name:find("Fruit",1,true) then
                    local nome=t:GetAttribute("OriginalName") or t.Name
                    pcall(function() CommF:InvokeServer("StoreFruit",nome,t) end)
                    task.wait(0.5)
                end
            end
        end
    end
end)
if EX.Rejoin then
    game:GetService("GuiService").ErrorMessageChanged:Connect(function()
        task.wait(3)
        TPS:Teleport(game.PlaceId,P)
    end)
end
if EX.FPS then
    pcall(function()
        settings().Rendering.QualityLevel=Enum.QualityLevel.Level01
        local L=game:GetService("Lighting")
        L.GlobalShadows=false L.FogEnd=9e9
        for _,v in ipairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then v.Enabled=false end
        end
    end)
end

-- Tecla K: copia sua posição (para preencher QuestPos)
UIS.InputBegan:Connect(function(i,gp)
    if gp or i.KeyCode~=Enum.KeyCode.K then return end
    local r=GR() if not r then return end
    local p=r.Position
    local s=("Vector3.new(%d,%d,%d)"):format(p.X,p.Y,p.Z)
    if setclipboard then pcall(setclipboard,s) end
    print("POS: "..s) SETT("Posição copiada: "..s,"ok")
end)

-- ===== RAÇA V2 / V3 / V4 =====
local FL={"Blue Flower","Red Flower","Yellow Flower"}
local function racaInfo()
    local d=P:FindFirstChild("Data")
    local r=d and d:FindFirstChild("Race")
    return r and tostring(r.Value) or "Human", r
end
local function temMarca(m) local _,r=racaInfo() return r and r:FindFirstChild(m)~=nil end
do
    local nome,r=racaInfo()
    local t={} if r then for _,c in ipairs(r:GetChildren()) do t[#t+1]=c.Name end end
    print("RACA:",nome,"| marcas:",table.concat(t,", "))
end
local function remoto(...)
    local a={...}
    local okk,res=pcall(function() return CommF:InvokeServer(table.unpack(a)) end)
    print("REMOTE",a[1],a[2],"->",okk and tostring(res) or "erro")
    return okk and res
end
local function cacarMob(nome,seg)
    local est=estiloAtual() or "Combat"
    local t0=tick()
    local m=acharMob(nome)
    if not m then
        local sp=acharSpawn(nome)
        if sp then voarPara(sp.Position+Vector3.new(0,20,0),300) end
        return false
    end
    local mh=m:FindFirstChildOfClass("Humanoid")
    local h=GH() if h then h.PlatformStand=true end
    while mh and mh.Health>0 and m.Parent and tick()-t0<seg do
        local mr,r,hh=m:FindFirstChild("HumanoidRootPart"),GR(),GH()
        if not mr or not r or not hh or hh.Health/hh.MaxHealth<EX.SafeHP then break end
        r.CFrame=mr.CFrame*CFrame.new(0,9,0)
        r.AssemblyLinearVelocity=Vector3.zero
        atacar(est) task.wait(0.1)
    end
    local h2=GH() if h2 then h2.PlatformStand=false end
    return true
end
local function pegarObjeto(o)
    local pos=o:IsA("BasePart") and o.Position or (o.PrimaryPart and o.PrimaryPart.Position)
    if not pos then return end
    voarPara(pos+Vector3.new(0,3,0),300)
    local r=GR()
    if r then
        r.CFrame=CFrame.new(pos)
        if firetouchinterest and o:IsA("BasePart") then pcall(function() firetouchinterest(r,o,0) firetouchinterest(r,o,1) end) end
    end
    task.wait(0.5)
end
local function racaV2()
    local lvl,beli=getData()
    if mar~=2 or lvl<850 then return false end
    if beli<2000000 then SETT("V2 precisa de 2M de Beli","warn") return false end
    remoto("Alchemist","1")
    for i,nome in ipairs(FL) do
        if not getTool(nome) then
            local f=workspace:FindFirstChild("Flower"..i)
            if f then SETT("Pegando "..nome,"warn") pegarObjeto(f)
            elseif i==3 then SETT("Farmando Zumbi (Yellow Flower)","warn") cacarMob("Zombie",60)
            elseif i==2 then SETT("Farmando Swan Pirate (Red Flower)","warn") cacarMob("Swan Pirate",60)
            else SETT("Blue Flower só aparece à noite","warn") return false end
            return true
        end
    end
    remoto("Alchemist","2") task.wait(1)
    remoto("Alchemist","3")
    return true
end
local function racaV3()
    if mar~=3 then return false end
    local nome=racaInfo()
    remoto("Wenlocktoad","1")
    if nome=="Human" then
        for _,b in ipairs({"Diamond","Jeremy","Fajita"}) do
            if acharMob(b) then SETT("Boss "..b,"warn") cacarMob(b,90) return true end
        end
    elseif nome=="Mink" then
        coletarBaus() return true
    else
        SETT("V3 de "..nome..": passo manual","warn")
    end
    remoto("Wenlocktoad","2") task.wait(1)
    remoto("Wenlocktoad","3")
    return false
end
local function v4Monitor()
    local map=workspace:FindFirstChild("Map")
    local mi=map and map:FindFirstChild("MysticIsland")
    if mi then
        SETT("Mirage Island apareceu!","ok")
        voarPara(mi:GetPivot().Position+Vector3.new(0,300,0),300)
        return true
    end
    return false
end
local function corridaRaca()
    if not temMarca("Evolved") then return racaV2() end
    return racaV3() or v4Monitor()
end

-- ===== AUTO BOUNTY =====
pcall(function() CommF:InvokeServer("EnablePvp") end)
local amigos={}
local function ehAmigo(pl)
    if amigos[pl.UserId]==nil then
        local okk,r=pcall(function() return P:IsFriendsWith(pl.UserId) end)
        amigos[pl.UserId]=okk and r or false
    end
    return amigos[pl.UserId]
end
local function alvoBounty()
    local hrp=GR()
    if not hrp then return end
    local best,bd
    for _,pl in ipairs(Players:GetPlayers()) do
        local c=pl.Character
        local r=c and c:FindFirstChild("HumanoidRootPart")
        local h=c and c:FindFirstChildOfClass("Humanoid")
        if pl~=P and r and h and h.Health>0 and not c:FindFirstChildOfClass("ForceField") and not ehAmigo(pl) then
            local d=(r.Position-hrp.Position).Magnitude
            if not bd or d<bd then best,bd=pl,d end
        end
    end
    return best
end
local ultHop=0
local function cacarBounty()
    local est=estiloAtual() or "Combat"
    local pl=alvoBounty()
    if not pl then
        if EX.BountyHop and tick()-ultHop>30 then
            ultHop=tick()
            SETT("Sem alvos, trocando de server...","warn")
            pcall(function() TPS:Teleport(game.PlaceId,P) end)
        else
            SETT("Sem alvos no server","warn")
        end
        return false
    end
    SETT("Bounty: "..pl.Name,"warn")
    local c=pl.Character
    local r=c and c:FindFirstChild("HumanoidRootPart")
    if not r then return false end
    voarPara(r.Position+Vector3.new(0,8,0),300)
    local h=GH() if h then h.PlatformStand=true end
    local t0=tick()
    while tick()-t0<25 do
        c=pl.Character
        r=c and c:FindFirstChild("HumanoidRootPart")
        local th=c and c:FindFirstChildOfClass("Humanoid")
        local me,hh=GR(),GH()
        if not r or not th or th.Health<=0 or not me or not hh then break end
        if hh.Health/hh.MaxHealth<EX.SafeHP then break end
        if c:FindFirstChildOfClass("ForceField") then break end
        me.CFrame=r.CFrame*CFrame.new(0,6,0)
        me.AssemblyLinearVelocity=Vector3.zero
        atacar(est) task.wait(0.1)
    end
    local h2=GH() if h2 then h2.PlatformStand=false end
    return true
end
local function bountyLiberado()
    local lvl=getData()
    if lvl<CF.MaxLvl then return false end
    if EX.BountyAposEstilos and not todosProntos() then return false end
    return true
end

-- ===== LOOP PRINCIPAL =====
local questAtual,ultMar,ultBau,ultGH,ultRaca=nil,0,0,0,0
local godOk=false
UP() SETT("Kaitun iniciado!","ok")

task.spawn(function()
    while true do
        task.wait(0.3)
        pcall(UP)
        local hrp,hum=GR(),GH()
        if not hrp or not hum or hum.Health<=0 then SETT("Aguardando respawn...","error") task.wait(2) continue end

        if vidaSegura() then continue end

        local lvl=getData()
        local estilo=estiloAtual()

        -- God Human
        if not godOk and todosProntos() and tick()-ultGH>20 then
            ultGH=tick()
            pcall(function() CommF:InvokeServer("BuyGodhuman") end)
            task.wait(1)
            if getTool("Godhuman") or getTool("God Human") then godOk=true SETT("God Human obtido!","ok") end
        end

        -- baús
        if EX.Chests and tick()-ultBau>180 then
            ultBau=tick() coletarBaus() continue
        end

        -- raça
        if EX.Raca and tick()-ultRaca>8 then
            ultRaca=tick()
            if corridaRaca() then continue end
        end

        -- bounty (só no level máximo)
        if EX.Bounty and bountyLiberado() then
            if cacarBounty() then continue end
        end

        -- troca de mar
        local marAlvo=marDoLvl(lvl)
        if marAlvo>mar then
            if tick()-ultMar>15 then
                ultMar=tick()
                SETT("Viajando pro Mar "..marAlvo,"warn")
                pcall(function() CommF:InvokeServer(marAlvo==2 and "TravelDressrosa" or "TravelZou") end)
            end
            continue
        end

        local q=getQuest(lvl)
        if not q then continue end
        if marDoLvl(q[1])~=mar then SETT("Mar errado para o level "..lvl,"error") task.wait(3) continue end

        -- quest
        if questAtual and questAtual~=q[3]..q[4] then
            pcall(function() CommF:InvokeServer("AbandonQuest") end)
            questAtual=nil
        end
        if not questAtiva() then
            irAoNPC(q[3])
            pcall(function() CommF:InvokeServer("StartQuest",q[3],q[4]) end)
            task.wait(0.5)
            if questAtiva() then questAtual=q[3]..q[4] end
        end

        -- alvo
        local mob=acharMob(q[2])
        if not mob then
            local sp=acharSpawn(q[2])
            if sp then SETT("Indo até "..q[2],"warn") voarPara(sp.Position+Vector3.new(0,20,0),300)
            else SETT("Sem "..q[2].." (spawn não achado)","error") task.wait(2) end
            continue
        end

        SETT((estilo or "Sem estilo").." "..(estilo and (getMastery(estilo).."/"..CF.Mastery) or "").." | "..q[2],"ok")
        local mh=mob:FindFirstChildOfClass("Humanoid")
        local t0=tick()
        hum.PlatformStand=true
        while mh and mh.Health>0 and mob.Parent and tick()-t0<40 do
            local hh=GH()
            if not hh or hh.Health/hh.MaxHealth<EX.SafeHP then break end
            local mr=mob:FindFirstChild("HumanoidRootPart")
            local r=GR()
            if not mr or not r then break end
            r.CFrame=mr.CFrame*CFrame.new(0,9,0)
            r.AssemblyLinearVelocity=Vector3.zero
            atacar(estilo or "Combat")
            task.wait(0.1)
        end
        hum.PlatformStand=false
    end
end)
end)
if not ok then warn("Kaitun erro: "..tostring(err)) end