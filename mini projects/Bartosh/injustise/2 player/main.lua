local x = 200
local y = 400

local px = 0
local py = 0

local fx = 600 
local fy = 400

local hpb = 10  
local hpf = 10

local hpbx = 0
local hpby = 0

local hpfx = 500
local hpfy = 0

local uronb = 2
local uronf = 1

local speedflash = 30
local speedbatman = 2

local waitudar = 0

local anim = 1
local batanim = 1

local tim = 0
local tim1 = 0
local tim2 = 6
local tim3 = 0

local txf = 0
local tyf = 0

local fsx = 647
local fsy = 26

local brx = 0
local bry = 0

local bsx = -153
local bsy = 26

local ssb = 10

local speedbr = 200

local showbatarang = false

local time_jump = {}

function love.load(arg)
	if arg[#arg] == "-debug" then
		require("mobdebug").start()
	end
	phon = love.graphics.newImage ("phon.png")
	batman1 = love.graphics.newImage ("batman.png")
	flash = love.graphics.newImage ("flash.png")
	bathp = love.graphics.newImage ("bathp.png")
	batman2 = love.graphics.newImage ("batman2.png")
	batman3 = love.graphics.newImage ("batman3.png")
	banim = {batman1, batman2, batman3} 
	flashs = love.graphics.newImage ("flashs.png")
	batarang1 = love.graphics.newImage ("batarang1.png")
	batarang2 = love.graphics.newImage ("batarang2.png")
	bataranim = {batarang1,batarang2}
	time_jump[1] = {}
	time_jump[1].x = fx
	time_jump[1].y = fy
	time_jump[1].hp = hpf
	time_jump[1].hpfx = hpfx
	
end

function love.update(dt)
		
		batanim = batanim + 1
		
		tim3 = tim3 + dt
		tim = tim + dt
		tim1 = tim1 + dt
		tim2 = tim2 + dt
		
	if batanim >= #bataranim then
		batanim = 1
	end
	
	if tim2 >= 3 then
		time_jump[1].x = fx
		time_jump[1].y = fy
		time_jump[1].hp = hpf
		time_jump[1].hpfx = hpfx
		tim2 = 0
	end
	
	if tim1 >= 3.5 then
		bsx = 0
		fsx = 647
		end
		
	if fx < brx + 42 and fx > brx - 42 and fy < bry + 35 and fy > bry - 35 and tim >= 5 then
		hpfx = hpfx + 90
		hpf = hpf - 3
		showbatarang = false
		tim1 = 0
		brx = 0
		bry = 0
	end
	
	if fx > brx and showbatarang == true then
		brx = brx + speedbr * dt
		end
    if fx < brx and showbatarang == true then
		brx = brx - speedbr * dt
	end	
	if fy + 45 > bry and showbatarang == true then
		bry = bry + speedbr * dt
	end
	if fy + 29 < bry and  showbatarang == true then
		bry = bry - speedbr * dt
	end
	if anim == #banim then 
		anim = 1
	end
	if batanim == #bataranim then 
		batanim = 1
	end
	if love.keyboard.isDown( "d" ) then
		x = x + speedbatman
		anim = anim + 1 
	end
	if love.keyboard.isDown( "a" ) then
		x = x - speedbatman
	end
	if love.keyboard.isDown( "w" ) then
		y = y - speedbatman
	end
	if love.keyboard.isDown( "s" ) then
		y = y + speedbatman
	end
	if fy < 376 then 
		fy = 376
	end
	if fx < 0 then 
		fx = 0
	end
	if fy > 505  then 
		fy = 505
	end
	if fx > 800 - 70 then 
		fx = 800 - 70
	end
	if love.keyboard.isDown( "right" ) then
		fx = fx + speedflash
	end
	if love.keyboard.isDown( "left" ) then
		fx = fx - speedflash
	end
	if love.keyboard.isDown( "up" ) then
		fy = fy - speedflash
	end
	if love.keyboard.isDown( "down" ) then
		fy = fy + speedflash
	end
	if y < 376 then 
		y = 376
	end
	if x < 0 then 
		x = 0
	end
	if y > 505  then 
		y = 505
	end
	if x > 800 - 70 then 
		x = 800 - 70
	end
	if hpb <= 0 or hpf <= 0 then 
		speedflash = 0 
		speedbatman = 0
	end

end
function love.draw()
	love.graphics.draw(phon, px, py)
	love.graphics.draw(banim[anim], x, y)
	love.graphics.draw(flash, fx, fy)
	love.graphics.draw(bathp, hpbx, hpby)
	love.graphics.draw(bathp,hpfx, hpfy)
	love.graphics.draw(bathp,hpfx, hpfy)
	love.graphics.draw(flashs,fsx,fsy)
	love.graphics.draw(flashs,bsx,bsy)
		if 	showbatarang == true then
	love.graphics.draw(bataranim[batanim],brx,bry)
	end
	
	if hpf <= 0 and speedbatman == 0 then
		love.graphics.print("Batman WIN!",0,580)
		uronb = 0
		uronf = 0
	end
	if hpb <= 0 and speedbatman == 0 then
		love.graphics.print("Flash WIN!",0,580)
		uronb = 0
		uronf = 0
	end
	function love.keypressed(key, unicode)
		if key == "e" and tim1 >= 3.5 then
			bsx = -153
			tim1 = 0
			showbatarang = true
			brx = x
			bry = y
			ssb = 0
			end
		if key == "/" and x >= fx - 58 and x <= fx + 58 and fy <= y + 30 and fy >= y - 30 then
			hpb = hpb - uronf
			hpbx = hpbx - 30
		end
		if key == "f" and x >= fx - 58 and x <= fx + 58 and fy <= y + 30 and fy >= y - 30  and tim >= 0.20 then
			hpf = hpf - uronb
			hpfx = hpfx + 60
			tim = 0
		end
		if key == "." then 
			fsx = 800
			fx = time_jump[1].x
			fy = time_jump[1].y
			hpf = time_jump[1].hp
			hpfx = time_jump[1].hpfx
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