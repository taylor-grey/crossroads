

function love.load()


	--font and font size (do it here because love.draw will load it repeatedly)
	matrix = love.graphics.newFont("X.ttf", 30)


	--sizes of the ascii pixels
	ascii_pixel = {}

	ascii_pixel.x = 18

	ascii_pixel.y = 30


	--variables that govern the player object
	player = {}

	player_appear = false

	--horizontal starting position (positive pushes right into the screen)
	player.x = ascii_pixel.x * 17

	--vertical starting position (positive pushes down into the screen)
	player.y = ascii_pixel.y * 11.155



	--list of location names With the coordinates of where to put their backgrounds
	title = {}

	title.x = ascii_pixel.x * 11

	title.y = ascii_pixel.y * 7


	crossroads = {}

	crossroads.x = ascii_pixel.x * 18

	crossroads.y = ascii_pixel.y * 5


	outside_house = {}

	outside_house.x = ascii_pixel.x * 0

	outside_house.y = ascii_pixel.y * 4.3


	inside_house =  {}

	inside_house.x = ascii_pixel.y * 0

	inside_house.y = ascii_pixel.y * 1


	--position of the smoke animation
	smoke_x = ascii_pixel.x * 0

	smoke_y = ascii_pixel.y * 2


	--list of collision detectors
	outside_house_threshold = ascii_pixel.x * 16

	inside_house_threshold = ascii_pixel.x * 30

	bed = ascii_pixel.x * 17


	--this variable loads the specified scene on startup
	location = title

end


--Initializing variables


--counts the time when love.update is called
time_passed = 0 

--time between ascii frames
delay = .25

--counts trhough the frames of the smoke animation
smoke_counter = 0


function love.update(dt)


	if player_appear == false then
		
		player.right_frame_1 = false

		player.right_frame_2 = false

		player.right_run_frame_1 = false
	
		player.right_run_frame_2 = false

		player.left_frame_1 = false

		player.left_frame_2 = false

		player.left_run_frame_1 = false
	
		player.left_run_frame_2 = false

	end


	if love.keyboard.isDown("return") then

		location = inside_house
	
	end


	if location ~= title then

		player_appear = true

		standing = true

	end

	if love.keyboard.isDown("f") then

		standing = false

		player_appear = true

	end

	if love.keyboard.isDown("d") then

		standing = false

		player_appear = true

	end

	if love.keyboard.isDown("a") then

		standing = false

		player_appear = true

	end

	if love.keyboard.isDown("capslock") then

		standing = false

		player_appear = true


	end


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

			player.x = player.x + ascii_pixel.x

		end

	end


	--times frame by frame animations and makes player movement pixellated to the ascii matrix instead of sliding
	if time_passed > delay then 

		if love.keyboard.isDown("d") then

			--turn off standing sprite, switch to right walking sprite
			standing = false

			player.right_step = true

			--cycle through right walking frames while moving right
			if player.right_counter > .5 and player.right_counter < 1.5 then

				player.right_frame_1 = true

				player.right_frame_2 = false
			
				player.x = player.x + ascii_pixel.x

			end

			if player.right_counter > 1 and player.right_counter < 2 then

				player.right_frame_1 = false

				player.right_frame_2 = true

				player.x = player.x + ascii_pixel.x

			end

			if player.right_counter > 1.5 then
	
				player.right_counter = 1
	
				player.right_frame_1 = true
	
				player.right_frame_2 = false
	
				player.x = player.x + ascii_pixel.x

			end

			else

			--making sure that the frames transition properly by resetting variables
			player.right_step = false
	
			player.right_frame_1 = false
	
			player.right_frame_2 = false
	
			player.right_counter = 0
	
			--for some reason the player will be invisible while standing if I don't set standing to true here :/ idk why

		end


		--pushing the sprites through the right stepping animation
		player.right_counter = player.right_counter + .5


		if love.keyboard.isDown("f") then

			--turn off standing and stepping sprite, switch to running sprite
			standing = false

			player.right_frame_1 = false

			player.right_frame_2 = false

			player.right_run = true

			--cycle through right running frames while moving right (twice the distance per fram as walking)
			if player.right_run_counter > .5 and player.right_run_counter < 1.5 then
		
				player.right_run_frame_1 = true
		
				player.right_run_frame_2 = false
		
				player.x = player.x + ascii_pixel.x * 2

			end

			if player.right_run_counter > 1 and player.right_run_counter < 2 then

				player.right_run_frame_1 = false

				player.right_run_frame_2 = true

				player.x = player.x + ascii_pixel.x * 2

			end

			if player.right_run_counter > 1.5 then

				player.right_run_counter = 1

				player.right_run_frame_1 = true

				player.right_run_frame_2 = false

				player.x = player.x + ascii_pixel.x * 2

			end

			else

			--making sure that the frames transition properly by resetting variables
			player.right_run = false
	
			player.right_run_frame_1 = false
	
			player.right_run_frame_2 = false
	
			player.right_run_counter = 0

		end


		--push the sprites through the walk animation while holding right
		player.right_run_counter = player.right_run_counter + .5


		if love.keyboard.isDown("a") then

			--turn off standing sprite, switch to left walking sprite
			standing = false
	
			player.left_step = true

			--cycle through left walking frames while moving left
			if player.left_counter > .5 and player.left_counter < 1.5 then

				player.left_frame_1 = true

				player.left_frame_2 = false

				player.x = player.x - ascii_pixel.x

			end

			if player.left_counter > 1 and player.left_counter < 2 then

				player.left_frame_1 = false

				player.left_frame_2 = true

				player.x = player.x - ascii_pixel.x

			end

			if player.left_counter > 1.5 then

				player.left_counter = 1

				player.left_frame_1 = true

				player.left_frame_2 = false

				player.x = player.x - ascii_pixel.x

			end

			else

			--making sure that the frames transition properly by resetting variables
			player.left_step = true

			player.left_frame_1 = false

			player.left_frame_2 = false

			player.left_counter = 0

		end


		--push the sprites through the left walking animation
		player.left_counter = player.left_counter + .5


		if love.keyboard.isDown("capslock") then

			--turn off standing sprite and walking sprites, switch to left running sprite
			standing = false

			player.left_run = true

			player.left_frame_1 = false

			player.left_frame_2 = false

			--cycle through left runnning frames while moving left (twice the distance per fram as walking)
			if player.left_run_counter > .5 and player.left_run_counter < 1.5 then

				player.left_run_frame_1 = true

				player.left_run_frame_2 = false

				player.x = player.x - ascii_pixel.x * 2

			end

			if player.left_run_counter > 1 and player.left_run_counter < 2 then

				player.left_run_frame_1 = false

				player.left_run_frame_2 = true

				player.x = player.x - ascii_pixel.x * 2

			end

			if player.left_run_counter > 1.5 then
	
				player.left_run_counter = 1
	
				player.left_run_frame_1 = true
	
				player.left_run_frame_2 = false
	
				player.x = player.x - ascii_pixel.x * 2

			end

			else

			--making sure that the frames transition properly by resetting variables
			player.left_run = false
	
			player.left_run_frame_1 = false
	
			player.left_run_frame_2 = false
	
			player.left_run_counter = 0

		end


		--push the sprites through the left running animation
		player.left_run_counter = player.left_run_counter + .5


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
		smoke_counter = smoke_counter + delay


		--reset time passed clock so the player has to wait for the delay before moving another ascii pixel
		time_passed = 0


	end

