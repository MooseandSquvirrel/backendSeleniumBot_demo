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
    

    puts "stringHash[:start_date]"
    puts stringsHash[:start_date]
    daysParsed = Date.parse(stringsHash[:start_date])
    datesArray = []
    i = 0
    while i < stringsHash[:total_days].to_i
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


    "Creeper/Download file codes here"

"REMEMBER TO GRAB DOWNLOAD FILE NAME FOR INTERPOLATION BELOW IN THE END OF THE PATH STRING BELOW SO FINDING FILE WILL BE POSSIBLE"
    # LOCATE FILE TO PARSE, OPEN AND READ
    "PATH OUTSIDE OF CURRENT DIRECTORY OF BACKENDSELENIUM ISN'T WORKING, FIGURE OUT HOW TO GET PATH FROM DESKTOP WHERE TEMP_DATA IS"
    workbook = RubyXL::Parser.parse("funky.xlsx")
    puts workbook.worksheets[0] # Returns first worksheet
    # DEFINES WORKBOOK AS WORKSHEET (DONT DELETE)
    worksheet = workbook[0]
  
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
        p "#{worksheet.sheet_data.rows.size} - #{index}"
        firstCell = worksheet.sheet_data[index][0].value
        lastCell = worksheet.sheet_data[index][7].value
        p "firstCell = #{firstCell} lastCell = #{lastCell}"
        if firstCell != lastCell
            p "DELETE"
            worksheet.delete_row(index)
            # puts "Not new user. Row #a#{i} Deleted."
        else
            index += 1
        end
    end

    workbook.write("firstScan.xlsx")

    firstScanRowCount = index - 1
    puts "firstScanRowCount = :#{firstScanRowCount}"

    # USE USER INPUT FROM INITIAL GETS.CHOMPS (stringsHash[:start_date]) ABOVE TO REMOVE DATES OUTSIDE EVENT RANGE TO GET FINAL N.R.U.
    index = 1
    while index < worksheet.sheet_data.rows.size
        puts "-------------------------------------------------------------------------------------------------------------"
        p "worksheet.sheet_data.rows.size: #{worksheet.sheet_data.rows.size} -- index: #{index}"
        cellDate = worksheet.sheet_data[index][3].value
        p "cellDate = #{cellDate}"
        p datesArray
        if not datesArray.include?("#{cellDate}")
            puts "cellDate: #{cellDate} is not one of the dates of #{stringsHash[:event_name]}."
            worksheet.delete_row(index)
            puts "Not new user. Row #{index} Deleted."
            puts "----------------------------------------------------------------------------------------------------------"
        else
            index += 1
        end
    end

    puts "firstScanRowCount: #{firstScanRowCount}"
    puts "finalScanRowCount: #{index}"
    finalScanRowCount = index - 1

    puts "=============================="
    puts "Results of first B7 (#{stringsHash[:event_name]}):"
    # to_f BELOW SO THAT DIVISION FOR PERCENTAGE DOESN'T EQUAL 0
    nru = finalScanRowCount.to_f
    puts "NRUs: #{nru}"
    nruPercentage = (finalScanRowCount / rowCount.to_f) * 100
    puts "NRUs Percentage for the event '#{stringsHash[:event_name]}': #{nruPercentage}%"

    workbook.write("secondScan.xlsx")


    # B3 PARSE LOOP
    

   

    puts "next steps reached"

