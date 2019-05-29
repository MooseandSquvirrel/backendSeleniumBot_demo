#!/usr/env/bin ruby


require 'rubyXL'
require 'rubyXL/convenience_methods'
require 'rubygems'
require 'awesome_print'

puts "\n\n"
print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n"
print "                                            WELCOME TO Parser!                                          \n"
print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n"

print "\n\nThis program will continue until 'exit' is entered on the command line.\nIf exited, 'Up Arrow' then 'Enter' will restart.\nHit 'Enter' key to begin.\n"

bandsArray = Array.new

until gets.strip() == "exit"
    puts "\n"
    stringsHash = Hash.new
    stringsHash = {:event_name => "Enter Event Name:", 
        :start_date => "\nEnter starting date of event:\n(ex: for June 21, 2019 enter: 21/06/2019)\n",
        :total_days => "\nEnter number of days for the event: (ex: 4)", :band_num => "\nEnter BAND number:"}

    # OLD CODE FOR REFERENCE ONLY
    # puts stringsHash[:total_days]
    # stringsHash[:total_days] = gets.strip


    # COUNTER TO IGNORE THE 'puts stringsHash[:event_name]' THE SECOND TIME THROUGH IF 'n' IS SELECTED BY USER
    counter = 0
    event_name_check = ""
    while event_name_check != 'y' || event_name_check != "exit"
        if counter == 0
            puts stringsHash[:event_name]
        end
        counter += 1
        stringsHash[:event_name] = gets.strip
        if stringsHash[:event_name] == 'exit'
            return
        end
        puts "\n"
        puts "Is '#{stringsHash[:event_name]}' the correct event name?\nPress 'y' for 'Yes' or 'n' for 'No' and press 'Enter'."
        event_name_check = gets.strip
        if event_name_check == "exit"
            return
        end
        if event_name_check == 'y'
            break
        end
        if event_name_check == 'n'
            puts "\n"
            puts "-------------------------------------------------------"
            puts "Re-Enter the Event Name and press 'Enter':"
            redo
        end
        if event_name_check != 'y' || event_name_check != 'n'
            puts "Please press 'y' for 'Yes' or 'n' for 'No' and hit the 'Enter' Key."
            puts "If you'd like to exit the program, type 'exit' and hit the 'Enter' Key."
            puts "\n"
            puts "**** Now Re-Enter the event name and hit 'Enter'. ****"
            redo
        end
    end
            

    # COUNTER TO IGNORE THE 'puts stringsHash[:start_date]' THE SECOND TIME THROUGH IF 'n' IS SELECTED BY USER
    counter = 0
    start_date_check = ""
    while start_date_check != 'y' || start_date_check != "exit"
        if counter == 0
            puts stringsHash[:start_date]
        end
        counter += 1
        stringsHash[:start_date] = gets.strip
        if stringsHash[:start_date] == 'exit'
            return
        end
        puts "\n"
        puts "Is '#{stringsHash[:start_date]}' the correct start date? -----> ex. (??/??/????)\nPress 'y' for 'Yes' or 'n' for 'No' and press 'Enter'."
        start_date_check = gets.strip
        if start_date_check == 'exit'
            return
        end
        if start_date_check == 'y'
            break
        end
        if start_date_check == 'n'
            puts "\n"
            puts "-------------------------------------------------------"
            puts "Re-Enter the Start Date of '#{stringsHash[:event_name]}' and press 'Enter':"
            redo
        end
        if start_date_check != 'y' || start_date_check != 'n'
            puts "\n"
            puts "Please press 'y' for 'Yes' or 'n' for 'No' and hit the 'Enter' Key."
            puts "If you'd like to exit the program, type 'exit' and hit the 'Enter' Key."
            puts "\n"
            puts "**** Now Re-Enter the start date of '#{stringsHash[:event_name]}' and hit 'Enter'. ****"
        redo
        end
    end


        # COUNTER TO IGNORE THE 'puts stringsHash[:total_days]' THE SECOND TIME THROUGH IF 'n' IS SELECTED BY USER
    counter = 0
    total_days_check = ""
    while total_days_check != 'y' || total_days_check != "exit"
        if counter == 0
            puts stringsHash[:total_days]
        end
        counter += 1
        stringsHash[:total_days] = gets.strip
        if stringsHash[:total_days] == 'exit'
            return
        end
        puts "\n"
        puts "Is '#{stringsHash[:total_days]}' the correct amount of days of #{stringsHash[:event_name]}?\nPress 'y' for 'Yes' or 'n' for 'No' and press 'Enter'."
        total_days_check = gets.strip
        if event_name_check == "exit"
            return
        end
        if total_days_check == 'y'
            break
        end
        if total_days_check == 'n'
            puts "\n"
            puts "-------------------------------------------------------"
            puts "Re-Enter the correct amount of days for '#{stringsHash[:event_name]}' and press 'Enter':"
            redo
        end
        if total_days_check != 'y' || total_days_check != 'n'
            puts "Please press 'y' for 'Yes' or 'n' for 'No' and hit the 'Enter' Key."
            puts "If you'd like to exit the program, type 'exit' and hit the 'Enter' Key."
            puts "\n"
            puts "**** Now Re-Enter the amount of days for '#{stringsHash[:event_name]}' and hit 'Enter'. ****"
            redo
        end
    end


    # COUNTER TO IGNORE THE 'puts stringsHash[:band_num]' THE SECOND TIME THROUGH IF 'n' IS SELECTED BY USER
    counter = 0
    band_num_check = ""
    while band_num_check != 'y' || band_num_check != "exit"
        if counter == 0
            puts stringsHash[:band_num]
        end
        counter += 1
        stringsHash[:band_num] = gets.strip
        if stringsHash[:band_num] == "exit"
            return
        end
        puts "\n"
        puts "Is '#{stringsHash[:band_num]}' the correct BAND number for #{stringsHash[:event_name]}?\nPress 'y' for 'Yes' or 'n' for 'No' and press 'Enter'."
        band_num_check = gets.strip
        if event_name_check == "exit"
            return
        end
        if band_num_check == 'y'
            break
        end
        if band_num_check == 'n'
            puts "\n"
            puts "-------------------------------------------------------"
            puts "Re-Enter the correct BAND number for '#{stringsHash[:event_name]}' and press 'Enter':"
            redo
        end
        if band_num_check != 'y' || band_num_check != 'n'
            puts "Please press 'y' for 'Yes' or 'n' for 'No' and hit the 'Enter' Key."
            puts "If you'd like to exit the program, type 'exit' and hit the 'Enter' Key."
            puts "\n"
            puts "**** Now Re-Enter the BAND number for #{} 'Enter'. ****"
            redo
        end
    end

    puts "bandsArray << stringsHash (Before hitting 'go')"
    bandsArray << stringsHash
    p bandsArray

    puts "\n"
    puts "----------------------------------------------------------------------------------"
    puts "If no more BANDs to enter info for, type 'go' and hit 'Enter'."
    puts "Otherwise, hit 'Enter' to begin submitting another Summer Camp BAND's info."
    if (orders = gets.strip) == "go"
        break
    else
        redo
    end
