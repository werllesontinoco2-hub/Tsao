local Config = {
    MaxLevel = 2800,
    TargetBounty = 10000000,
    Team = "Pirates",
    SafeHealth = 20,
    Race = "Mink",
    SkipFruits = {"Buddha", "T-Rex", "Leopard", "Dough"},
    AutoV4 = true,
    V4Hop = true,
}

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")

local COLORS = {
    BG        = Color3.fromRGB(15, 15, 25),
    BG_LIGHT  = Color3.fromRGB(25, 25, 40),
    ACCENT    = Color3.fromRGB(100, 200, 255),
    GREEN     = Color3.fromRGB(0, 230, 120),
    RED       = Color3.fromRGB(255, 80, 80),
    YELLOW    = Color3.fromRGB(255, 200, 50),
    PURPLE    = Color3.fromRGB(180, 100, 255),
    CYAN      = Color3.fromRGB(0, 240, 240),
    TEXT      = Color3.fromRGB(220, 220, 240),
    TEXT_DIM  = Color3.fromRGB(120, 120, 150),
    GRAD_TOP  = Color3.fromRGB(30, 30, 60),
    GRAD_BOT  = Color3.fromRGB(10, 10, 20),
}

local main = Instance.new("Frame")
main.Name = "KaitunGUI"
main.Size = UDim2.new(0, 320, 0, 420)
main.Position = UDim2.new(0, 20, 0, 40)
main.BackgroundColor3 = COLORS.BG
main.BackgroundTransparency = 0.1
main.Parent = playerGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(60, 60, 100)
mainStroke.Thickness = 1.5
mainStroke.Parent = main

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = COLORS.GRAD_TOP
header.BackgroundTransparency = 0.2
header.Parent = main

local headerCornerTop = Instance.new("UICorner")
headerCornerTop.CornerRadius = UDim.new(0, 14)
headerCornerTop.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 25)
title.Position = UDim2.new(0, 15, 0, 5)
title.BackgroundTransparency = 1
title.Text = "⚡ KAITUN"
title.TextColor3 = COLORS.ACCENT
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -20, 0, 18)
subtitle.Position = UDim2.new(0, 15, 0, 28)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Full Auto Progression"
subtitle.TextColor3 = COLORS.TEXT_DIM
subtitle.TextSize = 12
subtitle.Font = Enum.Font.Gotham
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = header

local statusFrame = Instance.new("Frame")
statusFrame.Size = UDim2.new(1, -20, 0, 45)
statusFrame.Position = UDim2.new(0, 10, 0, 60)
statusFrame.BackgroundColor3 = COLORS.BG_LIGHT
statusFrame.Parent = main

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 10)
statusCorner.Parent = statusFrame

local statusIcon = Instance.new("TextLabel")
statusIcon.Size = UDim2.new(0, 30, 1, 0)
statusIcon.Position = UDim2.new(0, 5, 0, 0)
statusIcon.BackgroundTransparency = 1
statusIcon.Text = "⏳"
statusIcon.TextSize = 22
statusIcon.TextColor3 = COLORS.ACCENT
statusIcon.Parent = statusFrame

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, -45, 0, 20)
statusText.Position = UDim2.new(0, 35, 0, 5)
statusText.BackgroundTransparency = 1
statusText.Text = "Iniciando..."
statusText.TextColor3 = COLORS.TEXT
statusText.TextSize = 14
statusText.Font = Enum.Font.GothamBold
statusText.TextXAlignment = Enum.TextXAlignment.Left
statusText.Parent = statusFrame

local statusDetail = Instance.new("TextLabel")
statusDetail.Size = UDim2.new(1, -45, 0, 16)
statusDetail.Position = UDim2.new(0, 35, 0, 26)
statusDetail.BackgroundTransparency = 1
statusDetail.Text = "Carregando..."
statusDetail.TextColor3 = COLORS.TEXT_DIM
statusDetail.TextSize = 11
statusDetail.Font = Enum.Font.Gotham
statusDetail.TextXAlignment = Enum.TextXAlignment.Left
statusDetail.Parent = statusFrame

