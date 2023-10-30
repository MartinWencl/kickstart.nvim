--- Table containing all the function related to the current enviroment
EnvLib = {}

--- Checks the env var MARTIN_LOCATION 
---@param location string value to be checked
function EnvLib:CheckLocation(location)
  return location ~= os.getenv("MARTIN_LOCATION") or ""
end
