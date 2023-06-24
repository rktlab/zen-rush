local Spritesheet = Component.create("Spritesheet")

-- Take a direction vector denoted by x & y
function Spritesheet:initialize(sheet)
  self.sheet = sheet or {}
  -- should somehow set default sx & sy that are calculated based on the tiles size and the sprite images?
  -- or a tiles x & y, and the system does the calculation? (but it will need to do it everytime)
end

return Spritesheet
