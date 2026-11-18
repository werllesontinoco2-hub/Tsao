local LINK="SEU_LINK_AQUI"   -- link onde o script está hospedado (opcional)
pcall(function()
    if queue_on_teleport and LINK~="SEU_LINK_AQUI" then
        queue_on_teleport('loadstring(game:HttpGet("'..LINK..'"))()')
    end
end)

local G=(getgenv and getgenv()) or _G
local ID=tostring(os.clock())..math.random(1,1e6)
G.KAITUN_ID=ID                                   -- derruba cópias antigas
local function vivo() return G.KAITUN_ID==ID end

local ok,err=pcall(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local Players=game:GetService("Players")
local P=Players.LocalPlayer
local PG=P:WaitForChild("PlayerGui")
local TS=game:GetService("TweenService")
local RS=game:GetService("ReplicatedStorage")
local VU=game:GetService("VirtualUser")
local VIM=game:GetService("VirtualInputManager")
local CS=game:GetService("CollectionService")
local UIS=game:GetService("UserInputService")
local RunS=game:GetService("RunService")
local TPS=game:GetService("TeleportService")
local CommF=RS:WaitForChild("Remotes"):WaitForChild("CommF_")

-- ================= CONFIG =================
local CFG={MaxLvl=2800,Mastery=400,SafeHP=0.25,Team="Pirates",Vel=250,
           Stats={Melee=1,Defense=1}}              -- pesos dos pontos de status
local T={Farm=true,Estilos=true,Stats=true,Buso=true,Frutas=true,Baus=false,
         Raca=true,Bounty=true,Hop=true,Trazer=false,FPS=true}
local QuestPos={ -- aperte K perto do NPC e cole aqui (opcional)
    -- ["BanditQuest1"]=Vector3.new(x,y,z),
}

-- ================= UI =================
local old=PG:FindFirstChild("KaitunMax") if old then old:Destroy() end
local gui=Instance.new("ScreenGui") gui.Name="KaitunMax" gui.ResetOnSpawn=false gui.Parent=PG
local fr=Instance.new("Frame",gui) fr.Size=UDim2.new(0,300,0,250) fr.Position=UDim2.new(0,10,0,60)
fr.BackgroundColor3=Color3.fromRGB(18,18,24) fr.BackgroundTransparency=0.1 fr.ClipsDescendants=true
Instance.new("UICorner",fr)
local titulo=Instance.new("TextLabel",fr) titulo.Size=UDim2.new(1,-30,0,24) titulo.Active=true
titulo.BackgroundColor3=Color3.fromRGB(40,40,58) titulo.TextColor3=Color3.new(1,1,1) titulo.TextSize=13
titulo.Text="Kaitun MAX (arraste aqui)" Instance.new("UICorner",titulo)
local mini=Instance.new("TextButton",fr) mini.Size=UDim2.new(0,28,0,24) mini.Position=UDim2.new(1,-28,0,0)
mini.BackgroundColor3=Color3.fromRGB(70,70,90) mini.TextColor3=Color3.new(1,1,1) mini.Text="-" Instance.new("UICorner",mini)
local corpo=Instance.new("Frame",fr) corpo.Position=UDim2.new(0,0,0,26) corpo.Size=UDim2.new(1,0,1,-26) corpo.BackgroundTransparency=1
local function lbl(y,h,ts,cor)
    local l=Instance.new("TextLabel",corpo) l.Position=UDim2.new(0,6,0,y) l.Size=UDim2.new(1,-12,0,h)
    l.BackgroundTransparency=1 l.TextColor3=cor or Color3.new(1,1,1) l.TextSize=ts l.TextWrapped=true
    l.TextXAlignment=Enum.TextXAlignment.Left l.TextYAlignment=Enum.TextYAlignment.Top return l
end
local lStatus=lbl(0,32,13) lStatus.Text="Iniciando..."
local lStats=lbl(32,16,12,Color3.fromRGB(180,180,180))
local lLog=lbl(50,62,11,Color3.fromRGB(150,200,255))
local rodando=true
local bP=Instance.new("TextButton",corpo) bP.Position=UDim2.new(0,6,0,114) bP.Size=UDim2.new(1,-12,0,24)
bP.BackgroundColor3=Color3.fromRGB(60,140,80) bP.TextColor3=Color3.new(1,1,1) bP.TextSize=13 bP.Text="Pausar"
Instance.new("UICorner",bP)
bP.MouseButton1Click:Connect(function()
    rodando=not rodando bP.Text=rodando and "Pausar" or "Continuar"
    bP.BackgroundColor3=rodando and Color3.fromRGB(60,140,80) or Color3.fromRGB(170,80,60)
end)
local sc=Instance.new("ScrollingFrame",corpo) sc.Position=UDim2.new(0,6,0,142) sc.Size=UDim2.new(1,-12,0,76)
sc.BackgroundTransparency=1 sc.CanvasSize=UDim2.new(0,0,0,0) sc.AutomaticCanvasSize=Enum.AutomaticSize.Y sc.ScrollBarThickness=3
local gl=Instance.new("UIGridLayout",sc) gl.CellSize=UDim2.new(0,88,0,24) gl.CellPadding=UDim2.new(0,3,0,3)
for _,k in ipairs({"Farm","Estilos","Stats","Buso","Frutas","Baus","Raca","Bounty","Hop","Trazer","FPS"}) do
    local b=Instance.new("TextButton",sc) b.TextSize=11 b.TextColor3=Color3.new(1,1,1) Instance.new("UICorner",b)
    local function pintar() b.Text=k..": "..(T[k] and "ON" or "OFF") b.BackgroundColor3=T[k] and Color3.fromRGB(50,110,70) or Color3.fromRGB(110,55,55) end
    pintar() b.MouseButton1Click:Connect(function() T[k]=not T[k] pintar() end)
end
local mini_on=false
mini.MouseButton1Click:Connect(function()
    mini_on=not mini_on corpo.Visible=not mini_on
    fr.Size=mini_on and UDim2.new(0,300,0,26) or UDim2.new(0,300,0,250) mini.Text=mini_on and "+" or "-"
end)
do -- arrastar (mouse e toque)
    local arr,ini,pos0
    titulo.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            arr=true ini=i.Position pos0=fr.Position
            i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then arr=false end end)
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if arr and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            local d=i.Position-ini
            fr.Position=UDim2.new(pos0.X.Scale,pos0.X.Offset+d.X,pos0.Y.Scale,pos0.Y.Offset+d.Y)
        end
    end)
