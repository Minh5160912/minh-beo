local WindUI = (loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua")))();
local Window = WindUI:CreateWindow({
    Title = "Minh BELL Hub",
    Author = "Blox Fruits",
    Folder = "By LEE MIN",
    Size = UDim2.fromOffset(520, 300),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 190,
    HasOutline = false,
});
Window:EditOpenButton({
    Title = "Minh BELL BF",
    Icon = "monitor",
    CornerRadius = UDim.new(1,0),
    StrokeThickness = 3,
    Color = ColorSequence.new(Color3.fromRGB(30, 30, 30), Color3.fromRGB(255, 255, 255)),
    Enabled = true, -- enable or disable openbutton
    Draggable = true,
    OnlyMobile = false,

    Color = ColorSequence.new( -- gradient
        Color3.fromHex("#30FF6A"), 
        Color3.fromHex("#e7ff2f")
    )

}); 
local _ReplicatedStorage = game:GetService("ReplicatedStorage")
local _Workspace = game:GetService("Workspace")

game:GetService("Players")

local u3 = {
    ToolCollect = _ReplicatedStorage.Events.ToolCollect,
    ToyEvent = _ReplicatedStorage.Events.ToyEvent,
    PlayerHiveCommand = _ReplicatedStorage.Events.PlayerHiveCommand,
    ClaimHive = _ReplicatedStorage.Events.ClaimHive,
}
local u4 = {
    HiddenStickers = _Workspace.HiddenStickers,
    Collectibles = _Workspace.Collectibles,
}
local u5 = {
    AutoDig = false,
    CollectHiddenStickers = false,
}

task.spawn(function()
    while true do
        if u5.CollectHiddenStickers then
            local v6, v7, v8 = u4.HiddenStickers:GetChildren()

            while true do
                local v9

                v8, v9 = v6(v7, v8)

                if v8 == nil then
                    break
                end

                fireclickdetector(v9.ClickDetector)
            end
        end

        task.wait(1)

        if false then
            return
        end
    end
end)
local Tabs = {
	MainTab = Window:Tab({
		Title = "Main",
		Icon = "house",
		Desc = "Main Section"
	}),
	EventTab = Window:Tab({
		Title = "Event",
		Icon = "inbox",
		Desc = "Farming Section"
	}),
	MobsTab = Window:Tab({
		Title = "Mobs",
		Icon = "box",
		Desc = "Items Section"
	}),
	SettingsTab = Window:Tab({
		Title = "Settings",
		Icon = "settings",
		Desc = "Settings Section"
	}),
	ItemsTab = Window:Tab({
		Title = "Items",
		Icon = "user",
		Desc = "Local Player Section"
	}),
	MiscTab = Window:Tab({
		Title = "Misc",
		Icon = "chart-no-axes-column",
		Desc = "Stats Section"
	}),
	ExtraTab = Window:Tab({
		Title = "Extra",
		Icon = "anchor",
		Desc = "Sea Event Section"
	}),
	ConfigTab = Window:Tab({
		Title = "UI setting",
		Icon = "server",
		Desc = "UI Section"
	})
};

Tabs.ConfigTab:Keybind({
    Title = "Keybind ",
    Desc = "Keybind to open ui",
    Value = "G",
    Callback = function(v)
        Window:SetToggleKey(Enum.KeyCode[v])
    end
});
Tabs.MainTab:Section({ 
    Title = "Farm" 
})
local u16 = 86400
local u17 = false

Tabs.MainTab:Button({
    Title = "Find All Stickers",
    Desc = "Collects all hidden stickers in the workspace",
    Callback = function()
        if u17 then
            Window:Notify({
                Title = "Cooldown",
                Content = "You need to wait another day" ,
                Image = "shining-2", -- Thay đổi icon phù hợp với WindUI
                Time = 5
            })
        else
            local v18, v19, v20 = ipairs(workspace.HiddenStickers:GetDescendants())
            local u21 = 0

            while true do
                local u22
                v20, u22 = v18(v19, v20)

                if v20 == nil then
                    break
                end
                if u22:IsA("ClickDetector") then
                    task.spawn(function()
                        fireclickdetector(u22)
                        u21 = u21 + 1
                    end)
                end
            end

            Window:Notify({
                Title = "Stickers Collected",
                Content = "You collected " .. u21 .. " stickers!",
                Image = "check",
                Time = 5
            })

            u17 = true

            task.delay(5, function()
                Window:Notify({
                    Title = "Limit Reached",
                    Content = "Stickers are limited! You need to wait until tomorrow to collect more.",
                    Image = "clock",
                    Time = 10
                })
            end)

            task.delay(u16, function()
                u17 = false
                Window:Notify({
                    Title = "Cooldown Finished",
                    Content = "You can now collect stickers again!",
                    Image = "circle-check",
                    Time = 5
                })
            end)
        end
    end
})
Tabs.MainTab:Button({
    Title = "Redeem All Codes",
    Desc = "Redeems all available promo codes",
    Callback = function()
        local u23 = {
            "Octobersmas",
            "15MMembers",
            "38217",
            "BeesBuzz123",
            "ClubBean",
            "Bopmaster",
            "Connoisseur",
            "Crawlers",
            "Nectar",
            "Roof",
            "Wax",
        }

        (function()
            local _PromoCodeEvent = game:GetService("ReplicatedStorage").Events.PromoCodeEvent
            local v25, v26, v27 = pairs(u23)

            while true do
                local v28
                v27, v28 = v25(v26, v27)

                if v27 == nil then
                    break
                end

                _PromoCodeEvent:FireServer(v28)
                print("Attempting to redeem code:", v28)
                task.wait(1)
            end

            Window:Notify({
                Title = "Codes Redeemed",
                Content = "You have already redeemed these codes or they have been redeemed.",
                Image = "ticket",
                Time = 5
            })
        end)()
    end,
})

Tabs.MainTab:Toggle({
    Title = "Auto Dig",
    Value = false,
    Callback = function(p29)
        u5.AutoDig = p29

        if p29 then
            startAutoDig()
        end
    end,
})
function startAutoDig()
    task.spawn(function()
        while true do
            if u5.AutoDig then
                u3.ToolCollect:FireServer()
            end

            task.wait(0.1)
        end
    end)
end

u5.AutoDig = false

local u30 = "BamBoo Field"
local u31 = "Tween"

Tabs.MainTab:Dropdown({
    Title = "Select Field",
    
    Values = {
        "BamBoo Field",
        "Blue Field",
        "Cactus Field",
        "Clover Field",
        "Coconut Field",
        "Dandelion Field",
        "Stump Field",
        "MountainTop Field",
        "Mushroom Field",
        "Pepper Patch",
        "Pineapple Field",
        "PineTree Field",
        "Pumpkin Field",
        "Rose Field",
        "Spider Field",
        "StrawBerry Field",
        "Sunflower Field",
    },
    Value = "BamBoo Field",
    Callback = function(p32)
        u30 = p32
    end,
})
Tabs.MainTab:Dropdown({
    Title = "Select Farm Mode",
    
    Values = {
        "Tween",
        "TweenFast",
        "Walk",
    },
    Value = "Tween",
    Callback = function(p33)
        u31 = p33
    end,
})

shared.farmFlames = false
shared.farmBubbles = false
shared.farmStars = false
shared.farmBalloons = false

Tabs.MainTab:Toggle({
    Title = "Farm Flames",
    Value = false,
    Callback = function(p34)
        shared.farmFlames = p34
    end,
})

Tabs.MainTab:Toggle({
    Title = "Farm Bubbles",
    Value = false,
    Callback = function(p35)
        shared.farmBubbles = p35
    end,
})

Tabs.MainTab:Toggle({
    Title = "Farm Stars",
    Value = false,
    Callback = function(p36)
        shared.farmStars = p36
    end,
})

Tabs.MainTab:Toggle({
    Title = "Farm Balloons",
    Value = false,
    Callback = function(p37)
        shared.farmBalloons = p37
    end,
})
-- [[ BIẾN TOÀN CỤC ]]
shared.autoSell = false
shared.a11 = false -- Tween
shared.a12 = false -- TweenFast
shared.a13 = false -- Walk
local u31 = "Tween" -- Chế độ farm mặc định

-- [[ HÀM THỰC HIỆN ĐI BÁN ]]
local function executeSellProcess()
    local LP = game.Players.LocalPlayer
    local Character = LP.Character
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
    
    -- Lưu chế độ đang farm
    local lastMode = nil
    if shared.a11 then lastMode = "Tween"
    elseif shared.a12 then lastMode = "TweenFast"
    elseif shared.a13 then lastMode = "Walk" end

    -- Tắt farm để đứng yên
    shared.a11, shared.a12, shared.a13 = false, false, false
    task.wait(0.5)

    -- Bay về tổ
    local hiveNum = tostring(LP.Honeycomb.Value)
    if hiveNum ~= "-1" then
        local hivePart = workspace.Honeycombs[hiveNum].LightHolder
        for _ = 1, 5 do
            Character.HumanoidRootPart.CFrame = hivePart.CFrame * CFrame.new(0, 5, -5)
            task.wait(0.1)
        end

        -- Đợi bán mật
        while LP.CoreStats.Pollen.Value > 0 and shared.autoSell do
            if LP.PlayerGui.ScreenGui.ActivateButton.TextBox.Text == "Make Honey" then
                game.ReplicatedStorage.Events.PlayerHiveCommand:FireServer("ToggleHoneyMaking")
            end
            task.wait(0.5)
        end

        -- Bán xong đợi 5 giây rồi quay lại farm
        if shared.autoSell then
            task.wait(5)
            if lastMode == "Tween" then shared.a11 = true startTweenFarm()
            elseif lastMode == "TweenFast" then shared.a12 = true startTweenFastFarm()
            elseif lastMode == "Walk" then shared.a13 = true startWalkFarm() end
        end
    end
end

-- [[ HÀM KIỂM TRA TÚI ]]
local function checkPollenStatus()
    local LP = game.Players.LocalPlayer
    if LP.CoreStats.Pollen.Value >= LP.CoreStats.Capacity.Value * 0.99 then
        if shared.autoSell then
            executeSellProcess()
            return true
        end
        return "Full"
    end
    return false
end
Tabs.MainTab:Toggle({
    Title = "Auto Farm",
    Value = false,
    Callback = function(state)
        if state then
            if u31 == "Tween" then shared.a11 = true startTweenFarm()
            elseif u31 == "TweenFast" then shared.a12 = true startTweenFastFarm()
            elseif u31 == "Walk" then shared.a13 = true startWalkFarm() end
        else
            shared.a11, shared.a12, shared.a13 = false, false, false
        end
    end
})
local function u41(p39, p40)
    return (p39 - p40).Magnitude <= 40
end
local function u50(p42)
    local _huge = math.huge
    local v44, v45, v46 = pairs(workspace.PlayerFlames:GetChildren())
    local v47 = nil

    while true do
        local v48

        v46, v48 = v44(v45, v46)

        if v46 == nil then
            break
        end

        local _Magnitude = (v48.Position - p42).Magnitude

        if _Magnitude < _huge then
            v47 = v48
            _huge = _Magnitude
        end
    end

    return v47
end
local function u59(p51)
    local _huge2 = math.huge
    local v53, v54, v55 = pairs(workspace.Particles:GetChildren())
    local v56 = nil

    while true do
        local v57

        v55, v57 = v53(v54, v55)

        if v55 == nil then
            break
        end
        if v57.Name == "Bubble" and v57:IsA("Part") then
            local _Magnitude2 = (v57.Position - p51).Magnitude

            if _Magnitude2 < _huge2 then
                v56 = v57
                _huge2 = _Magnitude2
            end
        end
    end

    return v56
end
local function u68(p60)
    local _huge3 = math.huge
    local v62, v63, v64 = pairs(workspace.Particles:GetChildren())
    local v65 = nil

    while true do
        local v66

        v64, v66 = v62(v63, v64)

        if v64 == nil then
            break
        end
        if v66.Name == "Star" and v66:IsA("Part") then
            local _Magnitude3 = (v66.Position - p60).Magnitude

            if _Magnitude3 < _huge3 then
                v65 = v66
                _huge3 = _Magnitude3
            end
        end
    end

    return v65
end
local function u79(p69)
    local _huge4 = math.huge
    local v71, v72, v73 = pairs(workspace.Balloons.FieldBalloons:GetChildren())
    local v74 = nil
    local v75 = nil

    while true do
        local v76

        v73, v76 = v71(v72, v73)

        if v73 == nil then
            break
        end

        local _BalloonBody = v76:FindFirstChild("BalloonBody")

        if _BalloonBody then
            local _Magnitude4 = (_BalloonBody.Position - p69).Magnitude

            if _Magnitude4 <= 40 and _Magnitude4 < _huge4 then
                v75 = _BalloonBody.Position
                v74 = _BalloonBody
                _huge4 = _Magnitude4
            end
        end
    end

    return v74, v75
end

function startTweenFarm()
    spawn(function()
        local u80 = {
            ["BamBoo Field"] = CFrame.new(93, 20, -25),
            ["Blue Field"] = CFrame.new(113.7, 4, 101.5),
            ["Cactus Field"] = CFrame.new(-194, 68, -107),
            ["Clover Field"] = CFrame.new(174, 34, 189),
            ["Coconut Field"] = CFrame.new(-255, 72, 459),
            ["Dandelion Field"] = CFrame.new(-30, 4, 225),
            ["Stump Field"] = CFrame.new(420, 117, -178),
            ["MountainTop Field"] = CFrame.new(76, 176, -181),
            ["Mushroom Field"] = CFrame.new(-91, 4, 116),
            ["Pepper Patch"] = CFrame.new(-486, 124, 517),
            ["Pineapple Field"] = CFrame.new(262, 68, -201),
            ["PineTree Field"] = CFrame.new(-338, 69, -180),
            ["Pumpkin Field"] = CFrame.new(-186, 68.5, -194),
            ["Rose Field"] = CFrame.new(-322, 20, 124),
            ["Spider Field"] = CFrame.new(-57.2, 20, -5.3),
            ["StrawBerry Field"] = CFrame.new(-179, 20, -14),
            ["Sunflower Field"] = CFrame.new(-208, 4, 185),
        }

        local function u82()
            local v81 = u80[u30]

            if v81 then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v81
            end
        end

        u82()
        game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Died:Connect(function()
            if shared.a11 then
                wait(5)
                u82()
            end
        end)

        local v83 = u80

        while shared.a11 do
            local status = checkPollenStatus()
            if status == true then break end 
            if status == "Full" then task.wait(1) continue end
            local _LocalPlayer = game.Players.LocalPlayer
            local _TweenService = game:GetService("TweenService")
            local v86 = TweenInfo.new(0.4)
            local _Position = _LocalPlayer.Character.HumanoidRootPart.Position
            local v88 = v83[u30]

            if (_Position - v88.Position).Magnitude > 40 then
                _LocalPlayer.Character.HumanoidRootPart.CFrame = v88
            end

            local v89 = u50(_Position)
            local v90 = u59(_Position)
            local v91 = u68(_Position)
            local v92, v93 = u79(_Position)

            if shared.farmFlames and (v89 and u41(v89.Position, v88.Position)) then
                local _Position2 = v89.Position
                local v95 = {
                    CFrame = CFrame.new(_Position2.X, _LocalPlayer.Character.HumanoidRootPart.Position.Y, _Position2.Z),
                }
                local v96 = _TweenService:Create(_LocalPlayer.Character.HumanoidRootPart, v86, v95)

                v96:Play()
                v96.Completed:Wait()
            elseif shared.farmBubbles and (v90 and u41(v90.Position, v88.Position)) then
                local _Position3 = v90.Position
                local v98 = {
                    CFrame = CFrame.new(_Position3.X, _LocalPlayer.Character.HumanoidRootPart.Position.Y, _Position3.Z),
                }
                local v99 = _TweenService:Create(_LocalPlayer.Character.HumanoidRootPart, v86, v98)

                v99:Play()
                v99.Completed:Wait()
            elseif shared.farmStars and (v91 and u41(v91.Position, v88.Position)) then
                local _Position4 = v91.Position
                local v101 = {
                    CFrame = CFrame.new(_Position4.X, _LocalPlayer.Character.HumanoidRootPart.Position.Y, _Position4.Z),
                }
                local v102 = _TweenService:Create(_LocalPlayer.Character.HumanoidRootPart, v86, v101)

                v102:Play()
                v102.Completed:Wait()
            elseif shared.farmBalloons and (v92 and v93) then
                local v103, v104, v105 = pairs(workspace.Collectibles:GetChildren())
                local v106 = 10
                local v107 = {}

                while true do
                    local v108

                    v105, v108 = v103(v104, v105)

                    if v105 == nil then
                        break
                    end
                    if v108.Transparency == 0 and (v108.Position - v93).Magnitude <= v106 then
                        table.insert(v107, v108)
                    end
                end

                if #v107 <= 0 then
                    local v109 = math.random() * math.pi * 2
                    local v110 = math.random() * v106
                    local v111 = math.cos(v109) * v110
                    local v112 = math.sin(v109) * v110
                    local v113 = Vector3.new(v93.X + v111, _LocalPlayer.Character.HumanoidRootPart.Position.Y, v93.Z + v112)
                    local v114 = {
                        CFrame = CFrame.new(v113),
                    }
                    local v115 = _TweenService:Create(_LocalPlayer.Character.HumanoidRootPart, v86, v114)

                    v115:Play()
                    v115.Completed:Wait()
                else
                    local v116, v117, v118 = ipairs(v107)

                    while true do
                        local v119

                        v118, v119 = v116(v117, v118)

                        if v118 == nil then
                            break
                        end

                        local _Position5 = v119.Position
                        local v121 = {
                            CFrame = CFrame.new(_Position5.X, _LocalPlayer.Character.HumanoidRootPart.Position.Y, _Position5.Z),
                        }
                        local v122 = _TweenService:Create(_LocalPlayer.Character.HumanoidRootPart, v86, v121)

                        v122:Play()
                        v122.Completed:Wait()
                    end
                end
            else
                local v123, v124, v125 = pairs(workspace.Collectibles:GetChildren())

                while true do
                    local v126

                    v125, v126 = v123(v124, v125)

                    if v125 == nil then
                        break
                    end

                    local _Magnitude5 = (v126.Position - _Position).Magnitude

                    if v126.Transparency == 0 and _Magnitude5 <= 40 then
                        local _Position6 = v126.Position

                        if (_Position6 - v88.Position).Magnitude <= 40 then
                            local _X = _Position6.X
                            local _Z = _Position6.Z
                            local v131 = {
                                CFrame = CFrame.new(_X, _LocalPlayer.Character.HumanoidRootPart.Position.Y, _Z),
                            }

                            _TweenService:Create(_LocalPlayer.Character.HumanoidRootPart, v86, v131):Play()
                        end
                    end
                end
            end

            task.wait(0.5)
        end
    end)
end
function startTweenFastFarm()
    spawn(function()
        local u132 = {
            ["BamBoo Field"] = CFrame.new(93, 20, -25),
            ["Blue Field"] = CFrame.new(113.7, 4, 101.5),
            ["Cactus Field"] = CFrame.new(-194, 68, -107),
            ["Clover Field"] = CFrame.new(174, 34, 189),
            ["Coconut Field"] = CFrame.new(-255, 72, 459),
            ["Dandelion Field"] = CFrame.new(-30, 4, 225),
            ["Stump Field"] = CFrame.new(420, 117, -178),
            ["MountainTop Field"] = CFrame.new(76, 176, -181),
            ["Mushroom Field"] = CFrame.new(-91, 4, 116),
            ["Pepper Patch"] = CFrame.new(-486, 124, 517),
            ["Pineapple Field"] = CFrame.new(262, 68, -201),
            ["PineTree Field"] = CFrame.new(-338, 69, -180),
            ["Pumpkin Field"] = CFrame.new(-186, 68.5, -194),
            ["Rose Field"] = CFrame.new(-322, 20, 124),
            ["Spider Field"] = CFrame.new(-57.2, 20, -5.3),
            ["StrawBerry Field"] = CFrame.new(-179, 20, -14),
            ["Sunflower Field"] = CFrame.new(-208, 4, 185),
        }

        local function u134()
            local v133 = u132[u30]

            if v133 then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v133
            end
        end

        u134()
        game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Died:Connect(function()
            if shared.a12 then
                wait(5)
                u134()
            end
        end)

        local v135 = u132

        while shared.a12 do
            local status = checkPollenStatus()
            if status == true then break end 
            if status == "Full" then task.wait(1) continue end
            local _LocalPlayer2 = game.Players.LocalPlayer
            local _TweenService2 = game:GetService("TweenService")
            local v138 = TweenInfo.new(0.1)
            local _Position7 = _LocalPlayer2.Character.HumanoidRootPart.Position
            local v140 = v135[u30]

            if (_Position7 - v140.Position).Magnitude > 40 then
                _LocalPlayer2.Character.HumanoidRootPart.CFrame = v140
            end

            local v141 = u50(_Position7)
            local v142 = u59(_Position7)
            local v143 = u68(_Position7)
            local v144, v145 = u79(_Position7)

            if shared.farmFlames and (v141 and u41(v141.Position, v140.Position)) then
                local _Position8 = v141.Position
                local v147 = {
                    CFrame = CFrame.new(_Position8.X, _LocalPlayer2.Character.HumanoidRootPart.Position.Y, _Position8.Z),
                }
                local v148 = _TweenService2:Create(_LocalPlayer2.Character.HumanoidRootPart, v138, v147)

                v148:Play()
                v148.Completed:Wait()
            elseif shared.farmBubbles and (v142 and u41(v142.Position, v140.Position)) then
                local _Position9 = v142.Position
                local v150 = {
                    CFrame = CFrame.new(_Position9.X, _LocalPlayer2.Character.HumanoidRootPart.Position.Y, _Position9.Z),
                }
                local v151 = _TweenService2:Create(_LocalPlayer2.Character.HumanoidRootPart, v138, v150)

                v151:Play()
                v151.Completed:Wait()
            elseif shared.farmStars and (v143 and u41(v143.Position, v140.Position)) then
                local _Position10 = v143.Position
                local v153 = {
                    CFrame = CFrame.new(_Position10.X, _LocalPlayer2.Character.HumanoidRootPart.Position.Y, _Position10.Z),
                }
                local v154 = _TweenService2:Create(_LocalPlayer2.Character.HumanoidRootPart, v138, v153)

                v154:Play()
                v154.Completed:Wait()
            elseif shared.farmBalloons and (v144 and v145) then
                local v155, v156, v157 = pairs(workspace.Collectibles:GetChildren())
                local v158 = 10
                local v159 = {}

                while true do
                    local v160

                    v157, v160 = v155(v156, v157)

                    if v157 == nil then
                        break
                    end
                    if v160.Transparency == 0 and (v160.Position - v145).Magnitude <= v158 then
                        table.insert(v159, v160)
                    end
                end

                if #v159 <= 0 then
                    local v161 = math.random() * math.pi * 2
                    local v162 = math.random() * v158
                    local v163 = math.cos(v161) * v162
                    local v164 = math.sin(v161) * v162
                    local v165 = Vector3.new(v145.X + v163, _LocalPlayer2.Character.HumanoidRootPart.Position.Y, v145.Z + v164)
                    local v166 = {
                        CFrame = CFrame.new(v165),
                    }
                    local v167 = _TweenService2:Create(_LocalPlayer2.Character.HumanoidRootPart, v138, v166)

                    v167:Play()
                    v167.Completed:Wait()
                else
                    local v168, v169, v170 = ipairs(v159)

                    while true do
                        local v171

                        v170, v171 = v168(v169, v170)

                        if v170 == nil then
                            break
                        end

                        local _Position11 = v171.Position
                        local v173 = {
                            CFrame = CFrame.new(_Position11.X, _LocalPlayer2.Character.HumanoidRootPart.Position.Y, _Position11.Z),
                        }
                        local v174 = _TweenService2:Create(_LocalPlayer2.Character.HumanoidRootPart, v138, v173)

                        v174:Play()
                        v174.Completed:Wait()
                    end
                end
            else
                local v175, v176, v177 = pairs(workspace.Collectibles:GetChildren())

                while true do
                    local v178

                    v177, v178 = v175(v176, v177)

                    if v177 == nil then
                        break
                    end

                    local _Magnitude6 = (v178.Position - _Position7).Magnitude

                    if v178.Transparency == 0 and _Magnitude6 <= 40 then
                        local _Position12 = v178.Position

                        if (_Position12 - v140.Position).Magnitude <= 40 then
                            local _X2 = _Position12.X
                            local _Z2 = _Position12.Z
                            local v183 = {
                                CFrame = CFrame.new(_X2, _LocalPlayer2.Character.HumanoidRootPart.Position.Y, _Z2),
                            }

                            _TweenService2:Create(_LocalPlayer2.Character.HumanoidRootPart, v138, v183):Play()
                        end
                    end
                end
            end

            task.wait(0.2)
        end
    end)
end
function startWalkFarm()
    spawn(function()
        local u184 = {
            ["BamBoo Field"] = CFrame.new(93, 20, -25),
            ["Blue Field"] = CFrame.new(113.7, 4, 101.5),
            ["Cactus Field"] = CFrame.new(-194, 68, -107),
            ["Clover Field"] = CFrame.new(174, 34, 189),
            ["Coconut Field"] = CFrame.new(-255, 72, 459),
            ["Dandelion Field"] = CFrame.new(-30, 4, 225),
            ["Stump Field"] = CFrame.new(420, 117, -178),
            ["MountainTop Field"] = CFrame.new(76, 176, -181),
            ["Mushroom Field"] = CFrame.new(-91, 4, 116),
            ["Pepper Patch"] = CFrame.new(-486, 124, 517),
            ["Pineapple Field"] = CFrame.new(262, 68, -201),
            ["PineTree Field"] = CFrame.new(-338, 69, -180),
            ["Pumpkin Field"] = CFrame.new(-186, 68.5, -194),
            ["Rose Field"] = CFrame.new(-322, 20, 124),
            ["Spider Field"] = CFrame.new(-57.2, 20, -5.3),
            ["StrawBerry Field"] = CFrame.new(-179, 20, -14),
            ["Sunflower Field"] = CFrame.new(-208, 4, 185),
        }

        local function u186()
            local v185 = u184[u30]

            if v185 then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v185
            end
        end

        u186()
        game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Died:Connect(function()
            if shared.a13 then
                wait(5)
                u186()
            end
        end)

        local v187 = u184

        while shared.a13 do
            local status = checkPollenStatus()
            if status == true then break end 
            if status == "Full" then task.wait(1) continue end
            local _Character = game.Players.LocalPlayer.Character
            local _Humanoid = _Character:FindFirstChild("Humanoid")
            local _Position13 = _Character.HumanoidRootPart.Position
            local v191 = v187[u30]

            if (_Position13 - v191.Position).Magnitude > 40 then
                _Character.HumanoidRootPart.CFrame = v191
            end

            local v192 = u50(_Position13)
            local v193 = u59(_Position13)
            local v194 = u68(_Position13)
            local v195, v196 = u79(_Position13)

            if shared.farmFlames and (v192 and u41(v192.Position, v191.Position)) then
                _Humanoid:MoveTo(Vector3.new(v192.Position.X, _Character.HumanoidRootPart.Position.Y, v192.Position.Z))
                _Humanoid.MoveToFinished:Wait()
            elseif shared.farmBubbles and (v193 and u41(v193.Position, v191.Position)) then
                _Humanoid:MoveTo(Vector3.new(v193.Position.X, _Character.HumanoidRootPart.Position.Y, v193.Position.Z))
                _Humanoid.MoveToFinished:Wait()
            elseif shared.farmStars and (v194 and u41(v194.Position, v191.Position)) then
                _Humanoid:MoveTo(Vector3.new(v194.Position.X, _Character.HumanoidRootPart.Position.Y, v194.Position.Z))
                _Humanoid.MoveToFinished:Wait()
            elseif shared.farmBalloons and (v195 and v196) then
                local v197, v198, v199 = pairs(workspace.Collectibles:GetChildren())
                local v200 = 10
                local v201 = {}

                while true do
                    local v202

                    v199, v202 = v197(v198, v199)

                    if v199 == nil then
                        break
                    end
                    if v202.Transparency == 0 and (v202.Position - v196).Magnitude <= v200 then
                        table.insert(v201, v202)
                    end
                end

                if #v201 <= 0 then
                    local v203 = math.random() * math.pi * 2
                    local v204 = math.random() * v200
                    local v205 = math.cos(v203) * v204
                    local v206 = math.sin(v203) * v204

                    _Humanoid:MoveTo((Vector3.new(v196.X + v205, _Character.HumanoidRootPart.Position.Y, v196.Z + v206)))
                    _Humanoid.MoveToFinished:Wait()
                else
                    local v207, v208, v209 = ipairs(v201)

                    while true do
                        local v210

                        v209, v210 = v207(v208, v209)

                        if v209 == nil then
                            break
                        end

                        _Humanoid:MoveTo(Vector3.new(v210.Position.X, _Character.HumanoidRootPart.Position.Y, v210.Position.Z))
                        _Humanoid.MoveToFinished:Wait()
                    end
                end
            else
                local v211, v212, v213 = pairs(workspace.Collectibles:GetChildren())

                while true do
                    local v214

                    v213, v214 = v211(v212, v213)

                    if v213 == nil then
                        break
                    end

                    local _Magnitude7 = (v214.Position - _Position13).Magnitude

                    if v214.Transparency == 0 and _Magnitude7 <= 40 then
                        local _Position14 = v214.Position

                        if (_Position14 - v191.Position).Magnitude <= 40 then
                            _Humanoid:MoveTo(Vector3.new(_Position14.X, _Character.HumanoidRootPart.Position.Y, _Position14.Z))
                            _Humanoid.MoveToFinished:Wait()
                        end
                    end
                end
            end

            task.wait(0.1)
        end
    end)
end
Tabs.MainTab:Toggle({
    Title = "Auto Sell",
    Value = false,
    Callback = function(state)
        shared.autoSell = state
        -- Nếu đang đứng ở sân farm mà bật Sell khi túi đã đầy, nó sẽ đi bán luôn
        if state then
            task.spawn(function()
                checkPollenStatus()
            end)
        end
    end
})

Tabs.MainTab:Section({ Title = "Other" })

Tabs.MainTab:Toggle({
    Title = "Auto Use Micro-Converter",
    Value = false,
    Callback = function(p225)
        getgenv().turnoff4 = p225

        while turnoff4 == true do
            local _LocalPlayer4 = game:GetService("Players").LocalPlayer
            local _ProgressLabel = _LocalPlayer4.Character:FindFirstChild("ProgressLabel", true)
            local v228 = tonumber(_ProgressLabel.Text:match("%d+$"))

            task.wait(0.1)

            if v228 <= _LocalPlayer4.CoreStats.Pollen.Value then
                local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
                Event:FireServer({
                    Name = "Micro-Converter",
                })
            end
        end
    end,
})

Tabs.MainTab:Toggle({
    Title = "Auto Use Instant Converter",
    Value = false,
    Callback = function(p229)
        getgenv().turnoff4 = p229

        while turnoff4 == true do
            local _LocalPlayer5 = game:GetService("Players").LocalPlayer
            local _ProgressLabel2 = _LocalPlayer5.Character:FindFirstChild("ProgressLabel", true)
            local v232 = tonumber(_ProgressLabel2.Text:match("%d+$"))

            task.wait(0.3)

            if v232 > _LocalPlayer5.CoreStats.Pollen.Value then
                if v232 > _LocalPlayer5.CoreStats.Pollen.Value then
                    if v232 <= _LocalPlayer5.CoreStats.Pollen.Value then
                        local zakharpidor = { "Instant Converter C" }
                        game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer(unpack(zakharpidor))
                    end
                else
                    local zakharpidor = { "Instant Converter B" }
                    game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer(unpack(zakharpidor))
                    task.wait(0.3)
                end
            else
                game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer(unpack({ "Instant Converter" }))
                task.wait(0.3)
            end
        end
    end,
})

Tabs.MainTab:Toggle({
    Title = "Auto Use Coconut",
    Value = false,
    Callback = function(p233)
        getgenv().turnoff4 = p233

        while turnoff4 == true do
            local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
            Event:FireServer({
                Name = "Coconut",
            })
            task.wait(11)
        end
    end,
})
-- Tiếp tục ở MainTab
Tabs.MainTab:Toggle({
    Title = "Auto Use Gumdrops",
    Value = false,
    Callback = function(p234)
        getgenv().turnoff4 = p234

        while turnoff4 == true do
            local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
            Event:FireServer({
                Name = "Gumdrops",
            })
            task.wait(3)
        end
    end,
})

-- Chuyển sang ItemsTab (Local Player Section)
-- Chuyển sang ExtraTab (v15)
Tabs.ExtraTab:Section({ 
    Title = "Mask" 
})

Tabs.ExtraTab:Dropdown({
    Title = "Equip Mask",
 
    Values = {
        "Gummy Mask",
        "Demon Mask",
        "Diamond Mask",
        "Bubble Mask",
        "Fire Mask",
        "Honey Mask",
    },
    Value = "nil",
    Callback = function(p235)
        local Event = game:GetService("ReplicatedStorage").Events.ItemPackageEvent
        if p235 == "Gummy Mask" then
            Event:InvokeServer("Equip", {
                Mute = true,
                Type = "Gummy Mask",
                Category = "Accessory",
            })
        elseif p235 == "Demon Mask" then
            Event:InvokeServer("Equip", {
                Mute = true,
                Type = "Demon Mask",
                Category = "Accessory",
            })
        elseif p235 == "Diamond Mask" then
            Event:InvokeServer("Equip", {
                Mute = true,
                Type = "Diamond Mask",
                Category = "Accessory",
            })
        elseif p235 == "Bubble Mask" then
            Event:InvokeServer("Equip", {
                Mute = true,
                Type = "Bubble Mask",
                Category = "Accessory",
            })
        elseif p235 == "Fire Mask" then
            Event:InvokeServer("Equip", {
                Mute = true,
                Type = "Fire Mask",
                Category = "Accessory",
            })
        elseif p235 == "Honey Mask" then
            Event:InvokeServer("Equip", {
                Mute = true,
                Type = "Honey Mask",
                Category = "Accessory",
            })
        end
    end,
})

-- Phần còn lại thuộc v11 (EventTab)
Tabs.EventTab:Button({
    Title = "Bee Bear Teleport",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-38.666648864746094, 6.3912272453308105, 283.1805419921875)
    end,
})