end


function love.draw()

	--sets the font based on the variable "matrix" set in love.load
	love.graphics.setFont(matrix) 


	--logic to decide which player sprite to render


if location == title then
	love.graphics.print("C r o s s r o a d s\n\n\n\n\n\n     E N T E R",title.x, title.y)

end	


-------------------------------------------------------------

	--STANDING

	if standing == true then
		love.graphics.print("\n o\n |\n |",player.x, player.y)

--looks like this

--[[

 o
 |
 |

]]--

-------------------------------------------------------------

	--RIGHT WALKING

	elseif player.right_frame_1 == true then
		love.graphics.print("\n  o\n (\n |)",player.x, player.y)

--looks like this

--[[

 o
(
|)

]]--

	elseif player.right_frame_2 == true then
		love.graphics.print("\n  o\n (\n.|",player.x, player.y)

--looks like this

--[[

  o
 (
.|

]]--

-------------------------------------------------------------

	--RIGHT RUNNING

	elseif player.right_run_frame_1 == true then
		love.graphics.print("\n  o\n /\n/>",player.x, player.y)

--looks like this

--[[

  o
 /
/>

]]--

	elseif player.right_run_frame_2 == true then
		love.graphics.print("\n  o\n (\n/",player.x, player.y)

--looks like this

--[[

  o
 (
/

]]--

-------------------------------------------------------------

	--LEFT WALKING

	elseif player.left_frame_1 == true then
		love.graphics.print("\no\n )\n |.",player.x, player.y)

--looks like this

--[[

o
 )
 |.

]]--

	elseif player.left_frame_2 == true then
		love.graphics.print("\no\n )\n(|",player.x, player.y)

--looks like this

--[[

o
 )
(|

]]--

-------------------------------------------------------------

	--LEFT RUNNING

	elseif player.left_run_frame_1 == true then
		love.graphics.print("\no\n \\\n <\\",player.x, player.y)

--looks like this

--[[

o
 \
 <\

]]--

	elseif player.left_run_frame_2 == true then
		love.graphics.print("\no\n )\n  \\",player.x, player.y)

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
		love.graphics.print("\n____/'‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾'\\\n|‾‾| '                             ' \\\n|  |  .                           .   \\\n|  |                                   \\\n(  )   ,                         ,      \\\n|  |    ,                       ,       |\n|  |    +- -   -     -   -  - - +       |\n|  |    |                       | _.,   |\n|  |    |                       |:  |   |\n|  |    ;~.~~--~|               ||. |   |\n|  |   |_/_____||~  ~          ~'|  |   |\n|  |__,|_______|                  \\ |   |\n|  ) ,|                            '|   |\n|‾‾‾| |                              \\  |\n|   |,'                               '.|\n ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾",inside_house.x, inside_house.y)


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
		love.graphics.print("\n     ________\n __ ////////_\\\n ||///////// \\\\\n ||////////   \\\\\n /////////     \\\\\n ‾| _  _‾|  __ |‾\n  ||+||+|| |  ||\n  | ‾  ‾ | | .||\n,.|      | |  ||\n \"\',\" \"\'\'.,\n    \'      \'",outside_house.x, outside_house.y)

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
		love.graphics.print("\n(   )\n (  )\n( )\n ()",smoke_x, smoke_y)

--looks like this

--[[

(   )
 (  )
( )
 ()

]]--

	elseif smoke_frame_2 == true then
		love.graphics.print("\n (   )\n(  )\n ( )\n ()",smoke_x, smoke_y)

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
		love.graphics.print("\n<=#=>\n  |\n  |\n,.|, .\n '\" ",crossroads.x, crossroads.y)

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
