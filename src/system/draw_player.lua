-- Create a draw System.
local DrawPlayer = class("DrawPlayer", System)

-- Define this System requirements.
function DrawPlayer:requires()
  return {"PlayerControlled"}
end

function DrawPlayer:draw()
  for _, entity in pairs(self.targets) do

    scene = entity:getParent()
    pos_x = scene:get("ScreenSize").x/2
    pos_y = scene:get("ScreenSize").y/2

    love.graphics.draw(
      entity:get("Sprite").image,
      -- The player always go in the middle of the window
      pos_x,
      pos_y,
      0, -- rotation
      1, -- scale x
      1, -- scale y
      8, -- origin x
      8 -- origin y
    )
  end
end

return DrawPlayer