Tabs.EventTab:Section({ 
    Title = "SnowFlakes" 
})
local u236 = false

Tabs.EventTab:Toggle({
    Title = "SnowFlakes Farm",
    Value = false,
    Callback = function(p237)
        u236 = p237

        if u236 then
            farmSnowflakes()
        end
    end,
})
local _Snowflakes = workspace:WaitForChild("Particles"):WaitForChild("Snowflakes")
local u239 = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()

function chatmsg(p240, p241)
    game.StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = p240,
        Color = p241,
    })
end
function notif(p242, p243, p244)
    game.StarterGui:SetCore("SendNotification", {
        Title = p242,
        Text = p243,
        Duration = p244,
    })
end
function getsnowflake()
    if #_Snowflakes:GetChildren() ~= 0 then
        local v245 = _Snowflakes

        return _Snowflakes:GetChildren()[math.random(1, #v245:GetChildren())]
    end

    notif("SnowWare", "No SnowFlakes Found", 5)
    getsnowflake()
    task.wait(0.1)
end
function farmSnowflakes()
    while u236 do
        u239 = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
        selectedsnowflake = getsnowflake()
        collecttick = tick()

        repeat
            task.wait()
            game:GetService("TweenService"):Create(u239.HumanoidRootPart, TweenInfo.new(1), {
                CFrame = selectedsnowflake.CFrame + Vector3.new(0, 15, 0),
            }):Play()

            u239.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
        until tick() - collecttick > 3 or not u236

        task.wait(4)
    end
end

chatmsg(info, Color3.fromRGB(107, 170, 253))
Tabs.EventTab:Section({ 
    Title = "Gift Teleport" 
})

Tabs.EventTab:Dropdown({
    Title = "Teleport To Present - ",
  
    Values = {
        "Gift 3",
        "Gift 4",
        "Gift 6",
        "Gift 8",
        "Gift 9",
        "Gift 10",
        "Gift 11",
        "Gift 13",
        "Gift 14",
        "Gift 16",
    },
    Value = "Gift 3",
    Callback = function(p246)
        if p246 == "Gift 3" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(39, 5, 99)
        elseif p246 == "Gift 3" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(86, 4.6, 294)
        elseif p246 == "Gift 4" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-277, 18, 386.8)
        elseif p246 == "Gift 6" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-449, 69, -97.5)
        elseif p246 == "Gift 8" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(327.6, 195, -229.5)
        elseif p246 == "Gift 9" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-55.7, 41.5, 719.8)
        elseif p246 == "Gift 10" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-421.7, 72.8, 437.6)
        elseif p246 == "Gift 11" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-453, 122.8, 336.5)
        elseif p246 == "Gift 13" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(488, 180, -329)
        elseif p246 == "Gift 14" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(33.4, 235.8, -581.9)
        elseif p246 == "Gift 16" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-19.8, 231.5, -121.3)
        end
    end,
})
local u247 = false
local u248 = false
local u249 = nil
local u250 = nil
local u251 = nil
local u252 = nil

