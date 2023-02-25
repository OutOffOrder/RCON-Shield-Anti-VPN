local COLORS    =  9


Citizen.CreateThread(function()
    StartSystem()
end)

AddEventHandler("playerDropped", function(REASON)
    local SRC = source
    print("^"..COLORS.."RCON Shield^0: ^1Player ^3"..GetPlayerName(SRC).." ^1Disconnected ...  |  Reason : `^0(^6"..REASON.."^0)^0`")
    if GetPlayerName(SRC) and REASON ~= nil then
        SENDLOG(SRC, Config.Log.Disconnect, "DISCONNECT", REASON)
    end
end)

AddEventHandler("playerConnecting", function (name, setKickReason, deferrals)
    local SRC      = source
    local IP      = GetPlayerEndpoint(SRC)
    local STEAM   = "Not Found"
    local DISCORD = "Not Found"
    local FIVEML  = "Not Found"
    local LIVE    = "Not Found"
    local XBL     = "Not Found"
    local ISP     = "Not Found"
    local CITY    = "Not Found"
    local COUNTRY = "Not Found"
    local PROXY   = "Not Found"
    local HOSTING = "Not Found"
    local LON     = "Not Found"
    local LAT     = "Not Found"
    local HWID    = GetPlayerToken(SRC, 0)
    IP = (string.gsub(string.gsub(string.gsub(IP,  "-", ""), ",", ""), " ", ""):lower())
    local g, f = IP:find(string.lower("192.168"))
    if g or f then
        IP = "178.131.122.181"
    end
    for _, DATA in ipairs(GetPlayerIdentifiers(SRC)) do
        if DATA:match("steam") then
            STEAM = DATA
        elseif DATA:match("discord") then
            DISCORD = DATA:gsub("discord:", "")
        elseif DATA:match("license") then
            FIVEML = DATA
        elseif DATA:match("live") then
            LIVE = DATA
        elseif DATA:match("xbl") then
            XBL = DATA
        end
    end
    if Config.Connection.AntiVPN then
        PerformHttpRequest("http://ip-api.com/json/"..IP.."?fields=66846719", function(ERROR, DATA, RESULT)
            if DATA ~= nil then
                local TABLE = json.decode(DATA)
                if TABLE ~= nil then
                    ISP     = TABLE["isp"]
                    CITY    = TABLE["city"]
                    COUNTRY = TABLE["country"]
                    if TABLE["proxy"] == true then
                        PROXY   =  "ON"
                    else
                        PROXY   = "OFF"
                    end
                    if TABLE["hosting"] == true then
                        HOSTING   =  "ON"
                    else
                        HOSTING   = "OFF"
                    end
                    LON     = TABLE["lon"]
                    LAT     = TABLE["lat"]
                    if PROXY == "ON" or HOSTING == "ON" then
                       local card = {
                        type = "AdaptiveCard",
                        version = "1.2",
                        body = { {
                          type = "Image",
                          url = "https://cache.ip-api.com/"..LON..","..LAT..",10",
                          horizontalAlignment = "Center"
                        }, {
                            type = "TextBlock",
                            text = "🛡️ RCON Shield 🛡️",
                            wrap = true,
                            horizontalAlignment = "Center",
                            separator = true,
                            height = "stretch",
                            fontType = "Default",
                            size = "Large",
                            weight = "Bolder",
                            color = "Light"
                        }, {
                            type = "TextBlock",
                            text = "Your VPN is on Plase Turn off that\nIP: "..IP.."\nVPN: "..PROXY.."\nHosting: "..HOSTING.."\nISP: "..ISP.."\nCountry: "..COUNTRY.."\nCity: "..CITY.."",
                            wrap = true,
                            horizontalAlignment = "Center",
                            separator = true,
                            height = "stretch",
                            fontType = "Default",
                            size = "Medium",
                            weight = "Bolder",
                            color = "Light"
                        },
                      }
                    }
                    print("^"..COLORS.."RCON Shield^0: ^1Player ^3"..GetPlayerName(SRC).." ^3Try For Join ^0| ^3VPN Availble ^3 ISP: "..ISP.."/ Country:"..COUNTRY.."/ City: "..CITY.."^0")
                    SENDLOG(SRC, Config.Log.Connect, "VPN")
                    deferrals.presentCard(card, "XD")
                    Wait(15000)
                    deferrals.done("[""RCON Shield""]\nPlease Turn off your vpn and rejoin !")
                else
                    local NEW_HWID = GetPlayerToken(SRC, 0)
                        if NEW_HWID == nil then
                            deferrals.done("[""RCON Shield""]\nYour HWID (FiveM Token) not find please restart your fivem !")
                        else
                            SENDLOG(SRC, Config.Log.Connect, "CONNECT")
                            deferrals.update("\n[""RCON Shield""] Your Information\nName: "..name.."\nLicense : "..FIVEML.."\nSteam : "..STEAM.."\nDiscord ID: "..DISCORD.."\nLive ID: "..LIVE.."\nXbox ID: "..XBL.."\nIP: "..IP.."\nHWID : "..NEW_HWID.."")
                            Wait(2000)
                            deferrals.done()
                        end
                    end
                end
            end
        end)
    end
end)

