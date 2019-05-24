require 'rubygems'
require 'rubyXL'
require 'rubyXL/convenience_methods'
require 'date'


#  B3 IMPLEMENTATION OF excelTestParser.rb
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

    puts "----------------------------------------------------------------------------------------------------------------"
    puts "Press 'Enter' To Begin Another B7 Download and Analysis:"



end