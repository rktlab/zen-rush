-- Create a System class as lovetoys.System subclass.
local MovePlayer = class("MovePlayer", System)

-- Define this System's requirements.
function MovePlayer:requires()
  return {"PlayerControlled", "Position", "Velocity", "Direction"}
end

function MovePlayer:update(dt)
  -- print("Let's move the player")
  for _, entity in pairs(self.targets) do
    -- Determine direction
    local direction = {0, 0}

    if love.keyboard.isDown("right") then
      direction[1] = direction[1] + 1
    end
    
    if love.keyboard.isDown("left") then
      direction[1] = direction[1] - 1
    end

    if love.keyboard.isDown("down") then
      direction[2] = direction[2] + 1
    end
    
    if love.keyboard.isDown("up") then
      direction[2] = direction[2] - 1
    end

    -- If we go in diagonal, we normalise the speed
    -- Note that we hardcoded the norm, so it only support 45deg movement
    -- Anyway on a keyboard we can only do that.
    if not (direction[1] == 0 or direction[2] == 0) then
      direction[1] = direction[1] / 1.41
      direction[2] = direction[2] / 1.41
    end

    -- print("Direction vec: " .. direction[1] .. ", " .. direction[2])

    local position = entity:get("Position")
    local velocity = entity:get("Velocity")
    local new_x = position.x + direction[1] * velocity.x * dt
    local new_y = position.y + direction[2] * velocity.y * dt

    local colision = entity:getParent():get("Colision").layer

    local actualX, actualY, cols, len = colision:move(entity, new_x, new_y)
    colision:update(entity, actualX, actualY)

    position.x = actualX
    position.y = actualY

  end
end

return MovePlayer
