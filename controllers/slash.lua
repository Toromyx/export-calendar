SLASH_CALENDAREXPORT1 = "/calexp"

local function updated() CalendarExport.calendar.getAllEvents() end

function SlashCmdList:CALENDAREXPORT(msg)
    print('calexp slash command')
    CalendarExport.state.callback = function()
        print('calling update method')
        updated()
    end
    CalendarExport.state.executeCallbackOnUpdate = true
    C_Calendar.OpenCalendar()
end
