hostid = 11; -- id of main computer
protocol = "lift";

-- 11 управляющий
-- 12 кнопка 4 этаж
-- 13 кнопка 3 этаж
-- 14 кнопка 2 этаж
-- 15 кнопка 1 этаж

-- 20 кнопки в кабине

-- theme %theme% source %id%

id = os.getComputerID()

print("Button " .. id)

speaker = peripheral.find("speaker")
rednet.open("left")

while true do
    -- button is white redstone channel
    -- lift contact is orange redstone channel
    -- magenta is upper contact
    -- light blue is lower contact

    event, sender, message, receivedprotocol = os.pullEvent()

    if (event == "redstone") then
        if (redstone.testBundledInput("back", colors.white)) then
            print("Button pressed, sending message to " .. id)

            rednet.send(hostid, "theme button source " .. id, protocol)
        elseif (redstone.testBundledInput("back", colors.orange)) then
            print("Contact pressed, sending message to " .. id)

            rednet.send(hostid, "theme contact source " .. id, protocol)
        elseif (redstone.testBundledInput("back", colors.magenta)) then
            print("Upper contact pressed, sending message to " .. id)

            rednet.send(hostid, "theme uppercontact source " .. id, protocol)
        elseif (redstone.testBundledInput("back", colors.lightBlue)) then
            print("Lower contact pressed, sending message to " .. id)

            rednet.send(hostid, "theme lowercontact source " .. id, protocol)
        end
    elseif (event == "rednet_message") then
        if (receivedprotocol == "liftsound" and message == "play") then
            print("playing sound")

            for i = 10, 15, 2 do
                speaker.playNote("flute", 3.0, i)
                os.sleep(0.20)
            end
        end
    end
end
