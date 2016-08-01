-- ТАБЛИЦЫ
local flash = {}
local zlo = {}
local batman = {}
local pfon = {}
local time_jump = {}
local batarang = {}
--ПЕРЕМЕННЫЕ
local tim = 0
local tim_t_j = 0
local tim_br = 0
local tim_f_t_j = 0
--ФУНКЦИИ И ТД
function love.load(arg)
-- ТАБЛИЦА ФОНА
	pfon[1] = {}
	pfon[1].px = 0
	pfon[1].py = 0
-- ТАБЛИЦА ФЛЕША
	flash[1] = {}
	flash[1].fx = 50
	flash[1].fy = 400
	flash[1].speed = 30
	flash[1].hp = 10
	flash[1].hpfx = 0
	flash[1].hpfy = 0
	flash[1].atk = 1
	flash[1].atkx = 30
-- ТАБЛИЦА БЭТМЕНА
	batman[1] = {}
	batman[1].bx = 600
	batman[1].by = 400
	batman[1].speed = 2
	batman[1].hp = 10
	batman[1].hpbx = 500
	batman[1].hpby = 0
	batman[1].atk = 2
	batman[1].atkx = 60
-- ВРЕМЕННОЙ ПРЫЖОК
	time_jump[1] = {}
	time_jump[1].x = flash[1].fx 
	time_jump[1].y = flash[1].fy
	time_jump[1].hp = flash[1].hp
	time_jump[1].hpfx = flash[1].hpfx
-- ТАБЛИЦА БЭТАРАНГА
	batarang[1] = {}
	batarang[1].brx = batman[1].bx
	batarang[1].bry = batman[1].by
	batarang[1].speed = 250
	batarang[1].atk = 3
--ЗАГРУЗКА ЕЛЕМЕНТОВ
	phon = love.graphics.newImage ("phon.png")	
	flashl = love.graphics.newImage ("flash.png")	
	batmanl = love.graphics.newImage("batman.png")
	hpf = love.graphics.newImage ("bathp.png")	
	batarangl = love.graphics.newImage ("batarang1.png")
end

function love.update(dt)
	-- СЧЕТЧИКИ
-- СЧЕТЧИК ДЛЯ УДАРА БЭТМЕНА
	tim = tim + dt
-- СЧЕТЧИК ДЛЯ ПЕРЕМЕЩЕНИЯ ВО ВРЕМЕНИ
	tim_t_j = tim_t_j + dt 
-- СЧЕТЧИК ДЛЯ БЭТАРАНГА
	tim_br = tim_br + dt
-- СЧЕТЧИК ДЛЯ ПРЫЖКА ВО ВРЕСЕНИ (ОГРАНИЧИТЕЛЬ)
	tim_f_t_j = tim_f_t_j + dt
--ВРЕМЯ БЭТАРАНГА
	if tim_br >= 5 then
		showbatarang = false
		tim_br = 0
	end
-- ПРЫЖОК ВО ВРЕМЕНИ
	if tim_t_j >= 3 then
		time_jump[1].x = flash[1].fx 
		time_jump[1].y = flash[1].fy
		time_jump[1].hp = flash[1].hp
		time_jump[1].hpfx = flash[1].hpfx
		tim_t_j = 0
	end
-- УПРАВЛЕНИЕ
	if love.keyboard.isDown( "d" ) then
		flash[1].fx = flash[1].fx + flash[1].speed
	end
	if love.keyboard.isDown( "a" ) then
		flash[1].fx = flash[1].fx - flash[1].speed
	end
	if love.keyboard.isDown( "w" ) then
		flash[1].fy = flash[1].fy - flash[1].speed
	end
	if love.keyboard.isDown( "s" ) then
		flash[1].fy = flash[1].fy + flash[1].speed
	end
-- НЕ ВЫХОДИ ЗА РАМКИ
	if flash[1].fy < 300 then
		flash[1].fy = 300
	end
	if flash[1].fy > 500 then
		flash[1].fy = 500
	end
	if flash[1].fx > 760 then
		flash[1].fx = 760
	end
	if flash[1].fx < 0 then
		flash[1].fx = 0
	end
-- ПРЕСЛЕДОВАНИЕ БЭТМЕН
	if flash[1].fx < batman[1].bx then
		batman[1].bx = batman[1].bx - batman[1].speed
	end
	if flash[1].fx > batman[1].bx then
		batman[1].bx = batman[1].bx + batman[1].speed
	end
	if flash[1].fy < batman[1].by then
		batman[1].by = batman[1].by - batman[1].speed
	end
	if flash[1].fy > batman[1].by then
		batman[1].by = batman[1].by + batman[1].speed
	end
	-- БЭТАРАНГ
--ВЫПУСКАТЬ?
	if batman[1].bx > flash[1].fx then
		if batman[1].bx - flash[1].fx >= 400 then
			showbatarang = true

		end
	end
	if batman[1].bx < flash[1].fx then
		if flash[1].fx - batman[1].bx >= 400 then
			showbatarang = true
		end
	end
