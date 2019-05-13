#!/usr/env/bin ruby


=begin
puts "Before:"
puts Dir.pwd

Dir.chdir(Dir.pwd + "/Desktop")

puts "After:"
puts Dir.pwd
=end

def appleSubsidiary()
    puts "\n"
    puts "+++++++++++++++++++++++++++++"
    puts "Before:"
    puts Dir.pwd
    Dir.chdir("../../Desktop")  # GOING TO HAVE TO RESOLVE PATH FOR OTHERS SYSTEMS LATER (either manual or fix this)
    puts "Directory is now:"
    puts Dir.pwd
    puts "Checking Desktop for CAMP_DATA..."
    puts Dir.glob("CAMP_DATA")
    if Dir.glob("CAMP_DATA") == false
        puts "Creating CAMP_DATA Directory..."
        Dir.mkdir("CAMP_DATA")
    else
        puts "CAMP_DATA Directory exists."
    end
end
appleSubsidiary()