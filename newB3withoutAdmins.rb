#!/usr/env/bin ruby

####################################
# EXCELTESTPARSER REQUIRES
####################################
require 'rubyXL'
require 'rubyXL/convenience_methods'
require 'rubygems'
require 'awesome_print'
require 'date'
####################################
# TEST_CREEP REQUIRES
####################################
require 'selenium-webdriver'
require 'pp'
require 'rspec/expectations'
require 'io/console'
####################################
    


"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                            B3 Loop                                     "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



# B3 PARSE LOOP
"REMEMBER TO GRAB DOWNLOAD FILE NAME FOR INTERPOLATION BELOW IN THE END OF THE PATH STRING BELOW SO FINDING FILE WILL BE POSSIBLE"
# LOCATE FILE TO PARSE, OPEN AND READ
"PATH OUTSIDE OF CURRENT DIRECTORY OF BACKENDSELENIUM ISN'T WORKING, FIGURE OUT HOW TO GET PATH FROM DESKTOP WHERE TEMP_DATA IS"
workbookB3 = RubyXL::Parser.parse("b3.xlsx")
# DEFINES WORKBOOK AS WORKSHEET (DONT DELETE)
worksheet = workbookB3[0]


# SAVE ROWCOUNT FOR MATH OF TOTAL MEMBERS - NEW COUNT
rowCount = worksheet.sheet_data.rows.size
puts "rowCount: #{rowCount}"


newRowCount = worksheet.sheet_data.rows.size
newLeaderArray = Array.new
finalLeaderArray = Array.new
cell = ""
index = 1
#   GRAB AND STORE ALL LEADERS AND THEN USE .uniq  TO DELETE REPEAT NAMES AND GET newLeaderCount (CHECKS IF DATE CREATED CELL IS nil?, IF NOT, STORE)
while index < newRowCount
if not worksheet.sheet_data[index][10].nil?
    #  STORING ALL LEADER NAMES (MULTIPLES INCLUDED)
    newLeaderArray << worksheet.sheet_data[index][5].value
    #### puts "worksheet.sheet_data[index][5]: #{worksheet.sheet_data[index][5]}"
end
index += 1
end

puts "\nnewLeaderArray.length (count) -- before .uniq: #{newLeaderArray.length}"

# DELETES MULTIPLES OF LEADERS
finalLeaderArray = newLeaderArray.uniq
puts "\nnewLeaderArray.length (count) -- after .uniq: #{finalLeaderArray.length}"
puts "\nfinalLeaderArray"
ap finalLeaderArray

# TOTAL LEADERS
totalLeaderCount = finalLeaderArray.length 

# FILTERING CELLS FOR B3 AND STORING NEW LEADERS AND THEIR NEW BANDS IN ARRAYS, AND FINDING TOTAL LEADER COUNT (newLeaderCount)
newLeaderCount = 0
new_GBL_LeaderCount = 0
cellDateCreated = ""
newLeaderArray = Array.new
newBandsArray = Array.new
index = 1
while index < rowCount
# puts "index: #{index}  --  rowCount: #{rowCount}"
#### puts "ROW COUNT: #{rowCount} -- INDEX: #{index}"
if worksheet.sheet_data[index][10].nil?
#### puts "EMPTY CELL: SKIPPED NIL row skipped at index #{index}."
index += 1
elsif not worksheet.sheet_data[index][10].nil?
#### puts "-------------------------------------------------------------------------------------------------------------"
# p "worksheet.sheet_data.rows.size: #{worksheet.sheet_data.rows.size} -- index: #{index}"
cellDateCreated = worksheet.sheet_data[index][10].value
cellMemberSize = worksheet.sheet_data[index][14].value.to_i
#### puts "Row: #{index}"
#### p "cellDateCreated = #{cellDateCreated}"
#### p "cellMembersize = #{cellMemberSize}"
#### p datesArray
#### puts "\n"
if not datesArray.include?("#{cellDateCreated}")
    #### puts "SKIPPED : WRONG CELL DATE cellDateCreated: #{cellDateCreated} is not one of the dates of #{stringsHash[:band_name]}."
    index += 1
    #### puts "----------------------------------------------------------------------------------------------------------"
elsif not cellMemberSize > 1
    #### puts "SKIPPED : worksheet.sheet_data[index][14] = #{worksheet.sheet_data[index][14].value}."
    newLeaderCount += 1
    index += 1
else
    newBandsArray << worksheet.sheet_data[index][7].value
    newLeaderArray << worksheet.sheet_data[index][5].value
    #### puts "\n\n\n\n$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\n"
    #### puts "newBandsArray Band: #{worksheet.sheet_data[index][7].value}"
    #### puts "newLeaderArray: #{worksheet.sheet_data[index][5].value}"
    new_GBL_LeaderCount += 1
    #### puts "new_GBL_LeaderCount: #{new_GBL_LeaderCount}"
    #### puts "\n$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\n\n\n\n"
    index += 1
end
end
end

puts "\n"

#   GRAB ORIGINAL BAND COUNT FOR DIVISION WITH NEW B
totalMembers = worksheet.sheet_data[1][2].value.to_f
puts "Total Members:"
puts totalMembers
puts "\n"
newLeaderCount = newLeaderArray.length.to_f


puts "B3 Results (and Total Members):"
puts "---------------------------------------------------------------------------------------------------------------------------------------"
puts "Total Leaders (totalLeaderCount):"
p totalLeaderCount
puts "New Leaders (newLeaderCount):"
p newLeaderCount
puts "newBandsArray:"
p newBandsArray
puts "newLeaderArray:"
p newLeaderArray
puts "GBLs (new_GBL_LeaderCount):"
p new_GBL_LeaderCount
puts "New Leader Avg (newLeaderAvg):"
p newLeaderAvg = (newLeaderCount/totalMembers) * 100
puts "Total Members:"
puts totalMembers
puts "Camp Date:"
p "ADD FORMULA USING :start_date AND :total_days TO GET STARTING DATE AND ENDING DATE FOR THIS CELL"
puts "Activity Sum:"
p "STILL NEED TO GET A:2 AND PARSE"
puts "NRU's:"
p "#{nruCount}"
puts "New Member Avg:"
p (nruCount/totalMembers)

puts "\n\nfinalLeaderArray"
ap finalLeaderArray

workbookB3.write("b3write.xlsx")

puts "rowCount #{rowCount}"

puts "next steps reached"