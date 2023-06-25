local Colision = Component.create("Colision")
local bump = require("vendors.bump")

function Colision:initialize(cellSize)
  self.layer = bump.newWorld(cellSize or 16)
end

return Colision
