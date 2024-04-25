local pages = {}
local sections = {}
-- Rotorflight pages.


sections[#sections + 1] = {title = "Flight Profiles" , section=1,open=true}
	pages[#pages + 1] = { title = "PIDs", section=1, script = "pids.lua" }
	pages[#pages + 1] = { title = "Governor", section=1,  script = "profile_governor.lua" }
	pages[#pages + 1] = { title = "Rescue", section=1, script = "profile_rescue.lua" }
	pages[#pages + 1] = { title = "PID Controller", section=1, subpage=1,script = "profile.lua" }
	pages[#pages + 1] = { title = "PID Controller Bandwidth", section=1, subpage=3,script = "profile.lua" }
	pages[#pages + 1] = { title = "Tail Rotor", section=1, subpage=2,script = "profile.lua" }
	pages[#pages + 1] = { title = "Main Rotor", section=1, subpage=4,script = "profile.lua" }
	pages[#pages + 1] = { title = "Auto Level", section=1, subpage=5,script = "profile.lua" }
	pages[#pages + 1] = { title = "Rates (NC)",section=1, script = "rates.lua" }

sections[#sections + 1] = {title = "General", section=2,open=false }
	pages[#pages + 1] = { title = "Governor", section=2, script = "governor.lua" }
	pages[#pages + 1] = { title = "Mixer", section=2, script = "mixer.lua" }
	pages[#pages + 1] = { title = "Filters", section=2, script = "filters.lua" }


sections[#sections + 1] = {title = "Hardware", section=3,open=false }
	pages[#pages + 1] = { title = "Servos (NC)", section=3,  script = "servos.lua" }
	pages[#pages + 1] = { title = "Accelerometer",section=3,  script = "accelerometer.lua" }

sections[#sections + 1] = {title = "Tools",section=4,open=false }
	pages[#pages + 1] = { title = "Copy profiles", section=4, script = "copy_profiles.lua" }

return {
	pages = pages,
	sections = sections
}