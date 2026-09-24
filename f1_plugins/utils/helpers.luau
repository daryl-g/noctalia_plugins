-- Helper functions

local Utils = {}

--- Noctalia's directory for cached files
local cacheFilePath: string? = nil

--- Get Noctalia's cache data directory
-- Copied from github-notifications plugin (https://github.com/noctalia-dev/community-plugins/blob/caeccf1f48f52565924d77b3afcbf6a8cec73b61/github-notifications/service.luau#L10)
function Utils.getCacheFilePath() : string | nil
    -- If there's no current data dir
    if cacheFilePath ~= nil then
        return cacheFilePath
    end

    -- Ask Noctalia for the data dir
    local dataDir = noctalia.pluginDataDir()
    -- Validate output
    if dataDir == nil then
        return nil
    end

    return cacheFilePath
end

--- Write to a cached json file
-- Modified from world-radio plugin (https://github.com/noctalia-dev/community-plugins/blob/caeccf1f48f52565924d77b3afcbf6a8cec73b61/world-radio/panel.luau#L325)
function Utils.writeJson(file_name: string, contents: any) : boolean
    -- Encode contents into json format
    local encodeOk: boolean, encoded: string? = pcall(noctalia.json.encode, contents, true)
    -- Validate output and write to specified json file
    if encodeOk and encoded ~= nil then
        local writeOk: boolean, _ = noctalia.writeFile(
            (Utils.getCacheFilePath() or "./") .. "/" .. file_name,
            contents
        )
        return writeOk
    end

    return false
end

return Utils