local ok,err=pcall(function()
local CF={MaxLvl=2800,TargetBty=10000000,SafeHP=20,Skip={"Buddha","T-Rex","Leopard","Dough"},V4=true}
local P=game.Players.LocalPlayer
local PG=P:WaitForChild("PlayerGui")
local UIS=game:GetService("UserInputService")
local TS=game:GetService("TeleportService")
local HS=game:GetService("HttpService")
local LT=game:GetService("Lighting")
local R=Color3.fromRGB

local SG=Instance.new("ScreenGui")
SG.Name="KaitunUI"
SG.ResetOnSpawn=false
SG.IgnoreGuiInset=true
SG.Parent=PG

local M=Instance.new("Frame")
M.Size=UDim2.new(0,300,0,360)
M.Position=UDim2.new(0,20,0,40)
M.BackgroundColor3=R(15,15,25)
M.Parent=SG

local MC=Instance.new("UICorner")
MC.CornerRadius=UDim.new(0,14)
MC.Parent=M

local H=Instance.new("TextLabel")
H.Size=UDim2.new(1,0,0,36)
H.BackgroundColor3=R(30,30,60)
H.Text="KAITUN"
H.TextColor3=R(100,200,255)
H.TextSize=18
H.Font=Enum.Font.GothamBold
H.Parent=M

local ST=Instance.new("TextLabel")
ST.Size=UDim2.new(1,-20,0,18)
ST.Position=UDim2.new(0,10,0,44)
ST.BackgroundTransparency=1
ST.Text="Starting..."
ST.TextColor3=R(220,220,240)
ST.TextSize=13
ST.Font=Enum.Font.GothamBold
ST.TextXAlignment=Enum.TextXAlignment.Left
ST.Parent=M

local SD=Instance.new("TextLabel")
SD.Size=UDim2.new(1,-20,0,14)
SD.Position=UDim2.new(0,10,0,64)
SD.BackgroundTransparency=1
SD.Text="Loading..."
SD.TextColor3=R(120,120,150)
SD.TextSize=10
SD.Font=Enum.Font.Gotham
SD.TextXAlignment=Enum.TextXAlignment.Left
SD.Parent=M

local PB=Instance.new("Frame")
PB.Size=UDim2.new(1,-20,0,6)
PB.Position=UDim2.new(0,10,0,84)
PB.BackgroundColor3=R(25,25,40)
PB.ClipsDescendants=true
PB.Parent=M
local PBC=Instance.new("UICorner")
PBC.CornerRadius=UDim.new(1,0)
PBC.Parent=PB
local PBAR=Instance.new("Frame")
PBAR.Size=UDim2.new(0,0,1,0)
PBAR.BackgroundColor3=R(0,230,120)
PBAR.BorderSizePixel=0
PBAR.Parent=PB
local PBBC=Instance.new("UICorner")
PBBC.CornerRadius=UDim.new(1,0)
PBBC.Parent=PBAR

local S1=Instance.new("TextLabel")
S1.Size=UDim2.new(0,140,0,14)
S1.Position=UDim2.new(0,10,0,96)
S1.BackgroundTransparency=1
S1.Text="Level: -"
S1.TextColor3=R(255,200,50)
S1.TextSize=11
S1.Font=Enum.Font.GothamBold
S1.TextXAlignment=Enum.TextXAlignment.Left
S1.Parent=M

local S2=Instance.new("TextLabel")
S2.Size=UDim2.new(0,140,0,14)
S2.Position=UDim2.new(0,10,0,114)
S2.BackgroundTransparency=1
S2.Text="Bounty: -"
S2.TextColor3=R(255,80,80)
S2.TextSize=11
S2.Font=Enum.Font.GothamBold
S2.TextXAlignment=Enum.TextXAlignment.Left
S2.Parent=M

local S3=Instance.new("TextLabel")
S3.Size=UDim2.new(0,140,0,14)
S3.Position=UDim2.new(0,10,0,132)
S3.BackgroundTransparency=1
S3.Text="Race: -"
S3.TextColor3=R(180,100,255)
S3.TextSize=11
S3.Font=Enum.Font.GothamBold
S3.TextXAlignment=Enum.TextXAlignment.Left
S3.Parent=M

local S4=Instance.new("TextLabel")
S4.Size=UDim2.new(0,140,0,14)
S4.Position=UDim2.new(0,10,0,150)
S4.BackgroundTransparency=1
S4.Text="Fruit: -"
S4.TextColor3=R(0,240,240)
S4.TextSize=11
S4.Font=Enum.Font.GothamBold
S4.TextXAlignment=Enum.TextXAlignment.Left
S4.Parent=M

local LF=Instance.new("Frame")
LF.Size=UDim2.new(1,-20,0,180)
LF.Position=UDim2.new(0,10,0,170)
LF.BackgroundColor3=R(25,25,40)
LF.BackgroundTransparency=0.5
LF.Parent=M
local LC=Instance.new("UICorner")
LC.CornerRadius=UDim.new(0,8)
LC.Parent=LF
local LS=Instance.new("ScrollingFrame")
LS.Size=UDim2.new(1,-8,1,-8)
LS.Position=UDim2.new(0,4,0,4)
LS.BackgroundTransparency=1
LS.BorderSizePixel=0
LS.ScrollBarThickness=3
LS.Parent=LF

local LN=0
function LOG(m,c)
LN=LN+1
local e=Instance.new("TextLabel")
e.Size=UDim2.new(1,0,0,15)
e.Position=UDim2.new(0,0,0,(LN-1)*16)
e.BackgroundTransparency=1
e.Text=m
e.TextColor3=c or R(220,220,240)
e.TextSize=10
e.Font=Enum.Font.Gotham
e.TextXAlignment=Enum.TextXAlignment.Left
e.TextTruncate=Enum.TextTruncate.AtEnd
e.Parent=LS
LS.CanvasSize=UDim2.new(0,0,0,LN*16)
LS.CanvasPosition=Vector2.new(0,LS.CanvasSize.Y.Offset)
end

function SETS(t,d,c)
ST.Text=t
ST.TextColor3=c or R(220,220,240)
if d then SD.Text=d end
end

function SETB(p)
PBAR.Size=UDim2.new(math.clamp(p,0,1),0,1,0)
PBAR.BackgroundColor3=p<0.3 and R(255,80,80) or p<0.7 and R(255,200,50) or R(0,230,120)
end

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
if d then
local r=d:FindFirstChild("Race")
if r and r.Value then return r.Value end
end
local r=P:FindFirstChild("Race")
if r and r.Value then return r.Value end
return "Human"
end

function getFruit()
local d=P:FindFirstChild("Data")
if d then
local f=d:FindFirstChild("BloxFruit") or d:FindFirstChild("Blox Fruit")
if f and f.Value then return f.Value end
end
local f=P:FindFirstChild("Blox Fruit")
if f and f.Value then return f.Value end
return "None"
end

function UP()
local l=GL()
local b=GB()
S1.Text="Level: "..l
S2.Text="Bounty: "..b
S4.Text="Fruit: "..getFruit()
S3.Text="Race: "..getRace()
SETB(l/CF.MaxLvl)
end

function HV3()
local d=P:FindFirstChild("Data")
if d then
local s=d:FindFirstChild("RaceStage") or d:FindFirstChild("Race_V")
if s and s.Value>=3 then return true end
end
local s=P:FindFirstChild("RaceStage") or P:FindFirstChild("Race_V")
if s and s.Value>=3 then return true end
return false
end

function HV4()
local d=P:FindFirstChild("Data")
if d then
local s=d:FindFirstChild("RaceStage") or d:FindFirstChild("Race_V")
if s and s.Value>=4 then return true end
end
local s=P:FindFirstChild("RaceStage") or P:FindFirstChild("Race_V")
if s and s.Value>=4 then return true end
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
if d then
local r=d:FindFirstChild("Race")
if r and r.Value then rv=r.Value end
end
if rv~=myR and not seen[rv] then seen[rv]=true n=n+1 end
end
end
return n
end

function FM()
local ct=LT.ClockTime
return ct>=17.5 and ct<=18.5
end

function HP()
local ok2,res=pcall(function()
return HS:RequestAsync({Url="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?limit=10",Method="GET"})
end)
if ok2 and res and res.Body then
local data=HS:JSONDecode(res.Body)
if data.servers then
for _,s in ipairs(data.servers) do
if s.id~=game.JobId then
TS:TeleportToPlaceInstance(game.PlaceId,s.id)
return
end
end
end
end
TS:TeleportToPlaceInstance(game.PlaceId,game.JobId)
end

function ATK()
UIS:SendKeyEvent(true,Enum.KeyCode.Z,false,game)
task.wait(0.05)
UIS:SendKeyEvent(false,Enum.KeyCode.Z,false,game)
task.wait(math.random(8,20)/100)
UIS:SendKeyEvent(true,Enum.KeyCode.X,false,game)
task.wait(0.05)
UIS:SendKeyEvent(false,Enum.KeyCode.X,false,game)
task.wait(math.random(8,20)/100)
UIS:SendKeyEvent(true,Enum.KeyCode.C,false,game)
task.wait(0.05)
UIS:SendKeyEvent(false,Enum.KeyCode.C,false,game)
task.wait(math.random(8,20)/100)
end

function V4()
if HV4() then SETS("V4 COMPLETE","Already V4",R(0,230,120)) return true end
if not HV3() then SETS("V4 LOCKED","Need V3 first",R(255,200,50)) LOG("No V3",R(255,200,50)) return false end
SETS("V4: CHECK","Counting races...",R(180,100,255))
local n=CR()
if n<2 then
SETS("V4: HOP","Need 2+ races, hopping",R(180,100,255))
LOG("Only "..n.." race(s), hopping",R(255,200,50))
task.wait(3)
HP()
return false
end
if not FM() then
SETS("V4: MOON","Waiting full moon (18:00)",R(180,100,255))
LOG("Waiting full moon",R(255,200,50))
task.wait(30)
return false
end
SETS("V4: TP","Temple of Time",R(180,100,255))
LOG("TP to Temple",R(180,100,255))
TP(Vector3.new(-7894,5548,-380))
task.wait(3)
SETS("V4: ABIL","Activating race ability",R(180,100,255))
UIS:SendKeyEvent(true,Enum.KeyCode.Y,false,game)
task.wait(0.1)
UIS:SendKeyEvent(false,Enum.KeyCode.Y,false,game)
task.wait(2)
SETS("V4: TRIAL","Fighting...",R(180,100,255))
LOG("Trial started",R(180,100,255))
for i=1,60 do
task.wait(3)
if HV4() then SETS("V4 UNLOCKED","Complete!",R(0,230,120)) LOG("V4 UNLOCKED!",R(0,230,120)) return true end
local h=GH()
local r=GR()
if h and r and(h.Health/h.MaxHealth)*100<CF.SafeHP then
TP(r.Position+Vector3.new(0,200,0))
task.wait(2)
end
ATK()
end
SETS("V4: CLOCK","Ancient Clock",R(180,100,255))
TP(Vector3.new(-7894,5560,-380))
task.wait(3)
if HV4() then SETS("V4 UNLOCKED","Complete!",R(0,230,120)) LOG("V4 via Clock!",R(0,230,120)) return true end
SETS("V4 FAILED","Try again",R(255,80,80))
LOG("V4 failed",R(255,80,80))
return false
end

function BTY()
local h=GH()
local r=GR()
if not h or not r then return end
local bty=GB()
SETS("BOUNTY: "..string.format("%.1fM/10M",bty/1000000),"Finding target...",R(255,80,80))
local tgt=nil
local best=0
for _,p in ipairs(game.Players:GetPlayers()) do
if p~=P then
local ls=p:FindFirstChild("leaderstats")
if ls then
local b=ls:FindFirstChild("Bounty") or ls:FindFirstChild("Honor")
if b and b.Value>best and b.Value<=30000000 then
local fn=""
local d=p:FindFirstChild("Data")
if d then
local f=d:FindFirstChild("BloxFruit") or d:FindFirstChild("Blox Fruit")
if f and f.Value then fn=f.Value end
end
if fn=="" then
local f2=p:FindFirstChild("Blox Fruit")
if f2 and f2.Value then fn=f2.Value end
end
local sk=false
local fnl=string.lower(fn)
for _,f in ipairs(CF.Skip) do
if fnl:find(string.lower(f),1,true) then sk=true break end
end
if not sk then best=b.Value tgt=p end
end
end
end
end
if not tgt then SETS("BOUNTY","No targets",R(255,80,80)) task.wait(5) return end
local tc=tgt.Character
if not tc then return end
local tr=tc:FindFirstChild("HumanoidRootPart")
if not tr then return end
if(r.Position-tr.Position).Magnitude>150 then TP(tr.Position) end
local hp=(h.Health/h.MaxHealth)*100
if hp<CF.SafeHP then
SETS("LOW HP","Running...",R(255,80,80))
TP(r.Position+Vector3.new(0,5000,0))
task.wait(3)
return
end
SETS("ATTACK: "..tgt.Name,best.." bounty",R(255,80,80))
LOG("Atk: "..tgt.Name,R(255,80,80))
for i=1,15 do
local tc2=tgt.Character
if not tc2 then break end
local th=tc2:FindFirstChild("Humanoid")
if not th or th.Health<=0 then break end
ATK()
end
local tc3=tgt.Character
if not tc3 or not tc3:FindFirstChild("Humanoid") then
local nb=GB()
LOG("KILL: "..tgt.Name.." -> "..nb,R(0,230,120))
SETS("KILL: "..tgt.Name,"Bounty: "..nb,R(0,240,240))
task.wait(2)
end
end

SETS("WAITING","Character spawning...",R(100,200,255))
LOG("Loaded",R(0,230,120))

repeat task.wait(1) until P.Character and P.Character:FindFirstChild("Humanoid")
task.wait(2)
LOG("Ready",R(0,230,120))

while true do
task.wait(2)
if not P.Character then
SETS("DEAD","Respawning...",R(255,80,80))
repeat task.wait(1) until P.Character and P.Character:FindFirstChild("Humanoid")
continue
end
local l=GL()
local b=GB()
UP()
if l<CF.MaxLvl then
if CF.V4 and HV3() and not HV4() then V4()
else SETS("FARM","Farming level...",R(0,230,120)) task.wait(3) end
elseif b<CF.TargetBty then
BTY()
else
SETS("COMPLETE","Max Level + 10M Bounty",R(0,240,240))
LOG("ALL DONE!",R(0,240,240))
break
end
end
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
ef.BackgroundColor3=Color3.fromRGB(60,0,0)
ef.Parent=sg2
local ec=Instance.new("UICorner")
ec.CornerRadius=UDim.new(0,10)
ec.Parent=ef
local et=Instance.new("TextLabel")
et.Size=UDim2.new(1,-20,1,-10)
et.Position=UDim2.new(0,10,0,5)
et.BackgroundTransparency=1
et.Text="ERR: "..tostring(err)
et.TextColor3=Color3.fromRGB(255,100,100)
et.TextSize=12
et.Font=Enum.Font.Gotham
et.TextXAlignment=Enum.TextXAlignment.Left
et.TextYAlignment=Enum.TextYAlignment.Top
et.TextWrapped=true
et.Parent=ef
end   