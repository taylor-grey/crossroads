--TO DO











function love.load()

	--font and font size
	matrix = love.graphics.newFont("X.ttf", 20);

	--horizontal starting position (positive pushes right into the screen)
	x = 200 

	--vertical starting position (positive pushes down into the screen)
	y = 200 

end






--Initializing variables






--counts through the animation cycle to decide which frame to render
right_counter = 0

--the right stepping frame
right_frame_1 = false

--the right stepped frame
right_frame_2 = true

--counts the time whe love.update is called
time_passed = 0 

--time between cursor movements
delay = .25

--start in the standing animation
standing = true













function love.update(dt)

	--time passed counter
	time_passed = time_passed + dt

	--put character in standing position when not moving
	if right_step == false and left_left == false then 
		standing = true
	end

	--make the character wait between steps instead on continous sliding
	if time_passed > delay then 




		if love.keyboard.isDown("right") then

			--turn off standing sprite, switch to running sprite, and move right
			standing = false
			right_step = true



			--cycle through walk frames while moving right
			if right_counter > .5 and right_counter < 1.5 then
				right_frame_1 = true
				right_frame_2 = false
				x = x + 10

			end

			if right_counter > 1 and right_counter < 2 then
				right_frame_1 = false
				right_frame_2 = true
				x = x + 10

			end

			if right_counter > 1.5 then
				right_counter = 1
				right_frame_1 = true
				right_frame_2 = false
				x = x + 10

			end

			else

			--make sure that it doesn't get stuck in the step right animation, reset walk variables
			right_step = false
			right_frame_1 = false
			right_frame_2 = false
			right_counter = 0

		end

		--push the sprites through the walk animation while holding right
		right_counter = right_counter + .5






		if love.keyboard.isDown("left") then

			--turn of standing sprite, switch to running sprite, and move left
			standing = false
			left_step = true

			--cycle through walk frames while moving left
			if left_counter > .5 and left_counter < 1.5 then
				left_frame_1 = true
				left_frame_2 = false
				x = x - 10

			end

			if left_counter > 1 and left_counter < 2 then
				left_frame_1 = false
				left_frame_2 = true
				x = x - 10

			end

			if left_counter > 1.5 then
				left_counter = 1
				left_frame_1 = true
				left_frame_2 = false
				x = x - 10

			end

			else

			--make sure that it doesn't get stuck in the step left animation, reset walk variables
			left_step = true
			left_frame_1 = false
			left_frame_2 = true
			left_counter = 0

		end

		--push the sprites through the walk animation while holding left
		left_counter = left_counter + .5

		if right_step == false and left_left == false then 
			standing = true
		end




		time_passed = 0
		
	end
end
function love.draw()

	--sets the font to x.ttf
	love.graphics.setFont(matrix) 

	--logic to decide which sprite to render
	if standing == true then
		love.graphics.print(" o \n | \n | ", x, y)



	elseif right_frame_1 == true then
		love.graphics.print("  o \n ( \n )\\ ", x, y)

	elseif right_frame_2 == true then
		love.graphics.print(" o \n | \n | ", x, y)



	elseif left_frame_1 == true then
		love.graphics.print("o \n )\n/( ", x, y)

	elseif left_frame_2 == true then
		love.graphics.print(" o \n | \n | ", x, y)


	end
end