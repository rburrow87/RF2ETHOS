local toolName = "HobbyWing"
moduleName = "RF2HW5"
moduleTitle = "HobbyWing ESC v0.42"

mspSignature = 0xFD
mspHeaderBytes = 2
mspBytes = 60 --

rf2ethos.config.apiVersion = 0
mcuId = nil

function getText(page, st, en)
    if page.values == nil then
        return ""
    end

    local tt = {}
    for i = st, en do
        local v = page.values[i + mspHeaderBytes]
        if v == 0 then
            break
        end
        table.insert(tt, string.char(v))
    end
    return table.concat(tt)
end

function getPageValue(page, index)
    return page.values[mspHeaderBytes + index]
end

function setPageValue(page, index, value)
    page.values[mspHeaderBytes + index] = value
end

return {toolName = toolName, powerCycle = false, mspSignature = mspSignature, mspHeaderBytes = mspHeaderBytes, mspBytes = mspBytes}
