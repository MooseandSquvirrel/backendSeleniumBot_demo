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


# CHANGING DIRECTORIES (THIS ONE TO ACCESS TEMP_B7)
def mvDirB7()
    puts "----- Moving Directories to reach TEMP_B7 Directory -----"
    puts "Directory before:"
    puts Dir.pwd
    b7Dir = '~/fixit/backendSelenium/TEMP_B7'
    Dir.chdir(File.expand_path(b7Dir))
    puts "Directory is now:"
    puts Dir.pwd
end

# USE USER INPUT FROM INITIAL GETS.CHOMPS ($_start_date]) TO REMOVE DATES OUTSIDE EVENT RANGE TO GET FINAL N.R.U.
def dateRangeAndRowCount(worksheet, datesArray)
    puts "inside dateRangeAndRowCount"
    puts "datesArray: "
    ap datesArray
    
    puts "1 INSIDE FUNCTION - worksheet rows: #{worksheet.sheet_data.rows.size}"

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
    puts "2 END OF FUNCTION - worksheet rows: #{worksheet.sheet_data.rows.size}"
    # THIS SHOULD BE THE NRU COUNT (-1 FOR TITLE ROW)
    return worksheet.sheet_data.rows.size - 1
end

# **FINAL RESULT** NRUCOUNT STORING RESULTS INTO ORIGINAL EVENT OBJECTS' INSTANCE VARIABLES
def resultsB7(eventName, band, nruCount, worksheet)
    band.nruCount = nruCount
    puts "nruCout: #{nruCount}"

    puts "==============================================================================================="
    puts "Results of first B7 (#{eventName}):"
    puts "-----------------------------------"
    puts "nruCount: #{band.nruCount}"
    puts "-----------------------------------"
    puts "==============================================================================================="
end

"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                              B7_1 Loop Main                                            "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


# bandsArraywDates PARAMETER IN ORDER TO STORE INSTANCE VARIABLES FOR RESULTS, eventNumsArray TO ACCESS BANDS.NUMS
def b71Parse(eventNumsArray, bandsArraywDates)

    # MOVE TO TEMP_B7
    mvDirB7()

    # COLLECTS FILE(S) WITH .XLSX FORMAT (SHOULD ONLY BE ONE) IN ORDER TO PARSE IT
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
        p worksheet

        #  ASSIGNS BAND OBJECT FROM ARRAY
        band = bandsArraywDates[i]

        bandNumber = eventNumsArray[bandNum]

        # CLEANS USERS THAT DIDN'T JOIN FROM THIS SPECIFIC EVENT
        index = 1
        totalMemberCounter = 0
        nruCounter = 0
        counter = 0
        while counter < worksheet.sheet_data.rows.size - 1
            puts "worksheet.sheet_data[index][7].value : #{worksheet.sheet_data[index][7].value}"
            lastCell = worksheet.sheet_data[index][7].value
            if bandNumber == worksheet.sheet_data[index][0].value
                totalMemberCounter += 1
                if bandNumber == lastCell
                    nruCounter += 1
                end
                index += 1
            else
                index += 1
            end
            counter += 1
        end
        puts "nruCounter: #{nruCounter}"
        puts "totalMemberCounte: #{totalMemberCounter}"
            # puts "counter : #{counter}"
            # p "#{worksheet.sheet_data.rows.size} - #{index}" ####
            # #bandNumber = eventNumsArray[bandNum]
            # puts "bandNum = #{eventNumsArray[bandNum]}"
            # lastCell = worksheet.sheet_data[index][7].value
            # puts "lastCell = #{lastCell}"
            # if bandNumber != lastCell
            #     #worksheet.delete_row(index)
            #     index += 1
            # counter += 1
            # else
            #     totalMemberCounter += 1
            #     puts "totalMemberCounter: #{totalMemberCounter}"
            #     counter += 1
            # end
        # end

        puts "worksheet rows: #{worksheet.sheet_data.rows.size}"

        # **FINAL RESULT** SAVE ROWCOUNT FOR MATH OF TOTAL MEMBERS -- subtract 1 FOR TITLE ROW AT INDEX[0] -- to_f FOR DIVISION PURPOSES LATER
        band.totalMembers = (totalMemberCounter - 1).to_f

        nruCount = dateRangeAndRowCount(worksheet, band.datesArray)
        resultsB7(band.eventName, band, nruCount, worksheet)
    
        i += 1
        bandNum += 1
    end
end

