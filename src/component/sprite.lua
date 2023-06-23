local Sprite = Component.create("Sprite")

-- Take a direction vector denoted by x & y
function Sprite:initialize(image)
  self.image = image or {}
  -- should somehow set default sx & sy that are calculated based on the tiles size and the sprite images?
  -- or a tiles x & y, and the system does the calculation? (but it will need to do it everytime)
end

return Sprite
