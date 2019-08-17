local csvService = {}

function csvService.formatCsv(table)
  local out = ''
  local numRows = #table
  for i, row in ipairs(table) do
    local numCols = #row
    for j, col in ipairs(row) do
      out = out .. col
      if (j < numCols) then
        out = out .. ','
      end
    end
    if (i < numRows) then
      out = out .. '\n'
    end
  end
  return out
end

CalendarExport.csvService = csvService