(function()
    local v253 = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()

    u249 = v253.Humanoid.WalkSpeed
    u250 = v253.Humanoid.JumpPower
end)()
Tabs.MiscTab:Section({ 
    Title = "Player Speed" 
})

Tabs.MiscTab:Toggle({
    Title = "Enable Speed",
    Value = false,
    Callback = function(p254)
        u247 = p254

        if not u247 then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = u249
        end
    end,
})

Tabs.MiscTab:Input({
    Title = "Set Speed 1-150",
    Value = tostring(math.floor(u249)),
    Placeholder = "Enter speed...",
    Callback = function(p255)
        local v256 = tonumber(p255)

        if v256 and (1 <= v256 and v256 <= 150) then
            u251 = math.floor(v256)
            -- Giữ nguyên biến u14 theo logic gốc của bạn
            u14.Character.Humanoid.WalkSpeed = u251
        end
    end,
})

Tabs.MiscTab:Section({ 
    Title = "Player Jump Power" 
})

Tabs.MiscTab:Toggle({
    Title = "Enable Jump Power",
    Value = false,
    Callback = function(p257)
        u248 = p257

        if not u248 then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = u250
        end
    end,
})
Tabs.MiscTab:Input({
    Title = "Set Jump Power 1-200",
    Value = tostring(math.floor(u250)),
    Placeholder = "Enter jump power...",
    Callback = function(p258)
        local v259 = tonumber(p258)

        if v259 and (1 <= v259 and v259 <= 200) then
            u252 = math.floor(v259)
            u14.Character.Humanoid.JumpPower = u252
        end
    end,
})
game:GetService("RunService").Heartbeat:Connect(function()
    if u247 then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = u251
    end
    if u248 then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = u252
    end
end)
Tabs.MiscTab:Section({ 
    Title = "Misc" 
})

