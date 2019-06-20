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
require 'fileutils'
############################
require './adminsList.rb' 
############################
require './datesSection.rb' 
############################


# USE USER INPUT FROM INITIAL GETS.CHOMPS ($_start_date]) TO REMOVE DATES OUTSIDE EVENT RANGE TO GET FINAL N.R.U.
def dateRange(worksheet, datesArray)
    puts "inside dateRange"
    puts "datesArray: "
    ap datesArray
    
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
end


# CHANGING DIRECTORIES (THIS ONE TO ACCESS TEMP_B7)
def mvDir()
    puts "----- Moving Directories to reach TEMP_B7 Directory -----"
    puts "Directory before:"
    puts Dir.pwd
    b7Dir = '~/fixit/backendSelenium/TEMP_B7'
    Dir.chdir(File.expand_path(b7Dir))
    puts "Directory is now:"
    puts Dir.pwd
end

# STORING RESULTS INTO ORIGINAL EVENT OBJECTS' INSTANCE VARIABLES
def resultsB7(eventName, band, rowCount, worksheet)
    nruCount = worksheet.sheet_data.rows.size - 1
    puts "nruCout: #{nruCount}"

    puts "==============================================================================================="
    puts "Results of first B7 (#{eventName}):"
    puts "-----------------------------------"
    puts "nruCount: #{band.nruCount}"
    puts "-----------------------------------"
    "I DON'T BELIEVE THE BELOW 2 LINES WORK SINCE band.totalMembers NEEDS TO BE COLLECTED FROM B3 IN ORDER TO NOW GET band.newMemberAvg IN B3 LOOP"
    "PROBABLY DELETABLE SOON"
    # band.newMemberAvg = ((nruCount / rowCount.to_f) * 100).round(2)
    # puts "NRUs Percentage for the event '#{band.eventName}': #{band.newMemberAvg}%"
    puts "==============================================================================================="
end

"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                              B7_1 Loop Main                                            "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


# bandsArraywDates PARAMETER IN ORDER TO STORE INSTANCE VARIABLES FOR RESULTS, eventNumsArray TO ACCESS BANDS.NUMS
def b71Parse(eventNumsArray, bandsArraywDates)

    # Move to TEMP_B7
    mvDir()

    fileNamesArray = []
    fileNamesArray = Dir["./*.xlsx"]
    puts "fileNamesArray:"
    ap fileNamesArray

    i = 0
    bandNum = 0
    while i < eventNumsArray.length
        puts "i = #{i}"
        puts "eventNumsArray.length = #{eventNumsArray.length}"
        workbookB7first = RubyXL::Parser.parse("#{fileNamesArray[0]}")
        
        # DEFINES WORKBOOK AS WORKSHEET (DONT DELETE)
        worksheet = workbookB7first[0]

        #  ASSIGNS BAND OBJECT FROM ARRAY
        band = bandsArraywDates[i]
    
        # **FINAL RESULT** SAVE ROWCOUNT FOR MATH OF TOTAL MEMBERS -- subtract 1 FOR TITLE ROW AT INDEX[0] -- to_f FOR DIVISION PURPOSES LATER
        rowCount = worksheet.sheet_data.rows.size - 1
        band.totalMembers = rowCount.to_f
        puts "Initial row count (rowCount) of sheet before filtering: #{rowCount}"


    #  CLEANS USERS THAT DIDN'T JOIN FROM THIS SPECIFIC EVENT
        index = 1
        while index < worksheet.sheet_data.rows.size
            #### p "#{worksheet.sheet_data.rows.size} - #{index}" ####
            firstCell = eventNumsArray[bandNum]
            puts "bandNum = #{eventNumsArray[bandNum]}"
            lastCell = worksheet.sheet_data[index][7].value
            if firstCell != lastCell
                worksheet.delete_row(index)
            else
                index += 1
            end
        end
        dateRange(worksheet, band.datesArray)
        ap bandsArraywDates
        resultsB7(band.eventName, band, rowCount, worksheet)
        puts "band"
        print band
        puts "band.eventName"
        puts band.eventName
        i += 1
        bandNum += 1
    end
end

