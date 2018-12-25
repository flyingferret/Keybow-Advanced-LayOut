require "keybow" --

-- setup colours --

function setup() -- Set custom lights up
    keybow.auto_lights(false)
    keybow.clear_lights()

	--create layout table to allow for layout switching --
	keybow.layouts = {}

	--create default layout keymap--
	--populate keymap table with default values --
	keybow.layouts["default"] = {}
	keybow.layouts["default"]["pressed_default_colour"] = {0,200,0}
	keybow.layouts["default"]["released_default_colour"] = {200,200,0}
	keymap1 = create_blank_keymap(keybow.layouts["default"]["pressed_default_colour"],keybow.layouts["default"]["released_default_colour"])

	--set customised properties of keymap --

	keymap1[10]["action"] = "anytext"
	keymap1[10]["pressed_colour"] = {255,0,0}
	keymap1[10]["released_colour"] = {0,0,255}

	keymap1[5]["action"] = keybow.tap_enter
	keymap1[5]["pressed_colour"] = {255,0,0}
	keymap1[5]["released_colour"] = {0,0,255}

	keymap1[0]["action"] = increase_red_released
	keymap1[0]["pressed_colour"] = {255,0,0}
	keymap1[1]["action"] = increase_green__released
	keymap1[1]["pressed_colour"] = {0,255,0}
	keymap1[2]["action"] = increase_blue_released
	keymap1[2]["pressed_colour"] = {0,0,255}
	keymap1[11]["action"] = next_layout

	--attache keymap to default layout --

	keybow.layouts["default"]["keymap"] = keymap1

	-- create additonal layouts and attach keymap to it --

	keybow.layouts["test"] = {}
	keybow.layouts["test"]["pressed_default_colour"] = {0,0,255}
	keybow.layouts["test"]["released_default_colour"] = {255,255,255}
	keymap2 = create_blank_keymap(keybow.layouts["test"]["pressed_default_colour"],keybow.layouts["test"]["released_default_colour"])
	keybow.layouts["test"]["keymap"] = keymap2

	-- Set selected layout --
	keybow.current_layout = keybow.layouts["default"]

	print("setup finished")

end


-- layout functions --

--generic key command using varibles from keybow.keymap table --
function generic_key_command(pressed,key_id)

	if pressed then
		layout = keybow.current_layout
		key = layout["keymap"][key_id]
		action = key["action"] -- temp varible for simplifaction of following arguments --


		-- Check what type action is and carry out the applicable action , if string usd keybow.text , if character use tab, if function carry out function --
		if type(action)=="string" then
			if string.len(action) > 1 then
				keybow.text(action)
			else
				keybow.tap_key(action)
			end
		elseif type(action)=="function" then
			action()
		end
		--set pixel colour to keymap pressed colour --
		keybow.set_pixel(key_id, key["pressed_colour"][1], key["pressed_colour"][2], key["pressed_colour"][3])

	else
		--set pixel colour to keymap released colour --
		keybow.set_pixel(key_id, key["released_colour"][1], key["released_colour"][2], key["released_colour"][3])

	end

end



--these functions allow for easy adjustment of default colours and outputs colour value --
function increase_red_released()
	colour_delta(keybow.current_layout["released_default_colour"],5,0,0)
end
function increase_green__released()
	colour_delta(keybow.current_layout["released_default_colour"],0,5,0)
end

function increase_blue_released()
	colour_delta(keybow.current_layout["released_default_colour"],0,0,5)
end


function increase_red_pressed()
	colour_delta(keybow.current_layout["pressed_default_colour"],5,0,0)
end
function increase_green__pressed()
	colour_delta(keybow.current_layout["pressed_default_colour"],0,5,0)
end
function increase_blue_pressed()
	colour_delta(keybow.current_layout["pressed_default_colour"],0,0,5)
end

function colour_delta(colour,rdelta,gdelta,bdelta)
	colour[1] = (colour[1] +rdelta)%255
	colour[2] = (colour[2] +gdelta)%255
	colour[3] = (colour[3] +bdelta)%255

	refesh_released()

end

-- refresh released colours of all keymap--
function refesh_released()
	keymap = keybow.current_layout["keymap"]
	for key_id=0,tablelength(keymap)-1,1
		do
		keybow.set_pixel(key_id, keymap[key_id]["released_colour"][1], keymap[key_id]["released_colour"][2], keymap[key_id]["released_colour"][3])
	end
end


-- helper functions --
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function create_blank_keymap(pressed_colour, released_colour)
	local keymap = {}
	for i=0,11,1
	do
		keymap[i] = {}
		keymap[i]["pressed_colour"] = pressed_colour
		keymap[i]["released_colour"] = released_colour
		keymap[i]["action"] = ""..i
	end
	keymap[11]["action"] = next_layout
	return keymap
end

function next_layout()
	local current_found =false
	local first_layout = nil
	for k,v in pairs(keybow.layouts)

		do

		if first_latout == nill then
			first_latout = keybow.layouts[k]
		end

		if current_found then
			keybow.current_layout  = keybow.layouts[k]

			local current_found =false
			local first_layout = nil
			keybow.sleep(500)
			refesh_released()
			return
		elseif keybow.layouts[k] == keybow.current_layout then
			current_found =  true
		end
	end

	keybow.current_layout = first_layout
	local current_found =false
	local first_layout = nil
	keybow.sleep(500)
	refesh_released()
end


-- Key mappings --

function handle_key_00(pressed)
		generic_key_command(pressed,0)
end

function handle_key_01(pressed)
		generic_key_command(pressed,1)
end

function handle_key_02(pressed)
		generic_key_command(pressed,2)
end

function handle_key_03(pressed)
		generic_key_command(pressed,3)
end

function handle_key_04(pressed)
		generic_key_command(pressed,4)
end

function handle_key_05(pressed)
		generic_key_command(pressed,5)
end

function handle_key_06(pressed)
		generic_key_command(pressed,6)
end

function handle_key_07(pressed)
		generic_key_command(pressed,7)
end

function handle_key_08(pressed)
		generic_key_command(pressed,8)
end

function handle_key_09(pressed)
		generic_key_command(pressed,9)
end

function handle_key_10(pressed)
		generic_key_command(pressed,10)
end

function handle_key_11(pressed)
		generic_key_command(pressed,11)
end