local progressBg = Instance.new("Frame")
progressBg.Size = UDim2.new(1, -20, 0, 8)
progressBg.Position = UDim2.new(0, 10, 0, 115)
progressBg.BackgroundColor3 = COLORS.BG_LIGHT
progressBg.Parent = main

local progressCorner = Instance.new("UICorner")
progressCorner.CornerRadius = UDim.new(1, 0)
progressCorner.Parent = progressBg

local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = COLORS.GREEN
progressBar.BorderSizePixel = 0
progressBar.Parent = progressBg

local progressCornerBar = Instance.new("UICorner")
progressCornerBar.CornerRadius = UDim.new(1, 0)
progressCornerBar.Parent = progressBar

local statsFrame = Instance.new("Frame")
statsFrame.Size = UDim2.new(1, -20, 0, 55)
statsFrame.Position = UDim2.new(0, 10, 0, 130)
statsFrame.BackgroundColor3 = COLORS.BG_LIGHT
statsFrame.Parent = main

local statsCorner = Instance.new("UICorner")
statsCorner.CornerRadius = UDim.new(0, 10)
statsCorner.Parent = statsFrame

local levelLabel = Instance.new("TextLabel")
levelLabel.Size = UDim2.new(0, 90, 1, 0)
levelLabel.Position = UDim2.new(0, 10, 0, 8)
levelLabel.BackgroundTransparency = 1
levelLabel.Text = "Level: -"
levelLabel.TextColor3 = COLORS.YELLOW
levelLabel.TextSize = 13
levelLabel.Font = Enum.Font.GothamBold
levelLabel.Parent = statsFrame

local bountyLabel = Instance.new("TextLabel")
bountyLabel.Size = UDim2.new(0, 110, 1, 0)
bountyLabel.Position = UDim2.new(0, 10, 0, 30)
bountyLabel.BackgroundTransparency = 1
bountyLabel.Text = "Bounty: -"
bountyLabel.TextColor3 = COLORS.RED
bountyLabel.TextSize = 13
bountyLabel.Font = Enum.Font.GothamBold
bountyLabel.Parent = statsFrame

local raceLabel = Instance.new("TextLabel")
raceLabel.Size = UDim2.new(0, 100, 1, 0)
raceLabel.Position = UDim2.new(1, -110, 0, 8)
raceLabel.BackgroundTransparency = 1
raceLabel.Text = "Race: -"
raceLabel.TextColor3 = COLORS.PURPLE
raceLabel.TextSize = 13
raceLabel.Font = Enum.Font.GothamBold
raceLabel.TextXAlignment = Enum.TextXAlignment.Right
raceLabel.Parent = statsFrame

local fruitLabel = Instance.new("TextLabel")
fruitLabel.Size = UDim2.new(0, 100, 1, 0)
fruitLabel.Position = UDim2.new(1, -110, 0, 30)
fruitLabel.BackgroundTransparency = 1
fruitLabel.Text = "Fruit: -"
fruitLabel.TextColor3 = COLORS.CYAN
fruitLabel.TextSize = 13
fruitLabel.Font = Enum.Font.GothamBold
fruitLabel.TextXAlignment = Enum.TextXAlignment.Right
fruitLabel.Parent = statsFrame

local logFrame = Instance.new("Frame")
logFrame.Size = UDim2.new(1, -20, 1, -220)
logFrame.Position = UDim2.new(0, 10, 0, 195)
logFrame.BackgroundColor3 = COLORS.GRAD_BOT
logFrame.BackgroundTransparency = 0.3
logFrame.Parent = main

local logCorner = Instance.new("UICorner")
logCorner.CornerRadius = UDim.new(0, 10)
logCorner.Parent = logFrame

