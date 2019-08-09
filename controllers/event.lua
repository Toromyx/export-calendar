local eventFrame = CreateFrame("FRAME")
local events = {}

local function calendarUpdate()
    print('calendarUpdate()')
    if (CalendarExport.state.executeCallbackOnUpdate) then
        print('calling callback')
        CalendarExport.state.callback()
        CalendarExport.state.executeCallbackOnUpdate = false
    end
end

function events.CALENDAR_UPDATE_EVENT(self, ...) calendarUpdate() end

function events.CALENDAR_UPDATE_EVENT_LIST(self, ...) calendarUpdate() end

function events.CALENDAR_UPDATE_GUILD_EVENTS(self, ...) calendarUpdate() end

eventFrame:SetScript("OnEvent",
                     function(self, event, ...) events[event](self, ...) end)

for event, func in pairs(events) do eventFrame:RegisterEvent(event) end