local u260 = false

Tabs.MiscTab:Toggle({
    Title = "Noclip",
    Value = false,
    Callback = function(p261)
        u260 = p261
    end,
})
game:GetService("RunService").Stepped:Connect(function()
    if u260 then
        local v262, v263, v264 = pairs(game.Players.LocalPlayer.Character:GetDescendants())

        while true do
            local v265

            v264, v265 = v262(v263, v264)

            if v264 == nil then
                break
            end
            if v265:IsA("BasePart") and v265.CanCollide then
                v265.CanCollide = false
            end
        end
    end
end)
Tabs.ExtraTab:Section({ 
    Title = "Teleports" 
})

Tabs.ExtraTab:Button({
    Title = "TP To Hive",
    Desc = "Teleports you to your hive",
    Callback = function()
        local _LocalPlayer6 = game:GetService("Players").LocalPlayer
        if _LocalPlayer6.SpawnPos and _LocalPlayer6.SpawnPos.Value then
            _LocalPlayer6.Character:MoveTo(_LocalPlayer6.SpawnPos.Value.p)
        end
    end,
})

Tabs.ExtraTab:Dropdown({
    Title = "Teleport To Shop - ",
    
    Values = {
        "Bee Shop",
        "First Tool Shop",
        "Second Tool Shop (15+ bees)",
        "MountainTop Shop (25+ bees)",
        "Spirit Shop (35+ bees)",
        "Dapper Bears Shop",
        "GumBall Shop",
        "Blue Clubhouse",
        "Red Clubhouse",
        "Ticket Shop",
        "RoyalJelly Shop",
        "Ticket RoyalJelly Shop",
        "Treat Shop",
        "Moon",
        "Nuoc",
    },
    Value = "First Tool Shop",
    Callback = function(p267)
        local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
        if p267 == "Bee Shop" then
            hrp.CFrame = CFrame.new(-136.8, 4.6, 243.4)
        elseif p267 == "First Tool Shop" then
            hrp.CFrame = CFrame.new(86, 4.6, 294)
        elseif p267 == "Second Tool Shop (15+ bees)" then
            hrp.CFrame = CFrame.new(165, 69, -161)
        elseif p267 == "MountainTop Shop (25+ bees)" then
            hrp.CFrame = CFrame.new(-18, 176, -137)
        elseif p267 == "Spirit Shop (35+ bees)" then
            hrp.CFrame = CFrame.new(-501, 52, 474)
        elseif p267 == "Dapper Bears Shop" then
            hrp.CFrame = CFrame.new(456.7, 137.9, -313.8)
        elseif p267 == "GumBall Shop" then
            hrp.CFrame = CFrame.new(269, 25257.55, -724.2)
        elseif p267 == "Blue Clubhouse" then
            hrp.CFrame = CFrame.new(292, 4, 98)
        elseif p267 == "Red Clubhouse" then
            hrp.CFrame = CFrame.new(-334, 21, 216)
        elseif p267 == "Ticket Shop" then
            hrp.CFrame = CFrame.new(-12.8, 184, -222.2)
        elseif p267 == "RoyalJelly Shop" then
            hrp.CFrame = CFrame.new(-297, 53, 68)
        elseif p267 == "Ticket RoyalJelly Shop" then
            hrp.CFrame = CFrame.new(81, 18, 240)
        elseif p267 == "Treat Shop" then
            hrp.CFrame = CFrame.new(-228.2, 5, 89.4)
        elseif p267 == "Moon" then
            hrp.CFrame = CFrame.new(21, 88, -54)
        elseif p267 == "Nuoc" then
            hrp.CFrame = CFrame.new(-426, 70, 38)
        end
    end,
})

