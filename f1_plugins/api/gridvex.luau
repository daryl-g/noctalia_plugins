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

--- Fetch all constructors for a season
function Gridvex.fetchAllConstructors() : ()
    fetchJson(
        GRIDVEX_URL .. "/constructors?season=" .. os.date("%Y"),
        function(data: any)
            if data ~= nil then
                local constructors: { types.ConstructorShort } = data
                local ok: boolean = writeJson("constructors.json", constructors)
                -- Validate write process
                if ok then
                    noctalia.log("All constructors data successfully written into constructors.json.")
                end
        end
    end)
end

--- Fetch constructor details
function Gridvex.fetchConstructor(id: string) : ()
    fetchJson(
        GRIDVEX_URL .. "/constructors/" .. id,
        function(data: any)
            if data ~= nil then
                local constructor: types.ConstructorDetails = data
                local ok: boolean = writeJson("constructor.json", constructor)
                -- Validate write process
                if ok then
                    noctalia.log("Constructor data successfully written into constructor.json.")
                end
        end
    end)

--- Fetch constructor results for a season
function Gridvex.fetchConstructorResults(id: string, season: number): { types.ConstructorRaceResult }

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