function StartAntiVPN()
    print("^"..COLORS.."")
    print([[

    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ─████████████████───██████████████─██████████████─██████──────────██████────██████████████─██████──██████─██████████─██████████████─██████─────────████████████───
    ─██░░░░░░░░░░░░██───██░░░░░░░░░░██─██░░░░░░░░░░██─██░░██████████──██░░██────██░░░░░░░░░░██─██░░██──██░░██─██░░░░░░██─██░░░░░░░░░░██─██░░██─────────██░░░░░░░░████─
    ─██░░████████░░██───██░░██████████─██░░██████░░██─██░░░░░░░░░░██──██░░██────██░░██████████─██░░██──██░░██─████░░████─██░░██████████─██░░██─────────██░░████░░░░██─
    ─██░░██────██░░██───██░░██─────────██░░██──██░░██─██░░██████░░██──██░░██────██░░██─────────██░░██──██░░██───██░░██───██░░██─────────██░░██─────────██░░██──██░░██─
    ─██░░████████░░██───██░░██─────────██░░██──██░░██─██░░██──██░░██──██░░██────██░░██████████─██░░██████░░██───██░░██───██░░██████████─██░░██─────────██░░██──██░░██─
    ─██░░░░░░░░░░░░██───██░░██─────────██░░██──██░░██─██░░██──██░░██──██░░██────██░░░░░░░░░░██─██░░░░░░░░░░██───██░░██───██░░░░░░░░░░██─██░░██─────────██░░██──██░░██─
    ─██░░██████░░████───██░░██─────────██░░██──██░░██─██░░██──██░░██──██░░██────██████████░░██─██░░██████░░██───██░░██───██░░██████████─██░░██─────────██░░██──██░░██─
    ─██░░██──██░░██─────██░░██─────────██░░██──██░░██─██░░██──██░░██████░░██────────────██░░██─██░░██──██░░██───██░░██───██░░██─────────██░░██─────────██░░██──██░░██─
    ─██░░██──██░░██████─██░░██████████─██░░██████░░██─██░░██──██░░░░░░░░░░██────██████████░░██─██░░██──██░░██─████░░████─██░░██████████─██░░██████████─██░░████░░░░██─
    ─██░░██──██░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░██──██████████░░██────██░░░░░░░░░░██─██░░██──██░░██─██░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░████─
    ─██████──██████████─██████████████─██████████████─██████──────────██████────██████████████─██████──██████─██████████─██████████████─██████████████─████████████───
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
        
    ^2 By Knax🎃#6053^0 
    ]])