Tabs.ExtraTab:Dropdown({
    Title = "Teleport To Bear - ",
   
    Values = {
        "Black Bear",
        "Brown Bear",
        "Panda Bear",
        "Polar Bear",
        "Science Bear",
        "Mother Bear",
        "Spirit Bear",
        "Gummy Bear",
        "Onett",
        "Tunnel Bear",
        "Stick Bug",
    },
    Value = "Black Bear",
    Callback = function(p268)
        local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
        if p268 == "Black Bear" then
            hrp.CFrame = CFrame.new(-258.1, 5, 299.7)
        elseif p268 == "Brown Bear" then
            hrp.CFrame = CFrame.new(282, 46, 236)
        elseif p268 == "Panda Bear" then
            hrp.CFrame = CFrame.new(106.3, 35, 50.1)
        elseif p268 == "Polar Bear" then
            hrp.CFrame = CFrame.new(-106, 119, -77)
        elseif p268 == "Science Bear" then
            hrp.CFrame = CFrame.new(267, 103, 20)
        elseif p268 == "Mother Bear" then
            hrp.CFrame = CFrame.new(-183.898, 5.64093, 83.4582)
        elseif p268 == "Spirit Bear" then
            hrp.CFrame = CFrame.new(-363.936, 105.284, 485.853)
        elseif p268 == "Gummy Bear" then
            hrp.CFrame = CFrame.new(271.624, 25292.9, -850.958)
        elseif p268 == "Tunnel Bear" then
            hrp.CFrame = CFrame.new(313.654, 6.81172, -46.9131)
        elseif p268 == "Onett" then
            hrp.CFrame = CFrame.new(-9.41592, 232.791, -520.278)
        elseif p268 == "Stick Bug" then
            hrp.CFrame = CFrame.new(-129.2, 50.0709, 148.288)
        end
    end,
})

