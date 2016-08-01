-- ТАБЛИЦЫ
local begin = {}
local flash = {}
local zlo = {}
local batman = {}
local pfon = {}
local time_jump = {}
local batarang = {}
-- ПЕРЕМЕННЫЕ
local rezhim = 1
local tim = 0
local tim_t_j = 0
local tim_br = 0
local tim_f_t_j = 0
--TRUE OR FALSE
showbegin = true
player1 = false
player2 = false
function love.load(arg)
	c = initgame()
		-- ЗАГРУЗКА ЕЛЕМЕНТОВ
		beginl = love.graphics.newImage ("begin.png")
		phon = love.graphics.newImage ("phon.png")	
		flashl = love.graphics.newImage ("flash.png")	
		batmanl = love.graphics.newImage("batman.png")
		hpf = love.graphics.newImage ("bathp.png")	
		batarangl = love.graphics.newImage ("batarang1.png")
end
function love.update ()
	if rezhim == 1 then
		showbegin = true
		player1 = false
		player2 = false
	end
	if rezhim == 2 then
		player1 = true
		showbegin = false
		player2 = false
	end
	if rezhim == 3 then
		player2 = true
		player1 = false
		showbegin = false
	end
end
function love.draw()
	-- ПРОРИСОВКА ЕЛЕМЕНТОВ
	love.graphics.draw(beginl, bnx, bny)
end
function love.mousepressed (x,y,button)
	if x > 233 and x < 543 and y > 134 and y < 207 then
		rezhim = 1
		initgame ()
	end
end
function initgame ()

	-- ТАБЛИЦА ЗАСТАВКИ
	if rezhim == 2 then
		begin[1] = {}
		begin[1].bnx = 0
		begin[1].bny = 0
	end
end	