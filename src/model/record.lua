local loadsave = require( "src.util.loadsave" )

local storageName = "records.json"
local storedRecords = nil
local Record = {}

function Record.insert( value )
    Record.validateAndLoadRecords()
    table.insert( storedRecords, value )
    table.sort( storedRecords )
end

function Record.save()
    if ( storedRecords ) then
        while #storedRecords > 10 do
            table.remove( storedRecords, 1 )
        end
        loadsave.saveTable( storedRecords, storageName )
    end
end

function Record.load()
    return loadsave.loadTable( storageName )
end

function Record.validateAndLoadRecords()
    if ( not storedRecords ) then
        local loadedRecords = Record.load()
        if ( loadedRecords ) then
            storedRecords = loadedRecords
        else
            storedRecords = {}
        end
    end
end

return Record
