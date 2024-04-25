local template = assert(loadScript(radio.template))()

local labels = {}
local fields = {}


labels[#labels + 1] = { t = "",       }
labels[#labels + 1] = { t = "",       }
labels[#labels + 1] = { t = "ROLL",   }
labels[#labels + 1] = { t = "PITCH",  }
labels[#labels + 1] = { t = "YAW",    }
labels[#labels + 1] = { t = "COL",    }


labels[#labels + 1] = { t = "RC",     }
labels[#labels + 1] = { t = "Rate",   }
fields[#fields + 1] = {              min = 0, max = 255, vals = { 2 }, scale = 100 }
fields[#fields + 1] = {              min = 0, max = 255, vals = { 8 }, scale = 100 }
fields[#fields + 1] = {              min = 0, max = 255, vals = { 14 }, scale = 100 }
fields[#fields + 1] = {              min = 0, max = 255, vals = { 20 }, scale = 100 }


labels[#labels + 1] = { t = "Super",  }
labels[#labels + 1] = { t = "Rate",   }
fields[#fields + 1] = {              min = 0, max = 100, vals = { 4 }, scale = 100 }
fields[#fields + 1] = {              min = 0, max = 100, vals = { 10 }, scale = 100 }
fields[#fields + 1] = {              min = 0, max = 255, vals = { 16 }, scale = 100 }
fields[#fields + 1] = {              min = 0, max = 255, vals = { 22 }, scale = 100 }


labels[#labels + 1] = { t = "RC",     }
labels[#labels + 1] = { t = "Expo",   }
fields[#fields + 1] = {              min = 0, max = 100, vals = { 3 }, scale = 100 }
fields[#fields + 1] = {              min = 0, max = 100, vals = { 9 }, scale = 100 }
fields[#fields + 1] = {              min = 0, max = 100, vals = { 15 }, scale = 100 }
fields[#fields + 1] = {              min = 0, max = 100, vals = { 21 }, scale = 100 }


fields[#fields + 1] = { t = "Rates Type",          min = 0, max = 5,      vals = { 1 }, table = { [0] = "NONE", "BETAFL", "RACEFL", "KISS", "ACTUAL", "QUICK"}, postEdit = function(self) self.updateRatesType(self, true) end }


labels[#labels + 1] = { t = "Roll dynamics",        }
fields[#fields + 1] = { t = "Response time",       min = 0, max = 250,   vals = { 5 } }
fields[#fields + 1] = { t = "Max acceleration",    min = 0, max = 50000, vals = { 6,7 },   scale = 0.1 }
labels[#labels + 1] = { t = "Pitch dynamics",       }
fields[#fields + 1] = { t = "Response time",       min = 0, max = 250,   vals = { 11 } }
fields[#fields + 1] = { t = "Max acceleration",    min = 0, max = 50000, vals = { 12,13 }, scale = 0.1 }
labels[#labels + 1] = { t = "Yaw dynamics",         }
fields[#fields + 1] = { t = "Response time",       min = 0, max = 250,   vals = { 17 } }
fields[#fields + 1] = { t = "Max acceleration",    min = 0, max = 50000, vals = { 18,19 }, scale = 0.1 }
labels[#labels + 1] = { t = "Collective dynamics",  }
fields[#fields + 1] = { t = "Response time",       min = 0, max = 250,   vals = { 23 } }
fields[#fields + 1] = { t = "Max acceleration",    min = 0, max = 50000, vals = { 24,25 }, scale = 0.1 }

return {
    read        = 111, -- MSP_RC_TUNING
    write       = 204, -- MSP_SET_RC_TUNING
    title       = "Rates",
    reboot      = false,
    eepromWrite = true,
    minBytes    = 25,
    labels      = labels,
    fields      = fields,
    ratesType,
    getRatesType = function(self)
        for i = 1, #self.fields do
            if self.fields[i].vals and self.fields[i].vals[1] == 1 then
                return self.fields[i].table[self.fields[i].value]
            end
        end
    end,
    updateRatesType = function(self, applyDefaults)
        local ratesTable = assert(loadScript("/scripts/RF2/RATETABLES/"..self.getRatesType(self)..".lua"))()
        for i = 1, #ratesTable.labels do
            self.labels[i].t = ratesTable.labels[i]
        end
        for i = 1, #ratesTable.fields do
            for k, v in pairs(ratesTable.fields[i]) do
                self.fields[i][k] = v
            end
        end
        if applyDefaults and self.ratesType ~= self.getRatesType(self) then
            for i = 1, #ratesTable.defaults do
                local f = self.fields[i]
                f.value = ratesTable.defaults[i]
                for idx=1, #f.vals do
                    self.values[f.vals[idx]] = math.floor(f.value*(f.scale or 1) + 0.5) >> (idx-1)*8
                end
            end
        else
            for i = 1, 12 do
                local f = self.fields[i]
                f.value = 0
                for idx=1, #f.vals do
                    local raw_val = self.values[f.vals[idx]] or 0
                    raw_val = raw_val << (idx-1)*8
                    f.value = f.value | raw_val
                end
                f.value = f.value/(f.scale or 1)
            end
        end
        self.ratesType = self.getRatesType(self)
    end,
    postLoad = function(self)
        self.updateRatesType(self)
    end,
}