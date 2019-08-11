function CalendarExport.debug(data, name)
  name = name or 'CalendarExport Debug Data'
  if ViragDevTool_AddData then
    ViragDevTool_AddData(data, name)
  else
    print(data)
  end
end
