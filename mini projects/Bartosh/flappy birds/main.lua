local x = 320
local y = 240

local tx = 400
local ty = 320

local px = 0
local py = 0

local lx = 200
local ly = 200

local t2x = 400
local t2y = 0

local tr = 0

speephon = 250
speetruba = 300
speebird = 150

youlose =  false

function love.load(arg)
	--Need for ZeroBane Studio debugging
	if arg[#arg] == "-debug" then
		require("mobdebug").start()
	end

	image = love.graphics.newImage("smile1.png")
	image2 = love.graphics.newImage("truba.png")
	phon = love.graphics.newImage("phon.png")
	pik_youlose = love.graphics.newImage("youlose.png")
end

function love.update(dt)
	y = y + speebird * dt

	if y > 480 then
		youlose = true
		speebird = 0
		speephon = 0
		speetruba = 0
	end
	if y < 0 then
		youlose = true
		speebird = 0
		speephon = 0
		speetruba = 0
	end	


	tx = tx - speetruba * dt
	if tx < -66 then
		tx = 800

	end
	t2x = t2x - speetruba * dt
	if t2x < -66 then
		t2x = 800
	end
	px = px - speephon * dt
	if px < 0 then
		px = 800

	end
	if y > ty and x > tx and x < (tx + 66 - 32) then 
		youlose = true
		speephon = 0
		speetruba = 0
		speebird = 0
	end
	if y < (t2y + 223) and x > t2x and x < (t2x + 66 - 32) then
				youlose = true
		speephon = 0
		speetruba = 0
		speebird = 0
		end
	if x > tx and x < tx + 1 then 
		tr = tr + 1		 
	end

end

function love.draw()
	love.graphics.draw(phon, px, py)
	love.graphics.draw(phon, px - 800, py)
	love.graphics.draw(image2, tx, ty)
	love.graphics.draw(image, x, y)
	love.graphics.draw(image2, t2x, t2y)
	if youlose then 
		love.graphics.draw(pik_youlose, lx, ly)
	end
	love.graphics.print("SCORE "..tr, 20,20)
end

function love.keypressed(key, unicode)
	if key == "up" and speebird ~= 0 then
		y = y - 100
	end
	if key == "down" and speebird ~= 0 then
		y = y + 50
	end
	if key == "r" then
		youlose = false
		y = 0
		x = 15
		speephon = 250
		speetruba = 300
		speebird = 150
		tr = 0
	end
	if key == "p" then
		speephon = 0
		speetruba = 0
		speebird = 0
	end
	if key == "n" and youlose == false then
		speephon = 250
		speetruba = 300
		speebird = 150
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