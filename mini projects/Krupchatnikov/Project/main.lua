local mur1 = {hp =  100, x = 200, y = 150}
math.randomseed(os.time())
local eda = {hp = 5,  x = 150, y = 150}

function love.load(arg)
 kap = love.graphics.newImage("sirop.png")
	fon = love.graphics.newImage("fon.png")
	image = love.graphics.newImage("working_ant.png")
end
function love.draw()
	love.graphics.draw(kap, eda.x, eda.y)
	love.graphics.draw(fon)
	love.graphics.draw(image, mur1.x, mur1.y)
end

function love.update(dt)
	if love.keyboard.isDown("up") then 
		mur1.y = mur1.y - 5
	end
	if love.keyboard.isDown("down") then 
		mur1.y = mur1.y + 5
	end
	if love.keyboard.isDown("left") then 
		mur1.x = mur1.x - 5
	end
	if love.keyboard.isDown("right") then 
		mur1.x = mur1.x + 5
	end
	end

function love.mousepressed(xm, ym, bottom)
	if xm > mur1.x and
	ym > mur1.y
	then 
		mur1.x = xm + 5 
		mur1.y = ym + 5 
	end
	if xm < mur1.x and
	ym < mur1.y
	then 
		mur1.x = xm - 5 
		mur1.y = ym - 5 
end
end