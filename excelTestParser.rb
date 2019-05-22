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

until gets.strip() == "exit"
    puts "\n"
    stringsHash = Hash.new
    stringsHash = {:event_name => "Enter Event Name.", 
        :start_date => "\nEnter starting date of event with Day first and Month second, followed by year.\n(ex: for June 21, 2019 enter: 21/6/2019)\n",
        :total_days => "\nEnter number of days for the event. (ex: 4)", :band_num => "\nEnter BAND number:"}

    puts stringsHash[:event_name]
    stringsHash[:event_name] = gets.strip
    puts stringsHash[:start_date]
    stringsHash[:start_date] = gets.strip
    puts stringsHash[:total_days]
    stringsHash[:total_days] = gets.strip
    puts stringsHash[:band_num]
    stringsHash[:band_num] = gets.strip
    

    "Creeper/Download file codes here"

"REMEMBER TO GRAB DOWNLOAD FILE NAME FOR INTERPOLATION BELOW IN THE END OF THE PATH STRING BELOW SO FINDING FILE WILL BE POSSIBLE"
    # LOCATE FILE TO PARSE, OPEN AND READ
    "PATH OUTSIDE OF CURRENT DIRECTORY OF BACKENDSELENIUM ISN'T WORKING, FIGURE OUT HOW TO GET PATH FROM DESKTOP WHERE TEMP_DATA IS"
    workbook = RubyXL::Parser.parse("18579.xlsx")
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
#    pp worksheet

#  CLEANS USERS THAT DIDN'T JOIN FROM THIS SPECIFIC EVENT
    index = 0
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

    
    newCount = index
    puts "NewCount = :#{newCount}"
    
    


            
    workbook.write("new.xlsx")


end