local logScroller = Instance.new("ScrollingFrame")
logScroller.Size = UDim2.new(1, -10, 1, -10)
logScroller.Position = UDim2.new(0, 5, 0, 5)
logScroller.BackgroundTransparency = 1
logScroller.BorderSizePixel = 0
logScroller.ScrollBarThickness = 3
logScroller.ScrollBarImageColor3 = COLORS.ACCENT
logScroller.CanvasSize = UDim2.new(0, 0, 0, 0)
logScroller.AutomaticCanvasSize = Enum.AutomaticSize.Y
logScroller.Parent = logFrame

local dragging = false
local dragStart, dragPos
main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        dragPos = main.Position
    end
end)
main.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(dragPos.X.Scale, dragPos.X.Offset + delta.X, dragPos.Y.Scale, dragPos.Y.Offset + delta.Y)
    end
end)

local logCount = 0

local function log(msg, color)
    logCount += 1
    local entry = Instance.new("TextLabel")
    entry.Size = UDim2.new(1, 0, 0, 16)
    entry.Position = UDim2.new(0, 0, 0, (logCount - 1) * 17)
    entry.BackgroundTransparency = 1
    entry.Text = "[Kaitun] " .. msg
    entry.TextColor3 = color or COLORS.TEXT
    entry.TextSize = 11
    entry.Font = Enum.Font.Gotham
    entry.TextXAlignment = Enum.TextXAlignment.Left
    entry.TextTruncate = Enum.TextTruncate.AtEnd
    entry.Parent = logScroller
    logScroller.CanvasPosition = Vector2.new(0, logScroller.CanvasSize.Y.Offset)
end

local function setStatus(icon, text, detail, color)
    statusIcon.Text = icon
    statusIcon.TextColor3 = color or COLORS.ACCENT
    statusText.Text = text
    statusText.TextColor3 = color or COLORS.TEXT
    if detail then
        statusDetail.Text = detail
    end
end

local function setProgress(pct)
    progressBar.Size = UDim2.new(math.clamp(pct, 0, 1), 0, 1, 0)
    if pct < 0.3 then
        progressBar.BackgroundColor3 = COLORS.RED
    elseif pct < 0.7 then
        progressBar.BackgroundColor3 = COLORS.YELLOW
    else
        progressBar.BackgroundColor3 = COLORS.GREEN
    end
end

local function updateStats()
    local ls = player:FindFirstChild("leaderstats")
    if not ls then return end
    local lvl = ls:FindFirstChild("Level") or ls:FindFirstChild("Lvl")
    local bty = ls:FindFirstChild("Bounty") or ls:FindFirstChild("Honor")
    levelLabel.Text = "Level: " .. (lvl and lvl.Value or "?")
    bountyLabel.Text = "Bounty: " .. (bty and tostring(bty.Value) or "0")
    local fruit = player:FindFirstChild("Blox Fruit")
    fruitLabel.Text = "Fruit: " .. (fruit and fruit.Value or "None")
    local race = player:FindFirstChild("Race")
    raceLabel.Text = "Race: " .. (race and race.Value or "?")
    if lvl then
        setProgress(lvl.Value / Config.MaxLevel)
    end
end

local function getLevel()
    local ls = player:FindFirstChild("leaderstats")
    if not ls then return 0 end
    local lvl = ls:FindFirstChild("Level") or ls:FindFirstChild("Lvl")
    return lvl and lvl.Value or 0
end

local function getBounty()
    local ls = player:FindFirstChild("leaderstats")
    if not ls then return 0 end
    local b = ls:FindFirstChild("Bounty") or ls:FindFirstChild("Honor")
    return b and b.Value or 0
end

local function getCharacter()
    local c = player.Character
    if not c then return nil, nil, nil end
    return c, c:FindFirstChild("Humanoid"), c:FindFirstChild("HumanoidRootPart")
end

local function teleport(pos)
    local _, _, root = getCharacter()
    if root then
        root.CFrame = CFrame.new(pos + Vector3.new(0, 5, 0))
    end
