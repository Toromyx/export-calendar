-- this a stupid implementation which just counts up, works for my purposes
local counter = 0

function CalendarExport.uid()
  counter = counter + 1
  return tostring(counter)
end
