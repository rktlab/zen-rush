local Energy = Component.create("Energy")

-- Take a direction vector denoted by x & y
function Energy:initialize(start, max)
  self.value = start or 100
  self.max = max or 200
end

return Energy