end
local cores={ok=Color3.fromRGB(80,220,120),warn=Color3.fromRGB(255,200,60),error=Color3.fromRGB(255,90,90)}
local function SETT(m,k) lStatus.Text=m lStatus.TextColor3=cores[k] or Color3.new(1,1,1) end
local logs={}
local function log(m)
    m=os.date("%H:%M:%S").." "..tostring(m)
    table.insert(logs,m) if #logs>5 then table.remove(logs,1) end
    lLog.Text=table.concat(logs,"\n") print("[KAITUN] "..m)
end

-- ================= BASE =================
P.Idled:Connect(function() VU:CaptureController() VU:ClickButton1(Vector2.new()) end)
local function GR() return P.Character and P.Character:FindFirstChild("HumanoidRootPart") end
local function GH() return P.Character and P.Character:FindFirstChildOfClass("Humanoid") end
local function rem(...) local a={...} local o,r=pcall(function() return CommF:InvokeServer(table.unpack(a)) end) return o and r end
local function getData()
    local d=P:FindFirstChild("Data") local lvl,beli,frag=0,0,0
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
    lStats.Text=("Lv %d | Beli %d | Frag %d%s"):format(lvl,beli,frag,b and (" | B "..b.Value) or "")
end
local function getTool(n)
    local c,bp=P.Character,P:FindFirstChild("Backpack")
    return (c and c:FindFirstChild(n)) or (bp and bp:FindFirstChild(n))
end
local function getMastery(n) local t=getTool(n) local l=t and t:FindFirstChild("Level") return l and l.Value or 0 end
local function equipar(n)
    local t,h=getTool(n),GH()
    if t and h and t.Parent~=P.Character then pcall(function() h:EquipTool(t) end) end
end
local SEAS={[2753915549]=1,[4442272183]=2,[7449423635]=3}
local mar=SEAS[game.PlaceId] or 1
local function marDoLvl(l) return l>=1500 and 3 or (l>=700 and 2 or 1) end

