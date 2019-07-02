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
require './stringToArrayCsv.rb'
############################


# CHANGING DIRECTORIES (THIS ONE TO ACCESS TEMP_B7)
def mvDirA2()
    puts "----- Moving Directories to reach TEMP_B7 Directory -----"
    puts "Directory before:"
    puts Dir.pwd
    a2Dir = '~/fixit/backendSelenium/TEMP_A2'
    Dir.chdir(File.expand_path(a2Dir))
    puts "Directory is now:"
    puts Dir.pwd
end

def parserA2(bandNumber, band, worksheet)
    # CLEANS USERS THAT DIDN'T JOIN FROM THIS SPECIFIC EVENT
    index = 1
    totalMemberCounter = 0
    nruCounter = 0
    counter = 0
    while counter < worksheet.sheet_data.rows.size - 1
        puts "worksheet.sheet_data[index][7].value : #{worksheet.sheet_data[index][7].value}"
        cellBandNum = worksheet.sheet_data[index][0].value
        cellCurrentMember = worksheet.sheet_data[index][3].value
        cellActivitySum_Cnt = worksheet.sheet_data[index][14].value
        cellUniqueUsers_Uccu = worksheet.sheet_data[index][15].value
        # IF USER ENTERED BANDNUMBER MATCHES BAND NUMBER FIRST ROW (IDENTIFY CORRECT BAND TO PARSE IN DOCUMENT)
        if bandNumber == cellBandNum
            # **FINAL RESULTS FOR USER ACTIVITY** 
            band.activitySum = cellActivitySum_Cnt
            band.uniqueUserActivity = cellUniqueUsers_Uccu
            band.sumTotalMemberAvg = (cellActivitySum_Cnt.to_f / cellCurrentMember.to_f) 
            band.uniqueMemberavg = (cellUniqueUsers_Uccu.to_f / cellCurrentMember.to_f)
        else
            index += 1
        end
        counter += 1
    end
end

# **FINAL RESULT** NRUCOUNT STORING RESULTS INTO ORIGINAL EVENT OBJECTS' INSTANCE VARIABLES
def resultsA2(eventName, band, worksheet)
 
    puts "==============================================================================================="
    puts "Results of A2 (#{eventName}):"
    puts "-----------------------------------"
    puts "band.activitySum = #{band.activitySum}"
    puts "band.uniqueUserActivity = #{band.uniqueUserActivity}"
    puts "band.sumTotalMemberAvg = #{band.sumTotalMemberAvg}" 
    puts "band.uniqueMemberavg = #{band.uniqueMemberavg}"
    puts "-----------------------------------"
    puts "==============================================================================================="
end

"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                              A2 Main Parser Function                                   "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


# bandsArraywDates PARAMETER IN ORDER TO STORE INSTANCE VARIABLES FOR RESULTS, eventNumsArray TO ACCESS BANDS.NUMS
def a2Parse(eventNumsArray, bandsArraywDates)

    # MOVE TO TEMP_A2
    mvDirA2()

    # COLLECTS FILE(S) WITH .XLSX FORMAT (SHOULD ONLY BE ONE) IN ORDER TO PARSE IT
    fileNamesArray = []
    fileNamesArray = Dir["./*.xlsx"]
    puts "fileNamesArray:"
    ap fileNamesArray

    i = 0
    bandNum = 0
    while i < eventNumsArray.length
        puts "eventNumsArray.length = #{eventNumsArray.length}"

        workbookB7first = RubyXL::Parser.parse("#{fileNamesArray[0]}")

        # DEFINES WORKBOOK AS WORKSHEET (DONT DELETE)
        worksheet = workbookB7first[0]

        #  ASSIGNS BAND OBJECT FROM ARRAY
        band = bandsArraywDates[i]

        bandNumber = eventNumsArray[bandNum]

        parserA2(bandNumber, band, worksheet)

        #nruCount = dateRangeAndRowCount(worksheet, band.datesArray)
        resultsA2(band.eventName, band, worksheet)
    
        i += 1
        bandNum += 1
    end
end

