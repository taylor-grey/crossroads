

function love.load()


	--font and font size (do it here because love.draw will load it repeatedly)
	matrix = love.graphics.newFont("X.ttf", 30)



	--variables that govern the player object
	player = {}

	--horizontal starting position (positive pushes right into the screen)
	player.x = 0

	--vertical starting position (positive pushes down into the screen)
	player.y = 330



	--list of location names With the coordinates of where to put their backgrounds
	crossroads = {}

	crossroads.x = 324

	crossroads.y = 155


	outside_house = {}

	outside_house.x = 0

	outside_house.y = 125


	inside_house =  {}

	inside_house.x = 0

	inside_house.y = 30


	--position of the smoke animation
	smoke_x = 0

	smoke_y = 30


	--list of collision detectors
	outside_house_threshold = 288

	inside_house_threshold = 540

	bed = 306


	--this variable loads the specified scene on startup
	location = inside_house

end


--Initializing variables


--counts the time when love.update is called
time_passed = 0 

--time between ascii frames
delay = .25

--counts trhough the frames of the smoke animation
smoke_counter = 0


function love.update(dt)


	--time passed counter for use in timing ascii frames
	time_passed = time_passed + dt


	--this block defines what scene collisions will do what
	if location == outside_house then

		smoke = true

		if player.x < outside_house_threshold then

			location = inside_house

			player.x = inside_house_threshold

		end

	elseif location == inside_house then

		smoke = false

		if player.x > inside_house_threshold then

			location = outside_house

			player.x = outside_house_threshold

		end

		if player.x < bed then

			player.x = player.x + 18

		end

	end


	--times frame by frame animations and makes player movement pixellated to the ascii matrix instead of sliding
	if time_passed > delay then 

		if love.keyboard.isDown("d") then

			--turn off standing sprite, switch to right walking sprite
			standing = false

			right_step = true

			--cycle through right walking frames while moving right
			if right_counter > .5 and right_counter < 1.5 then

				right_frame_1 = true

				right_frame_2 = false
			
				player.x = player.x + 18

			end

			if right_counter > 1 and right_counter < 2 then

				right_frame_1 = false

				right_frame_2 = true

				player.x = player.x + 18

			end

			if right_counter > 1.5 then
	
				right_counter = 1
	
				right_frame_1 = true
	
				right_frame_2 = false
	
				player.x = player.x + 18

			end

			else

			--making sure that the frames transition properly by resetting variables
			right_step = false
	
			right_frame_1 = false
	
			right_frame_2 = false
	
			right_counter = 0
	
			--for some reason the player will be invisible while standing if I don't set standing to true here :/ idk why
			standing = true

		end


		--pushing the sprites through the right stepping animation
		right_counter = right_counter + .5


		if love.keyboard.isDown("f") then

			--turn off standing and stepping sprite, switch to running sprite

			standing = false

			right_frame_1 = false

			right_frame_2 = false

			right_run = true

			--cycle through right running frames while moving right (twice the distance per fram as walking)
			if right_run_counter > .5 and right_run_counter < 1.5 then
		
				right_run_frame_1 = true
		
				right_run_frame_2 = false
		
				player.x = player.x + 36

			end

			if right_run_counter > 1 and right_run_counter < 2 then

				right_run_frame_1 = false

				right_run_frame_2 = true

				player.x = player.x + 36

			end

			if right_run_counter > 1.5 then

				right_run_counter = 1

				right_run_frame_1 = true

				right_run_frame_2 = false

				player.x = player.x + 36

			end

			else

			--making sure that the frames transition properly by resetting variables
		
			right_run = false
	
			right_run_frame_1 = false
	
			right_run_frame_2 = false
	
			right_run_counter = 0

		end


		--push the sprites through the walk animation while holding right
		right_run_counter = right_run_counter + .5


		if love.keyboard.isDown("a") then

			--turn off standing sprite, switch to left walking sprite
			standing = false
	
			left_step = true

			--cycle through left walking frames while moving left
			if left_counter > .5 and left_counter < 1.5 then

				left_frame_1 = true

				left_frame_2 = false

				player.x = player.x - 18

			end

			if left_counter > 1 and left_counter < 2 then

				left_frame_1 = false

				left_frame_2 = true

				player.x = player.x - 18

			end

			if left_counter > 1.5 then

				left_counter = 1

				left_frame_1 = true

				left_frame_2 = false

				player.x = player.x - 18

			end

			else

			--making sure that the frames transition properly by resetting variables
			left_step = true

			left_frame_1 = false

			left_frame_2 = false

			left_counter = 0

		end


		--push the sprites through the left walking animation
		left_counter = left_counter + .5


		if love.keyboard.isDown("capslock") then

			--turn off standing sprite and walking sprites, switch to left running sprite
			standing = false

			left_run = true

			left_frame_1 = false

			left_frame_2 = false

			--cycle through left runnning frames while moving left (twice the distance per fram as walking)
			if left_run_counter > .5 and left_run_counter < 1.5 then

				left_run_frame_1 = true

				left_run_frame_2 = false

				player.x = player.x - 36

			end

			if left_run_counter > 1 and left_run_counter < 2 then

				left_run_frame_1 = false

				left_run_frame_2 = true

				player.x = player.x - 36

			end

			if left_run_counter > 1.5 then
	
				left_run_counter = 1
	
				left_run_frame_1 = true
	
				left_run_frame_2 = false
	
				player.x = player.x - 36

			end


			else

			--making sure that the frames transition properly by resetting variables
			left_run = false
	
			left_run_frame_1 = false
	
			left_run_frame_2 = false
	
			left_run_counter = 0

		end


		--push the sprites through the left running animation
		left_run_counter = left_run_counter + .5


		if smoke == true then

			--cycle through smoke frames
			if smoke_counter > 0 and smoke_counter < 1 then
				smoke_frame_1 = true
				smoke_frame_2 = false

			end

			if smoke_counter > 1 and smoke_counter < 2 then
				smoke_frame_1 = false
				smoke_frame_2 = true
				smoke_counter = 0

			end

			else 
				--kills the smoke animation if smoke != true
				smoke_counter = 0
				smoke_frame_1 = false
				smoke_frame_2 = false

		end


		--pushes through the smoke frame count bit by bit everytime time_passed > delay
		smoke_counter = smoke_counter + .25


		--reset time passed clock so the player has to wait for the delay before moving another ascii pixel
		time_passed = 0


	end

