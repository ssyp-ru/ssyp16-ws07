local x = 320
local y = 240

local xt = 800
local yt = 0

local bad_x = 50
local bad_y = 50
local speed_bad_x = 0
local speed_bad_y = 0
local bad_delay = 0

local bad_x2 = 100
local bad_y2 = 100
local speed_bad_x2 = 0
local speed_bad_y2 = 0
local bad_delay2 = 0

local x_shirina 

local gameover = false


function love.load(arg)
	--Need for ZeroBane Studio debugging
	if arg[#arg] == "-debug" then
		require("mobdebug").start()
	end
	fon = love.graphics.newImage("fon.png")
	image = love.graphics.newImage("PtizaLetit.png")
	x_shirina = image:getWidth()

	--love.graphics.rotate( 2 )
end
function love.update(dt) 

	if love.keyboard.isDown("up") then 
		y = y - 5
	end
	if love.keyboard.isDown("down") then 
		y = y + 5
	end
	if love.keyboard.isDown("left") then 
		x = x - 5
	end
	if love.keyboard.isDown("right") then 
		x = x + 5
	end
	if x >= bad_x and y >= bad_x
	and
	x<=bad_x and y<=bad_y
	then 
		gameover = true
	end
	if gameover 
	then

	end	

	xt = xt - 5

	if xt < 0 then 
		xt = 800
	end
	if bad_x < 0 then 
		bad_x = 800
	end
	if bad_x > 600 then 
		bad_x = 0
	end
	if bad_y < 0 then 
		bad_y = 800
	end
	if bad_y > 600 then 
		bad_y = 0
	end

	if bad_x2 < 0 then 
		bad_x2 = 800
	end
	if bad_x2 > 600 then 
		bad_x2 = 0
	end
	if bad_y2 < 0 then 
		bad_y2 = 800
	end
	if bad_y2 > 600 then 
		bad_y2 = 0
	end
	--Враги. движение
	bad_delay = bad_delay + dt
	if bad_delay > 1 then
		speed_bad_x =love.math.random(-5, 5)
		speed_bad_y =love.math.random(-5, 5)
		bad_delay = 0
	end

	bad_x = bad_x + speed_bad_x
	bad_y = bad_y + speed_bad_y

	bad_delay2 = bad_delay2 + dt
	if bad_delay2 > 1 then
		speed_bad_x2 =love.math.random(-5, 5)
		speed_bad_y2 =love.math.random(-5, 5)
		bad_delay2 = 0
	end

	bad_x2 = bad_x2 + speed_bad_x2
	bad_y2 = bad_y2 + speed_bad_y2

end
function love.draw()
	--Рисуем на экране
	love.graphics.draw(fon, xt, yt)
	love.graphics.draw(fon, xt-800, yt)
	love.graphics.draw(image, x, y, 0 , 0.2, 0.2, 50, 50)
	love.graphics.draw(image, bad_x2, bad_y2, 0 , 0.3, 0.3, 50, 50)
	love.graphics.draw(image, bad_x, bad_y, 0 , 0.3, 0.3, 50, 50)
	love.graphics.print("time:")
end

function love.keypressed(key, unicode)

	if key == "r" then

		x = 320
		y = 240

		xt = 800
		yt = 0

		bad_x = 50
		bad_y = 50
		bad_x2 = 100
		bad_y2 = 100
	end
end

function love.keyreleased(key, unicode)
end
function love.mousepressed(x, y, button)	

end
function love.mousereleased(x, y, button)

end
function love.wheelmoved( dx, dy )

end