-- ================= MOVIMENTO E COMBATE =================
local noclip=false
RunS.Stepped:Connect(function()
    if noclip and vivo() and P.Character then
        for _,p in ipairs(P.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end
    end
end)
local function estab(on)
    noclip=on
    local r=GR() if not r then return end
    local bv=r:FindFirstChild("KaitunBV")
    if on and not bv then
        bv=Instance.new("BodyVelocity") bv.Name="KaitunBV" bv.MaxForce=Vector3.new(1e9,1e9,1e9) bv.Velocity=Vector3.zero bv.Parent=r
    elseif not on and bv then bv:Destroy() end
end
local function voar(pos,vel)
    vel=vel or CFG.Vel
    local r=GR() if not r then return false end
    local d=(pos-r.Position).Magnitude
    if d<12 then return true end
    estab(true)
    local tw=TS:Create(r,TweenInfo.new(d/vel,Enum.EasingStyle.Linear),{CFrame=CFrame.new(pos)})
    tw:Play()
    local t0,lim=tick(),d/vel+4
    while vivo() and rodando and tick()-t0<lim do
        r=GR() if not r then break end
        if (pos-r.Position).Magnitude<12 then break end
        task.wait(0.1)
    end
    pcall(function() tw:Cancel() end)
    estab(false)
    r=GR()
    return r~=nil and (pos-r.Position).Magnitude<40
end
local function grudar(mr) -- 4 studs na frente do alvo, olhando pra ele; só teleporta se estiver longe
    local r=GR() if not r or not mr then return end
    local alvo=(mr.CFrame*CFrame.new(0,2,-4)).Position
    if (r.Position-alvo).Magnitude>5 then r.CFrame=CFrame.lookAt(alvo,mr.Position)
    else r.CFrame=CFrame.lookAt(r.Position,Vector3.new(mr.Position.X,r.Position.Y,mr.Position.Z)) end
    r.AssemblyLinearVelocity=Vector3.zero
end
local function atacar(estilo)
    equipar(estilo)
    pcall(function()
        local t=P.Character and P.Character:FindFirstChildOfClass("Tool") if t then t:Activate() end
        VU:CaptureController()
        VU:Button1Down(Vector2.new(900,500),workspace.CurrentCamera.CFrame)
        VU:Button1Up(Vector2.new(900,500),workspace.CurrentCamera.CFrame)
    end)
    pcall(function() VIM:SendMouseButtonEvent(900,500,0,true,game,0) VIM:SendMouseButtonEvent(900,500,0,false,game,0) end)
end
local function trazer(mob) -- opcional: junta mobs iguais no alvo
    if not T.Trazer then return end
    pcall(function() if sethiddenproperty then sethiddenproperty(P,"SimulationRadius",math.huge) end end)
    local mr=mob:FindFirstChild("HumanoidRootPart") local en=workspace:FindFirstChild("Enemies")
    if not mr or not en then return end
    for _,m in ipairs(en:GetChildren()) do
        local r,h=m:FindFirstChild("HumanoidRootPart"),m:FindFirstChildOfClass("Humanoid")
        if m~=mob and m.Name==mob.Name and r and h and h.Health>0 and (r.Position-mr.Position).Magnitude<250 then
            r.CFrame=mr.CFrame r.CanCollide=false
        end
    end
end
local function bater(m,seg,estilo)
    local mh=m:FindFirstChildOfClass("Humanoid") local t0=tick()
    estab(true)
    while vivo() and rodando and mh and mh.Health>0 and m.Parent and tick()-t0<seg do
        local mr,hh=m:FindFirstChild("HumanoidRootPart"),GH()
        if not mr or not hh or hh.Health<=0 or hh.Health/hh.MaxHealth<CFG.SafeHP then break end
        trazer(m) grudar(mr) atacar(estilo) task.wait(0.12)
    end
    estab(false)
    return mh~=nil and mh.Health<=0
end
local function acharMob(nome)
    local best,bd local hrp=GR() local en=workspace:FindFirstChild("Enemies")
    if not en or not hrp then return end
    for _,m in ipairs(en:GetChildren()) do
        local h,r=m:FindFirstChildOfClass("Humanoid"),m:FindFirstChild("HumanoidRootPart")
        if m.Name==nome and h and r and h.Health>0 then
            local d=(r.Position-hrp.Position).Magnitude
            if not bd or d<bd then best,bd=m,d end
        end
    end
    return best
end
local function acharSpawn(nome)
    local wo=workspace:FindFirstChild("_WorldOrigin") local sp=wo and wo:FindFirstChild("EnemySpawns") local hrp=GR()
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
local function questAtiva() local m=PG:FindFirstChild("Main") local q=m and m:FindFirstChild("Quest") return q and q.Visible end

-- ================= DADOS DO JOGO =================
local Q={ -- {nivelMin, mob, quest, indice}
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
local function getQuest(l) local r for _,q in ipairs(Q) do if l>=q[1] then r=q end end return r end
local Estilos={
 {"Black Leg","BuyBlackLeg"},{"Electro","BuyElectro"},{"Fishman Karate","BuyFishmanKarate"},{"Dragon Claw","BuyDragonClaw"},
 {"Superhuman","BuySuperhuman"},{"Death Step","BuyDeathStep"},{"Sharkman Karate","BuySharkmanKarate"},
 {"Electric Claw","BuyElectricClaw"},{"Dragon Talon","BuyDragonTalon"},
}
local ultCompra=0
local function estiloAtual()
    if not T.Estilos then return nil end
    for _,e in ipairs(Estilos) do if getTool(e[1]) and getMastery(e[1])<CFG.Mastery then return e[1] end end
    if tick()-ultCompra>20 then
        ultCompra=tick()
        for _,e in ipairs(Estilos) do
            if not getTool(e[1]) then
                rem(e[2]) task.wait(1)
                if getTool(e[1]) then log("Comprou "..e[1]) return e[1] end
                break
            end
        end
    end
    return nil
end
local function todosProntos() for _,e in ipairs(Estilos) do if getMastery(e[1])<CFG.Mastery then return false end end return true end

-- ================= TAREFAS (em ordem de prioridade) =================
local tasks={}
local function add(nome,flag,fn) table.insert(tasks,{n=nome,f=flag,fn=fn}) end

-- 0) escolhe o time
local timeOk=false
add("Time",nil,function()
    if timeOk then return false end
    if P.Team==nil then log("Escolhendo time "..CFG.Team) rem("SetTeam",CFG.Team) task.wait(2) return true end
    timeOk=true return false
end)

-- 1) vida baixa: sobe uma vez e espera
add("Vida",nil,function()
    local h,r=GH(),GR()
    if h.Health/h.MaxHealth>=CFG.SafeHP then return false end
    SETT("Vida baixa, regenerando...","warn")
    r.CFrame=r.CFrame+Vector3.new(0,120,0) estab(true)
    local t0=tick()
    while vivo() and rodando and h.Parent and h.Health>0 and h.Health/h.MaxHealth<0.7 and tick()-t0<20 do task.wait(0.5) end
    estab(false) return true
end)