end


function love.draw()

	--sets the font based on the variable "matrix" set in love.load
	love.graphics.setFont(matrix) 


	--logic to decide which player sprite to render


-------------------------------------------------------------

	--STANDING

	if standing == true then
		love.graphics.print(" o\n |\n |",player.x, player.y)

--looks like this

--[[

 o
 |
 |

]]--

-------------------------------------------------------------

	--RIGHT WALKING

	elseif right_frame_1 == true then
		love.graphics.print("  o\n (\n |)",player.x, player.y)

--looks like this

--[[

 o
(
|)

]]--

	elseif right_frame_2 == true then
		love.graphics.print("  o\n (\n.|",player.x, player.y)

--looks like this

--[[

  o
 (
.|

]]--

-------------------------------------------------------------

	--RIGHT RUNNING

	elseif right_run_frame_1 == true then
		love.graphics.print("  o\n /\n/>",player.x, player.y)

--looks like this

--[[

  o
 /
/>

]]--

	elseif right_run_frame_2 == true then
		love.graphics.print("  o\n (\n/",player.x, player.y)

--looks like this

--[[

  o
 (
/

]]--

-------------------------------------------------------------

	--LEFT WALKING

	elseif left_frame_1 == true then
		love.graphics.print("o\n )\n |.",player.x, player.y)

--looks like this

--[[

o
 )
 |.

]]--

	elseif left_frame_2 == true then
		love.graphics.print("o\n )\n(|",player.x, player.y)

--looks like this

--[[

o
 )
(|

]]--

-------------------------------------------------------------

	--LEFT RUNNING

	elseif left_run_frame_1 == true then
		love.graphics.print("o\n \\\n <\\",player.x, player.y)

--looks like this

--[[

o
 \
 <\

]]--

	elseif left_run_frame_2 == true then
		love.graphics.print("o\n )\n  \\",player.x, player.y)

--looks like this

--[[

o
 )
  \

]]--

-------------------------------------------------------------

	end


	--logic deciding which background elements to render in which area


-------------------------------------------------------------

	-- INSIDE HOUSE

  	if location == inside_house then
		love.graphics.print("____/'‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾'\\\n|‾‾| '                             ' \\\n|  |  .                           .   \\\n|  |                                   \\\n(  )   ,                         ,      \\\n|  |    ,                       ,       |\n|  |    +- -   -     -   -  - - +       |\n|  |    |                       | _.,   |\n|  |    |                       |:  |   |\n|  |    ;~.~~--~|               ||. |   |\n|  |   |_/_____||~  ~          ~'|  |   |\n|  |__,|_______|                  \\ |   |\n|  ) ,|                            '|   |\n|‾‾‾| |                              \\  |\n|   |,'                               '.|\n ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾",inside_house.x, inside_house.y)


--looks like this

--[[

 __ /'‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾'\
|‾‾| '                             ' \
|  |  .                           .   \
|  |                                   \
(__)   ,                         ,      \   
|  |    ,                       ,     .-| 
|  |''-.+- -   -     -   -  - - +.-''‾  |
|  |    |                       | _.,   |
|  |    |                       |:  |   |
|  |    ;~.~~--~|               ||. |   |
|  |   |_/ _ __||~  ~          ~'|  |   |
|  |__,|_ ___ _|                  \ |   |
|  ) ,|                            '|   |
|‾‾‾| |                              \  |
|   |,'                               '.|
 ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

 ]]--


	end

-------------------------------------------------------------

	--OUTSIDE HOUSE

	if location == outside_house then
		love.graphics.print("     ________\n __ ////////_\\\n ||///////// \\\\\n ||////////   \\\\\n /////////     \\\\\n ‾| _  _‾|  __ |‾\n  ||+||+|| |  ||\n  | ‾  ‾ | | .||\n,.|      | |  ||\n \"\',\" \"\'\'.,\n    \'      \'",outside_house.x, outside_house.y)

--looks like this

--       ________
--   __ ////////_\
--   ||///////// \\
--   ||////////   \\
--   /////////     \\
--   ‾| _  _‾|  __ |‾
--    ||+||+|| |  ||
--    | ‾  ‾ | | .||
--  ,.|      | |  ||
--   "'," "''.,    
--      '      '

  	end

-------------------------------------------------------------

  	--CHIMNEY SMOKE

	if smoke_frame_1 == true then
		love.graphics.print("(   )\n (  )\n( )\n ()",smoke_x, smoke_y)

--looks like this

--[[

(   )
 (  )
( )
 ()

]]--

	elseif smoke_frame_2 == true then
		love.graphics.print(" (   )\n(  )\n ( )\n ()",smoke_x, smoke_y)

--looks like this

--[[

 (   )
(  )
 ( )
 ()

]]--

	end

-------------------------------------------------------------

	--CROSSROADS

	if location == crossroads then
		love.graphics.print("<=#=>\n  |\n  |\n,.|, .\n '\" ",crossroads.x, crossroads.y)

--looks like this

--[[

<=#=>
  |
  |
,.|, .
 '"

]]--

	end

-------------------------------------------------------------

end