end
    function SENDLOG(SRC, URL, TYPE, REASON, DETAILS)
        if URL ~= nil and GetPlayerName(SRC) ~= nil and tonumber(SRC) then
            local NAME    = GetPlayerName(SRC)
            local COORDS  = GetEntityCoords(GetPlayerPed(SRC))
            local STEAM   = "Not Found"
            local DISCORD = "Not Found"
            local FIVEML  = "Not Found"
            local LIVE    = "Not Found"
            local XBL     = "Not Found"
            local ISP     = "Not Found"
            local CITY    = "Not Found"
            local COUNTRY = "Not Found"
            local PROXY   = "Not Found"
            local HOSTING = "Not Found"
            local LON     = "Not Found"
            local LAT     = "Not Found"
            local IP      = GetPlayerEndpoint(SRC)
            IP = (string.gsub(string.gsub(string.gsub(IP,  "-", ""), ",", ""), " ", ""):lower())
            local g, f = IP:find(string.lower("192.168"))
            if g or f then
               IP = "178.131.122.181"
            end
            for _, DATA in ipairs(GetPlayerIdentifiers(SRC)) do
                if DATA:match("steam") then
                    STEAM = DATA
                elseif DATA:match("discord") then
                    DISCORD = DATA:gsub("discord:", "")
                elseif DATA:match("license") then
                    FIVEML = DATA
                elseif DATA:match("live") then
                    LIVE = DATA
                elseif DATA:match("xbl") then
                    XBL = DATA
                end
            end
            if DISCORD ~= "Not Found" then
                DISCORD = "<@"..DISCORD..">"
            else
                DISCORD = "Not Found"
            end
            PerformHttpRequest("http://ip-api.com/json/"..IP.."?fields=66846719", function(ERROR, DATA, RESULT)
                if DATA ~= nil then
                    local TABLE = json.decode(DATA)
                    if TABLE ~= nil then
                        ISP     = tostring(TABLE["isp"])
                        CITY    = tostring(TABLE["city"])
                        COUNTRY = tostring(TABLE["country"])
                        if TABLE["proxy"] == true then
                            PROXY   =  "ON"
                        else
                            PROXY   = "OFF"
                        end
                        if TABLE["hosting"] == true then
                            HOSTING   =  "ON"
                        else
                            HOSTING   = "OFF"
                        end
                        LON     = TABLE["lon"]
                        LAT     = TABLE["lat"]
                        if TYPE == "CONNECT" and CITY ~= nil then
                           PerformHttpRequest(URL, function(ERROR, DATA, RESULT)
                            end, "POST", json.encode({
                                embeds = {
                                    {
                                        author = {
                                            name = " 🛡️ RCON Shield 🛡️",
                                            url = "https://discord.gg/Jcc5Zj4tud",
                                            icon_url = "https://cdn.discordapp.com/attachments/1066409446928035881/1066410227282481152/standard.gif"
                                        },
                                        footer = {
                                            text = " 🛡️ RCON Shield 🛡️ | "..os.date("%Y/%m/%d | %X").."",
                                            icon_url = "https://cdn.discordapp.com/attachments/1066409446928035881/1066410227282481152/standard.gif",
                                        },
                                        title = " Connecting ",
                                        description = "**Player:** "..NAME.."\n**Steam Hex:** "..STEAM.."\n**Discord:** "..DISCORD.."\n**License:** "..FIVEML.."\n**Live:** "..LIVE.."\n**Xbox:** "..XBL.."\n**ISP:** "..ISP.."\n**Country:** "..COUNTRY.."\n**City:** "..CITY.."\n**IP:** ||"..IP.."||\n**VPN:** "..PROXY.."\n**Hosting:** "..HOSTING.."",
                                        color = 1769216
                                    }
                                }
                            }), {
                                ["Content-Type"] = "application/json"
                            })
                        elseif TYPE == "DISCONNECT" then
                            PerformHttpRequest(URL, function(ERROR, DATA, RESULT)
                            end, "POST", json.encode({
                                embeds = {
                                    {
                                        author = {
                                            name = " 🛡️ RCON Shield 🛡️",
                                            url = "https://discord.gg/Jcc5Zj4tud",
                                            icon_url = "https://cdn.discordapp.com/attachments/1066409446928035881/1066410227282481152/standard.gif"
                                        },
                                        footer = {
                                            text = " 🛡️ RCON Shield 🛡️" | "..os.date("%Y/%m/%d | %X").."",
                                            icon_url = "https://cdn.discordapp.com/attachments/1066409446928035881/1066410227282481152/standard.gif",
                                        },
                                        title = "Disconnect",
                                        description = "**Player:**` "..NAME.."`\n**Reason:**: "..REASON.."\n**Steam Hex:** "..STEAM.."\n**Discord:** "..DISCORD.."\n**License:** "..FIVEML.."\n**Live:** "..LIVE.."\n**Xbox:** "..XBL.."\n**ISP:** "..ISP.."\n**Country:** "..COUNTRY.."\n**City:** "..CITY.."\n**IP:** ||"..IP.."||\n**VPN:** "..PROXY.."\n**Hosting:** "..HOSTING.."",
                                        color = 16711680
                                    }
                                }
                            }), {
                                ["Content-Type"] = "application/json"
                            })
                        elseif TYPE == "VPN" then
                            PerformHttpRequest(URL, function(ERROR, DATA, RESULT)
                            end, "POST", json.encode({
                                embeds = {
                                    {
                                        author = {
                                            name = " 🛡️ RCON Shield 🛡️",
                                            url = "https://discord.gg/Jcc5Zj4tud",
                                            icon_url = "https://cdn.discordapp.com/attachments/1066409446928035881/1066410227282481152/standard.gif"
                                        },
                                        image =  {
                                            url = "https://cache.ip-api.com/"..LON..","..LAT..",10",
                                        },
                                        footer = {
                                            text = "RCON Shield 🛡️" "| "..os.date("%Y/%m/%d | %X").."",
                                            icon_url = "https://cdn.discordapp.com/attachments/1066409446928035881/1066410227282481152/standard.gif",
                                        },
                                        title = "VPN Blocked",
                                        description = "**Player:** "..NAME.."\n**Details:** Try For Join By VPN\n**Steam Hex:** "..STEAM.."\n**Discord:** "..DISCORD.."\n**License:** "..FIVEML.."\n**Live:** "..LIVE.."\n**Xbox:** "..XBL.."\n**ISP:** "..ISP.."\n**Country:** "..COUNTRY.."\n**City:** "..CITY.."\n**IP:** ||"..IP.."||\n**VPN:** "..PROXY.."\n**Hosting:** "..HOSTING.."",
                                        color = 10181046
                                    }
                                }
                            }), {
                                ["Content-Type"] = "application/json"
                            })
                        end
                    end
                end
            end)
        end
    end
end