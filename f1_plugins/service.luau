--!nonstrict
-- Service functions

local helpers = require("./utils/helpers.luau")
local getCacheFilePath = helpers.getCacheFilePath

--- Update preferences cache
-- Reworked from github-notifications plugin (https://github.com/noctalia-dev/community-plugins/blob/caeccf1f48f52565924d77b3afcbf6a8cec73b61/github-notifications/service.luau#L22)
local function updatePreferences(favourite_team: string, favourite_driver: string) : ()
    -- Get cache data directory
    local path = getCacheFilePath()
    -- Validate output
    if path == nil then
        noctalia.log("F1 plugins: Unable to update preferences due to empty cache file path.")
        return
    end

    -- Assign json file
    path = path .. "/preferences.json"

    -- Pack json file and update user preferences
    local payload = {
        favourite_team = favourite_team or "",
        favourite_driver = favourite_driver or "",
    }
    local encoded, err = noctalia.json.encode(payload, true)
    if encoded ~= nil then
        noctalia.writeFile(path, encoded)
    else
        noctalia.log("F1 plugins: Preferences encode error: " .. tostring(err))
    end
end

--- Load preferences cache
-- Reworked from github-notifications plugin (https://github.com/noctalia-dev/community-plugins/blob/caeccf1f48f52565924d77b3afcbf6a8cec73b61/github-notifications/service.luau#L40)
local function loadPreferences() : ()
    -- Get cache data directory
    local path = getCacheFilePath()
    -- Validate output
    if path == nil then
        return
    end

    -- Read stored user preferences
    local contents, _err = noctalia.readFile(path)
    -- Validate output
    if contents == nil or contents == "" then
        return
    end
    -- Decode json data
    local cached, decodeErr = noctalia.json.decode(contents)

    -- Set display data
    if type(cached.favourite_team) == "string" and type(cached.favourite_driver) == "string" then
        noctalia.state.set("f1_plugins:favourite_team", cached.favourite_team)
        noctalia.state.set("f1_plugins:favourite_driver", cached.favourite_driver)
    else
        noctalia.log("F1 plugins: invalid cache file: " .. tostring(decodeErr))
    end
end