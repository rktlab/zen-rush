local Velocity = Component.create("Velocity")

function Velocity:initialize(velocity)
  self.x = velocity or 68
  self.y = velocity or 68
end

return Velocity