Tabs.ExtraTab:Dropdown({
    Title = "Teleport To Field - ",
   
    Values = {
        "BamBoo Field",
        "Blue Field",
        "Cactus Field",
        "Clover Field",
        "Coconut Field",
        "Dandelion Field",
        "Stump Field",
        "MountainTop Field",
        "Mushroom Field",
        "Pepper Patch",
        "Pineapple Field",
        "PineTree Field",
        "Pumpkin Field",
        "Rose Field",
        "Spider Field",
        "StrawBerry Field",
        "Sunflower Field",
    },
    Value = "BamBoo Field",
    Callback = function(p269)
        local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
        if p269 == "BamBoo Field" then
            hrp.CFrame = CFrame.new(93, 20, -25)
        elseif p269 == "Blue Field" then
            hrp.CFrame = CFrame.new(113.7, 4, 101.5)
        elseif p269 == "Cactus Field" then
            hrp.CFrame = CFrame.new(-194, 68, -107)
        elseif p269 == "Clover Field" then
            hrp.CFrame = CFrame.new(174, 34, 189)
        elseif p269 == "Coconut Field" then
            hrp.CFrame = CFrame.new(-255, 72, 459)
        elseif p269 == "Dandelion Field" then
            hrp.CFrame = CFrame.new(-30, 4, 225)
        elseif p269 == "Stump Field" then
            hrp.CFrame = CFrame.new(420, 117, -178)
        elseif p269 == "MountainTop Field" then
            hrp.CFrame = CFrame.new(76, 176, -181)
        elseif p269 == "Mushroom Field" then
            hrp.CFrame = CFrame.new(-91, 4, 116)
        elseif p269 == "Pepper Patch" or p269 == "Pumpkin Field" then
            hrp.CFrame = CFrame.new(-486, 124, 517)
        elseif p269 == "Pineapple Field" then
            hrp.CFrame = CFrame.new(262, 68, -201)
        elseif p269 == "PineTree Field" then
            hrp.CFrame = CFrame.new(-318, 68, -150)
        elseif p269 == "Rose Field" then
            hrp.CFrame = CFrame.new(-322, 20, 124)
        elseif p269 == "Spider Field" then
            hrp.CFrame = CFrame.new(-57.2, 20, -5.3)
        elseif p269 == "StrawBerry Field" then
            hrp.CFrame = CFrame.new(262, 68, -201)
        elseif p269 == "Sunflower Field" then
            hrp.CFrame = CFrame.new(-208, 4, 185)
        end
    end,
})

Tabs.ExtraTab:Dropdown({
    Title = "Teleport To Booster - ",

    Values = {
        "Ant",
        "Bluefield Boost",
        "Blueberry Dispenser",
        "Club Honey",
        "Gumdrop Dispenser",
        "Glue Dispenser",
        "Honeystorm Dispensor",
        "Instant Honey Convertor",
        "MountainTop Boost",
        "Nectar Condenser",
        "Redfield Boost",
        "Sprout Dispenser",
        "Star Hut",
        "Strawberry Dispenser",
        "Treat Dispenser",
    },
    Value = "Ant",
    Callback = function(p270)
        local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
        if p270 == "Ant" then
            hrp.CFrame = CFrame.new(125, 32, 495)
        elseif p270 == "Bluefield Boost" then
            hrp.CFrame = CFrame.new(272, 58, 86)
        elseif p270 == "Blueberry Dispenser" then
            hrp.CFrame = CFrame.new(307, 5, 134)
        elseif p270 == "Club Honey" then
            hrp.CFrame = CFrame.new(44.8, 5, 319.6)
        elseif p270 == "Gumdrop Dispenser" then
            hrp.CFrame = CFrame.new(68, 21.8, 26)
        elseif p270 == "Glue Dispenser" then
            hrp.CFrame = CFrame.new(269, 25257.546875, -724)
        elseif p270 == "Honeystorm Dispensor" then
            hrp.CFrame = CFrame.new(238.4, 33.3, 165.6)
        elseif p270 == "Instant Honey Convertor" then
            hrp.CFrame = CFrame.new(282, 68, -62)
        elseif p270 == "MountainTop Boost" then
            hrp.CFrame = CFrame.new(-40, 176, -191.7)
        elseif p270 == "Nectar Condenser" then
            hrp.CFrame = CFrame.new(-416.7, 101.5, 342.8)
        elseif p270 == "Redfield Boost" then
            hrp.CFrame = CFrame.new(-315.5, 21, 240)
        elseif p270 == "Sprout Dispenser" then
            hrp.CFrame = CFrame.new(-269.26, 26.56, 267.31)
        elseif p270 == "Star Hut" then
            hrp.CFrame = CFrame.new(135.9, 64.6, 322.1)
        elseif p270 == "Strawberry Dispenser" then
            hrp.CFrame = CFrame.new(-320.5, 46, 272.5)
        elseif p270 == "Treat Dispenser" then
            hrp.CFrame = CFrame.new(193.9, 68, -123)
        end
    end,
})
Tabs.ItemsTab:Section({ 
    Title = "Dispensers" 
})

local toyEvent = game:GetService("ReplicatedStorage").Events.ToyEvent

Tabs.ItemsTab:Button({
    Title = "Use All Dispensers",
    Callback = function()
        local dispensers = {
            "Glue Dispenser", "Wealth Clock", "Coconut Dispenser", 
            "Strawberry Dispenser", "Treat Dispenser", "Free Ant Pass Dispenser", 
            "Blueberry Dispenser", "Honey Dispenser", "Free Royal Jelly Dispenser"
        }
        for _, name in ipairs(dispensers) do
            toyEvent:FireServer(name)
        end
    end,
})

Tabs.ItemsTab:Toggle({
    Title = "Auto Use All Dispensers",
    Value = false,
    Callback = function(p271)
        getgenv().turnoff5 = p271
        local dispensers = {
            "Glue Dispenser", "Wealth Clock", "Coconut Dispenser", 
            "Strawberry Dispenser", "Treat Dispenser", "Free Ant Pass Dispenser", 
            "Blueberry Dispenser", "Honey Dispenser", "Free Royal Jelly Dispenser"
        }
        while getgenv().turnoff5 == true do
            for _, name in ipairs(dispensers) do
                toyEvent:FireServer(name)
            end
            task.wait(10)
        end
    end,
})

Tabs.ItemsTab:Button({
    Title = "Use Glue Dispenser",
    Callback = function()
        toyEvent:FireServer("Glue Dispenser")
    end,
})

Tabs.ItemsTab:Toggle({
    Title = "Auto Use Glue Dispenser",
    Value = false,
    Callback = function(p272)
        getgenv().turnoff4 = p272
        while getgenv().turnoff4 == true do
            toyEvent:FireServer("Glue Dispenser")
            task.wait(10)
        end
    end,
})

Tabs.ItemsTab:Button({
    Title = "Use Wealth Clock",
    Callback = function()
        toyEvent:FireServer("Wealth Clock")
    end,
})

Tabs.ItemsTab:Toggle({
    Title = "Auto Use Wealth Clock",
    Value = false,
    Callback = function(p273)
        getgenv().turnoff4 = p273
        while getgenv().turnoff4 == true do
            toyEvent:FireServer("Wealth Clock")
            task.wait(10)
        end
    end,
})

Tabs.ItemsTab:Button({
    Title = "Use Coconut Dispenser",
    Callback = function()
        toyEvent:FireServer("Coconut Dispenser")
    end,
})

Tabs.ItemsTab:Toggle({
    Title = "Auto Use Coconut Dispenser",
    Value = false,
    Callback = function(p274)
        getgenv().turnoff4 = p274
        while getgenv().turnoff4 == true do
            toyEvent:FireServer("Coconut Dispenser")
            task.wait(10)
        end
    end,
})
Tabs.ItemsTab:Button({
    Title = "Use Strawberry Dispenser",
    Callback = function()
        A_1 = "Strawberry Dispenser"
        Event = game:GetService("ReplicatedStorage").Events.ToyEvent

        Event:FireServer(A_1)
    end,
})

Tabs.ItemsTab:Toggle({
    Title = "Auto Use Strawberry Dispenser",
    Value = false,
    Callback = function(p275)
        getgenv().turnoff4 = p275

        while turnoff4 == true do
            A_1 = "Strawberry Dispenser"
            Event = game:GetService("ReplicatedStorage").Events.ToyEvent

            Event:FireServer(A_1)
            wait(10)
        end
    end,
})

Tabs.ItemsTab:Button({
    Title = "Use Treat Dispenser",
    Callback = function()
        A_1 = "Treat Dispenser"
        Event = game:GetService("ReplicatedStorage").Events.ToyEvent

        Event:FireServer(A_1)
    end,
})

Tabs.ItemsTab:Toggle({
    Title = "Auto Use Treat Dispenser",
    Value = false,
    Callback = function(p276)
        getgenv().turnoff4 = p276

        while turnoff4 == true do
            A_1 = "Treat Dispenser"
            Event = game:GetService("ReplicatedStorage").Events.ToyEvent

            Event:FireServer(A_1)
            wait(10)
        end
    end,
})

Tabs.ItemsTab:Button({
    Title = "Use Free Ant Pass Dispenser",
    Callback = function()
        A_1 = "Free Ant Pass Dispenser"
        Event = game:GetService("ReplicatedStorage").Events.ToyEvent

        Event:FireServer(A_1)
    end,
})

Tabs.ItemsTab:Toggle({
    Title = "Auto Use Free Ant Pass Dispenser",
    Value = false,
    Callback = function(p277)
        getgenv().turnoff4 = p277

        while turnoff4 == true do
            A_1 = "Free Ant Pass Dispenser"
            Event = game:GetService("ReplicatedStorage").Events.ToyEvent

            Event:FireServer(A_1)
            wait(10)
        end
    end,
})

