--Мастерская #7, ЛШЮП 2016
-- симулятор муравейника

math.randomseed(os.time())

function switchFullScreen()
	if FULL_SCREEN then
		FULL_SCREEN = not love.window.setFullscreen( false )
	else
		FULL_SCREEN = love.window.setFullscreen( true )
	end
end
--камера
gamera = require "gamera"
Camera = require "camera"
mainCamera = Camera:new(2000, 2000)


-- ТАБЛИЦЫ
local mur = {}
local mur_v2 = {}
local phon = {}
local murav = {}
-- ПЕРЕМННЫЕ
local max_colvo_mur = 10
local minx = 10000
local miny = 10000
local minx2 = 10000
local miny2 = 10000
local p_eda = 3
local p_soldat = 1
local p_rab = 4
local p_koroleva = 6
-- TRUE OR FALSE

function love.load(arg)
	-- ЗАГРУЗКА ЕЛЕМЕНТОВ
	spr_soldat = love.graphics.newImage ("soldier.png")
	spr_rab = love.graphics.newImage ("working_ant.png")
	spr_koroleva = love.graphics.newImage ("koroleva.png")
	phonl = love.graphics.newImage ("k.png")
	--muraveynikl = love.graphics.newImage ("murav.png")
	spr_eda = love.graphics.newImage ("kaplya.png")
-- ТАБЛИЦЫ 
-- ТАБЛИЦА ФОНА
	phon[1] = {}
	phon[1].x = 0
	phon[1].y = 0
-- ТАБЛИЦА МУРАВЕЙНИКА

--KOROLEVA
	for k = 1,2 do
		i = #mur + 1
		mur[i] = {}
		mur[i].ugol = (i-1)*math.pi
		mur[i].speed = 0
		mur[i].atk = math.random(100,150)
		mur[i].hp = math.random(600,900)
		mur[i].vrag = 0
		mur[i].prof = p_koroleva
		if i == 1 then
			mur[i].id = 1
			mur[i].x = math.random(50,80)
			mur[i].y = math.random(50,80)
		else
			mur[i].id = 2 
			mur[i].x = math.random(800-150,800-100)
			mur[i].y = math.random(600-100,600-150)
		end

	end
-- ТАБЛИЦА МУРАВЬЯ SOLD
	for k = 1,max_colvo_mur do
		i = #mur + 1
		mur[i] = {}
		mur[i].ugol = 0
		mur[i].speed = math.random(5,50)
		mur[i].atk = math.random(5,10)
		mur[i].hp = math.random(300,600)
		mur[i].vrag = 0
		mur[i].prof = p_soldat
		if i > max_colvo_mur / 2  then
			mur[i].id = 1
			mur[i].x = math.random(1,200)
			mur[i].y = math.random(1,700)
		else
			mur[i].id = 2
			mur[i].x = math.random(600,800)
			mur[i].y = math.random(100,690)
		end

	end

	for k = 1,30 do
		spawnRab(id)
	end 

	for k = 1,30 do
		spawnEda()
	end

end

function love.update(dt)
	mainCamera:update(dt, mur[3].x, mur[3].y)
	--ИНОГДА ПОЯВЛЯЕТСЯ ЕДА
	if math.random(10) <= 1 then 
		spawnEda()
	end
-- БЛИЖАЙШИЙ МУРАВЕЙ
	local vrag_id = 0
	local vrag = 0
	for i = 1,#mur do
		if mur[i].prof == p_soldat then
			if mur[i].id == 1 then
				vrag_id = 2
			else 
				vrag_id = 1
			end
		elseif mur[i].prof == p_rab then
			vrag_id = 0
		end
		vrag = FCO(i,vrag_id)
		if vrag > 0 then 
			mur[i].vrag = vrag
		elseif vrag_id == 2 then
			--	print("net zheltih")
		else 
			--	print("net sinih")
		end
	end
-- ПРЕСЛЕДОВАНИЕ
-- ПРЕСЛЕДОВАНИЕ ЕДЫ
	for i = 1,#mur do
		if (mur[i].prof == p_rab 
			or mur[i].prof == p_soldat)
		and mur[i].vrag then 
			local v = mur[mur[i].vrag]
			if v.x > mur[i].x + 10 then
				mur[i].x = mur[i].x + mur[i].speed * dt
				mur[i].ugol = math.pi * 0
			end
			if v.x < mur[i].x - 10 then
				mur[i].x = mur[i].x - mur[i].speed * dt
				mur[i].ugol = math.pi * 1
			end
			if v.y > mur[i].y + 10 then
				mur[i].y = mur[i].y + mur[i].speed * dt
				--mur[i].ugol = math.pi * 0
			end
			if v.y < mur[i].y - 10 then
				mur[i].y = mur[i].y - mur[i].speed * dt
				--mur[i].ugol = math.pi * 0
			end
		end
	end
-- НЕ ВЫХОДИ ЗА РАМКИ МУРАВЕЙ
	for i = 1,#mur do
		mur[i].x = norm( mur[i].x, 800 )
		mur[i].y = norm( mur[i].y, 600 )
	end
