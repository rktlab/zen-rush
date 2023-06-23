local helper = {}

function helper.printFps(x, y)
  love.graphics.print(
    "FPS: " .. tostring(love.timer.getFPS()),
    x or 10,
    y or 10
  )
end

return helper
