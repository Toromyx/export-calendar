local export = {}
local frame = CalendarExport_ExportFrame
local content = CalendarExport_ExportFrame_Content

function export.show()
  frame:SetPoint('CENTER', 0, 0)
  frame:Show()
end

function export.fillContent(text)
  content:SetText(text)
end

function export.selectAll()
  content:SetFocus()
  content:HighlightText()
end

CalendarExport.frames.export = export
