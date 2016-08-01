local x = 320
local y = 240
local r = 0

function love.load(arg)
	--Need for ZeroBane Studio debugging
	if arg[#arg] == "-debug" then
		require("mobdebug").start()
	end
	image = love.graphics.newImage("illuminaty.png")
end

function love.update(dt)
	x = x + 30 * dt
	y = y + 30 * dt
	r = r + 1 * dt
	
	if y >= 616 then
		y = -32
	end
	
	if x >= 816 then
		x = -32
	end
	
	if x <= -33 then
		x = 816
	end
	
	if y <= -33 then
		y = 616
	end
	
end

function love.draw()
	love.graphics.draw(image, x, y, r, 1, 1, 16, 16, 0, 1)
end

function love.keypressed(key, unicode)

end

function love.keyreleased(key, unicode)
end

function love.mousepressed(x, y, button)

end

function love.mousereleased(x, y, button)
end

function love.wheelmoved( dx, dy )

end