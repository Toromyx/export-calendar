SLASH_CALENDAREXPORT1 = "/calexp"

function printHelp()
    local events = CalendarExport.calendar.getAllEvents()
    print("Type '\\calexp x' with being x one of:")
    for i, event in ipairs(events) do
        print(i .. ": " .. event.title .. "(" .. event.startTime.hour .. ":" ..
                  event.startTime.minute .. ")")
    end
end

function SlashCmdList.CALENDAREXPORT(msg)
    local events = CalendarExport.calendar.getAllEvents()
    if (#events == 0) then
        print("There are no events today")
        return
    end
    if (msg == "") then
        printHelp()
    else
        local index = tonumber(msg)
        if (index and CalendarExport.calendar.getEvent(index)) then
            local event = CalendarExport.calendar.getEvent(index)
            local inviteList = CalendarExport.calendar.getInviteList(
                                   event.eventID)
            local csv = CalendarExport.csv.formatCsv(inviteList)
            CalendarExport.frames.export.fillContent(csv)
            CalendarExport.frames.export.show()
            CalendarExport.frames.export.selectAll()
        else
            print("No valid event index given")
            printHelp()
        end
    end
end
