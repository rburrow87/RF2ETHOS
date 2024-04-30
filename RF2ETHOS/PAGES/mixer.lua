local template = assert(loadScriptRF2ETHOS(radio.template))()

local labels = {}
local fields = {}

labels[#labels + 1] = {t = "Swashplate",label="line1", inline_size = 30}
fields[#fields + 1] = {t = "Geo correction", label = "line1", inline=1,min = -125, max = 125, vals = {19}, decimals = 1, scale = 5, step = 2}

labels[#labels + 1] = {t = "", label = "line2", inline_size = 30}
fields[#fields + 1] = {t = "Total pitch limit", label = "line2", inline=1, min = 0, max = 3000, vals = {10, 11}, decimals = 1, scale = 83.33333333333333, step = 1}

labels[#labels + 1] = {t = "", label = "line3", inline_size = 30}
fields[#fields + 1] = {t = "Phase angle", label = "line3", inline=1, min = -1800, max = 1800, vals = {8, 9}, decimals = 1, scale = 10}

labels[#labels + 1] = {t = "", label = "line4", inline_size = 30}
fields[#fields + 1] = {t = "TTA precomp", label = "line4", inline=1, min = 0, max = 250, vals = {18}}

labels[#labels + 1] = {t = "Swashplate link trims", label = "line5", inline_size = 30}
fields[#fields + 1] = {t = "Roll trim %", label = "line5", inline=1, min = -1000, max = 1000, vals = {12, 13}, decimals = 1, scale = 10}

labels[#labels + 1] = {t = "", label = "line6", inline_size = 30}
fields[#fields + 1] = {t = "Pitch trim %", label = "line6", inline=1, min = -1000, max = 1000, vals = {14, 15}, decimals = 1, scale = 10}

labels[#labels + 1] = {t = "", label = "line7", inline_size = 30}
fields[#fields + 1] = {t = "Coll. trim %", label = "line7", inline=1, min = -1000, max = 1000, vals = {16, 17}, decimals = 1, scale = 10}

labels[#labels + 1] = {t = "Motorised tail", label = "line8", inline_size = 30}
fields[#fields + 1] = {t = "Idle throttle%", label = "line8", inline=1, min = 0, max = 250, vals = {3}, decimals = 1, scale = 10, unit="%"}

labels[#labels + 1] = {t = "", label = "line9", inline_size = 30}
fields[#fields + 1] = {t = "Center trim", label = "line9", inline=1 , min = -500, max = 500, vals = {4, 5}, decimals = 1, scale = 10}

return {
    read = 42, -- MSP_MIXER_CONFIG
    write = 43, -- MSP_SET_MIXER_CONFIG
    eepromWrite = true,
    reboot = false,
    title = "Mixer",
    minBytes = 19,
    labels = labels,
    fields = fields
}