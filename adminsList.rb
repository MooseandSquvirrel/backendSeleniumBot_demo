require 'rubygems'
require 'selenium-webdriver'
require 'pp'
require 'rspec/expectations'
require 'io/console'
require 'httparty'
require 'rest-client'
require 'open-uri'
require 'ap'
require 'rubyXL'

# SETTING UP ARRAY OF ADMINS NAMES FROM ADMINS EXCEL SPREADSHEET -- FOR USE IN B3 (AND B7.1?) TO REMOVE ADMINS WHO CREATED BANDS
adminsListWorkBook = RubyXL::Parser.parse("Admin List.xlsx")
adminsWorksheet = adminsListWorkBook[0]
adminsArray = []
i = 1
adminsRowCount = adminsWorksheet.sheet_data.rows.size - 1
puts "adminsRowCount:"
puts adminsRowCount
while i < adminsRowCount
    name = adminsWorksheet.sheet_data[i][2].value
    if not name.nil?
        adminsArray << name
    end
    i += 1
end

puts "adminsArray"
ap adminsArray


=begin
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
           #### puts "cellDate: #{cellDate} is not one of the dates of #{stringsHash[:band_name]}." ####
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
    puts "Results of first B7 (#{stringsHash[:band_name]}):"
    # to_f BELOW SO THAT DIVISION FOR PERCENTAGE DOESN'T EQUAL 0
    nruCount = nruCount.to_f
    puts "NRUs: #{nruCount}"
    newMemberAvg = ((nruCount / rowCount.to_f) * 100).round(2)
    puts "NRUs Percentage for the event '#{stringsHash[:band_name]}': #{newMemberAvg}%"
    puts "=============================="

    workbookB7first.write("secondScan.xlsx")

=end