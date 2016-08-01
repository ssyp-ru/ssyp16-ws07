local x = 180
local y = 240
local vremya = 0
local time = 0
local recordtime = 0
local scorost = 100
local scorost2 = 150
local vverh = 100
local hon = 0
local trub1x = 0
local trub1y = 355
local trub2x = 0
local trub2y = 0
local gameover = false
local gameend = false
local gamestart = false
local try = 1

function love.load(arg)
	--Need for ZeroBane Studio debugging
	if arg[#arg] == "-debug" then
		require("mobdebug").start()
	end
	
	spr_smile = love.graphics.newImage("ptica.png")
	--icon = love.graphics.newImage("icon.png"):getData()
	--love.window.setIcon( icon )
	phon = love.graphics.newImage("fb.png")
	truba = love.graphics.newImage("truba.png")
	truba2 = love.graphics.newImage("truba2.png")
end

function love.update(dt)
--	love.graphics.print (nachtime, 590, 5)
	
	--x = x + scorost * dt
	y = y + vverh * dt
	vremya = vremya + dt
	time = time + dt
	recordtime = recordtime + dt

	if gameover == false then
		trub1x = trub1x - scorost2 * dt
		trub2x = trub2x - scorost2 * dt
		hon = hon - scorost * dt
	end


	if y == 568 then
		gameover = true
	end


	if hon < 0 then
		hon = 800
	end

	if trub1x < -66 then
		trub1x = 800
	end

	if trub2x < -66 then
		trub2x = 800
	end

	if vremya > 10 then
		scorost = scorost + 50
		scorost2 = scorost2 + 50
		vverh = vverh + 5
		vremya = 0
	end

	if vremya > 10 then
		hon = hon + 50
		vremya = 0
	end

	--x = x - 100 * dt
	--y = y - 100 * dt

	if (y > 568) then
		y  = 568
	end

	if (y < 32) then
		y = 32
	end

	--[[if (x > 768) then
		x  = 10
	end--]]

	if 
		x + 32 >= trub1x and x <= trub1x + 66 and
		y >= trub1y and y <= trub1y + 245 
		then 
		gameover = true
	end
	
	if	
		x + 32 >= trub2x and x <= trub2x + 66 and
		y >= trub2y and y <= trub2y + 245
		then 
		gameover = true
	end
	if y > 567 then
		gameover = true
	end
	
	if gameover == true then
		time = time - dt 
		y = y - vverh * dt
	end
	
	if gameover == true then
		recordtime = recordtime
	end
	
	if time >= recordtime then
		recordtime = time
	end
	
	if gameend == true then
		recordtime = recordtime  - dt
	end
	
end



function love.draw()
	
	--love.graphics.circle( "line", 20, 50, 25 )
	--love.graphics.circle( "fill", 120, 150, 25 )

	love.graphics.draw(phon, hon, 0)
	love.graphics.draw(phon, hon - 800)
	love.graphics.draw(truba, trub1x, trub1y)
	love.graphics.draw(truba2, trub2x, trub2y)

	love.graphics.draw(spr_smile, x, y)

	--[[if y > 500 then
		love.graphics.print ("you lose",200,500)
	end--]]
	
	if gameover == true then
		love.graphics.print ("highscore: "..recordtime, 563 , 5)
		love.graphics.print ("tries: "..try, 50 , 5)
	else
		love.graphics.print ("tries: "..try, 50 , 5)
		love.graphics.print ("highscore: "..recordtime, 563, 5)
	end
	

	
	if gameover == false then
		love.graphics.print ("score: "..time, 590, 25)
	else
		love.graphics.print ("score: "..time, 590, 25)
	end
	
	if gameover then
		love.graphics.print ("you lose", 380, 270  )
	end

end

function love.keypressed(key, unicode)

	if key == "space" then
		y = y - 60
	end
	
	if key == "r" then
		try = try + 1
		gameover = false
		gameend = true
	x = 180
	y = 240
	vremya = 0
	time = 0
	scorost = 100
	scorost2 = 150
	vverh = 100
	hon = 0
	trub1x = 0
	trub1y = 355
	trub2x = 0
	trub2y = 0
end

if gameover == true then
	
	if key == "space" then
		y = y + 60
	end
end
	--[[if key == "space" then
		x = 0
		y = 20
	end
	if key == "return" then
		x = 200
		y = 0
	end
	
	if key == "a" then
		x = 400
		y = 0400
end--]]


end

function love.keyreleased(key, unicode)
end

function love.mousepressed(x, y, button)

end

function love.mousereleased(x, y, button)
end

function love.wheelmoved( dx, dy )

end