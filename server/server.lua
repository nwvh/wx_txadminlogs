
-- Kick

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if eventData.secondsRemaining == 500 then
        LogRestart('10')
    elseif eventData.secondsRemaining == 300 then
        LogRestart('5')
    elseif eventData.secondsRemaining == 240 then
        LogRestart('4')
    elseif eventData.secondsRemaining == 180 then
        LogRestart('3')
    elseif eventData.secondsRemaining == 120 then
        LogRestart('2')
    elseif eventData.secondsRemaining == 60 then
        LogRestart('1')
    end
end)

AddEventHandler('txAdmin:events:playerKicked', function(eventData)
    Author = eventData.author
    Target = n[eventData.target]
    Reason = eventData.reason
    local ids = ExtractIdentifiers(eventData.target);
	local discord = ids.discord;
    LogKick(Author,Target,Reason,"Steam ID: "..ids.steam.."\nLicense: "..ids.license.."\nDiscord: "..ids.discord.."\nIP Address: "..ids.ip)
end)

-- Ban
AddEventHandler('txAdmin:events:playerBanned', function(eventData)
    Author = eventData.author
    Target = GetPlayerName(eventData.target)
    Reason = eventData.reason
    ActionID = eventData.actionId
    Expiration = eventData.expiration
    local ids = ExtractIdentifiers(eventData.target);
	local discord = ids.discord;  
    local gameLicense = ids.license;
    LogBan(Author,Target,Reason,Expiration,"Steam ID: "..ids.steam.."\nLicense: "..ids.license.."\nDiscord: "..ids.discord.."\nIP Address: "..ids.ip)

    if eventData.expiration ~= false then
        LogBan(Author,Target,Reason,Expiration,ActionID,"Steam ID: "..ids.steam.."\nLicense: "..ids.license.."\nDiscord: "..ids.discord.."\nIP Address: "..ids.ip)
    else
        LogBan(Author,Target,Reason,"PERMANENT",ActionID,"Steam ID: "..ids.steam.."\nLicense: "..ids.license.."\nDiscord: "..ids.discord.."\nIP Address: "..ids.ip)
    end
end)

AddEventHandler('txAdmin:events:playerWarned', function(eventData)
    Author = eventData.author
    Target = GetPlayerName(eventData.target)
    Reason = eventData.reason
    ActionID = eventData.actionId
    local ids = ExtractIdentifiers(eventData.target);
    LogWarning(Author,Target,Reason,"Steam ID: "..ids.steam.."\nLicense: "..ids.license.."\nDiscord: "..ids.discord.."\nIP Address: "..ids.ip)
end)


-- Player Healed
AddEventHandler('txAdmin:events:healedPlayer', function(eventData)
    Author = GetPlayerName(eventData.id)
    if eventData.id ~= -1 then
        LogHeal(Author,"Themselfs")
    else
        LogHeal(Author,"Everyone")
    end
end)

-- Server Announcement
AddEventHandler('txAdmin:events:announcement', function(eventData)
    LogAnnouncement(eventData.author,eventData.message)
end)

-- Functions

function LogRestart(time)
    local embed = {
          {
              ["color"] = wx.WebhookColor,
              ["title"] = "**Server is restarting soon!**",
          ["fields"] = {
            {
              ["name"]= "Minutes Remaining",
              ["value"]= time,
              ["inline"] = true
            }
          }
        }
      }
    PerformHttpRequest(wx.ExplosionWebhook, function(err, text, headers) end, 'POST', json.encode({username = wx.WebHookName, embeds = embed}), { ['Content-Type'] = 'application/json' })
  end
