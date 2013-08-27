-------------------------------------------------------------------------------
-- A car (not really an animal...) for Mob Framework by Sapier
-- Model by Zeg9
-- adopted for mobf by Sokomine (based on animal_rat by Sapier)
-------------------------------------------------------------------------------
minetest.log("action","MOD: mobf_car mod loading ...")

local version = "0.0.1"

local car_groups = {
						not_in_creative_inventory=1
					}

--local selectionbox_car = {-0.5, -0.05, -1.85, 1.3, 0.7, 1.25};
local selectionbox_car = {-1.85, -0.05, -0.5, 1.25, 0.7, 1.3};



get_car_prototype = function( color )
  return {
		name="car_"..color,
		modname="mobf_car",
	
		generic = {
					description= color.." car",
					base_health=2,
					kill_result="",
					armor_groups= {
						fleshy=90,
					},
					groups = car_groups,
					envid="on_ground_1",
				},
		movement =  {
					min_accel=0.4,
					max_accel=0.6,
					max_speed=0.2,
					min_speed=0.1,
					pattern="run_and_jump_low",
					canfly=false,
					},
		catching = {
					tool="animalmaterials:lasso", -- TODO: catch with a glass
					consumed=true,
					},
		spawning = {
					rate=0.02,
					density=250,
					algorithm="forrest_mapgen",
					height=2
					},
                                        {
                                        rate=0.01,
                                        density=250,
                                        algorithm="shadows_spawner",
                                        height=1,
                                        respawndelay = 120,
                                        },

		sound = {
					},
		animation = {

				walk = {
					start_frame = 0,
					end_frame   = 1,
					},
				stand = {
					start_frame = 0,
					end_frame   = 1,
					},
			},
                ride = {
                                        walkspeed  = 20,
                                        sneakspeed = 10,
                                        jumpspeed  = 5,
                                        attacheoffset = { x=0,y=2,z=0},
--                                        texturemod = "^mob_ostrich_ostrich_saddle_mesh.png",
                                        walk_anim = "walk"
                        },

		states = {

				{
					name = "default",
					movgen = "none",
					typical_state_time = 40,
					chance = 0,
					animation = "stand",
					graphics = { 
--						sprite_scale={x=4,y=4},
--						sprite_div = {x=6,y=1},
--						visible_height = 1.5, -- TODO
						},
					graphics_3d = {
						visual = "mesh",
						mesh = "car_270.obj", -- TODO: right one?
						textures = {"textur_"..color..".png"}, -- TODO: several colors
						collisionbox = selectionbox_car,
--						visual_size= {x=2,y=2,z=2}, --TODO
						},
				},
				{ 
					name = "walking",
					custom_preconhandler = nil,
					movgen = "probab_mov_gen",
					typical_state_time = 10,
					chance = 0.20,
					animation = "walk"
				},
			}
		}
end
		
	
local car_colors = {'red','orange','yellow', 'green', 'cyan', 'blue', 'violet', 'magenta',
                    'pink', 'brown', 'dark_green',
                    'white', 'grey', 'dark_grey', 'black'
                    };


for i,c in ipairs( car_colors ) do

   local car_prototype = get_car_prototype( c );

   minetest.log("action","\tadding animal "..car_prototype.name)

   mobf_add_mob(car_prototype)
end

minetest.log("action","MOD: mobf_car mod           version " .. version .. " loaded")
