local ok, err = pcall(function()

local Config = {
    MaxLevel = 2800,
    TargetBounty = 10000000,
    SafeHealth = 20,
    SkipFruits = {"Buddha", "T-Rex", "Leopard", "Dough"},
    AutoV4 = true,
}

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TeleportService")

local C = {
    BG = Color3.fromRGB(15, 15, 25),
    BG2 = Color3.fromRGB(25, 25, 40),
    ACC = Color3.fromRGB(100, 200, 255),
    GRN = Color3.fromRGB(0, 230, 120),
    RED = Color3.fromRGB(255, 80, 80),
    YEL = Color3.fromRGB(255, 200, 50),
    PUR = Color3.fromRGB(180, 100, 255),
    CYN = Color3.fromRGB(0, 240, 240),
    TXT = Color3.fromRGB(220, 220, 240),
    DIM = Color3.fromRGB(120, 120, 150),
}

local main = Instance.new("Frame")
main.Name = "KaitunGUI"
main.Size = UDim2.new(0, 300, 0, 380)
main.Position = UDim2.new(0, 20, 0, 40)
main.BackgroundColor3 = C.BG
main.BackgroundTransparency = 0.1
main.Parent = playerGui

local mc = Instance.new("UICorner")
mc.CornerRadius = UDim.new(0, 14)
mc.Parent = main

local hdr = Instance.new("TextLabel")
hdr.Size = UDim2.new(1, 0, 0, 40)
hdr.BackgroundColor3 = C.BG2
hdr.BackgroundTransparency = 0.3
hdr.Text = "KAITUN"
hdr.TextColor3 = C.ACC
hdr.TextSize = 20
hdr.Font = Enum.Font.GothamBold
hdr.Parent = main

local st = Instance.new("TextLabel")
st.Size = UDim2.new(1, -20, 0, 20)
st.Position = UDim2.new(0, 10, 0, 50)
st.BackgroundTransparency = 1
st.Text = "Starting..."
st.TextColor3 = C.TXT
st.TextSize = 14
st.Font = Enum.Font.GothamBold
st.TextXAlignment = Enum.TextXAlignment.Left
st.Parent = main

local sd = Instance.new("TextLabel")
sd.Size = UDim2.new(1, -20, 0, 16)
sd.Position = UDim2.new(0, 10, 0, 72)
sd.BackgroundTransparency = 1
sd.Text = "Loading..."
sd.TextColor3 = C.DIM
sd.TextSize = 11
sd.Font = Enum.Font.Gotham
sd.TextXAlignment = Enum.TextXAlignment.Left
st.Parent = main

local pbg = Instance.new("Frame")
pbg.Size = UDim2.new(1, -20, 0, 6)
pbg.Position = UDim2.new(0, 10, 0, 95)
pbg.BackgroundColor3 = C.BG2
pbg.Parent = main
local pc = Instance.new("UICorner")
pc.CornerRadius = UDim.new(1, 0)
pc.Parent = pbg
local pbar = Instance.new("Frame")
pbar.Size = UDim2.new(0, 0, 1, 0)
pbar.BackgroundColor3 = C.GRN
pbar.BorderSizePixel = 0
pbar.Parent = pbg
local pbc = Instance.new("UICorner")
pbc.CornerRadius = UDim.new(1, 0)
pbc.Parent = pbar

local s1 = Instance.new("TextLabel")
s1.Size = UDim2.new(0, 130, 0, 16)
s1.Position = UDim2.new(0, 10, 0, 110)
s1.BackgroundTransparency = 1
s1.Text = "Level: -"
s1.TextColor3 = C.YEL
s1.TextSize = 12
s1.Font = Enum.Font.GothamBold
s1.TextXAlignment = Enum.TextXAlignment.Left
s1.Parent = main

local s2 = Instance.new("TextLabel")
s2.Size = UDim2.new(0, 130, 0, 16)
s2.Position = UDim2.new(0, 10, 0, 130)
s2.BackgroundTransparency = 1
s2.Text = "Bounty: -"
s2.TextColor3 = C.RED
s2.TextSize = 12
s2.Font = Enum.Font.GothamBold
s2.TextXAlignment = Enum.TextXAlignment.Left
s2.Parent = main

local s3 = Instance.new("TextLabel")
s3.Size = UDim2.new(0, 130, 0, 16)
s3.Position = UDim2.new(0, 10, 0, 150)
s3.BackgroundTransparency = 1
s3.Text = "Race: -"
s3.TextColor3 = C.PUR
s3.TextSize = 12
s3.Font = Enum.Font.GothamBold
s3.TextXAlignment = Enum.TextXAlignment.Left
s3.Parent = main

local s4 = Instance.new("TextLabel")
s4.Size = UDim2.new(0, 130, 0, 16)
s4.Position = UDim2.new(0, 10, 0, 170)
s4.BackgroundTransparency = 1
s4.Text = "Fruit: -"
s4.TextColor3 = C.CYN
s4.TextSize = 12
s4.Font = Enum.Font.GothamBold
s4.TextXAlignment = Enum.TextXAlignment.Left
s4.Parent = main

local lg = Instance.new("Frame")
lg.Size = UDim2.new(1, -20, 0, 180)
lg.Position = UDim2.new(0, 10, 0, 195)
lg.BackgroundColor3 = C.BG2
lg.BackgroundTransparency = 0.5
lg.Parent = main
local lc = Instance.new("UICorner")
lc.CornerRadius = UDim.new(0, 8)
lc.Parent = lg

local lsc = Instance.new("ScrollingFrame")
lsc.Size = UDim2.new(1, -8, 1, -8)
lsc.Position = UDim2.new(0, 4, 0, 4)
lsc.BackgroundTransparency = 1
lsc.BorderSizePixel = 0
lsc.ScrollBarThickness = 3
lsc.AutomaticCanvasSize = Enum.AutomaticSize.Y
lsc.Parent = lg

local lcount = 0
local function addLog(msg, col)
    lcount = lcount + 1
    local e = Instance.new("TextLabel")
    e.Size = UDim2.new(1, 0, 0, 16)
    e.Position = UDim2.new(0, 0, 0, (lcount - 1) * 17)
    e.BackgroundTransparency = 1
    e.Text = msg
    e.TextColor3 = col or C.TXT
    e.TextSize = 10
    e.Font = Enum.Font.Gotham
    e.TextXAlignment = Enum.TextXAlignment.Left
    e.TextTruncate = Enum.TextTruncate.AtEnd
    e.Parent = lsc
    lsc.CanvasPosition = Vector2.new(0, lsc.CanvasSize.Y.Offset)
end

local function setSt(text, detail, col)
    st.Text = text
    st.TextColor3 = col or C.TXT
    if detail then sd.Text = detail end
end

local function setBar(pct)
    pbar.Size = UDim2.new(math.clamp(pct, 0, 1), 0, 1, 0)
    if pct < 0.3 then pbar.BackgroundColor3 = C.RED
    elseif pct < 0.7 then pbar.BackgroundColor3 = C.YEL
    else pbar.BackgroundColor3 = C.GRN end
end

local function getLvl()
    local ls = player:FindFirstChild("leaderstats")
    if not ls then return 0 end
    local l = ls:FindFirstChild("Level") or ls:FindFirstChild("Lvl")
    return l and l.Value or 0
end

local function getBty()
    local ls = player:FindFirstChild("leaderstats")
    if not ls then return 0 end
    local b = ls:FindFirstChild("Bounty") or ls:FindFirstChild("Honor")
    return b and b.Value or 0
end

local function getRoot()
    local c = player.Character
    if not c then return nil end
    return c:FindFirstChild("HumanoidRootPart")
end

local function getHum()
    local c = player.Character
    if not c then return nil end
    return c:FindFirstChild("Humanoid")
end

local function tp(pos)
    local r = getRoot()
    if r then r.CFrame = CFrame.new(pos + Vector3.new(0, 5, 0)) end
end

local function upStats()
    local l = getLvl()
    local b = getBty()
    s1.Text = "Level: " .. l
    s2.Text = "Bounty: " .. b
    local fr = player:FindFirstChild("Blox Fruit")
    s4.Text = "Fruit: " .. (fr and fr.Value or "None")
    local rc = player:FindFirstChild("Race")
    s3.Text = "Race: " .. (rc and rc.Value or "?")
    setBar(l / Config.MaxLevel)
end

local function hasV3()
    local st2 = player:FindFirstChild("RaceStage") or player:FindFirstChild("Race_V")
    if st2 and st2.Value >= 3 then return true end
    return false
end

local function hasV4()
    local st2 = player:FindFirstChild("RaceStage") or player:FindFirstChild("Race_V")
    if st2 and st2.Value >= 4 then return true end
    return false
end

local function countRaces()
    local my = player:FindFirstChild("Race")
    local myR = my and my.Value or "Human"
    local seen = {}
    local n = 0
    for _, p in ipairs(game.Players:GetPlayers()) do
        if p ~= player then
            local r = p:FindFirstChild("Race")
            local rv = r and r.Value or "Human"
            if rv ~= myR and not seen[rv] then
                seen[rv] = true
                n = n + 1
            end
        end
    end
    return n
end

local function isFullMoon()
    local rs = game:GetService("ReplicatedStorage")
    local moon = rs:FindFirstChild("MoonPhase") or rs:FindFirstChild("Moon")
    if moon then
        local ph = moon:FindFirstChild("Phase")
        if ph and ph.Value then
            return ph.Value:lower():find("full") ~= nil
        end
    end
    return false
end

local function hop()
    TS:TeleportToPlaceInstance(game.PlaceId, game.JobId, {})
end

local function doV4()
    if hasV4() then
        setSt("V4 COMPLETE", "Already V4", C.GRN)
        return true
    end
    if not hasV3() then
        setSt("V4 LOCKED", "Need V3 first", C.YEL)
        addLog("No V3 yet", C.YEL)
        return false
    end

    setSt("V4: CHECKING", "Counting races...", C.PUR)
    local n = countRaces()
    if n < 2 then
        setSt("V4: HOPPING", "Need 2+ races, hopping...", C.PUR)
        addLog("Only " .. n .. " race(s), hopping", C.YEL)
        task.wait(3)
        hop()
        return false
    end

    if not isFullMoon() then
        setSt("V4: WAITING MOON", "Full moon required", C.PUR)
        addLog("Waiting full moon...", C.YEL)
        task.wait(30)
        return false
    end

    setSt("V4: TELEPORT", "Going to Temple of Time", C.PUR)
    addLog("TP to Temple of Time", C.PUR)
    tp(Vector3.new(-7894, 5548, -380))
    task.wait(3)

    setSt("V4: ABILITY", "Activating race ability", C.PUR)
    UIS:SendKeyEvent(true, Enum.KeyCode.Y, false, game)
    task.wait(0.1)
    UIS:SendKeyEvent(false, Enum.KeyCode.Y, false, game)
    task.wait(2)

    setSt("V4: TRIAL", "Fighting mobs...", C.PUR)
    addLog("Trial started", C.PUR)

    for i = 1, 60 do
        task.wait(3)
        if hasV4() then
            setSt("V4 UNLOCKED", "Complete!", C.GRN)
            addLog("V4 UNLOCKED!", C.GRN)
            return true
        end
        local h = getHum()
        local r = getRoot()
        if h and r and (h.Health / h.MaxHealth) * 100 < Config.SafeHealth then
            tp(r.Position + Vector3.new(0, 200, 0))
            task.wait(2)
        end
        UIS:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
        task.wait(0.05)
        UIS:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
        task.wait(0.1)
        UIS:SendKeyEvent(true, Enum.KeyCode.X, false, game)
        task.wait(0.05)
        UIS:SendKeyEvent(false, Enum.KeyCode.X, false, game)
        task.wait(0.1)
        UIS:SendKeyEvent(true, Enum.KeyCode.C, false, game)
        task.wait(0.05)
        UIS:SendKeyEvent(false, Enum.KeyCode.C, false, game)
        task.wait(math.random(10, 30) / 100)
    end

    setSt("V4: CLOCK", "Going to Ancient Clock", C.PUR)
    tp(Vector3.new(-7894, 5560, -380))
    task.wait(3)

    if hasV4() then
        setSt("V4 UNLOCKED", "Complete!", C.GRN)
        addLog("V4 via Clock!", C.GRN)
        return true
    end

    setSt("V4 FAILED", "Try again", C.RED)
    addLog("V4 failed", C.RED)
    return false
end

local function doBounty()
    local h = getHum()
    local r = getRoot()
    if not h or not r then return end

    local bty = getBty()
    setSt("BOUNTY: " .. string.format("%.1fM/10M", bty / 1000000), "Finding target...", C.RED)

    local target = nil
    local best = 0
    for _, p in ipairs(game.Players:GetPlayers()) do
        if p ~= player then
            local ls = p:FindFirstChild("leaderstats")
            if ls then
                local b = ls:FindFirstChild("Bounty") or ls:FindFirstChild("Honor")
                if b and b.Value > best and b.Value <= 30000000 then
                    local fr = p:FindFirstChild("Blox Fruit")
                    local fn = fr and fr.Value or ""
                    local skip = false
                    for _, f in ipairs(Config.SkipFruits) do
                        if fn:find(f) then skip = true break end
                    end
                    if not skip then
                        best = b.Value
                        target = p
                    end
                end
            end
        end
    end

    if not target then
        setSt("BOUNTY", "No targets, waiting...", C.RED)
        task.wait(5)
        return
    end

    local tc = target.Character
    if not tc then return end
    local tr = tc:FindFirstChild("HumanoidRootPart")
    if not tr then return end

    if (r.Position - tr.Position).Magnitude > 150 then
        tp(tr.Position)
    end

    local hp = (h.Health / h.MaxHealth) * 100
    if hp < Config.SafeHealth then
        setSt("LOW HP", "Running...", C.RED)
        tp(r.Position + Vector3.new(0, 5000, 0))
        task.wait(3)
        return
    end

    setSt("ATTACK: " .. target.Name, best .. " bounty", C.RED)
    addLog("Attacking: " .. target.Name, C.RED)

    for i = 1, 15 do
        local tc2 = target.Character
        if not tc2 then break end
        local th = tc2:FindFirstChild("Humanoid")
        if not th or th.Health <= 0 then break end
        UIS:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
        task.wait(0.05)
        UIS:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
        task.wait(math.random(8, 20) / 100)
        UIS:SendKeyEvent(true, Enum.KeyCode.X, false, game)
        task.wait(0.05)
        UIS:SendKeyEvent(false, Enum.KeyCode.X, false, game)
        task.wait(math.random(8, 20) / 100)
        UIS:SendKeyEvent(true, Enum.KeyCode.C, false, game)
        task.wait(0.05)
        UIS:SendKeyEvent(false, Enum.KeyCode.C, false, game)
        task.wait(math.random(8, 20) / 100)
    end

    local tc3 = target.Character
    if not tc3 or not tc3:FindFirstChild("Humanoid") then
        local nb = getBty()
        addLog("KILL: " .. target.Name .. " -> " .. nb, C.GRN)
        setSt("KILL: " .. target.Name, "Bounty: " .. nb, C.CYN)
        task.wait(2)
    end
end

setSt("WAITING", "Character spawning...", C.ACC)
addLog("Kaitun loaded", C.GRN)

repeat task.wait(1) until player.Character and player.Character:FindFirstChild("Humanoid")
task.wait(2)
addLog("Ready. Starting loop.", C.GRN)

while true do
    task.wait(2)
    local l = getLvl()
    local b = getBty()
    upStats()

    if l < Config.MaxLevel then
        if Config.AutoV4 and hasV3() and not hasV4() then
            doV4()
        else
            setSt("FARM", "Farming level...", C.GRN)
            task.wait(3)
        end
    elseif b < Config.TargetBounty then
        doBounty()
    else
        setSt("COMPLETE", "Max Level + 10M Bounty", C.CYN)
        addLog("ALL DONE!", C.CYN)
        break
    end
end

end)

if not ok then
    local pg = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local ef = Instance.new("Frame")
    ef.Size = UDim2.new(0, 300, 0, 150)
    ef.Position = UDim2.new(0, 20, 0, 40)
    ef.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
    ef.Parent = pg
    local ec = Instance.new("UICorner")
    ec.CornerRadius = UDim.new(0, 10)
    ec.Parent = ef
    local et = Instance.new("TextLabel")
    et.Size = UDim2.new(1, -20, 1, -10)
    et.Position = UDim2.new(0, 10, 0, 5)
    et.BackgroundTransparency = 1
    et.Text = "ERROR:\n" .. tostring(err)
    et.TextColor3 = Color3.fromRGB(255, 100, 100)
    et.TextSize = 12
    et.Font = Enum.Font.Gotham
    et.TextXAlignment = Enum.TextXAlignment.Left
    et.TextYAlignment = Enum.TextYAlignment.Top
    et.TextWrapped = true
    et.Parent = ef
end   