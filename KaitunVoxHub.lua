local function setupAutoLoad()
    local queueFunc = queue_on_teleport or (syn and syn.queue_on_teleport)
    if queueFunc then
        local scriptSource = debug.getinfo(1, "S").source
        if string.sub(scriptSource, 1, 1) == "=" then
            scriptSource = string.sub(scriptSource, 2)
        end
        queueFunc(scriptSource)
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
    local RS = game:GetService("ReplicatedStorage")
    local Remotes = RS:WaitForChild("Remotes")
    local CommF = Remotes:WaitForChild("CommF_")

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

    local scale = Instance.new("UIScale")
    scale.Parent = SG
    scale.Scale = UIS.TouchEnabled and 0.8 or 0.95

    local menu=Instance.new("Frame")
    menu.Name="MenuPrincipal"
    menu.Parent=SG
    menu.Size=UDim2.new(0,350,0,460)
    menu.Position=UDim2.new(0.5,-175,0.5,-230)
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
    containerCol.Size=UDim2.new(1,-20,0,235)
    containerCol.Position=UDim2.new(0,10,0,185)
    containerCol.BackgroundColor3=CORES.FundoCard
    containerCol.BorderSizePixel=0
    aplicarCanto(containerCol,8)

    criarTexto(containerCol,"Collection",UDim2.new(1,0,0,15),UDim2.new(0,10,0,8),CORES.TextoCinza,false,10)

    local ITENS={"Cursed Dual Katana","Valkyrie Helm","Skull Guitar","Mirror Fractal","Pull Lever"}
    local itemLabels={}
    for i,nome in ipairs(ITENS) do
        local y=30+((i-1)*35)
        criarTexto(containerCol,nome,UDim2.new(0,200,0,15),UDim2.new(0,10,0,y),CORES.TextoBranco,false,12)
        itemLabels[i]=criarTexto(containerCol,"Missing",UDim2.new(0,60,0,15),UDim2.new(1,-70,0,y),CORES.TextoMissing,false,12)
        itemLabels[i].TextXAlignment=Enum.TextXAlignment.Right
    end

    local containerStatus=Instance.new("Frame")
    containerStatus.Parent=menu
    containerStatus.Size=UDim2.new(1,-20,0,45)
    containerStatus.Position=UDim2.new(0,10,0,435)
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
    local statusTask=criarTexto(containerStatus,"Aguardando...",UDim2.new(1,0,0,15),UDim2.new(0,10,0,24),CORES.TextoBranco,false,11)

    local dragging, dragInput, dragStart, startPos
    local function updateDrag(input)
        local delta = input.Position - dragStart
        menu.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    cabecalho.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = menu.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateDrag(input) end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)

    local minimizado=false
    local botaoFlutuante
    local draggingBtn = false
    local dragStartBtn, startPosBtn

    botaoMin.MouseButton1Click:Connect(function()
        if not minimizado then
            minimizado=true; menu.Visible=false
            botaoFlutuante=Instance.new("TextButton")
            botaoFlutuante.Parent=SG; botaoFlutuante.Size=UDim2.new(0,70,0,70); botaoFlutuante.Position=UDim2.new(0,20,0,20)
            botaoFlutuante.BackgroundColor3=CORES.FundoMenu; botaoFlutuante.Text="K"; botaoFlutuante.TextColor3=CORES.TextoBranco
            botaoFlutuante.Font=Enum.Font.GothamBold; botaoFlutuante.TextSize=24; aplicarCanto(botaoFlutuante,10)
            local moved = false
            botaoFlutuante.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    draggingBtn = true; moved = false; dragStartBtn = input.Position; startPosBtn = botaoFlutuante.Position
                end
            end)
            UIS.InputChanged:Connect(function(input)
                if draggingBtn and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    local delta = input.Position - dragStartBtn
                    if delta.Magnitude > 10 then moved = true end
                    botaoFlutuante.Position = UDim2.new(startPosBtn.X.Scale, startPosBtn.X.Offset + delta.X, startPosBtn.Y.Scale, startPosBtn.Y.Offset + delta.Y)
                end
            end)
            UIS.InputEnded:Connect(function(input)
                if draggingBtn and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                    draggingBtn = false
                    if not moved then menu.Visible=true; botaoFlutuante:Destroy(); minimizado=false end
                end
            end)
        end
    end)

    local function getData()
        local data = P:FindFirstChild("Data")
        local lvl, beli, frag, race = 0, 0, 0, "Human"
        if data then
            if data:FindFirstChild("Level") then lvl = data.Level.Value end
            if data:FindFirstChild("Beli") then beli = data.Beli.Value end
            if data:FindFirstChild("Fragments") then frag = data.Fragments.Value end
            if data:FindFirstChild("Race") then race = tostring(data.Race.Value) end
        else
            local ls = P:FindFirstChild("leaderstats")
            if ls then
                if ls:FindFirstChild("Level") then lvl = ls.Level.Value end
                if ls:FindFirstChild("Beli") then beli = ls.Beli.Value end
            end
        end
        return lvl, beli, frag, race
    end

    local function hasItem(name)
        local bp=P:FindFirstChild("Backpack")
        if bp then
            for _,v in ipairs(bp:GetChildren()) do if v:IsA("Tool") and v.Name:find(name,1,true) then return true end end
        end
        local c=P.Character
        if c then
            for _,v in ipairs(c:GetChildren()) do if v:IsA("Tool") and v.Name:find(name,1,true) then return true end end
        end
        return false
    end

    local function UP()
        local lvl, beli, frag, race = getData()
        cardLvl.Text = tostring(lvl); cardRace.Text = race; cardBeli.Text = tostring(beli); cardFrag.Text = tostring(frag)
        for i,nome in ipairs(ITENS) do
            if hasItem(nome) then itemLabels[i].Text="Owned"; itemLabels[i].TextColor3=CORES.TextoVerde
            else itemLabels[i].Text="Missing"; itemLabels[i].TextColor3=CORES.TextoMissing end
        end
    end

    local function SETT(text, status)
        statusTask.Text=text
        if status=="ok" then bolinha.BackgroundColor3=R(80,200,120)
        elseif status=="error" then bolinha.BackgroundColor3=R(255,80,80)
        elseif status=="warn" then bolinha.BackgroundColor3=R(255,200,50) end
    end

    -- ==========================================
    -- SISTEMA DE VOO E QUESTS
    -- ==========================================
    local function GR() return P.Character and P.Character:FindFirstChild("HumanoidRootPart") end
    local function GH() return P.Character and P.Character:FindFirstChild("Humanoid") end

    -- Função de Voo (em vez de teleporte seco)
    local function VoarPara(posicao)
        local hrp = GR()
        if not hrp then return end
        local bv = Instance.new("BodyVelocity")
        bv.Parent = hrp
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        
        local tempo = 0
        while tempo < 1.5 do
            if not hrp or not hrp.Parent then break end
            local direcao = (posicao - hrp.Position).Unit
            bv.Velocity = direcao * 250 -- Velocidade do voo
            task.wait(0.1)
            tempo = tempo + 0.1
            if (posicao - hrp.Position).Magnitude < 15 then break end
        end
        bv:Destroy()
    end

    local function AceitarQuest()
        SETT("Pegando Quest...", "warn")
        pcall(function()
            -- Tenta se teleportar para o NPC de quest atual do jogador
            CommF:InvokeServer("Teleport", "Quest")
            task.wait(1)
            -- Tenta aceitar a quest via prompt do NPC
            local NPC = workspace:FindFirstChild("Quest")
            if NPC and NPC:FindFirstChild("HumanoidRootPart") then
                VoarPara(NPC.HumanoidRootPart.Position)
                task.wait(0.5)
                local prompt = NPC.HumanoidRootPart:FindFirstChild("ProximityPrompt")
                if prompt then
                    fireproximityprompt(prompt) -- Função do executor mobile/pc
                else
                    CommF:InvokeServer("AcceptQuest") -- Fallback
                end
            end
        end)
        task.wait(1)
    end

    local function findTarget()
        local r = GR()
        if not r then return nil end
        local best, bestD = nil, CF.FarmDist
        for _, obj in ipairs(workspace:GetChildren()) do
            if obj:IsA("Model") then
                local h = obj:FindFirstChild("Humanoid")
                -- Procura mobs com HP especifico para não bater em chefes
                if h and h.Health > 0 and h.MaxHealth < 5000 and obj ~= P.Character and obj.Name ~= "Quest" then
                    local hrp = obj:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local d = (r.Position - hrp.Position).Magnitude
                        if d < bestD then bestD = d; best = hrp end
                    end
                end
            end
        end
        return best
    end

    local function atacar(part)
        if not part then return end
        pcall(function() if mouse1click then mouse1click() end end)
        pcall(function() if firetouchinterest then firetouchinterest(P, 0, part, 1, 0) end end)
        pcall(function() if touch then touch(part.Position) end end)
        UIS:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
        task.wait(0.1)
        UIS:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
    end

    local function doFarm()
        local h, r = GH(), GR()
        if not h or not r then return end
        
        local tgt = findTarget()
        if not tgt then
            SETT("Nenhum mob. Pegando Quest...", "warn")
            AceitarQuest()
            task.wait(2)
            return
        end
        
        -- Usa o Voo em vez do Teleporte
        if (tgt.Position - r.Position).Magnitude > 30 then 
            SETT("Voando até o mob...", "ok")
            VoarPara(tgt.Position) 
        end
        
        SETT("Atacando Mobs...", "ok")
        
        for i = 1, 15 do
            local h2, r2 = GH(), GR()
            if not h2 or not r2 then break end
            if (h2.Health/h2.MaxHealth) < (CF.SafeHP/100) then 
                VoarPara(r2.Position + Vector3.new(0, 500, 0)) -- Foge voando pra cima
                task.wait(3)
                break 
            end
            
            local t2 = findTarget()
            if not t2 then break end
            if (t2.Position - r2.Position).Magnitude > 30 then VoarPara(t2.Position) end
            
            atacar(t2)
            task.wait(0.1)
        end
    end

    UP()
    SETT("Kaitun Iniciado!", "ok")
    
    task.spawn(function()
        while true do
            task.wait(1)
            UP()
            
            if not P.Character or not P.Character:FindFirstChild("HumanoidRootPart") then
                SETT("Aguardando respawn...", "error")
            else
                local lvl = getData()
                if lvl < CF.MaxLvl then
                    doFarm()
                else
                    SETT("Level Máximo! Procurando Bounty...", "ok")
                    -- Aqui entraria o doBounty()
                end
            end
        end
    end)
end)

if not ok then
    local pg=game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local sg2=Instance.new("ScreenGui") sg2.Parent=pg
    local ef=Instance.new("Frame") ef.Size=UDim2.new(0,300,0,120) ef.Position=UDim2.new(0,20,0,40) ef.BackgroundColor3=R(60,0,0) ef.Parent=sg2
    local ec=Instance.new("UICorner") ec.CornerRadius=UDim.new(0,10) ec.Parent=ef
    local et=Instance.new("TextLabel") et.Size=UDim2.new(1,-20,1,-10) et.Position=UDim2.new(0,10,0,5) et.BackgroundTransparency=1
    et.Text="ERRO:\n"..tostring(err) et.TextColor3=R(255,100,100) et.TextSize=12 et.TextWrapped=true et.Parent=ef
end