end 
"THE ABOVE 'end' IS WHERE THE BEGINNING 'UNTIL' end HAS BEEN MOVED TO TO TRY TO LOOP B7 (AND EVENTUALLY B3) INFORMATION. ++++  ++++  ++++  ++++ "

    puts "\n"
    print "THANK YOU. NOW I WILL DO WORK FOR YOU :)"
    sleep(1)
    print '.'
    sleep(1)
    print '.'
    sleep(1)
    print '.'
    sleep(1)
    print '.'
    
    # COVER THE DATES OF THE :starting_date UNTIL 3 DAYS AFTER
    puts "stringHash[:start_date]"
    puts stringsHash[:start_date]
    daysParsed = Date.parse(stringsHash[:start_date])
    datesArray = []
    i = 0
    # EVENT DATE RANGE PLUS 3 DAYS AFTER
    while i < ((stringsHash[:total_days].to_i) + 3)
        datesArray << daysParsed.to_s
        if stringsHash[:total_days] == 1
            break
        else
            daysParsed += 1
            puts "Dates Array:"
            puts "========"
            puts datesArray
            puts "\n"
            i += 1
        end
    end

    # COVERS THE DATES LEADING UP TO THE EVENT'S :start_date (7 DAYS BEFORE :start_date)
    daysParsed = Date.parse(stringsHash[:start_date])
    i = 0
    earlyDaysParsed = daysParsed - 7
    while i < 7
        datesArray << earlyDaysParsed.to_s
        earlyDaysParsed += 1
        i += 1
    end
    
    datesArray = datesArray.sort
    p datesArray


"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                            1st B7 Loop                                     "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


    "Creeper/Download file codes here"