-- ПРЕСЛЕДОВАНИЕ БЭТАРАНГ
	if flash[1].fx > batarang[1].brx and showbatarang == true then
		batarang[1].brx = batarang[1].brx + batarang[1].speed * dt
	end
	if flash[1].fx < batarang[1].brx and showbatarang == true then
		batarang[1].brx = batarang[1].brx - batarang[1].speed * dt
	end	
	if flash[1].fy + 45 > batarang[1].bry and showbatarang == true then
		batarang[1].bry = batarang[1].bry + batarang[1].speed * dt
	end
	if flash[1].fy + 29 < batarang[1].bry and  showbatarang == true then
		batarang[1].bry = batarang[1].bry - batarang[1].speed * dt
	end
--ПОПАЛ БЭТОРАНГОМ?
	if flash[1].fx < batarang[1].brx + 42 and flash[1].fx > batarang[1].brx - 42 and flash[1].fy < batarang[1].bry + 35 and flash[1].fy > batarang[1].bry  and tim_br >= 2 then
		flash[1].hpfx = flash[1].hpfx - 90
		flash[1].hp = flash[1].hp - batarang[1].atk
		showbatarang = false
		tim_br = 6
	end
-- БЭТМЕН БЬЕТ ФЛЕША
	if batman[1].bx >= flash[1].fx - 58 and batman[1].bx <= flash[1].fx + 58 and flash[1].fy <= batman[1].by + 30 and flash[1].fy >= batman[1].by - 30 and tim >= 0.50 then
		flash[1].hpfx = flash[1].hpfx - batman[1].atkx
		flash[1].hp = flash[1].hp - batman[1].atk
		tim = 0
	end
	--СМЕРТЬ
-- СМЕРТЬ ФЛЕША
	if flash[1].hp <= 0 then
		flash[1].speed = 0
		batman[1].speed = 0
		flash[1].atk = 0
		batman[1].atk = 0
		flash[1].atkx = 0
		batman[1].atkx = 0
	end
-- СМЕРТЬ БЭТМЕНА	
	if batman[1].hp <= 0 then
		batman[1].speed = 0
		flash[1].speed = 0
		batman[1].atk = 0
		flash[1].atk = 0
		flash[1].atkx = 0
		batman[1].atkx = 0
	end
end

function love.draw()
-- ПРОРИСОВКА КАРТИНОК
	love.graphics.draw(phon, pfon[1].px, pfon[1].py)
	love.graphics.draw(flashl, flash[1].fx, flash[1].fy)
	love.graphics.draw(batmanl, batman[1].bx, batman[1].by)
	love.graphics.draw(hpf,	flash[1].hpfx, flash[1].hpfy)
	love.graphics.draw(hpf, batman[1].hpbx, batman[1].hpby)
-- УСЛОВИЯ ПРОРИСОВКИ БЭТАРАНГА
	if 	showbatarang == true then
		love.graphics.draw(batarangl,batarang[1].brx,batarang[1].bry)
	end
-- УСЛОВИЯ ПРОИГРЫША
	if batman[1].hp <= 0 then
		love.graphics.print("FLASH WIN!",0,570)
	end
	if flash[1].hp <= 0 then
		love.graphics.print("BATMAN WIN",0,570)
	end
end
function love.keypressed(key, unicode)
	-- КНОПКИ
-- УДАР
	if key == "f" and batman[1].bx >= flash[1].fx - 58 and batman[1].bx <= flash[1].fx + 58 and flash[1].fy <= batman[1].by + 30 and flash[1].fy >= batman[1].by - 30 then
		batman[1].hpbx = batman[1].hpbx + flash[1].atkx
		batman[1].hp = batman[1].hp - flash[1].atk
	end
-- ПРЫЖОК ВО ВРЕМЕНИ	
	if key == "e" then 
		flash[1].fx = time_jump[1].x 
		flash[1].fy = time_jump[1].y
		flash[1].hp = time_jump[1].hp
		flash[1].hpfx = time_jump[1].hpfx
		tim_f_t_j = 0
	end
-- ПАУЗА
	if key == "p" then
		batman[1].speed = 0
		flash[1].speed = 0
		batman[1].atk = 0
		flash[1].atk = 0
		flash[1].atkx = 0
		batman[1].atkx = 0
		batarang[1].speed = 0
		batarang[1].atk = 0
	end
-- ВОСПРОИЗВЕСТИ
	if key == "n" then
		batman[1].speed = 2
		flash[1].speed = 30
		batman[1].atk = 2
		flash[1].atk = 1
		flash[1].atkx = 30
		batman[1].atkx = 60
		batarang[1].speed = 250
		batarang[1].atk = 3
	end	
-- РЕСТАРТ
	if key == "r" then
		flash[1].fx = 50
		flash[1].fy = 400
		flash[1].speed = 30
		flash[1].hp = 10
		flash[1].hpfx = 0
		flash[1].hpfy = 0
		flash[1].atk = 1
		flash[1].atkx = 30
		batman[1].bx = 600
		batman[1].by = 400
		batman[1].speed = 2
		batman[1].hp = 10
		batman[1].hpbx = 500
		batman[1].hpby = 0
		batman[1].atk = 2
		batman[1].atkx = 60
		batarang[1].speed = 250
		batarang[1].atk = 3
		batarang[1].brx = batman[1].bx
		batarang[1].bry = batman[1].by
		showbatarang = false
	end
end
function love.mousepressed(x, y, button, isTouch)
	if x > batman[1].bx and x < batman[1].bx + 58 and y > batman[1].by and y < batman[1].by + 92 then
		batman[1].hp = batman[1].hp - 6
		batman[1].hpbx = batman[1].hpbx + 180
	end
end