end

local function hasQuest()
    local quest = player:FindFirstChild("Quest")
    if not quest then return false end
    return quest:FindFirstChild("Active") ~= nil
end

local function needFruit()
    local fruit = player:FindFirstChild("Blox Fruit")
    if fruit and fruit.Value and fruit.Value ~= "" then return false end
    return getLevel() >= 10
end

local function getMyRace()
    local race = player:FindFirstChild("Race")
    return race and race.Value or "Human"
end

local function hasV3()
    local stage = player:FindFirstChild("RaceStage") or player:FindFirstChild("Race_V")
    if stage and stage.Value >= 3 then return true end
    local abilities = player:FindFirstChild("Abilities")
    if abilities then
        for _, a in ipairs(abilities:GetChildren()) do
            if a.Name:find("V3") or a.Name:find("Awaken") then
                return true
            end
        end
    end
    return false
end

local function hasV4()
    local stage = player:FindFirstChild("RaceStage") or player:FindFirstChild("Race_V")
    if stage and stage.Value >= 4 then return true end
    local abilities = player:FindFirstChild("Abilities")
    if abilities then
        for _, a in ipairs(abilities:GetChildren()) do
            if a.Name:find("V4") or a.Name:find("Awakening") then
                return true
            end
        end
    end
    return false
end

local function activateRaceAbility()
    UserInputService:SendKeyEvent(true, Enum.KeyCode.Y, false, game)
    task.wait(0.1)
    UserInputService:SendKeyEvent(false, Enum.KeyCode.Y, false, game)
    task.wait(0.5)
end

local function countEligiblePlayers()
    local myRace = getMyRace()
    local count = 0
    local races = {}
    for _, p in ipairs(game.Players:GetPlayers()) do
        if p ~= player then
            local race = p:FindFirstChild("Race")
            local r = race and race.Value or "Human"
            if r ~= myRace and not races[r] then
                races[r] = true
                count += 1
            end
        end
    end
    return count
end

local function isFullMoon()
    local rs = game:GetService("ReplicatedStorage")
    local moon = rs:FindFirstChild("MoonPhase") or rs:FindFirstChild("Moon")
    if moon then
        local phase = moon:FindFirstChild("Phase")
        if phase and phase.Value then
            return phase.Value:lower():find("full") ~= nil
        end
    end
    return false
end

local function serverHop()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, {})
end

