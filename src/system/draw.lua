-- Create a draw System.
local DrawSystem = class("DrawSystem", System)

-- Define this System requirements.
function DrawSystem:requires()
  return {"Sprite", "Position"}
end

function DrawSystem:draw()
  for _, entity in pairs(self.targets) do
    love.graphics.draw(
      entity:get("Sprite").image,
      entity:get("Position").x,
      entity:get("Position").y
    )
  end
end

return DrawSystem