"REMEMBER TO GRAB DOWNLOAD FILE NAME FOR INTERPOLATION BELOW IN THE END OF THE PATH STRING BELOW SO FINDING FILE WILL BE POSSIBLE"
    # LOCATE FILE TO PARSE, OPEN AND READ
    "PATH OUTSIDE OF CURRENT DIRECTORY OF BACKENDSELENIUM ISN'T WORKING, FIGURE OUT HOW TO GET PATH FROM DESKTOP WHERE TEMP_DATA IS"
    workbookB7first = RubyXL::Parser.parse("b71.xlsx")

    # DEFINES WORKBOOK AS WORKSHEET (DONT DELETE)
    worksheet = workbookB7first[0]
  
    # i = 1 TO SKIP TOP ROW OF TITLES IN SPREADSHEET
    i = 1
    # SAVE ROWCOUNT FOR MATH OF TOTAL MEMBERS -- subtract 1 FOR TITLE ROW AT INDEX[0]
    rowCount = worksheet.sheet_data.rows.size - 1
    puts "Initial row count (rowCount) of sheet before filtering: #{rowCount}"

#  CLEANS USERS THAT DIDN'T JOIN FROM THIS SPECIFIC EVENT
    index = 1
    while index < worksheet.sheet_data.rows.size
        #### p "#{worksheet.sheet_data.rows.size} - #{index}" ####
        firstCell = worksheet.sheet_data[index][0].value
        lastCell = worksheet.sheet_data[index][7].value
       #### p "firstCell = #{firstCell} lastCell = #{lastCell}" ####
        if firstCell != lastCell
       ####    p "DELETE" ####
            worksheet.delete_row(index)
            # puts "Not new user. Row #a#{i} Deleted."
        else
            index += 1
        end
    end

    
    finalScanRowCount = index - 1
    puts "FIRST B7 While loop. CLEAN USERS THAT DIDN'T JOIN FROM THIS EVENT (joined in earlier BAND). (finalScanRowCount): #{finalScanRowCount}"

    workbookB7first.write("firstScan.xlsx")


    puts "worksheet.sheet_data.rows.size BEFORE second loop: #{worksheet.sheet_data.rows.size}"

    # USE USER INPUT FROM INITIAL GETS.CHOMPS (stringsHash[:start_date]) ABOVE TO REMOVE DATES OUTSIDE EVENT RANGE TO GET FINAL N.R.U.
    index = 1
    puts "cellDate = worksheet.sheet_data[1][3] = #{worksheet.sheet_data[index][3].value}"
    while index < worksheet.sheet_data.rows.size
       #### puts "-------------------------------------------------------------------------------------------------------------" ####
       #### p "worksheet.sheet_data.rows.size: #{worksheet.sheet_data.rows.size} -- index: #{index}" ####
        cellDate = worksheet.sheet_data[index][3].value
       #### p "cellDate = #{cellDate}" ####
       #### p datesArray ####
        if not datesArray.include?("#{cellDate}")
           #### puts "cellDate: #{cellDate} is not one of the dates of #{stringsHash[:event_name]}." ####
           puts "cellDate: #{cellDate}"
            worksheet.delete_row(index)
           puts "Not new user. Row #{index} Deleted." ####
           #### puts "----------------------------------------------------------------------------------------------------------" ####
        else
            index += 1
            puts "cellDate #{cellDate} is good!\n(index += 1)"
        end
    end

    nruCount = worksheet.sheet_data.rows.size - 1
    puts "nruCout: #{nruCount}"


    puts "=============================="
    puts "Results of first B7 (#{stringsHash[:event_name]}):"
    # to_f BELOW SO THAT DIVISION FOR PERCENTAGE DOESN'T EQUAL 0
    nruCount = nruCount.to_f
    puts "NRUs: #{nruCount}"
    nruPercentage = ((nruCount / rowCount.to_f) * 100).round(2)
    puts "NRUs Percentage for the event '#{stringsHash[:event_name]}': #{nruPercentage}%"
    puts "=============================="

    workbookB7first.write("secondScan.xlsx")



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
            #### puts "SKIPPED : WRONG CELL DATE cellDateCreated: #{cellDateCreated} is not one of the dates of #{stringsHash[:event_name]}."
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






"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                            2nd B7 Loop                                     "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

" USE THE newBandsArray TO ENTER ALL THE NEW GBLs INTO THE TEXT BOX WITH THE DRIVER "



    "Creeper/Download file codes here"