-- АТАКА
	for i = 1,#mur do
		--АТАКА СОЛДАТАМИ
		if mur[i].prof == p_soldat or mur[i].prof == p_koroleva then 
			local v = mur[mur[i].vrag]
			if mur[i].x - 10 < v.x 
			and mur[i].x + 10 > v.x 
			and mur[i].y - 10 < v.y 
			and mur[i].y + 10 > v.y then
				--mur[i].hp = mur[i].hp - v.atk	
				v.hp = v.hp - mur[i].atk	
			end
		elseif mur[i].prof == p_rab then
			--ПОЕДАНИЕ ЕДЫ
		local v = mur[mur[i].vrag]
			if v then
				if mur[i].x - 10 < v.x 
					and mur[i].x + 10 > v.x 
					and mur[i].y - 10 < v.y 
					and mur[i].y + 10 > v.y
					and v.hp > 0
				then
					--mur[i].hp = mur[i].hp - v.atk
					v.hp = v.hp - mur[i].atk
					if v.hp <= 0 then
						--У КОРОЛЕВ НОМЕРА 1 и 2
						mur[mur[i].id].hp = mur[mur[i].id].hp + 100 
						spawnRab(mur[i].id)
					end
				end	
			end
		end
	end
-- СМЕРТЬ МУРАВЬЯ 
	for i = 1,#mur do
		if mur[i].id == 1 or mur[i].id == 2 or mur[i].id == 1 or mur[i].id == 4 or mur[i].id == 5 or mur[i].id == 6 then 
			if mur[i].hp <= 0 then
--[[			mur_v[i].x = 0
			mur_v[i].y = 0 --]]
				mur[i].speed = 0
				mur[i].atk = 0
			end
		end
	end
end

function love.draw()
	mainCamera:draw(function(l, t, w, h)

			local spr = spr_koroleva
			local ox = 0
			local oy = 0
-- ПРОРИСОВКА ЕЛЕМЕНТОВ
			love.graphics.setColor(255,255,255)
			love.graphics.draw (phonl, phon[1].x, phon[1].y)
-- ПРОРИСОВКА МУРАВЬЕВ 	
			for i = 1,#mur do
				if mur[i].prof == p_soldat then 	
					spr = spr_soldat
					ox = 14
					oy = 14
				elseif mur[i].prof == p_rab then
					spr = spr_rab
					ox = 12
					oy = 12
				elseif mur[i].prof == p_eda then
					-- ПРОРИСОВКА ЕДЫ 
					spr = spr_eda
					ox = 12
					oy = 12
				elseif mur[i].prof == p_koroleva then
					spr = spr_koroleva
					ox = 64
					oy = 64
				end

				if mur[i].hp > 0 then
					if mur[i].hp <= 15 then
--						РАНЕН (КРАСНЫЙ)
						love.graphics.setColor(255,0,0)
						love.graphics.draw (spr, mur[i].x + math.random(-5,5), mur[i].y + math.random(-5,5), mur[i].ugol, 1,1, ox, oy)
					else
						if mur[i].id == 1 then
						--СИНИЕ
							love.graphics.setColor(0,11,150)
						else
						--ЖЕЛТЫЕ
							love.graphics.setColor(255,251,45)
						end
					end
					if mur[i].prof== p_koroleva then
						love.graphics.circle("line", mur[i].x, mur[i].y, 50 + mur[i].hp/100)
						love.graphics.draw (spr, mur[i].x, mur[i].y, mur[i].ugol, 1,1, ox, oy)
					else
						love.graphics.draw (spr, mur[i].x, mur[i].y, mur[i].ugol, 1,1, ox, oy)
					end

				end
			end

		end)
end

function love.keypressed(key,unicode)
end

function norm(x, norma)
	local nx = x
	if x > norma then
		nx = norma
	end
	if x < 0 then
		nx = 0
	end
	return nx
end

-- dist = getDist( mur_v[i], mur_v2[k] )
function getDist(m1,m2)
	return math.sqrt((m1.x - m2.x)*(m1.x - m2.x) + (m1.y - m2.y)*(m1.y - m2.y))
end

--НАЙТИ БЛИЖАЙШИЙ ОБЬЕКТ ПО ID
-- i - номер муравья, для которого сравнивают всех остальнх
function FCO(i, id)
	local n = -1
	local dist = 100000
	local minDist = 100000
	for k = 1,#mur do
		if i ~= k and (mur[k].id == id) and mur[k].hp > 0 then
			dist = getDist(mur[i], mur[k])
			if dist <= minDist then
				minDist = dist
				n = k
			end
		end
	end
	return n
end

function spawnEda()
	local i = #mur + 1
	mur[i] = {}
	mur[i].prof = p_eda
	mur[i].id = 0
	mur[i].hp = 100
	mur[i].atk = 0
	mur[i].x = math.random(100,700)
	mur[i].y = math.random(100,500)
end
function spawnRab(id)
	local i = #mur + 1
	local x = 0
	local y = 0
	mur[i] = {}
	mur[i].prof = p_rab
	mur[i].id = id or math.random(1,2)
	mur[i].hp = 100
	mur[i].speed = math.random(5,50)
	mur[i].atk = 5

	if id then
		--ЕСЛИ ПЕРЕДАЕМ ИД, ТО БЕРЕМ КООРДИНАТЫ КОРОЛЕВЫ
		mur[i].x = mur[id].x
		mur[i].y = mur[id].y
	else
		mur[i].x = math.random(200,600)
		mur[i].y = math.random(200,400)
	end
end

--[[ function colrab ()
	if

function spawnKogoMalo(id)
	if --]]

function love.keypressed(k)
	if k == "f11" then
		switchFullScreen()
	end
end

function love.wheelmoved( dx, dy )

        if dy > 0 and mainCamera:getScale() < 5 then
            mainCamera:setScale(mainCamera:getScale() + 0.25 )
        elseif dy < 0 and mainCamera:getScale() > 0.01 then
            mainCamera:setScale(mainCamera:getScale() - 0.25 )
        end

end