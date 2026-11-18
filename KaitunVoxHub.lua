local function setupAutoLoad()
    local queueFunc = queue_on_teleport or (syn and syn.queue_on_teleport)
    if queueFunc then
        local scriptSource = debug.getinfo(1, "S").source
        if string.sub(scriptSource, 1, 1) == "=" then
            scriptSource = string.sub(scriptSource, 2)
        end
        queueFunc(scriptSource)
    else
        warn("[Kaitun] Seu executor nao suporta queue_on_teleport.")
    end
end
setupAutoLoad()

local ok,err=pcall(function()
    local CF={MaxLvl=2800,TargetBty=10000000,SafeHP=20,Skip={"Buddha","T-Rex","Leopard","Dough"},V4=true,FarmDist=250,V4Cooldown=60}
    local P=game.Players.LocalPlayer
    local PG=P:WaitForChild("PlayerGui")
    local UIS=game:GetService("UserInputService")
    local TS=game:GetService("TeleportService")
    local HS=game:GetService("HttpService")
    local R=Color3.fromRGB

    local CORES={
        FundoMenu=R(15,17,24),
        FundoCard=R(24,27,38),
        TextoBranco=R(255,255,255),
        TextoCinza=R(130,135,150),
        TextoVerde=R(100,230,150),
        TextoRoxo=R(180,150,255),
        TextoMissing=R(220,220,220),
        FundoBotao=R(40,45,65),
        Divisor=R(35,38,50),
    }

    local function aplicarCanto(o,r)
        local c=Instance.new("UICorner")
        c.CornerRadius=UDim.new(0,r)
        c.Parent=o
    end
    local function criarTexto(pai,texto,tam,pos,cor,neg,tamFonte)
        local l=Instance.new("TextLabel")
        l.Parent=pai
        l.BackgroundTransparency=1
        l.Size=tam
        l.Position=pos
        l.Text=texto
        l.TextColor3=cor
        l.Font=neg and Enum.Font.GothamBold or Enum.Font.Gotham
        l.TextSize=tamFonte or 12
        l.TextXAlignment=Enum.TextXAlignment.Left
        return l
    end

    local SG=Instance.new("ScreenGui")
    SG.Name="KaitunMenu"
    SG.ResetOnSpawn=false
    SG.IgnoreGuiInset=true
    SG.Parent=PG

    -- Tamanho adaptável para celular
    local scale = Instance.new("UIScale")
    scale.Parent = SG
    if UIS.TouchEnabled and not UIS.KeyboardEnabled then
        scale.Scale = 0.75 -- Ajustado para não cobrir a tela toda nem ficar minúsculo
    else
        scale.Scale = 0.95
    end

    local menu=Instance.new("Frame")
    menu.Name="MenuPrincipal"
    menu.Parent=SG
    menu.Size=UDim2.new(0,400,0,450)
    menu.Position=UDim2.new(0.5,-200,0.5,-225)
    menu.BackgroundColor3=CORES.FundoMenu
    menu.BorderSizePixel=0
    aplicarCanto(menu,10)

    local cabecalho=Instance.new("Frame")
    cabecalho.Parent=menu
    cabecalho.Size=UDim2.new(1,0,0,45)
    cabecalho.BackgroundTransparency=1

    local botaoKaitun=Instance.new("TextButton")
    botaoKaitun.Parent=cabecalho
    botaoKaitun.Size=UDim2.new(0,80,0,28)
    botaoKaitun.Position=UDim2.new(1,-100,0,10)
    botaoKaitun.BackgroundColor3=CORES.FundoBotao
    botaoKaitun.Text="Kaitun"
    botaoKaitun.TextColor3=CORES.TextoBranco
    botaoKaitun.Font=Enum.Font.GothamBold
    botaoKaitun.TextSize=11
    botaoKaitun.AutoButtonColor=false
    aplicarCanto(botaoKaitun,6)

    local botaoMin=Instance.new("TextButton")
    botaoMin.Parent=cabecalho
    botaoMin.Size=UDim2.new(0,30,0,30)
    botaoMin.Position=UDim2.new(1,-35,0,8)
    botaoMin.BackgroundTransparency=1
    botaoMin.Text="—"
    botaoMin.TextColor3=CORES.TextoCinza
    botaoMin.Font=Enum.Font.GothamBold
    botaoMin.TextSize=18

    local divisor=Instance.new("Frame")
    divisor.Parent=menu
    divisor.Size=UDim2.new(1,-20,0,1)
    divisor.Position=UDim2.new(0,10,0,45)
    divisor.BackgroundColor3=CORES.Divisor
    divisor.BorderSizePixel=0

    local containerStats=Instance.new("Frame")
    containerStats.Parent=menu
    containerStats.Size=UDim2.new(1,-20,0,120)
    containerStats.Position=UDim2.new(0,10,0,55)
    containerStats.BackgroundTransparency=1

    local function criarCard(pai,label,valor,cor,x,y)
        local card=Instance.new("Frame")
        card.Parent=pai
        card.Size=UDim2.new(0.48,0,0,55)
        card.Position=UDim2.new(x,0,y,0)
        card.BackgroundColor3=CORES.FundoCard
        card.BorderSizePixel=0
        aplicarCanto(card,8)
        criarTexto(card,label,UDim2.new(1,-10,0,15),UDim2.new(0,8,0,8),CORES.TextoCinza,false,10)
        local tv=criarTexto(card,valor,UDim2.new(1,-10,0,25),UDim2.new(0,8,0,26),cor,false,18)
        return tv
    end

    local cardLvl=criarCard(containerStats,"Level","-",CORES.TextoBranco,0,0)
    local cardRace=criarCard(containerStats,"Race","-",CORES.TextoBranco,0.52,0)
    local cardBeli=criarCard(containerStats,"Beli","-",CORES.TextoVerde,0,0.55)
    local cardFrag=criarCard(containerStats,"Fragments","-",CORES.TextoRoxo,0.52,0.55)

    local containerCol=Instance.new("Frame")
    containerCol.Parent=menu
    containerCol.Size=UDim2.new(1,-20,0,195)
    containerCol.Position=UDim2.new(0,10,0,185)
    containerCol.BackgroundColor3=CORES.FundoCard
    containerCol.BorderSizePixel=0
    aplicarCanto(containerCol,8)

    criarTexto(containerCol,"Collection",UDim2.new(1,0,0,15),UDim2.new(0,10,0,8),CORES.TextoCinza,false,10)

    local ITENS={"Cursed Dual Katana","Valkyrie Helm","Skull Guitar","Mirror Fractal","Pull Lever"}
    local itemLabels={}
    for i,nome in ipairs(ITENS) do
        local y=28+((i-1)*30)
        criarTexto(containerCol,nome,UDim2.new(0,200,0,15),UDim2.new(0,10,0,y),CORES.TextoBranco,false,11)
        itemLabels[i]=criarTexto(containerCol,"Missing",UDim2.new(0,60,0,15),UDim2.new(1,-70,0,y),CORES.TextoMissing,false,11)
        itemLabels[i].TextXAlignment=Enum.TextXAlignment.Right
    end

    local containerStatus=Instance.new("Frame")
    containerStatus.Parent=menu
    containerStatus.Size=UDim2.new(1,-20,0,45)
    containerStatus.Position=UDim2.new(0,10,0,395)
    containerStatus.BackgroundColor3=CORES.FundoCard
    containerStatus.BorderSizePixel=0
    aplicarCanto(containerStatus,8)

    local bolinha=Instance.new("Frame")
    bolinha.Parent=containerStatus
    bolinha.Size=UDim2.new(0,7,0,7)
    bolinha.Position=UDim2.new(0,10,0,12)
    bolinha.BackgroundColor3=R(80,200,120)
    bolinha.BorderSizePixel=0
    aplicarCanto(bolinha,100)

    criarTexto(containerStatus,"Current Task",UDim2.new(1,0,0,12),UDim2.new(0,22,0,8),CORES.TextoCinza,false,9)
    local statusTask=criarTexto(containerStatus,"Idle",UDim2.new(1,0,0,15),UDim2.new(0,10,0,24),CORES.TextoBranco,false,11)

    -- Arrastar Menu Inteiro
    local arrastando=false
    local inicioArrasto,posInicial
    local function iniciarArrasto(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
            arrastando=true
            inicioArrasto=inp.Position
            posInicial=menu.Position
        end
    end
    menu.InputBegan:Connect(iniciarArrasto)
    cabecalho.InputBegan:Connect(iniciarArrasto)

    UIS.InputChanged:Connect(function(inp)
        if arrastando and(inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch) then
            local d=inp.Position-inicioArrasto
            menu.Position=UDim2.new(posInicial.X.Scale,posInicial.X.Offset+d.X,posInicial.Y.Scale,posInicial.Y.Offset+d.Y)
        end
    end)
    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
            arrastando=false
        end
    end)

    -- Minimizar e Botão Flutuante Arrastável
    local minimizado=false
    local botaoFlutuante
    local arrastandoBtn=false
    local inicioBtn,posInicialBtn
    local clickIniciado=false

    botaoMin.MouseButton1Click:Connect(function()
        if not minimizado then
            minimizado=true
            menu.Visible=false
            
            botaoFlutuante=Instance.new("TextButton")
            botaoFlutuante.Name="BotaoFlutuante"
            botaoFlutuante.Parent=SG
            botaoFlutuante.Size=UDim2.new(0,65,0,65)
            botaoFlutuante.Position=UDim2.new(0,20,0,20)
            botaoFlutuante.BackgroundColor3=CORES.FundoMenu
            botaoFlutuante.Text="K"
            botaoFlutuante.TextColor3=CORES.TextoBranco
            botaoFlutuante.Font=Enum.Font.GothamBold
            botaoFlutuante.TextSize=24
            aplicarCanto(botaoFlutuante,10)
            
            botaoFlutuante.InputBegan:Connect(function(inp)
                if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
                    arrastandoBtn=true
                    clickIniciado=true
                    inicioBtn=inp.Position
                    posInicialBtn=botaoFlutuante.Position
                end
            end)
            
            botaoFlutuante.InputEnded:Connect(function(inp)
                if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
                    arrastandoBtn=false
                    if clickIniciado and (inp.Position - inicioBtn).Magnitude < 10 then
                        menu.Visible=true
                        botaoFlutuante:Destroy()
                        minimizado=false
                    end
                    clickIniciado=false
                end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(inp)
        if arrastandoBtn and(inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch) then
            local d=inp.Position-inicioBtn
            if d.Magnitude > 10 then
                botaoFlutuante.Position=UDim2.new(posInicialBtn.X.Scale,posInicialBtn.X.Offset+d.X,posInicialBtn.Y.Scale,posInicialBtn.Y.Offset+d.Y)
            end
        end
    end)
    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
            arrastandoBtn=false
        end
    end)

    -- Funções de dados
    function GL()
        local ls=P:FindFirstChild("leaderstats")
        if not ls then return 0 end
        local l=ls:FindFirstChild("Level") or ls:FindFirstChild("Lvl")
        return l and l.Value or 0
    end
    function GB()
        local ls=P:FindFirstChild("leaderstats")
        if not ls then return 0 end
        local b=ls:FindFirstChild("Bounty") or ls:FindFirstChild("Honor")
        return b and b.Value or 0
    end
    function GR()
        local c=P.Character
        if not c then return nil end
        return c:FindFirstChild("HumanoidRootPart")
    end
    function GH()
        local c=P.Character
        if not c then return nil end
        return c:FindFirstChild("Humanoid")
    end
    function TP(p)
        local r=GR()
        if r then r.CFrame=CFrame.new(p+Vector3.new(0,5,0)) end
    end
    function getRace()
        local d=P:FindFirstChild("Data")
        if d then local r=d:FindFirstChild("Race") if r and r.Value then return tostring(r.Value) end end
        local r=P:FindFirstChild("Race")
        if r and r.Value then return tostring(r.Value) end
        return "Human"
    end
    function getFruit()
        local d=P:FindFirstChild("Data")
        if d then local f=d:FindFirstChild("BloxFruit") or d:FindFirstChild("Blox Fruit") if f and f.Value then return tostring(f.Value) end end
        local f=P:FindFirstChild("Blox Fruit")
        if f and f.Value then return tostring(f.Value) end
        return "None"
    end
    function getBeli()
        local ls=P:FindFirstChild("leaderstats")
        if not ls then return 0 end
        local b=ls:FindFirstChild("Beli") or ls:FindFirstChild("Money")
        return b and b.Value or 0
    end
    function getFragments()
        local d=P:FindFirstChild("Data")
        if d then
            local f=d:FindFirstChild("Fragments") or d:FindFirstChild("RaceFragments")
            if f and f.Value then return f.Value end
        end
        return 0
    end
    function hasItem(name)
        local d=P:FindFirstChild("Data")
        if d then
            local inv=d:FindFirstChild("Inventory") or d:FindFirstChild("Items")
            if inv then
                for _,v in ipairs(inv:GetChildren()) do
                    if v.Name:find(name,1,true) or tostring(v.Value)==name then return true end
                end
            end
        end
        local bp=P:FindFirstChild("Backpack")
        if bp then
            for _,v in ipairs(bp:GetChildren()) do
                if v:IsA("Tool") and v.Name:find(name,1,true) then return true end
            end
        end
        local c=P.Character
        if c then
            for _,v in ipairs(c:GetChildren()) do
                if v:IsA("Tool") and v.Name:find(name,1,true) then return true end
            end
        end
        return false
    end

    function UP()
        cardLvl.Text=GL()
        cardRace.Text=getRace()
        cardBeli.Text=getBeli()
        cardFrag.Text=getFragments()
        for i,nome in ipairs(ITENS) do
            if hasItem(nome) then
                itemLabels[i].Text="Owned"
                itemLabels[i].TextColor3=CORES.TextoVerde
            else
                itemLabels[i].Text="Missing"
                itemLabels[i].TextColor3=CORES.TextoMissing
            end
        end
    end

    function SETT(text,col,status)
        statusTask.Text=text
        statusTask.TextColor3=col or CORES.TextoBranco
        if status=="ok" then bolinha.BackgroundColor3=R(80,200,120)
        elseif status=="warn" then bolinha.BackgroundColor3=R(255,200,50)
        elseif status=="error" then bolinha.BackgroundColor3=R(255,80,80)
        elseif status=="v4" then bolinha.BackgroundColor3=R(180,150,255)
        elseif status=="done" then bolinha.BackgroundColor3=R(0,240,240)
        end
    end

    function findTarget()
        local r=GR()
        if not r then return nil end
        local best=nil
        local bestD=CF.FarmDist
        for _,obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and obj ~= P.Character then
                local h=obj:FindFirstChild("Humanoid")
                if h and h.Health>0 and h.MaxHealth<5000 and h.MaxHealth>10 then
                    local hrp=obj:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local d=(r.Position-hrp.Position).Magnitude
                        if d<bestD then
                            bestD=d
                            best=hrp
                        end
                    end
                end
            end
        end
        return best
    end

    -- SISTEMA DE ATAQUE HÍBRIDO (Focado no Celular)
    function meleeHit(part)
        if not part then return end
        
        -- 1. Tenta API do Executor Mobile (Delta, Fluxus, etc)
        pcall(function()
            if mouse1click then mouse1click() end
        end)
        
        -- 2. Tenta tocar no objeto via TouchInterest (PC e alguns Mobile)
        pcall(function()
            if firetouchinterest then firetouchinterest(P,0,part,1,0) end
        end)
        
        -- 3. Tenta simular toque na tela via API mobile
        pcall(function()
            if gettouchvector and gettouchvector then
                -- Alguns executores usam isso
            end
        end)

        -- 4. Fallback para teclado (funciona em PC)
        pcall(function()
            UIS:SendKeyEvent(true,Enum.KeyCode.Z,false,game)
            task.wait(0.05)
            UIS:SendKeyEvent(false,Enum.KeyCode.Z,false,game)
        end)
    end

    function skillHit()
        -- Simula o toque do dedo na tela para usar Skills
        pcall(function() if mouse1click then mouse1click() end end)
        task.wait(0.1)
        
        -- No PC, usa as teclas normais
        if not UIS.TouchEnabled then
            UIS:SendKeyEvent(true,Enum.KeyCode.Z,false,game) task.wait(0.05) UIS:SendKeyEvent(false,Enum.KeyCode.Z,false,game) task.wait(0.1)
            UIS:SendKeyEvent(true,Enum.KeyCode.X,false,game) task.wait(0.05) UIS:SendKeyEvent(false,Enum.KeyCode.X,false,game) task.wait(0.1)
            UIS:SendKeyEvent(true,Enum.KeyCode.C,false,game) task.wait(0.05) UIS:SendKeyEvent(false,Enum.KeyCode.C,false,game) task.wait(0.1)
        end
    end

    function doFarm()
        local h=GH()
        local r=GR()
        if not h or not r then 
            SETT("Aguardando Personagem...",CORES.TextoCinza,"warn")
            return 
        end
        local hp=(h.Health/h.MaxHealth)*100
        if hp<CF.SafeHP then
            SETT("Fleeing (low HP)",R(255,80,80),"error")
            TP(r.Position+Vector3.new(0,500,0))
            task.wait(3)
            return
        end
        local tgt=findTarget()
        if not tgt then
            SETT("Buscando mobs...",CORES.TextoCinza,"warn")
            -- Se não achar mobs, pula para uma ilha inicial
            TP(Vector3.new(-1000, 50, -1000)) 
            task.wait(5)
            return
        end
        if(tgt.Position-r.Position).Magnitude>60 then TP(tgt.Position) end
        SETT("Farmando Level",CORES.TextoVerde,"ok")
        for i=1,30 do
            local h2=GH()
            local r2=GR()
            if not h2 or not r2 then return end
            if(h2.Health/h2.MaxHealth)*100<CF.SafeHP then
                SETT("Fleeing (low HP)",R(255,80,80),"error")
                TP(r2.Position+Vector3.new(0,500,0))
                task.wait(3)
                return
            end
            local t2=findTarget()
            if not t2 then break end
            if(t2.Position-r2.Position).Magnitude>60 then TP(t2.Position) end
            meleeHit(t2)
            if i%5==0 then skillHit() end
            task.wait(0.1)
        end
    end

    function doBounty()
        -- (Lógica de Bounty mantida igual, com proteções)
        local h=GH()
        local r=GR()
        if not h or not r then return end
        local bty=GB()
        SETT("Bounty: "..string.format("%.1fM / 10M",bty/1000000),R(255,80,80),"warn")
        local tgt=nil
        local bestScore=0
        for _,p in ipairs(game.Players:GetPlayers()) do
            if p~=P then
                local ls=p:FindFirstChild("leaderstats")
                if ls then
                    local b=ls:FindFirstChild("Bounty") or ls:FindFirstChild("Honor")
                    if b and b.Value>100000 and b.Value<=10000000 then
                        local fn=""
                        local d=p:FindFirstChild("Data")
                        if d then local f=d:FindFirstChild("BloxFruit") or d:FindFirstChild("Blox Fruit") if f and f.Value then fn=tostring(f.Value) end end
                        if fn=="" then local f2=p:FindFirstChild("Blox Fruit") if f2 and f2.Value then fn=tostring(f2.Value) end end
                        local sk=false
                        local fnl=string.lower(fn)
                        for _,f in ipairs(CF.Skip) do if fnl:find(string.lower(f),1,true) then sk=true break end end
                        if not sk then
                            local tc=p.Character
                            if tc then
                                local th=tc:FindFirstChild("Humanoid")
                                if th and th.Health>0 then
                                    local hpPct=(th.Health/th.MaxHealth)*100
                                    local score=b.Value
                                    if hpPct<50 then score=score*2 end
                                    if score>bestScore then
                                        bestScore=score
                                        tgt=p
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        if not tgt then SETT("Bounty: no targets",R(255,80,80),"warn") task.wait(5) return end
        local tc=tgt.Character
        if not tc then return end
        local tr=tc:FindFirstChild("HumanoidRootPart")
        if not tr then return end
        if(r.Position-tr.Position).Magnitude>150 then TP(tr.Position) end
        local hp=(h.Health/h.MaxHealth)*100
        if hp<CF.SafeHP then
            SETT("Fleeing (low HP)",R(255,80,80),"error")
            TP(r.Position+Vector3.new(0,5000,0))
            task.wait(3)
            return
        end
        SETT("Attacking: "..tgt.Name,R(255,80,80),"warn")
        for i=1,20 do
            local tc2=tgt.Character
            if not tc2 then break end
            local th=tc2:FindFirstChild("Humanoid")
            if not th or th.Health<=0 then break end
            local r2=GR()
            if not r2 then return end
            local tr2=tc2:FindFirstChild("HumanoidRootPart")
            if tr2 and(r2.Position-tr2.Position).Magnitude>60 then TP(tr2.Position) end
            meleeHit(tr2)
            if i%5==0 then skillHit() end
            task.wait(0.1)
        end
        local tc3=tgt.Character
        if not tc3 or not tc3:FindFirstChild("Humanoid") then
            SETT("Killed: "..tgt.Name.." | Bounty: "..GB(),R(0,240,240),"done")
            task.wait(2)
        end
    end

    function HV3()
        local d=P:FindFirstChild("Data")
        if d then local s=d:FindFirstChild("RaceStage") or d:FindFirstChild("Race_V") if s and s.Value>=3 then return true end end
        return false
    end
    function HV4()
        local d=P:FindFirstChild("Data")
        if d then local s=d:FindFirstChild("RaceStage") or d:FindFirstChild("Race_V") if s and s.Value>=4 then return true end end
        return false
    end
    function CR()
        local myR=getRace()
        local seen={}
        local n=0
        for _,p in ipairs(game.Players:GetPlayers()) do
            if p~=P then
                local d=p:FindFirstChild("Data")
                local rv="Human"
                if d then local r=d:FindFirstChild("Race") if r and r.Value then rv=tostring(r.Value) end end
                if rv~=myR and not seen[rv] then seen[rv]=true n=n+1 end
            end
        end
        return n
    end
    function HP()
        local servers=nil
        local ok1=pcall(function()
            local res=HS:RequestAsync({Url="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?limit=10",Method="GET"})
            servers=HS:JSONDecode(res.Body)
        end)
        if not ok1 or not servers then
            local ok2=pcall(function()
                local res=request({url="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?limit=10",method="GET"})
                if res and res.body then servers=HS:JSONDecode(res.body) end
            end)
        end
        if servers and servers.servers then
            for _,s in ipairs(servers.servers) do
                if s.id~=game.JobId then
                    pcall(function() TS:TeleportToPlaceInstance(game.PlaceId,s.id,P) end)
                    return
                end
            end
        end
        pcall(function() TS:TeleportToPlaceInstance(game.PlaceId,game.JobId,P) end)
    end

    local lastV4Try=0
    function doV4()
        -- (Lógica de V4 mantida igual)
        local now=tick()
        if now-lastV4Try<CF.V4Cooldown then return end
        lastV4Try=now
        if HV4() then SETT("V4 Complete",CORES.TextoVerde,"ok") return end
        if not HV3() then return end
        local n=CR()
        if n<2 then
            SETT("V4: Need 2+ races, hopping",CORES.TextoRoxo,"v4")
            task.wait(3)
            HP()
            return
        end
        SETT("V4: Trying trial...",CORES.TextoRoxo,"v4")
        TP(Vector3.new(-7894,5548,-380))
        task.wait(3)
        UIS:SendKeyEvent(true,Enum.KeyCode.Y,false,game)
        task.wait(0.1)
        UIS:SendKeyEvent(false,Enum.KeyCode.Y,false,game)
        task.wait(2)
        for i=1,10 do
            task.wait(3)
            if HV4() then SETT("V4 UNLOCKED!",CORES.TextoVerde,"done") return end
            local h=GH()
            local r=GR()
            if h and r and(h.Health/h.MaxHealth)*100<CF.SafeHP then
                SETT("V4: Fleeing (low HP)",R(255,80,80),"error")
                TP(r.Position+Vector3.new(0,200,0))
                task.wait(2)
            end
            local t=findTarget()
            if t then meleeHit(t) skillHit() end
        end
        TP(Vector3.new(-7894,5560,-380))
        task.wait(3)
        if HV4() then SETT("V4 UNLOCKED!",CORES.TextoVerde,"done") return end
        SETT("V4: Failed, retry in 60s",R(255,80,80),"error")
    end

    SETT("Script Iniciado!",CORES.TextoVerde,"ok")
    
    -- Loop principal sem travar
    task.spawn(function()
        while true do
            task.wait(1)
            
            if not P.Character or not P.Character:FindFirstChild("HumanoidRootPart") then
                SETT("Aguardando personagem...",R(255,80,80),"error")
            else
                UP()
                local l=GL()
                local b=GB()
                
                if l<CF.MaxLvl then
                    if CF.V4 and HV3() and not HV4() then
                        doV4()
                        doFarm()
                    else
                        doFarm()
                    end
                elseif b<CF.TargetBty then
                    doBounty()
                else
                    SETT("COMPLETO: Max Level + 10M Bounty",R(0,240,240),"done")
                end
            end
        end
    end)
end)

if not ok then
    local pg=game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local sg2=Instance.new("ScreenGui")
    sg2.Name="KaitunErr"
    sg2.ResetOnSpawn=false
    sg2.Parent=pg
    local ef=Instance.new("Frame")
    ef.Size=UDim2.new(0,300,0,120)
    ef.Position=UDim2.new(0,20,0,40)
    ef.BackgroundColor3=R(60,0,0)
    ef.Parent=sg2
    local ec=Instance.new("UICorner")ec.CornerRadius=UDim.new(0,10)ec.Parent=ef
    local et=Instance.new("TextLabel")
    et.Size=UDim2.new(1,-20,1,-10)
    et.Position=UDim2.new(0,10,0,5)
    et.BackgroundTransparency=1
    et.Text="ERR: "..tostring(err)
    et.TextColor3=R(255,100,100)
    et.TextSize=12
    et.Font=Enum.Font.Gotham
    et.TextXAlignment=Enum.TextXAlignment.Left
    et.TextYAlignment=Enum.TextYAlignment.Top
    et.TextWrapped=true
    et.Parent=ef
end