function LogKick(admin, player, reason, ids)
    local embed = {
          {
              ["color"] = wx.WebhookColor,
              ["title"] = "**Player has been kicked**",
          ["fields"] = {
            {
              ["name"]= "Admin Name",
              ["value"]= admin,
              ["inline"] = true
            },
            {
              ["name"]= "Target Player",
              ["value"]= player,
              ["inline"] = true
            },
            {
              ["name"]= "Reason",
              ["value"]= reason,
              ["inline"] = true
            },
            {
              ["name"]= "Target Identifiers",
              ["value"]= ids,
              ["inline"] = true
            }
          }
        }
      }
    PerformHttpRequest(wx.ExplosionWebhook, function(err, text, headers) end, 'POST', json.encode({username = wx.WebHookName, embeds = embed}), { ['Content-Type'] = 'application/json' })
  end
function LogWarning(admin, player, reason, ids)
    local embed = {
          {
              ["color"] = wx.WebhookColor,
              ["title"] = "**Player has been warned**",
          ["fields"] = {
            {
              ["name"]= "Admin Name",
              ["value"]= admin,
              ["inline"] = true
            },
            {
              ["name"]= "Target Player",
              ["value"]= player,
              ["inline"] = true
            },
            {
              ["name"]= "Reason",
              ["value"]= reason,
              ["inline"] = true
            },
            {
              ["name"]= "Target Identifiers",
              ["value"]= ids,
              ["inline"] = true
            }
          }
        }
      }
    PerformHttpRequest(wx.ExplosionWebhook, function(err, text, headers) end, 'POST', json.encode({username = wx.WebHookName, embeds = embed}), { ['Content-Type'] = 'application/json' })
  end
function LogBan(admin, player, reason, duration, banid, ids)
    local embed = {
          {
              ["color"] = wx.WebhookColor,
              ["title"] = "**Player has been banned**",
          ["fields"] = {
            {
              ["name"]= "Admin Name",
              ["value"]= admin,
              ["inline"] = true
            },
            {
              ["name"]= "Target Player",
              ["value"]= player,
              ["inline"] = true
            },
            {
              ["name"]= "Reason",
              ["value"]= reason,
              ["inline"] = true
            },
            {
              ["name"]= "Ban Duration",
              ["value"]= duration,
              ["inline"] = true
            },
            {
              ["name"]= "Ban ID",
              ["value"]= banid,
              ["inline"] = true
            },
            {
              ["name"]= "Target Identifiers",
              ["value"]= ids,
              ["inline"] = true
            }
          }
        }
      }
    PerformHttpRequest(wx.ExplosionWebhook, function(err, text, headers) end, 'POST', json.encode({username = wx.WebHookName, embeds = embed}), { ['Content-Type'] = 'application/json' })
  end
function LogHeal(admin, target)
    local embed = {
          {
              ["color"] = wx.WebhookColor,
              ["title"] = "**Admin Heal**",
          ["fields"] = {
            {
              ["name"]= "Admin Name",
              ["value"]= admin,
              ["inline"] = true
            },
            {
              ["name"]= "Target",
              ["value"]= target,
              ["inline"] = true
            }
          }
        }
      }
    PerformHttpRequest(wx.ExplosionWebhook, function(err, text, headers) end, 'POST', json.encode({username = wx.WebHookName, embeds = embed}), { ['Content-Type'] = 'application/json' })
  end
function LogAnnouncement(admin, message)
    local embed = {
          {
              ["color"] = wx.WebhookColor,
              ["title"] = "**New server announcement**",
          ["fields"] = {
            {
              ["name"]= "Announcer",
              ["value"]= admin,
              ["inline"] = true
            },
            {
              ["name"]= "Message",
              ["value"]= message,
              ["inline"] = true
            }
          }
        }
      }
    PerformHttpRequest(wx.ExplosionWebhook, function(err, text, headers) end, 'POST', json.encode({username = wx.WebHookName, embeds = embed}), { ['Content-Type'] = 'application/json' })
  end

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    --Loop over all identifiers
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        --Convert it to a nice table.
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end

-- Threads
n = {}
CreateThread(function()
	while true do
		Wait(1000)
		for k,v in pairs(GetPlayers()) do
			n[v] = GetPlayerName(v)
		end
	end
end)