Tabs.ItemsTab:Button({
    Title = "Use Blueberry Dispenser",
    Callback = function()
        A_1 = "Blueberry Dispenser"
        Event = game:GetService("ReplicatedStorage").Events.ToyEvent

        Event:FireServer(A_1)
    end,
})

Tabs.ItemsTab:Toggle({
    Title = "Auto Use Blueberry Dispenser",
    Value = false,
    Callback = function(p278)
        getgenv().turnoff4 = p278

        while turnoff4 == true do
            A_1 = "Blueberry Dispenser"
            Event = game:GetService("ReplicatedStorage").Events.ToyEvent

            Event:FireServer(A_1)
            wait(10)
        end
    end,
})

Tabs.ItemsTab:Button({
    Title = "Use Honey Dispenser",
    Callback = function()
        A_1 = "Honey Dispenser"
        Event = game:GetService("ReplicatedStorage").Events.ToyEvent

        Event:FireServer(A_1)
    end,
})

Tabs.ItemsTab:Toggle({
    Title = "Auto Use Honey Dispenser",
    Value = false,
    Callback = function(p279)
        getgenv().turnoff4 = p279

        while turnoff4 == true do
            A_1 = "Honey Dispenser"
            Event = game:GetService("ReplicatedStorage").Events.ToyEvent

            Event:FireServer(A_1)
            wait(10)
        end
    end,
})

Tabs.ItemsTab:Toggle({
    Title = "Auto Use Free Royal Jelly Dispenser",
    Value = false,
    Callback = function(p280)
        getgenv().turnoff4 = p280

        while turnoff4 == true do
            A_1 = "Free Royal Jelly Dispenser"
            Event = game:GetService("ReplicatedStorage").Events.ToyEvent

            Event:FireServer(A_1)
            wait(10)
        end
    end,
})

Tabs.ItemsTab:Section({ 
    Title = "Dices" 
})

Tabs.ItemsTab:Button({
    Title = "Use Field Dice",
    Callback = function()
        game:GetService("ReplicatedStorage").Events.PlayerActivesCommand:FireServer({
            Name = "Field Dice",
        })
    end,
})

Tabs.ItemsTab:Toggle({
    Title = "Auto Use Field Dice",
    Value = false,
    Callback = function(p281)
        getgenv().turnoff4 = p281

        while turnoff4 == true do
            game:GetService("ReplicatedStorage").Events.PlayerActivesCommand:FireServer({
                Name = "Field Dice",
            })
            wait(3)
        end
    end,
})

Tabs.ItemsTab:Button({
    Title = "Use Smooth Dice",
    Callback = function()
        Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand

        Event:FireServer({
            Name = "Smooth Dice",
        })
    end,
})

Tabs.ItemsTab:Toggle({
    Title = "Auto Use Smooth Dice",
    Value = false,
    Callback = function(p282)
        getgenv().turnoff4 = p282

        while turnoff4 == true do
            Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand

            Event:FireServer({
                Name = "Smooth Dice",
            })
            wait(3)
        end
    end,
})

Tabs.ItemsTab:Button({
    Title = "Use Loaded Dice",
    Callback = function()
        Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand

        Event:FireServer({
            Name = "Loaded Dice",
        })
    end,
})

Tabs.ItemsTab:Toggle({
    Title = "Auto Use Loaded Dice",
    Value = false,
    Callback = function(p283)
        getgenv().turnoff4 = p283

        while turnoff4 == true do
            Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand

            Event:FireServer({
                Name = "Loaded Dice",
            })
            wait(3)
        end
    end,
})

Tabs.ItemsTab:Section({ 
    Title = "Boosts" 
})
Tabs.ItemsTab:Button({
    Title = "Use All Boosters",
    Callback = function()
        game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Red Field Booster")
        game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Blue Field Booster")
        game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Field Booster")
    end,
})

Tabs.ItemsTab:Toggle({
    Title = "Auto Use All Field Booster",
    Value = false,
    Callback = function(p284)
        getgenv().turnoff4 = p284

        while turnoff4 == true do
            game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Red Field Booster")
            game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Blue Field Booster")
            game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Field Booster")
            wait(5)
        end
    end,
})

Tabs.ItemsTab:Button({
    Title = "Use Red Field Booster",
    Callback = function()
        game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Red Field Booster")
    end,
})

Tabs.ItemsTab:Toggle({
    Title = "Auto Use Red Field Booster",
    Value = false,
    Callback = function(p285)
        getgenv().turnoff4 = p285

        while turnoff4 == true do
            game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Red Field Booster")
            wait(5)
        end
    end,
})

Tabs.ItemsTab:Button({
    Title = "Use Blue Field Booster",
    Callback = function()
        Event = game:GetService("ReplicatedStorage").Events.ToyEvent

        Event:FireServer("Blue Field Booster")
    end,
})

Tabs.ItemsTab:Toggle({
    Title = "Auto Use Blue Field Booster",
    Value = false,
    Callback = function(p286)
        getgenv().turnoff4 = p286

        while turnoff4 == true do
            Event = game:GetService("ReplicatedStorage").Events.ToyEvent

            Event:FireServer("Blue Field Booster")
            wait(5)
        end
    end,
})

Tabs.ItemsTab:Button({
    Title = "Use Field Booster",
    Callback = function()
        Event = game:GetService("ReplicatedStorage").Events.ToyEvent

        Event:FireServer("Field Booster")
    end,
})

Tabs.ItemsTab:Toggle({
    Title = "Auto Use Field Booster",
    Value = false,
    Callback = function(p287)
        getgenv().turnoff4 = p287

        while turnoff4 == true do
            Event = game:GetService("ReplicatedStorage").Events.ToyEvent

            Event:FireServer("Field Booster")
            wait(5)
        end
    end,
})

Tabs.ItemsTab:Section({ 
    Title = "Buffs" 
})

Tabs.ItemsTab:Button({
    Title = "Use All Buffs [no potions and Marshmallow Bee]",
    Callback = function()
        Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand

        Event:FireServer({
            Name = "Red Extract",
        })

        Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand

        Event:FireServer({
            Name = "Blue Extract",
        })

        Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand

        Event:FireServer({
            Name = "Glitter",
        })

        Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand

        Event:FireServer({
            Name = "Glue",
        })

        Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand

        Event:FireServer({
            Name = "Oil",
        })

        Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand

        Event:FireServer({
            Name = "Enzymes",
        })

        Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand

        Event:FireServer({
            Name = "Tropical TDrink",
        })
    end,
})

Tabs.ItemsTab:Button({
    Title = "Use Red Extract",
    Callback = function()
        ({}).Name = "Red Extract"
        Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand

        Event:FireServer(RedEx)
    end,
})

Tabs.ItemsTab:Button({
    Title = "Use Blue Extract",
    Callback = function()
        Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand

        Event:FireServer({
            Name = "Blue Extract",
        })
    end,
})
Tabs.ItemsTab:Button({
    Title = "Use Glitter",
    Callback = function()
        Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand

        Event:FireServer({
            Name = "Glitter",
        })
    end,
})

Tabs.ItemsTab:Button({
    Title = "Use Glue",
    Callback = function()
        Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand

        Event:FireServer({
            Name = "Glue",
        })
    end,
})

Tabs.ItemsTab:Button({
    Title = "Use Oil",
    Callback = function()
        Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand

        Event:FireServer({
            Name = "Oil",
        })
    end,
})

Tabs.ItemsTab:Button({
    Title = "Use Enzymes",
    Callback = function()
        Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand

        Event:FireServer({
            Name = "Enzymes",
        })
    end,
})

Tabs.ItemsTab:Button({
    Title = "Use Tropical Drink",
    Callback = function()
        Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand

        Event:FireServer({
            Name = "Tropical Drink",
        })
    end,
})

Tabs.ItemsTab:Button({
    Title = "Use Purple Potion",
    Callback = function()
        Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand

        Event:FireServer({
            Name = "Purple Potion",
        })
    end,
})

Tabs.ItemsTab:Button({
    Title = "Use Super Smoothie",
    Callback = function()
        Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand

        Event:FireServer({
            Name = "Super Smoothie",
        })
    end,
})

Tabs.ItemsTab:Button({
    Title = "Use Marshmallow Bee",
    Callback = function()
        Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand

        Event:FireServer({
            Name = "Marshmallow Bee",
        })
    end,
})
Tabs.MobsTab:Section({ 
    Title = "Mobs" 
})

