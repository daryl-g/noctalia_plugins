--!strict

-- Functions to fetch data and images from OpenF1 and Gridvex

-- Helper functions
local helpers = require("../utils/helpers.luau")
local getCacheFilePath = helpers.getCacheFilePath

-- Static variables
--- Link to F1 official images
local MEDIA_URL = "https://media.formula1.com/image/upload/q_auto/v1740000001/"
--- F1 image type
local MEDIA_TYPE = ".webp"
--- OpenF1 API URL base
local OPENF1_URL = "https://api.openf1.org/v1/"
--- Gridvex API URL base
local GRIDVEX_URL = "https://api.gridvex.app/api"
--- User agent to include in headers
local USER_AGENT = "darylg/f1-plugins/1.0.0"

--- Generic function to fetch data
-- Copied from world-radio plugin (https://github.com/noctalia-dev/community-plugins/blob/caeccf1f48f52565924d77b3afcbf6a8cec73b61/world-radio/panel.luau#L332)
local function httpJson(url: string, resp) : ()
    noctalia.http({
        url = url,
        headers = {
            "Accept: application/json",
            "User-Agent: " .. USER_AGENT,
        }
    },
        -- Handle HTTP response
        function(res)
            -- Handle empty response
            if res == nil or res.ok ~= true then
                resp(nil)
                return
            end

            -- Decode response
            local ok: boolean, decoded: any = pcall(noctalia.json.decode, res.body)
            -- Validate output
            if ok then
                -- Send output to next function
                resp(decoded)
            else
                -- Send error message
                resp(nil)
            end
        end
    )
end

--- Download images from F1 official website
local function downloadImage(id: string) : boolean
    -- Get cache file directory
    local path: string? = getCacheFilePath()
    if path == nil or path == "" then
        return false
    end

    -- Assign subfolder path
    path = path .. "/img"
    -- Construct the image URL
    local image_url: string = MEDIA_URL .. id .. MEDIA_TYPE
    -- Grab the file name from the link ID
    local parts_list: {string} = string.split(id, "/")
    local file_name: string = parts_list[#parts_list]

    -- Handle download process
    local ok: boolean = noctalia.download(
        image_url,
        path,
        -- Validate if the image has been downloaded
        function(success: boolean)
            if success == true and noctalia.fileExists(path .. file_name) == true then
                return true
            elseif success == true and noctalia.fileExists(path .. file_name) ~= true then
                return false
            else
                return false
            end
        end
    )

    return ok
end