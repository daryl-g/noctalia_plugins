-- Functions to fetch data from Gridvex open API

local Gridvex = {}

--- Gridvex API URL base
local GRIDVEX_URL = "https://api.gridvex.app/api/v1"

-- Helper functions
local helpers = require("../utils/helpers.luau")
local writeJson = helpers.writeJson

-- Fetch function
local fetch = require("./fetch.luau")
local fetchJson = fetch.httpJson

-- Response types
local types = require("../utils/types.luau")

--- Fetch details about all constructors for a season or a single constructor
function Gridvex.fetchConstructor(id: string?) : ()
    local url: string
    -- Input check
    if id == nil or id == "" then
        url = GRIDVEX_URL .. "/constructors?season=" .. os.date("%Y")
    else
        url = GRIDVEX_URL .. "/constructors/" .. id
    end

    -- Fetch data and write to json file
    fetchJson(
        url,
        function(data: any)
            if data ~= nil then
                local constructors: { types.ConstructorShort } | types.ConstructorDetails = data
                local ok: boolean = writeJson("constructors.json", constructors)
                -- Validate write process
                if ok then
                    noctalia.log("Constructors data successfully written into constructors.json.")
                end
        end
    end)
end

--- Fetch constructor results for a season
function Gridvex.fetchConstructorResults(id: string): ()
    -- Fetch data and write to json file
    fetchJson(
        GRIDVEX_URL .. "/constructors/" .. id .. "/results",
        function(data: any)
            if data ~= nil then
                local results: { types.ConstructorRaceResult } = data
                local ok: boolean = writeJson("constructors_result.json", results)
                -- Validate write process
                if ok then
                    noctalia.log("Constructors race results data successfully written into constructors.json.")
                end
        end
    end)
end

--- Fetch all drivers for a season
function Gridvex.fetchAllDrivers(season: number): {}

--- Fetch driver details
function Gridvex.fetchDriver(id: number) : {}

--- Fetch driver career

--- Fetch driver results for a season

--- Fetch all grand prix for a season

--- Fetch latest grand prix info

--- Fetch results for a grand prix

return Gridvex