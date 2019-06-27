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
def mvDirB7()
    puts "----- Moving Directories to reach TEMP_B7 Directory -----"
    puts "Directory before:"
    puts Dir.pwd
    b7Dir = '~/fixit/backendSelenium/TEMP_B7'
    Dir.chdir(File.expand_path(b7Dir))
    puts "Directory is now:"
    puts Dir.pwd
end

def adminCounterb71(bandNumber, band, worksheet)
    adminNumbArray = adminNumbers()
    # COLLECTS ADMINS FOR MATH
    index = 1
    totalMemberCounter = 0
    nruCounter = 0
    adminCounter = 0
    counter = 0
    while counter < worksheet.sheet_data.rows.size - 1
        puts "worksheet.sheet_data[index][7].value : #{worksheet.sheet_data[index][7].value}"
        cellDate = worksheet.sheet_data[index][3].value
        lastCell = worksheet.sheet_data[index][7].value
        userNum = worksheet.sheet_data[index][1].value
        # IF USER ENTERED BANDNUMBER MATCHES BAND NUMBER FIRST ROW (IDENTIFY CORRECT BAND TO PARSE IN DOCUMENT)
        if bandNumber == worksheet.sheet_data[index][0].value
            totalMemberCounter += 1
            # COULD EVENTUALLY INCLUDE BANDS SHARED ACCOUNT USERNUMS IN userNum ARRAY INSIDE stringToArrayCsv.rb ARRAY
            if adminNumbArray.include?("#{userNum}")
                adminCounter += 1
            # IF USER ENTERED BANDNUMBER MATCHES THE 'DATE JOINED BAND' LASTCELL AND ALSO IN THE DATE RANGE OF EVENT -  MEANS PERSON IS NRU
            elsif bandNumber == lastCell && band.datesArray.include?("#{cellDate}")
                nruCounter += 1
            end
            index += 1
        else
            index += 1
        end
        counter += 1
    end
    band.adminCount = adminCounter
    return adminCounter
end


def parserb71(bandNumber, band, worksheet, adminCount)
    # CLEANS USERS THAT DIDN'T JOIN FROM THIS SPECIFIC EVENT
    index = 1
    totalMemberCounter = 0
    nruCounter = 0
    counter = 0
    while counter < worksheet.sheet_data.rows.size - 1
        puts "worksheet.sheet_data[index][7].value : #{worksheet.sheet_data[index][7].value}"
        cellDate = worksheet.sheet_data[index][3].value
        lastCell = worksheet.sheet_data[index][7].value
        # IF USER ENTERED BANDNUMBER MATCHES BAND NUMBER FIRST ROW (IDENTIFY CORRECT BAND TO PARSE IN DOCUMENT)
        if bandNumber == worksheet.sheet_data[index][0].value
            totalMemberCounter += 1
            # IF USER ENTERED BANDNUMBER MATCHES THE 'DATE JOINED BAND' LASTCELL AND ALSO IN THE DATE RANGE OF EVENT -  MEANS PERSON IS NRU
            if bandNumber == lastCell && band.datesArray.include?("#{cellDate}")
                nruCounter += 1
            end
            index += 1
        else
            index += 1
        end
        counter += 1
    end
    # **FINAL RESULT** SAVE ROWCOUNT FOR MATH OF TOTAL MEMBERS -- subtract 1 FOR TITLE ROW AT INDEX[0] -- to_f FOR DIVISION PURPOSES LATER
    band.totalMemberCount = (totalMemberCounter).to_f
    band.testCoachesCount = (totalMemberCounter - adminCount)
    # **FINAL RESULT** SAVE NRU COUNT INTO BAND OBJ EVENT
    band.nruCount = nruCounter.to_f

end

# **FINAL RESULT** NRUCOUNT STORING RESULTS INTO ORIGINAL EVENT OBJECTS' INSTANCE VARIABLES
def resultsB7(eventName, band, worksheet)
 
    puts "==============================================================================================="
    puts "Results of first B7 (#{eventName}):"
    puts "-----------------------------------"
    puts "totalMemberCount: #{band.totalMemberCount}"
    puts "coachesCount: #{band.coachesCount}"
    puts "nruCount: #{band.nruCount}"
    puts "-----------------------------------"
    puts "==============================================================================================="
end

"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                              B7_1 Main Parser Function                                 "
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
        puts "eventNumsArray.length = #{eventNumsArray.length}"

        workbookB7first = RubyXL::Parser.parse("#{fileNamesArray[0]}")

        # DEFINES WORKBOOK AS WORKSHEET (DONT DELETE)
        worksheet = workbookB7first[0]

        #  ASSIGNS BAND OBJECT FROM ARRAY
        band = bandsArraywDates[i]

        bandNumber = eventNumsArray[bandNum]

        adminCount = adminCounterb71(bandNumber, band, worksheet)

        parserb71(bandNumber, band, worksheet, adminCount)

        #nruCount = dateRangeAndRowCount(worksheet, band.datesArray)
        resultsB7(band.eventName, band, worksheet)
    
        i += 1
        bandNum += 1
    end
end

