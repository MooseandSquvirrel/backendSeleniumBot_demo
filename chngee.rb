#!/usr/env/bin ruby

bandNum = 340598345

=begin
puts "Before:"
puts Dir.pwd

Dir.chdir(Dir.pwd + "/Desktop")

puts "After:"
puts Dir.pwd
=end

require 'date'

dateToday = DateTime.now
dateToday.strftime("%d/%m/%Y")
puts "Date:"
puts dateToday

def appleSubsidiary()
    puts "\n"
    puts "+++++++++++++++++++++++++++++"
    puts "Before:"
    puts Dir.pwd
    Dir.chdir("../../Desktop")  # GOING TO HAVE TO RESOLVE PATH FOR OTHERS SYSTEMS LATER (either manual or fix this)
    puts "Directory is now:"
    puts Dir.pwd
    puts "Checking Desktop for CAMP_DATA..."
    if Dir.exist?("CAMP_DATA") == false
        puts "Creating CAMP_DATA directory..."
        Dir.mkdir("CAMP_DATA")
    else
        puts "CAMP_DATA Directory exists."
    end
end

def pearSubsidiary(bandNum)
    puts"\n"
    puts "+++++++++++++++++++++++++++++"
    Dir.chdir("CAMP_DATA")
    puts "Directory is now:"
    puts Dir.pwd
    puts "Checking CAMP_DATA for #{bandNum} BAND subdirectory..."
    if Dir.exist?("#{bandNum}") == false
        puts "Creating #{bandNum} subdirectory..."
        Dir.mkdir("#{bandNum}")
    else
        puts "#{bandNum} subdirectory exists."
    end
end

def lemonSubsidiary(bandNum, dateToday)
    puts"\n"
    puts "+++++++++++++++++++++++++++++"
    Dir.chdir("#{bandNum}")
    puts "Directory is now:"
    puts Dir.pwd
    puts "Checking #{bandNum} for #{dateToday} subdirectory..."
    if Dir.exist?("#{dateToday}") == false
        puts "Creating #{dateToday} subdirectory..."
        Dir.mkdir("#{dateToday}")
    else
        puts "#{dateToday} subdirectory exists."
    end
end

# EXECUTE 
appleSubsidiary()

# EXECUTE
pearSubsidiary(bandNum)

# EXECUTE
lemonSubsidiary(bandNum, dateToday)