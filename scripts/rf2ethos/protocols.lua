local supportedProtocols = {
    smartPort = {mspTransport = "msp/sp.lua", push = rf2ethos.sportTelemetryPush, maxTxBufferSize = 6, maxRxBufferSize = 6, maxRetries = 6, saveTimeout = 5.0, pageReqTimeout = 5},
    crsf = {mspTransport = "msp/crsf.lua", maxTxBufferSize = 8, maxRxBufferSize = 58, maxRetries = 3, saveTimeout = 3.0, pageReqTimeout = 2}
}

local function getProtocol()
    if system.getSource("Rx RSSI1") ~= nil then return supportedProtocols.crsf end
    return supportedProtocols.smartPort
end

return getProtocol()
