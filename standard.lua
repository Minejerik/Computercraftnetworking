local standard = {}


standard.tablecheck = function (table, element)
    for _, value in pairs(table) do
      if value == element then
        return true
      end
    end
    return false
end

--beans

standard.tablecheckline = function (table, element)
    for _, value in pairs(table) do
      if value == element then
				return _
      end
    end
    return false
end

standard.getlength = function (table)
  local count = 0
  for _ in pairs(table) do count = count + 1 end
  return count
end

standard.getstringlength = function (string)
  return string.len(string)
end

standard.printtable = function (table)
  for i = 1, standard.getlength(table), 1 do
    io.write(table[i].."\n")
  end
end

standard.getkeys = function (table)
  local keys={}
  for key,_ in pairs(table) do
    table.insert(keys, key)
  end
  return keys
end

standard.senderror = function (errmsg,quit,location)
	io.write("\n")
	io.write("FATAL ERROR\n")
	io.write(errmsg.."\n")
	io.write(location.."\n")
	if quit then
	os.exit()
end
end

standard.ingest = function (file)
   local f = io.open(file, "r")
   local lines = f:read("*all")
   f:close()
   return(lines)
end

standard.append = function (file,towright)
   local f = io.open(file, "a")
   io.output(f)
   io.write(towright)
   io.close(f)
end


standard.getline = function(fileName, name)
    local f = io.open(fileName, "r")
    local count = 1

    for line in f:lines() do
        if count == name then
            f:close()
            return line
        end
        count = count + 1
    end

    f:close()
    error("Not enough lines in file!")
end



-- see if the file exists
standard.file_exists = function(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
standard.getfiletable = function(file)
  if not Stand.file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

standard.getlinevalue = function (lineNum, fileName)
  local count = 0
  for line in io.lines(fileName) do
    count = count + 1
    if count == lineNum then return line end
  end
  error(fileName .. " has fewer than " .. lineNum .. " lines.")
end

standard.listdir =function(dir)
os.execute('ls')


  --[[ local p = io.popen('find "'..dir..'" -type f') 
   for file in p:lines() do
       print(file)
   end
	]]--
end

standard.setfileline = function(filea,text,line)

    local file = io.open(filea, 'r')
    local fileContent = {}
    for line in file:lines() do
        table.insert (fileContent, line)
    end
    io.close(file)

    fileContent[line] = text

    file = io.open(filea, 'w')
    for line, value in ipairs(fileContent) do
        file:write(value..'\n')
    end
    io.close(file)
end



local clock = os.clock
standard.sleep = function(n)
local t0 = clock()
while clock() - t0 <= n do end
end


return standard