-- 2) troca de mar (não bloqueia o farm)
local ultMar=0
add("Mar",nil,function()
    local alvo=marDoLvl((getData()))
    if alvo>mar and tick()-ultMar>15 then
        ultMar=tick() log("Tentando viajar pro Mar "..alvo)
        rem(alvo==2 and "TravelDressrosa" or "TravelZou")
    end
    return false
end)

-- 3) God Human
local godOk,ultGH=false,0
add("GodHuman","Estilos",function()
    if godOk or not todosProntos() or tick()-ultGH<20 then return false end
    ultGH=tick() rem("BuyGodhuman") task.wait(1)
    if getTool("Godhuman") or getTool("God Human") then godOk=true log("GOD HUMAN OBTIDO!") SETT("God Human obtido!","ok") end
    return false
end)

-- 4) baús
local ultBau=tick()
add("Baus","Baus",function()
    if tick()-ultBau<180 then return false end
    ultBau=tick()
    local lista,hrp=CS:GetTagged("_ChestTagged"),GR()
    if #lista==0 or not hrp then return false end
    table.sort(lista,function(a,b) return (a.Position-hrp.Position).Magnitude<(b.Position-hrp.Position).Magnitude end)
    for i=1,math.min(5,#lista) do
        local c=lista[i]
        if c:IsA("BasePart") and c.Parent then
            SETT("Coletando baú "..i,"warn") voar(c.Position,300)
            local r=GR() if r then r.CFrame=c.CFrame task.wait(0.4) end
        end
    end
    return true
end)

-- 5) raça V2 / V3 / aviso de Mirage
local function racaNome() local d=P:FindFirstChild("Data") local r=d and d:FindFirstChild("Race") return r and tostring(r.Value) or "Human",r end
local FL={"Blue Flower","Red Flower","Yellow Flower"}
local function cacar(nome,seg)
    local est=estiloAtual() or "Combat"
    local m=acharMob(nome)
    if not m then local sp=acharSpawn(nome) if sp then voar(sp.Position+Vector3.new(0,20,0),300) end return false end
    return bater(m,seg,est)
