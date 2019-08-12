function CalendarExport.debug(data, name)
  name = name or 'CalendarExport Debug Data'
  if ViragDevTool_AddData then
    ViragDevTool_AddData(data, name)
  elseif DevTools_Dump then
    print(name .. ":")
    DevTools_Dump(data)
  else
    print(data)
  end
end