"REMEMBER TO GRAB DOWNLOAD FILE NAME FOR INTERPOLATION BELOW IN THE END OF THE PATH STRING BELOW SO FINDING FILE WILL BE POSSIBLE"
    # LOCATE FILE TO PARSE, OPEN AND READ
    "PATH OUTSIDE OF CURRENT DIRECTORY OF BACKENDSELENIUM ISN'T WORKING, FIGURE OUT HOW TO GET PATH FROM DESKTOP WHERE TEMP_DATA IS"
    workbookB7second = RubyXL::Parser.parse("b72.xlsx")
    puts workbookB7second.worksheets[0] # Returns first worksheet
    # DEFINES WORKBOOK AS WORKSHEET (DONT DELETE)
    worksheet = workbookB7second[0]
  
    # i = 1 TO SKIP TOP ROW OF TITLES IN SPREADSHEET
    i = 1
    # SAVE ROWCOUNT FOR MATH OF TOTAL MEMBERS - NEW COUNT
    rowCount = worksheet.sheet_data.rows.size
    puts "rowCount: #{rowCount}"
    p worksheet.sheet_data[1][0].value
    p worksheet.sheet_data[1][7].value
#   pp worksheet

#  CLEANS USERS THAT DIDN'T JOIN FROM THIS SPECIFIC EVENT
    index = 1
    while index < worksheet.sheet_data.rows.size
        #### p "#{worksheet.sheet_data.rows.size} - #{index}"
        firstCell = worksheet.sheet_data[index][0].value
        lastCell = worksheet.sheet_data[index][7].value
        #### p "firstCell = #{firstCell} lastCell = #{lastCell}"
        if firstCell != lastCell
            #### p "DELETE"
            worksheet.delete_row(index)
            # puts "Not new user. Row #a#{i} Deleted."
        else
            index += 1
        end
    end

    workbookB7second.write("firstScan.xlsx")

    firstScanRowCount = index - 1
    puts "firstScanRowCount = :#{firstScanRowCount}"

    # USE USER INPUT FROM INITIAL GETS.CHOMPS (stringsHash[:start_date]) ABOVE TO REMOVE DATES OUTSIDE EVENT RANGE TO GET FINAL N.R.U.
    index = 1
    while index < worksheet.sheet_data.rows.size
        #### puts "-------------------------------------------------------------------------------------------------------------"
        #### p "worksheet.sheet_data.rows.size: #{worksheet.sheet_data.rows.size} -- index: #{index}"
        cellDate = worksheet.sheet_data[index][3].value
        #### p "cellDate = #{cellDate}"
        #### p datesArray
        if not datesArray.include?("#{cellDate}")
            #### puts "cellDate: #{cellDate} is not one of the dates of #{stringsHash[:event_name]}."
            worksheet.delete_row(index)
            #### puts "Not new user. Row #{index} Deleted."
            #### puts "----------------------------------------------------------------------------------------------------------"
        else
            index += 1
        end
    end

    puts "firstScanRowCount: #{firstScanRowCount}"
    puts "finalScanRowCount: #{index}"
    finalScanRowCount = index - 1

    puts "=============================="
    puts "Results of Second B7 (#{stringsHash[:event_name]}):"
    # to_f BELOW SO THAT DIVISION FOR PERCENTAGE DOESN'T EQUAL 0
    nru = finalScanRowCount.to_f
    puts "Second B7 NRUs: #{nru}"
    nruPercentage = (finalScanRowCount / rowCount.to_f) * 100
    puts "NRUs Percentage for the event '#{stringsHash[:event_name]}': #{nruPercentage}%"

    workbookB7second.write("secondScan.xlsx")

   
    p datesArray


"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                            A2? Activity Loop                                     "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"






"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                        Final Results to be Written                                    "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


puts "Results of first B7 for (#{stringsHash[:event_name]}):"
puts "---------------------------------------------------------------------------------------------------------------------------------------"
# to_f BELOW SO THAT DIVISION FOR PERCENTAGE DOESN'T EQUAL 0
nruCount = nruCount.to_f
puts "NRUs: #{nruCount}"
nruPercentage = ((nruCount / rowCount.to_f) * 100).round(2)
puts "NRUs Percentage for the event '#{stringsHash[:event_name]}': #{nruPercentage}%"


puts "B3 Results (and Total Members) for (#{stringsHash[:event_name]}):"
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


puts "Results of second B7 for (#{stringsHash[:event_name]}):"
puts "---------------------------------------------------------------------------------------------------------------------------------------"
puts "Results of Second B7 (#{stringsHash[:event_name]}):"
# to_f BELOW SO THAT DIVISION FOR PERCENTAGE DOESN'T EQUAL 0
nru = finalScanRowCount.to_f
puts "Second B7 NRUs: #{nru}"
nruPercentage = (finalScanRowCount / rowCount.to_f) * 100
puts "NRUs Percentage for the event '#{stringsHash[:event_name]}': #{nruPercentage}%"


puts "Results of A2 Activity for (#{stringsHash[:event_name]}):"
puts "---------------------------------------------------------------------------------------------------------------------------------------"
puts "_____TBD_____"