end
local ultRaca=0
add("Raca","Raca",function()
    if tick()-ultRaca<8 then return false end
    ultRaca=tick()
    local lvl,beli=getData()
    local _,r=racaNome()
    if not (r and r:FindFirstChild("Evolved")) then -- V2
        if mar~=2 or lvl<850 or beli<2000000 then return false end
        rem("Alchemist","1")
        for i,nome in ipairs(FL) do
            if not getTool(nome) then
                local f=workspace:FindFirstChild("Flower"..i)
                if f then
                    local pos=f:IsA("BasePart") and f.Position or (f.PrimaryPart and f.PrimaryPart.Position)
                    if pos then SETT("Pegando "..nome,"warn") voar(pos+Vector3.new(0,3,0),300) local hr=GR() if hr then hr.CFrame=CFrame.new(pos) end task.wait(0.5) end
                elseif i==3 then SETT("Yellow Flower: farmando Zombie","warn") cacar("Zombie",60)
                elseif i==2 then SETT("Red Flower: farmando Swan Pirate","warn") cacar("Swan Pirate",60)
                else return false end
                return true
            end
        end
        rem("Alchemist","2") task.wait(1) rem("Alchemist","3") log("Alchemist concluído (confira o V2)") return true
    end
    if mar==3 then -- V3 parcial (Human e Mink)
        local nome=racaNome()
        rem("Wenlocktoad","1")
        if nome=="Human" then
            for _,b in ipairs({"Diamond","Jeremy","Fajita"}) do
                if acharMob(b) then SETT("Boss "..b,"warn") cacar(b,90) return true end
            end
        end
        rem("Wenlocktoad","2") task.wait(1) rem("Wenlocktoad","3")
    end
    local mp=workspace:FindFirstChild("Map") local mi=mp and mp:FindFirstChild("MysticIsland")
    if mi then SETT("Mirage Island!","ok") voar(mi:GetPivot().Position+Vector3.new(0,300,0),300) return true end
    return false
end)

-- 6) bounty (só no level máximo e com todos os estilos em 400)
local amigos,ultHop={},0
local function ehAmigo(pl)
    if amigos[pl.UserId]==nil then local o,r=pcall(function() return P:IsFriendsWith(pl.UserId) end) amigos[pl.UserId]=o and r or false end
    return amigos[pl.UserId]
end
add("Bounty","Bounty",function()
    if (getData())<CFG.MaxLvl or not todosProntos() then return false end
    rem("EnablePvp")
    local hrp=GR() local alvo,bd
    for _,pl in ipairs(Players:GetPlayers()) do
        local c=pl.Character local r=c and c:FindFirstChild("HumanoidRootPart") local h=c and c:FindFirstChildOfClass("Humanoid")
        if pl~=P and r and h and h.Health>0 and not c:FindFirstChildOfClass("ForceField") and not ehAmigo(pl) then
            local d=(r.Position-hrp.Position).Magnitude
            if not bd or d<bd then alvo,bd=pl,d end
        end
    end
    if not alvo then
        if T.Hop and tick()-ultHop>30 then ultHop=tick() log("Sem alvos, trocando de server") pcall(function() TPS:Teleport(game.PlaceId,P) end) end
        return false
    end
    SETT("Bounty: "..alvo.Name,"warn")
    voar(alvo.Character.HumanoidRootPart.Position+Vector3.new(0,8,0),300)
    bater(alvo.Character,25,estiloAtual() or "Combat")
    return true
end)