local function autoV4()
    if hasV4() then
        setStatus("✅", "RACE V4 COMPLETA", "Já está em V4", COLORS.GREEN)
        return true
    end

    if not hasV3() then
        setStatus("⚠️", "V4 BLOQUEADO", "Precisa de V3 primeiro", COLORS.YELLOW)
        log("Sem V3 — não pode fazer trial", COLORS.YELLOW)
        return false
    end

    local myRace = getMyRace()
    setStatus("🔮", "RACE V4", "Verificando condições...", COLORS.PURPLE)
    log("Iniciando Auto V4 — Raça: " .. myRace, COLORS.PURPLE)

    local eligible = countEligiblePlayers()
    if eligible < 2 then
        if Config.V4Hop then
            setStatus("🔮", "V4: SEM ALVOS", "Hopping server (precisa 2+ raças diferentes)", COLORS.PURPLE)
            log("Só " .. eligible .. " raça(s) diferente(s) — hopping...", COLORS.YELLOW)
            task.wait(3)
            serverHop()
            return false
        else
            setStatus("🔮", "V4: AGUARDANDO", "Precisa 2+ players de raças diferentes", COLORS.PURPLE)
            task.wait(10)
            return false
        end
    end

    if not isFullMoon() then
        setStatus("🌙", "V4: AGUARDANDO LUA CHEIA", "Full moon necessária", COLORS.PURPLE)
        log("Aguardando lua cheia...", COLORS.YELLOW)
        task.wait(30)
        return false
    end

    local TempleOfTime = CFrame.new(-7894, 5548, -380)
    local TrialDoors = {
        Human   = CFrame.new(-7894, 5548, -350),
        Mink    = CFrame.new(-7894, 5548, -370),
        Fishman = CFrame.new(-7894, 5548, -390),
        Skypiea = CFrame.new(-7894, 5548, -410),
        Cyborg  = CFrame.new(-7894, 5548, -430),
        Ghoul   = CFrame.new(-7894, 5548, -450),
        Angel   = CFrame.new(-7894, 5548, -470),
        Shark   = CFrame.new(-7894, 5548, -490),
    }

    setStatus("🔮", "V4: TELEPORTANDO", "Indo pro Temple of Time", COLORS.PURPLE)
    log("Teleportando pro Temple of Time", COLORS.PURPLE)
    teleport(TempleOfTime.Position)
    task.wait(3)

    local door = TrialDoors[myRace] or TrialDoors.Human
    setStatus("🔮", "V4: NA PORTA", "Ativando race ability...", COLORS.PURPLE)
    teleport(door.Position)
    task.wait(2)

    activateRaceAbility()
    log("Race ability ativada — aguardando porta abrir", COLORS.PURPLE)
    setStatus("🔮", "V4: TRIAL INICIADO", "Lutando...", COLORS.PURPLE)

    local _, humanoid, root = getCharacter()
    if not humanoid or not root then return false end

    for i = 1, 120 do
        task.wait(2)

        if hasV4() then
            log("V4 UNLOCKED! 🎉", COLORS.GREEN)
            setStatus("✅", "RACE V4 UNLOCKED", "Completado!", COLORS.GREEN)
            return true
        end

        local hpPct = (humanoid.Health / humanoid.MaxHealth) * 100
        if hpPct < Config.SafeHealth then
            teleport(root.Position + Vector3.new(0, 200, 0))
            task.wait(2)
        end

        local nearest = nil
        local nearestDist = 200
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj ~= root and obj.Parent then
                if obj.Parent:FindFirstChild("Humanoid") then
                    local d = (root.Position - obj.Position).Magnitude
                    if d < nearestDist then
                        nearestDist = d
                        nearest = obj
                    end
                end
            end
        end

        if nearest then
            local UIS = game:GetService("UserInputService")
            for _, key in ipairs({Enum.KeyCode.Z, Enum.KeyCode.X, Enum.KeyCode.C}) do
                UIS:SendKeyEvent(true, key, false, game)
                task.wait(0.05)
                UIS:SendKeyEvent(false, key, false, game)
                task.wait(math.random(8, 25) / 100)
            end
        end
    end

    local AncientClock = CFrame.new(-7894, 5560, -380)
    log("Trial terminou — indo pro Ancient Clock", COLORS.PURPLE)
    teleport(AncientClock.Position)
    task.wait(3)

    if hasV4() then
        log("V4 UNLOCKED via Ancient Clock! 🎉", COLORS.GREEN)
        setStatus("✅", "RACE V4 UNLOCKED", "Completado!", COLORS.GREEN)
        return true
    end

    log("V4 não completou — tenta de novo", COLORS.RED)
    setStatus("🔮", "V4 FALHOU", "Tenta de novo", COLORS.RED)
    return false
end

