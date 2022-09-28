possible = {}
Stand = require('standard')
sha1 = require('sha')
Currentx = 120
Currenty = 50
Maxrange = 350

cc = {}
cc[1] = "1,1"
cc[2] = "13,160"
cc[3] = "10000,10000"
cc[4] = "323,592"
cc[5] = "244,81"
cc[6] = "-55,140"
cc[7] = "-677,973"

rc = {}
rc[1] = "120,100"
rc[2] = "-152,123"
rc[3] = "68,89"
rc[4] = "12,612"

rn = {}
rn[1] = 34
rn[2] = 37
rn[3] = 81
rn[4] = 21

function cleartable(t)
for k in pairs (t) do
    t [k] = nil
end
end

function max(a)
  local values = {}

  for k,v in pairs(a) do
    values[#values+1] = v
  end
  table.sort(values)

  return values[#values]
end

function checkmessagehash(message,hash)
local temp = sha1.hex(message)
if temp == hash then
return true
else
return false
end
end

function returnMin(t)
  local k
  for i, v in pairs(t) do
    k = k or i
    if v < t[k] then k = i end
  end
  return k
end


local temp
local temp2
local tempt = {}

function sendmessage(message,to)
print('sending '..message..' to '..to)
end


function distance( x1, y1, x2, y2 )
	return math.sqrt( (x2-x1)^2 + (y2-y1)^2 )
end

function finddistancetorelay(relaynum)
temp = string.find(rc[relaynum],",")
tempxc = tonumber(string.sub(rc[relaynum],0,temp - 1))
tempyc = tonumber(string.sub(rc[relaynum],temp + 1))
if distance(Currentx,Currenty,tempxc,tempyc) <= Maxrange then
table.insert(tempt,relaynum)
else
return
end
end

function finddistancefromrelay(relaynum,reciever)
temp = string.find(cc[reciever],",")
tempxc = tonumber(string.sub(cc[reciever],0,temp - 1))
tempyc = tonumber(string.sub(cc[reciever],temp + 1))
temp = string.find(rc[relaynum],",")
local dis = distance(tempxc,tempxc,tonumber(string.sub(rc[relaynum],0,temp - 1)),tonumber(string.sub(rc[relaynum],temp + 1)))
table.insert(tempt,dis)
table.insert(possible,relaynum)
end

function findrelay(reciever)
cleartable(tempt)
cleartable(possible)
for i = 1, Stand.getlength(rc), 1 do
finddistancetorelay(i)
end
temp = max(tempt)
temp2 = Stand.getlength(tempt)
cleartable(tempt)
for i = 1, temp2, 1 do
finddistancefromrelay(i,reciever)
end
temp = returnMin(tempt)
return rn[possible[temp]]
end

function main(input)
temp = string.find(input,",")
local reciever = tonumber(string.sub(input,0,temp - 1))
local message = string.sub(input,temp + 1)
temp = string.find(message,",")
local hash = string.sub(message,temp + 1)
message = string.sub(input,0,temp+1)
temp = string.find(input,",")
message = string.sub(message,temp + 1)
temp = string.find(cc[reciever],",")
tempxc = tonumber(string.sub(cc[reciever],0,temp - 1))
tempyc = tonumber(string.sub(cc[reciever],temp + 1))
local dis = distance(Currentx,Currenty,tempxc,tempyc)
if checkmessagehash(message,hash) == false then
return
end

if dis >= Maxrange then
print('finding relay')
temp = findrelay(reciever)
sendmessage(input,temp)
else
print('sending direct')
sendmessage(message..","..hash,reciever)
end
end
main("1,beans,"..sha1.hex('beans'))