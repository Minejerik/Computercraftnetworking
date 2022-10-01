if not fs.exists('IN_DATA') then
    fs.open('IN_DATA', 'w')
    fs.writeline('ININCNETWORKDATA')
    fs.close()
end
local x,y,z = gps.locate()