local function autoBounty()
    local _, humanoid, root = getCharacter()
    if not humanoid or not root then return end

    local bounty = getBounty()
    setStatus("⚔️", "BOUNTY: " .. string.format("%.1fM / 10M", bounty / 1000000),
        "Procurando alvo...", COLORS.RED)

    local target = nil
    local bestBounty = 0

    for _, p in ipairs(game.Players:GetPlayers()) do
        if p ~= player then
            local ls = p:FindFirstChild("leaderstats")
            if ls then
                local b = ls:FindFirstChild("Bounty") or ls:FindFirstChild("Honor")
                if b and b.Value > bestBounty and b.Value <= 30000000 then
                    local skip = false
                    local fruit = p:FindFirstChild("Blox Fruit")
                    local fruitName = fruit and fruit.Value or ""
                    for _, f in ipairs(Config.SkipFruits) do
                        if fruitName:find(f) then skip = true break end
                    end
                    if not skip then
                        bestBounty = b.Value
                        target = p
                    end
                end
            end
        end
    end

    if not target then
        setStatus("⚔️", "BOUNTY", "Sem alvos... esperando", COLORS.RED)
        task.wait(5)
        return
    end

    local tChar = target.Character
    if not tChar then return end
    local tRoot = tChar:FindFirstChild("HumanoidRootPart")
    if not tRoot then return end

    local dist = (root.Position - tRoot.Position).Magnitude
    if dist > 150 then
        teleport(tRoot.Position)
    end

    local hpPct = (humanoid.Health / humanoid.MaxHealth) * 100
    if hpPct < Config.SafeHealth then
        setStatus("💔", "HP BAIXO", "Fugindo...", COLORS.RED)
        teleport(root.Position + Vector3.new(0, 5000, 0))
        task.wait(3)
        return
    end

    setStatus("⚔️", "A: " .. target.Name, bestBounty .. " bounty", COLORS.RED)
    log("Atacando: " .. target.Name, COLORS.RED)

    local UIS = game:GetService("UserInputService")
    for i = 1, 15 do
        if not target.Character or not target.Character:FindFirstChild("Humanoid") then break end
        local tHum = target.Character:FindFirstChild("Humanoid")
        if tHum and tHum.Health <= 0 then break end

        for _, key in ipairs({Enum.KeyCode.Z, Enum.KeyCode.X, Enum.KeyCode.C}) do
            UIS:SendKeyEvent(true, key, false, game)
            task.wait(0.05)
            UIS:SendKeyEvent(false, key, false, game)
            task.wait(math.random(8, 25) / 100)
        end
        task.wait(0.1)
    end

    if not target.Character or not target.Character:FindFirstChild("Humanoid") then
        local newBounty = getBounty()
        log("KILL: " .. target.Name .. " → Bounty: " .. newBounty, COLORS.GREEN)
        setStatus("☠️", "Kill: " .. target.Name, "Bounty: " .. newBounty, COLORS.CYAN)
        task.wait(2)
    end
end

local function doFarmLevel()
    setStatus("🗡️", "FARM LEVEL", "Farmando boss/quest", COLORS.GREEN)
    task.wait(5)
end

local function doQuest()
    setStatus("📋", "QUEST", "Completando missão", COLORS.YELLOW)
    task.wait(3)
end

local function doShop()
    setStatus("🛒", "SHOP", "Comprando stuffs", COLORS.ACCENT)
    task.wait(3)
end

local function doFruit()
    setStatus("🍎", "FRUIT", "Procurando fruta", COLORS.PURPLE)
    task.wait(3)
end

setStatus("⏳", "INICIANDO", "Aguardando character...", COLORS.ACCENT)
log("Kaitun iniciado!", COLORS.GREEN)

repeat task.wait(1) until player.Character and player.Character:FindFirstChild("Humanoid")
task.wait(2)

log("Character pronto. Iniciando loop...", COLORS.GREEN)

while true do
    task.wait(2)

    local level = getLevel()
    local bounty = getBounty()
    updateStats()

    if level < Config.MaxLevel then
        if Config.AutoV4 and hasV3() and not hasV4() then
            autoV4()
        elseif hasQuest() then
            doQuest()
        elseif needFruit() then
            doFruit()
        else
            doFarmLevel()
        end
    elseif bounty < Config.TargetBounty then
        autoBounty()
    else
        setStatus("🏆", "COMPLETE!", "Max Level + 10M Bounty", COLORS.CYAN)
        log("🏆 TUDO PRONTO!", COLORS.CYAN)
        break
    end
end