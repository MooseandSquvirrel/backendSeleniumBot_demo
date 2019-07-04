def timestampB71(bandsArray)
    band = bandsArray[0]
    # MINUS 8 FOR SOUTH KOREA TIME ZONE
    minutes1 = Time.now.strftime '%M'
    puts "minutes1 #{minutes1}"
    minutes2 = ((minutes1.to_i) + 1).to_s
    puts "minutes2 #{minutes2}"
    tmpHours = ((Time.now.strftime '%H').to_i - 8).to_s
    puts "tmpHours : #{tmpHours}"
    band.hoursMinutesB71_backUp = "#{tmpHours}:#{minutes2}"
    hoursMinutesB71 = "#{tmpHours}:#{minutes1}"
end

def timestampB3(bandsArray)
    band = bandsArray[0]
    # MINUS 8 FOR SOUTH KOREA TIME ZONE
    minutes1 = Time.now.strftime '%M'
    puts "minutes1 #{minutes1}"
    minutes2 = ((minutes1.to_i) + 1).to_s
    puts "minutes2 #{minutes2}"
    tmpHours = ((Time.now.strftime '%H').to_i - 8).to_s
    puts "tmpHours : #{tmpHours}"
    band.hoursMinutesB3_backUp = "#{tmpHours}:#{minutes2}"
    hoursMinutesB3 = "#{tmpHours}:#{minutes1}"
end

def timestampA2(bandsArray)
    band = bandsArray[0]
    # MINUS 8 FOR SOUTH KOREA TIME ZONE
    minutes1 = Time.now.strftime '%M'
    puts "minutes1 #{minutes1}"
    minutes2 = ((minutes1.to_i) + 1).to_s
    puts "minutes2 #{minutes2}"
    tmpHours = ((Time.now.strftime '%H').to_i - 8).to_s
    puts "tmpHours : #{tmpHours}"
    band.hoursMinutesA2_backUp = "#{tmpHours}:#{minutes2}"
    hoursMinutesA2 = "#{tmpHours}:#{minutes1}"
end