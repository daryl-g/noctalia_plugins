-- Shared data types for the app

--- Primary colour for a constructor
export type ConstructorColour = {
    hex_color: string
}

--- Short info about a country
export type CountryShort = {
    alpha2_code: string,
    alpha3_code: string,
    id: string,
    name: string
}

--- Country full info
export type Country = {
    alpha2_code: string,
    alpha3_code: string,
    denonym: string?,
    id: string,
    ioc_code: string?,
    name: string
}

--- Constructor lineup details
export type ConstructorLineup = {
    abbreviation: string,
    country: Country,
    full_name: string,
    id: string,
    name: string,
    rounds_text: string?,
    test_driver: boolean
}

--- Short information about a constructor
export type ConstructorShort = {
    country_id: string,
    full_name: string,
    id: string,
    is_active: boolean,
    name: string,
    total_championship_points: number,
    total_championship_wins: number,
    total_podiums: number,
    total_points: number,
    total_pole_positions: number,
    total_race_wins: number,
    color: ConstructorColour,
    country: Country
}

--- Full information about a constructor
export type ConstructorDetails = {
    best_championship_position: number?,
    best_race_result: number?,
    best_sprint_race_result: number?,
    best_starting_grid_position: number?,
    color: ConstructorColour,
    country: Country,
    dnf_rate: number?,
    full_name: string,
    id: string,
    is_active: boolean,
    line_ups: { drivers: ConstructorLineup, season: string },
    name: string,
    podiums_rate: number?,
    poles_rate: number?,
    total_1_and_2_finishes: number,
    total_championship_points: number,
    total_championship_wins: number,
    total_fastest_laps: number,
    total_podium_races: number,
    total_podiums: number,
    total_pole_positions: number,
    total_race_entries: number,
    total_race_laps: number,
    total_race_starts: number,
    total_race_wins: number,
    total_sprint_race_starts: number,
    total_sprint_race_wins: number,
    wins_rate: number?,
}

--- Driver summary details
export type DriverSummary = {
    abbreviation: string,
    id: string,
    name: string,
    permanent_number: string?,
    country: Country
}

--- Sprint race result of a driver
export type DriverSprintRaceResult = {
    grid_position_number: number?,
    points: number,
    position_number: number?,
    position_text: string?,
    positions_gained: number?,
    reason_retired: string?
}

--- Race result of a driver
export type ConstructorRaceResultCar = {
    driver: DriverSummary,
    driver_of_the_day: boolean,
    fastest_lap: boolean,
    gap: string?,
    grand_slam: boolean,
    grid_position_number: number?,
    grid_position_text: string?,
    laps: number?,
    points: number,
    pole_position: boolean,
    position_number: number?,
    position_text: string?,
    positions_gained: number?,
    reason_retired: string?,
    sprint: DriverSprintRaceResult?,
    time: string?
}

--- Circuit information
export type GrandPrixCircuit = {
    direction: string,
    length: number,
    name: string,
    old_name: string?,
    place_name: string,
    turns: number,
    type: string,
    country: CountryShort
}

--- Circuit layout
export type CircuitLayout = {
    circuit_id: string,
    effective: boolean,
    id: string
}

--- Grand prix information
export type GrandPrixIdentity = {
    id: string,
    name: string,
    short_name: string,
    country: CountryShort
}

--- Race result of a constructor
export type ConstructorRaceResult = {
    best_finish: number?,
    cars: { DriverSummary },
    championship_points: number?,
    championship_position: number?,
    circuit: GrandPrixCircuit,
    circuit_layout: CircuitLayout,
    constructors_championship_decider: boolean,
    date: string,
    grand_prix: GrandPrixIdentity,
    official_name: string,
    points: number,
    round: number
}

return {}