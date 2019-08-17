SLASH_CALENDAREXPORT1 = '/calexp'

function printHelp()
  local events = CalendarExport.calendarService.getAllEvents()
  print("Type '/calexp x' with being x one of:")
  for i, event in ipairs(events) do
    print(i .. ': ' .. event.title .. ' (' .. GameTime_GetFormattedTime(event.startTime.hour, event.startTime.minute) .. ')')
  end
end

function SlashCmdList.CALENDAREXPORT(msg)
  local events = CalendarExport.calendarService.getAllEvents()
  if (#events == 0) then
    print('There are no events today')
    return
  end
  if (msg == '') then
    printHelp()
  else
    local index = tonumber(msg)
    if (index and CalendarExport.calendarService.getEvent(index)) then
      local event = CalendarExport.calendarService.getEvent(index)

      local showInviteList = function(inviteList)
        local csv = CalendarExport.csvService.formatCsv(inviteList)
        CalendarExport.frames.export.fillContent(csv)
        CalendarExport.frames.export.show()
        CalendarExport.frames.export.selectAll()
      end

      CalendarExport.calendarService.getInviteList(event.eventID, showInviteList)
    else
      print('No valid event index given')
      printHelp()
    end
  end
end
