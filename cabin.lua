hostid = 11; -- id of main computer
protocol = "lift";

-- 11 управляющий
-- 12 кнопка 4 этаж
-- 13 кнопка 3 этаж
-- 14 кнопка 2 этаж
-- 15 кнопка 1 этаж

-- theme %theme% source %id% data %data%

id = os.getComputerID()

print("Cabin " .. id)

rednet.open("left")

while true do
    os.pullEvent("redstone")

    if (redstone.testBundledInput("back", colors.white)) then
        print("Button 1 pressed, sending message to " .. id)

        rednet.send(hostid, "theme cabin source " .. id .. " data 1", protocol)
    elseif (redstone.testBundledInput("back", colors.orange)) then
        print("Button 2 pressed, sending message to " .. id)

        rednet.send(hostid, "theme cabin source " .. id .. " data 2", protocol)
    elseif (redstone.testBundledInput("back", colors.magenta)) then
        print("Button 3 pressed, sending message to " .. id)

        rednet.send(hostid, "theme cabin source " .. id .. " data 3", protocol)
    elseif (redstone.testBundledInput("back", colors.lightBlue)) then
        print("Button 4 pressed, sending message to " .. id)

        rednet.send(hostid, "theme cabin source " .. id .. " data 4", protocol)
    end
end
