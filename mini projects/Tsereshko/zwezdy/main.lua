local x = 320
local y = 240
local xz = {}
local yz = {}
local rz = {}

function love.load(arg)
	--Need for ZeroBane Studio debugging
	if arg[#arg] == "-debug" then
		require("mobdebug").start()
	end
	image = love.graphics.newImage("smile1.png")
	
	for i = 1, 50 do 
		xz[i] = math.random (1, 800)
		yz[i] = math.random (1, 600)
		rz[i] = math.random (10, 50)
	end
	
end

function love.update(dt)
	
	x = x + 60 * dt
	y = y + 60 * dt
	
	if y > 600 then
	y = -32
end

if x > 800 then
	x = -32
end


end

function love.draw()
	
	for i = 1, 50 do 
		love.graphics.circle ("line", xz[i], yz[i], rz[i])
	end
	
	love.graphics.draw(image, x, y)
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