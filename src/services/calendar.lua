local calendar = {}

function getFilteredEvents()
  local events = {}
  local currTime = C_DateAndTime.GetCurrentCalendarTime()
  local numEvents = C_Calendar.GetNumDayEvents(0, currTime.monthDay)
  local eventIndex = 1
  for i = 1, numEvents do
    local event = C_Calendar.GetDayEvent(0, currTime.monthDay, i)
    if (event.calendarType == 'PLAYER' or event.calendarType == 'GUILD_EVENT' or event.calendarType == 'COMMUNITY_EVENT') then
      events[eventIndex] = event
      eventIndex = eventIndex + 1
    end
  end
  return events
end

function getInviteStatusString()
end

function calendar.getEvent(eventIndex)
  return getFilteredEvents()[eventIndex]
end

function calendar.getAllEvents()
  return getFilteredEvents()
end

function calendar.getInviteList(eventID)
  local list = {}

  local indexInfo = C_Calendar.GetEventIndexInfo(eventID)
  C_Calendar.OpenEvent(indexInfo.offsetMonths, indexInfo.monthDay, indexInfo.eventIndex)

  local numInv = C_Calendar.GetNumInvites()
  for i = 1, numInv do
    local invite = C_Calendar.EventGetInvite(i)
    local inviteInList = { invite.name, CALENDAR_INVITESTATUS_INFO[invite.inviteStatus].name }
    list[i] = inviteInList
  end

  return list
end

CalendarExport.calendar = calendar
