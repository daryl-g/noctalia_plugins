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

return Utils