-- 7) FARM por quest
local questAtual,questIni,ultSem=nil,0,0
add("Farm","Farm",function()
    local lvl=getData()
    local teto=(mar==1 and 699) or (mar==2 and 1499) or 99999
    local q=getQuest(math.min(lvl,teto))
    if not q then return false end
    if marDoLvl(q[1])~=mar then SETT("Quest do Mar "..marDoLvl(q[1]).." e você está no Mar "..mar,"error") task.wait(2) return false end
    local chave=q[3]..q[4]
    if questAtual~=chave or (not questAtiva() and tick()-questIni>25) then
        if questAtual and questAtual~=chave then rem("AbandonQuest") end
        if QuestPos[q[3]] then voar(QuestPos[q[3]]+Vector3.new(0,3,0),300) end
        rem("StartQuest",q[3],q[4]) questAtual=chave questIni=tick() task.wait(0.5)
    end
    local mob=acharMob(q[2])
    if not mob then
        local sp=acharSpawn(q[2])
        if sp then SETT("Indo até "..q[2],"warn") voar(sp.Position+Vector3.new(0,20,0),300) task.wait(1)
        else
            SETT("Sem "..q[2].." (spawn não achado)","error")
            if tick()-ultSem>20 then ultSem=tick() log("Spawn não achado: "..q[2]) end
            task.wait(2)
        end
        return true
    end
    local est=estiloAtual()
    SETT((est or "Combat")..(est and (" "..getMastery(est).."/"..CFG.Mastery) or "").." | "..q[2],"ok")
    bater(mob,40,est or "Combat")
    return true
end)

-- ================= LOOPS PARALELOS =================
task.spawn(function() -- status
    while vivo() do
        task.wait(5)
        if T.Stats then
            local d=P:FindFirstChild("Data") local pts=d and d:FindFirstChild("Points")
            if pts and pts.Value>0 then
                local total=0 for _,w in pairs(CFG.Stats) do total=total+w end
                local n=pts.Value
                for k,w in pairs(CFG.Stats) do rem("AddPoint",k,math.floor(n*w/total)) end
            end
        end
    end
end)
task.spawn(function() -- buso
    while vivo() do
        task.wait(4)
        if T.Buso and P.Character and not P.Character:FindFirstChild("HasBuso") then rem("Buso") end
    end
end)
task.spawn(function() -- guardar frutas
    while vivo() do
        task.wait(10)
        local bp=P:FindFirstChild("Backpack")
        if T.Frutas and bp then
            for _,t in ipairs(bp:GetChildren()) do
                if t:IsA("Tool") and t.Name:find("Fruit",1,true) then rem("StoreFruit",t:GetAttribute("OriginalName") or t.Name,t) task.wait(0.5) end
            end
        end
    end
end)
game:GetService("GuiService").ErrorMessageChanged:Connect(function() if vivo() then task.wait(3) TPS:Teleport(game.PlaceId,P) end end)
if T.FPS then pcall(function()
    settings().Rendering.QualityLevel=Enum.QualityLevel.Level01
    local L=game:GetService("Lighting") L.GlobalShadows=false L.FogEnd=9e9
    for _,v in ipairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then v.Enabled=false end
    end
end) end
UIS.InputBegan:Connect(function(i,gp) -- K: copia posição
    if gp or i.KeyCode~=Enum.KeyCode.K then return end
    local r=GR() if not r then return end
    local p=r.Position local s=("Vector3.new(%d,%d,%d)"):format(p.X,p.Y,p.Z)
    if setclipboard then pcall(setclipboard,s) end
    log("POS "..s)
end)

-- ================= LOOP PRINCIPAL =================
local erros=0
log("Iniciado | Mar "..mar.." | Lv "..tostring((getData())))
task.spawn(function()
    while vivo() do
        task.wait(0.25)
        pcall(UP)
        if not rodando then estab(false) SETT("Pausado","warn") task.wait(0.5) continue end
        local hum,r=GH(),GR()
        if not hum or not r or hum.Health<=0 then SETT("Aguardando respawn...","error") task.wait(2) continue end
        for _,t in ipairs(tasks) do
            if vivo() and (t.f==nil or T[t.f]) then
                local o,res=pcall(t.fn)
                if not o then erros=erros+1 log("ERRO "..t.n..": "..tostring(res)) estab(false) task.wait(1) break
                elseif res then break end
            end
        end
    end
end)
end)
if not ok then warn("Kaitun MAX erro: "..tostring(err)) end