Tabs.MobsTab:Toggle({
    Title = "Kill Crab",
    Value = false,
    Callback = function(p288)
        shared.a5 = p288

        if shared.a5 then
            local _Part = Instance.new("Part", game:GetService("Workspace"))

            _Part.Name = "Coconut Part"
            _Part.Anchored = true
            _Part.Transparency = 0.5
            _Part.Size = Vector3.new(6, 1, 6)
            _Part.Position = Vector3.new(-307.52117919922, 105.91863250732, 467.86791992188)

            spawn(function()
                while shared.a5 do
                    shared.a11 = false
                    shared.a12 = false

                    local _LocalPlayer7 = game.Players.LocalPlayer
                    local _TweenService3 = game:GetService("TweenService")
                    local v292 = TweenInfo.new(0.1)
                    local v293, v294, v295 = pairs(workspace.Collectibles:GetChildren())

                    while true do
                        local v296

                        v295, v296 = v293(v294, v295)

                        if v295 == nil then
                            break
                        end

                        local _magnitude = (v296.Position - _LocalPlayer7.Character.HumanoidRootPart.Position).magnitude

                        if v296.Transparency == 0 and _magnitude <= 8 then
                            local _x = v296.Position.x
                            local _z = v296.Position.z
                            local v300 = {
                                CFrame = CFrame.new(_x, _LocalPlayer7.Character.HumanoidRootPart.Position.y, _z),
                            }

                            _TweenService3:Create(_LocalPlayer7.Character.HumanoidRootPart, v292, v300):Play()
                        end
                    end

                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-307.52117919922, 110.91863250732, 467.86791992188)

                    task.wait(0.2)
                end
            end)
        elseif workspace:FindFirstChild("Coconut Part") then
            workspace["Coconut Part"]:Destroy()
        end
    end,
})

Tabs.MobsTab:Button({
    Title = "Kill Commando Chick",
    Callback = function()
        local _Part2 = Instance.new("Part", game:GetService("Workspace"))

        _Part2.Name = "Commando Part"
        _Part2.Anchored = true
        _Part2.Transparency = 1
        _Part2.Size = Vector3.new(10, 1, 10)
        _Part2.Position = Vector3.new(532.56, 68.1981, 162.801)

        wait(0.1)

        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(532.56, 68.1981, 162.801)
    end,
})

Tabs.MobsTab:Button({
    Title = "AFK Stump Snail",
    Callback = function()
        local _Part3 = Instance.new("Part", game:GetService("Workspace"))

        _Part3.Name = "Coconut Part"
        _Part3.Anchored = true
        _Part3.Transparency = 1
        _Part3.Size = Vector3.new(10, 1, 10)
        _Part3.Position = Vector3.new(424.483276, 71.4255676, -174.810959, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(424.483276, 68.4255676, -174.810959, 1, 0, 0, 0, 1, 0, 0, 0, 1)

        wait(0.1)

        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(424.483276, 74.4255676, -174.810959, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    end,
})

Tabs.MobsTab:Button({
    Title = "Kill Tunnel Bear",
    Callback = function()
        local _Part4 = Instance.new("Part", game:GetService("Workspace"))

        _Part4.Name = "Tunnel Part"
        _Part4.Anchored = true
        _Part4.Transparency = 1
        _Part4.Size = Vector3.new(10, 1, 10)
        _Part4.Position = Vector3.new(469.095, 23.2665, -46.3918)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(469.095, 7.2665, -46.3918)

        wait(0.1)

        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(469.095, 24.2665, -46.3918)
    end,
})

Tabs.MobsTab:Toggle({
    Title = "Auto Kill Mondo Chick [In testing]",
    Value = false,
    Callback = function(p304)
        getgenv().turnoff54 = p304

        if turnoff54 ~= true then
            game.Players.LocalPlayer.Character.Humanoid.HipHeight = 3
        else
            while turnoff54 == true do
                mondopition = game.Workspace.Monsters["Mondo Chick (Lvl 8)"].Head.Position

                api.tween(0.3, CFrame.new(mondopition.x, mondopition.y + 30, mondopition.z))

                game.Players.LocalPlayer.Character.Humanoid.HipHeight = 40
            end
        end
    end,
})

Tabs.MobsTab:Toggle({
    Title = "Kill Windy Bee",
    Callback = function(p305)
        getgenv().pon1 = p305

        if pon1 ~= true then
            game.Players.LocalPlayer.Character.Humanoid.HipHeight = 3
        else
            while pon1 == true do
                wait(0.3)

                local v306, v307, v308 = pairs(game.workspace.NPCBees:GetChildren())

                while true do
                    local v309

                    v308, v309 = v306(v307, v308)

                    if v308 == nil then
                        break
                    end
                    if v309.Name == "Windy" then
                        game.Players.LocalPlayer.Character.Humanoid.HipHeight = 35
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v309.CFrame
                    end
                end

                local _HumanoidRootPart = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
                local v311 = next
                local v312, v313 = game.workspace.Particles:GetChildren()

                while true do
                    local v314

                    v313, v314 = v311(v312, v313)

                    if v313 == nil then
                        break
                    end

                    local v315, v316, v317 = string.gmatch(v314.Name, "Windy")

                    while true do
                        v317 = v315(v316, v317)

                        if v317 == nil then
                            break
                        end
                        if string.find(v314.Name, "Windy") then
                            api.tween(1, CFrame.new(v314.Position.x, v314.Position.y, v314.Position.z))
                            task.wait(1)
                            api.tween(0.5, CFrame.new(v314.Position.x, v314.Position.y, v314.Position.z))
                            task.wait(0.5)
                        end
                    end
                end

                local v318 = next
                local v319, v320 = game.workspace.Particles:GetChildren()

                while true do
                    local v321

                    v320, v321 = v318(v319, v320)

                    if v320 == nil then
                        break
                    end

                    local v322, v323, v324 = string.gmatch(v321.Name, "Windy")

                    while true do
                        v324 = v322(v323, v324)

                        if v324 == nil then
                            break
                        end

                        task.wait()

                        if string.find(v321.Name, "Windy") then
                            game.Players.LocalPlayer.Character.Humanoid.HipHeight = 20

                            for _ = 1, 4 do
                                _HumanoidRootPart.CFrame = CFrame.new(v321.Position + 10, v321.Position + 50, v321.Position)

                                task.wait(0.3)
                            end
                        end

                        task.wait(0.1)
                    end
                end
            end
        end
    end,
})

Tabs.MobsTab:Toggle({
    Title = "Kill Viciuos Bee",
    Value = false,
    Callback = function(p325)
        getgenv().turnoff4 = p325

        if turnoff4 ~= true then
            game.Players.LocalPlayer.Character.Humanoid.HipHeight = 3
        else
            while turnoff4 == true do
                wait()

                local _HumanoidRootPart2 = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
                local v327 = next
                local v328, v329 = game.workspace.Particles:GetChildren()

                while true do
                    local v330

                    v329, v330 = v327(v328, v329)

                    if v329 == nil then
                        break
                    end

                    local v331, v332, v333 = string.gmatch(v330.Name, "Vicious")

                    while true do
                        v333 = v331(v332, v333)

                        if v333 == nil then
                            break
                        end

                        task.wait()

                        if string.find(v330.Name, "Vicious") then
                            game.Players.LocalPlayer.Character.Humanoid.HipHeight = 20

                            for _ = 1, 4 do
                                _HumanoidRootPart2.CFrame = CFrame.new(v330.Position.x, v330.Position.y + 20, v330.Position.z)

                                task.wait(0.3)
                            end
                        end
                    end
                end
            end

            task.wait(0.1)
        end
    end,
})
wait(0.5)

local _ScreenGui = Instance.new("ScreenGui")
local _TextLabel = Instance.new("TextLabel")
local _Frame = Instance.new("Frame")
local _TextLabel2 = Instance.new("TextLabel")
local _TextLabel3 = Instance.new("TextLabel")

_ScreenGui.Parent = game.CoreGui
_ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
_TextLabel.Parent = _ScreenGui
_TextLabel.Active = true
_TextLabel.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
_TextLabel.Draggable = true
_TextLabel.Position = UDim2.new(5.698610067, 0, 0.098096624, 0)
_TextLabel.Size = UDim2.new(0, 150, 0, 52)
_TextLabel.Font = Enum.Font.SourceSansSemibold
_TextLabel.Text = "Anti AFK Script"
_TextLabel.TextColor3 = Color3.new(0, 1, 1)
_TextLabel.TextSize = 22
_Frame.Parent = _TextLabel
_Frame.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
_Frame.Position = UDim2.new(0, 0, 1.0192306, 0)
_Frame.Size = UDim2.new(0, 150, 0, 57)
_TextLabel2.Parent = _Frame
_TextLabel2.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
_TextLabel2.Position = UDim2.new(0, 0, 0.800455689, 0)
_TextLabel2.Size = UDim2.new(0, 150, 0, 21)
_TextLabel2.Font = Enum.Font.Arial
_TextLabel2.Text = "RBScr1pts"
_TextLabel2.TextColor3 = Color3.new(0, 1, 1)
_TextLabel2.TextSize = 20
_TextLabel3.Parent = daaaaaaaaaa
_TextLabel3.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
_TextLabel3.Position = UDim2.new(0, 0, 0.158377, 0)
_TextLabel3.Size = UDim2.new(0, 150, 0, 44)
_TextLabel3.Font = Enum.Font.ArialBold
_TextLabel3.Text = "Status: Active"
_TextLabel3.TextColor3 = Color3.new(0, 1, 1)
_TextLabel3.TextSize = 20

local _VirtualUser = game:service("VirtualUser")

game:service("Players").LocalPlayer.Idled:connect(function()
    _VirtualUser:CaptureController()
    _VirtualUser:ClickButton2(Vector2.new())

    _TextLabel3.Text = "Roblox Tried to kick you but we didnt let them kick you :D"

    wait(2)

    _TextLabel3.Text = "Status : Active"
end)
