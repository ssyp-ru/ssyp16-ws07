--local xo =400
--local yo =300
local dor = {}
local nemr = false
local sul = 0
local rege = 0 -- Режем игры.(На будощие)
local ugadal = false
--проигрыш 
local neu = false
--
local kud = {}
local novr = false
local shot = 0
local zvuk = true
local a = 1
local b = 6

zvuk_1 = love.audio.newSource( "Bell.ogg" )
zvuk_2 = love.audio.newSource( "Crash.ogg" )
zvuk_3 = love.audio.newSource( "Darkness2.ogg" )

math.randomseed(os.time())
function love.load(arg)
	for i = 1, 3 do
		dor[i] = love.graphics.newImage("dor.png")
	end
	--подсказки
	kud[1] = "1,->>,<-;2,<-,->>."
	kud[2] = "3,<<-;1,->>,<-,->."
	kud[3] = "1,->>,<-;2,<-,->>,<<-."
	kud[4] = "2,->;3,<<-,->."
	kud[5] = "3,<<-,->>;2,<-,->>,<<-."
	kud[6] = "2,->,<<-;3,<<-,->."
	--kud[7] = "3,\,|;2,/,\\,/,|."
	--kud[8] = "2,V;3,W."
	--kud[9] = "3,<<-,->>;2,<-,->>,<<-."
	--
	fon= love.graphics.newImage("fon.png")
	priv= love.graphics.newImage("previved.png")
	otlad= love.graphics.newImage("otach.png")
	pst= love.graphics.newImage("psst.png")
	kill = love.graphics.newImage("you.png")
	zvuch = love.graphics.newImage("zvuc.png")
	sul = sluch(a,b)
end

function love.update(dt)
	time = love.timer.getTime()
	--новый раунд
	if novr == true then
		if isTime() then
			novr = false 
			sul = sluch(a,b)
			ugadal = false
		end
	end
end
	function sluch (a,b  )
		num = math.random(b, a)
		return num
	end
	
	function love.draw()
		--  рисует фон  и  двери
		love.graphics.draw(fon, 0, 0)
		love.graphics.draw(dor[1],15 ,80 )
		love.graphics.draw(dor[2],280 ,80 )
		love.graphics.draw(dor[3],545 ,80 )
		--love.graphics.draw(otlad, xo, yo)
		--love.graphics.print(xo..","..yo, xo, yo+32)

		if sul == 1 and ugadal or sul == 4 and ugadal then
			love.graphics.draw(pst,15 ,80 )
			setTimer(10)
			novr = true
		end

		if sul == 2 and ugadal or sul == 5 and ugadal then
			love.graphics.draw(pst,280 ,80 )
			setTimer(10)
			novr = true
		end
		if sul == 3 and ugadal or sul == 6 and ugadal then
			love.graphics.draw(pst,545 ,80 )
			setTimer(10)
			novr = true
		end
        if neu and sul == 1 or neu and sul == 4 then
			love.graphics.draw(priv,545 ,80 )
			love.graphics.draw(priv,280 ,80 )
			love.graphics.draw(kill,150 ,80 )
		end
		 if neu and sul == 2 or neu and sul == 5  then
			love.graphics.draw(priv,15 ,80 ) 
			love.graphics.draw(priv,545 ,80 )
			love.graphics.draw(kill,150 ,80 )
		end
		 if neu and sul == 3 or neu and sul == 6  then
			love.graphics.draw(priv,280 ,80 ) 
			love.graphics.draw(priv,15 ,80 )
			love.graphics.draw(kill,150 ,80 )
		end
		if sul == 1 then
			love.graphics.print(kud[1],350,60)
		elseif sul == 4 then
			love.graphics.print(kud[4],350,60)
		end
		if sul == 2  then
			love.graphics.print(kud[2],350,60)
			elseif sul == 5 then
			love.graphics.print(kud[5],350,60)
		end
		if sul == 3 then
			love.graphics.print(kud[3],350,60)
			elseif sul == 6 then
			love.graphics.print(kud[6],350,60)
		end
		
		love.graphics.print("you shot:"..shot,10,580)
	end
	function love.keypressed(key, unicode)
		--[[if key == "up" then
		yo = yo-20
	end
	if key == "down" then
		yo = yo+20
	end
		if key == "left" then
		xo = xo-20
	end
	if key == "right" then
		xo = xo+20
	end]]--
	--открыть дверь 
	if key == "1" and neu == false then
		love.audio.play( zvuk_1 )
		if sul == 1 or sul == 4 then
			ugadal = true
			if novr == false then
				shot = shot + 1
			end
		elseif novr == false then
			neu = true
		end
	end
	if key == "2" and neu == false then
		love.audio.play( zvuk_2 )
		if sul == 2 or sul == 5 then
			ugadal = true
			if novr == false then
				shot = shot + 1
			end
		elseif novr == false then
			neu = true
		end
	end
	if key == "3"and neu == false then
		love.audio.play( zvuk_3 )
		if sul == 3 or sul == 6 then
			ugadal = true
			if novr == false then
				shot = shot + 1
			end
		elseif novr == false then
			neu = true
		end
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

local my_timer = love.timer.getTime()
-- задать таймер на 10 секунд: setTimer(10)
function setTimer(seconds)
	my_timer = love.timer.getTime() + seconds
end

--проверить, сработал ли таймер?
-- if isTime() then
--		print("сработал таймер!")
--else
--		print("еще не сработал таймер")
--end
function isTime()
	if my_timer > love.timer.getTime() then
		return true
	else
		return false
	end
end