local eventService = {}

local eventFrame = CreateFrame('FRAME')
local events = {}

eventFrame:SetScript('OnEvent', function(_, event, ...)
  for _, func in pairs(events[event]) do
    func(...)
  end
end)

function eventService.subscribe(event, callback, multiple, isCorrectEvent)
  if (events[event] == nil) then
    events[event] = {}
    eventFrame:RegisterEvent(event)
  end
  local id = CalendarExport.uid()
  local callbackWrapper = function(...)

    local callbackAndUnsubscribe = function(...)
      callback(...)
      if not multiple then
        eventService.unsubscribe(event, id)
      end
    end

    if isCorrectEvent then
      if isCorrectEvent(...) then
        callbackAndUnsubscribe(...)
      end
    else
      callbackAndUnsubscribe(...)
    end
  end
  table.insert(events[event], id, callbackWrapper)
  return id
end

function eventService.unsubscribe(event, id)
  table.remove(events[event], id)
  if (#events[event] <= 0) then
    events[event] = nil
    eventFrame:UnregisterEvent(event)
  end
end

CalendarExport.eventService = eventService
