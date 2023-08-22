floorid = {}
floorid[15] = 1 -- ids of floor computers
floorid[14] = 2
floorid[13] = 3
floorid[12] = 4

idfloor = {}
idfloor[1] = 15
idfloor[2] = 14
idfloor[3] = 13
idfloor[4] = 12

-- 11 управляющий
-- 12 кнопка 4 этаж
-- 13 кнопка 3 этаж
-- 14 кнопка 2 этаж
-- 15 кнопка 1 этаж

-- theme %theme% source %id%

protocol = "lift";

id = os.getComputerID()

print("Host " .. id)

rednet.open("right")

lastcontact = 2
lastbutton = 1

running = false

while true do
    id, message = rednet.receive(protocol)

    print(("Computer %d sent message %s"):format(id, message))

    value = {}
    n = 0

    for v in message:gmatch("%S+") do
        n = n + 1
        value[n] = v
    end

    theme = value[2]
    source = tonumber(value[4])


    print("theme" .. theme)
    print("source" .. source)

    if (theme == "contact" or theme == "button" or theme == "uppercontact" or theme == "lowercontact") then
        if (theme == "contact") then
            lastcontact = floorid[source]
        elseif (theme == "button") then
            if (not running) then
                lastbutton = floorid[source]
            end
        end
    end

    if (theme == "cabin") then
        cabinfloor = tonumber(value[6])

        if (not running) then
            lastbutton = cabinfloor
        end
    end

    print("lastcontact" .. lastcontact)
    print("lastbutton" .. lastbutton)

    -- white is reverse
    -- orange is clutch
    -- magente and light blue is double rpm

    -- if reverse off - elevator up
    -- if reverse on - elevator down

    if (lastcontact == lastbutton) then
        redstone.setBundledOutput("back", colors.orange)
        running = false;

        rednet.send(idfloor[lastcontact], "play", "liftsound")

        print("lift stop")
    end

    if (lastcontact < lastbutton) then
        if (theme == "lowercontact" and floorid[source] == lastbutton) then
            redstone.setBundledOutput("back", 0)
            print("lift go up on slow speed")
        else
            redstone.setBundledOutput("back", colors.combine(colors.magenta, colors.lightBlue))
            print("lift go up on full speed")
        end

        running = true;
    end

    if (lastcontact > lastbutton) then
        if (theme == "uppercontact" and floorid[source] == lastbutton) then
            redstone.setBundledOutput("back", colors.white)
            print("lift go down on slow speed")
        else
            redstone.setBundledOutput("back", colors.combine(colors.magenta, colors.lightBlue, colors.white))
            print("lift go down on full speed")
        end

        running = true;
    end
end
