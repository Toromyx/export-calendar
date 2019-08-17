local calendarService = {}

local function getFilteredEvents()
  local events = {}
  local currTime = C_DateAndTime.GetCurrentCalendarTime()
  local numEvents = C_Calendar.GetNumDayEvents(0, currTime.monthDay)
  for i = 1, numEvents do
    local event = C_Calendar.GetDayEvent(0, currTime.monthDay, i)
    if (event.calendarType == 'PLAYER' or event.calendarType == 'GUILD_EVENT' or event.calendarType == 'COMMUNITY_EVENT') then
      table.insert(events, event)
    end
  end
  return events
end

function calendarService.getEvent(eventIndex)
  return getFilteredEvents()[eventIndex]
end

function calendarService.getAllEvents()
  return getFilteredEvents()
end

function calendarService.getInviteList(eventID, callback)
  local list = {}
  local indexInfo = C_Calendar.GetEventIndexInfo(eventID)

  local eventOpened = function()
    local numInv = C_Calendar.GetNumInvites()
    for i = 1, numInv do
      local invite = C_Calendar.EventGetInvite(i)
      local inviteInList = { invite.name, CalendarUtil.GetCalendarInviteStatusInfo(invite.inviteStatus).name }
      list[i] = inviteInList
    end
    callback(list)
  end

  CalendarExport.eventService.subscribe('CALENDAR_OPEN_EVENT', eventOpened)
  C_Calendar.OpenEvent(indexInfo.offsetMonths, indexInfo.monthDay, indexInfo.eventIndex)
end

CalendarExport.calendarService = calendarService
