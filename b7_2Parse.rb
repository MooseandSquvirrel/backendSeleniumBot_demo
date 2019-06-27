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
def mvDirB7_2()
    puts "----- Moving Directories to reach TEMP_B7_2 Directory -----"
    puts "Directory before:"
    puts Dir.pwd
    b7Dir = '~/fixit/backendSelenium/TEMP_B7_2'
    Dir.chdir(File.expand_path(b7Dir))
    puts "Directory is now:"
    puts Dir.pwd
end

def adminCounter(bandNumber, band, worksheet)
    adminNumbArray = adminNumbers()
    # COLLECTS ADMINS FOR MATH
    index = 1
    totalMemberCounter = 0
    nruCounter = 0
    adminNumbs = 0
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
                adminNumbs += 1
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
    return adminNumbs
end


def parserb72(bandNumber, band, worksheet, adminNumbs)
    # CLEANS USERS THAT DIDN'T JOIN FROM THIS SPECIFIC EVENT
    puts"\n\n\n\n"
    puts "bandNumber: #{bandNumber}"
    puts"\n\n\n\n"

    index = 1
    totalMemberCounter = 0
    nruCounter = 0
    gblNru = 0
    counter = 0
    cellOriginalBandNum = worksheet.sheet_data[index][7].value
    while counter < worksheet.sheet_data.rows.size - 1
        # IF USER ENTERED BANDNUMBER MATCHES THE 'DATE JOINED BAND' LASTCELL AND ALSO IN THE DATE RANGE OF EVENT -  MEANS PERSON IS NRU
        if cellOriginalBandNum == worksheet.sheet_data[index][0].value
            nruCounter += 1
            index += 1
        else
            index += 1
        end
        counter += 1
    end

    puts "nruCounter for b7_2 parse: #{nruCounter}"
    puts "adminNumbs subtracted from nruCounter (to equal band.gblNru): #{adminNumbs}"
    puts "gblNru: #{gblNru}"
    # **FINAL RESULT** gblNru, nruPerGbl, totalNru
    gblNru = (nruCounter - adminNumbs).to_f
    puts "gblNru: #{gblNru}"
    band.gblNru = gblNru
    puts "band.newGblCount: #{band.newGblCount}"
    band.nruPerGbl = (nruCounter / band.newGblCount)
    band.totalNru = (band.nruCount + nruCounter).to_f
   
end

# **FINAL RESULT** NRUCOUNT STORING RESULTS INTO ORIGINAL EVENT OBJECTS' INSTANCE VARIABLES
def resultsB7_2(eventName, band, worksheet)
 
    puts "==============================================================================================="
    puts "Results of Second B7:"
    puts "-----------------------------------"
    puts "band.gblNru: #{band.gblNru}"
    puts "band.nruPerGbl: #{band.nruPerGbl}"
    puts "band.totalNru: #{band.totalNru}"
    puts "-----------------------------------"
    puts "==============================================================================================="
end

"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                              B7_2 Main Parser Function                                 "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


# bandsArraywDates PARAMETER IN ORDER TO STORE INSTANCE VARIABLES FOR RESULTS, eventNumsArray TO ACCESS BANDS.NUMS
def b7_2Parse(eventNumsArray, bandsArraywDates)

    # MOVE TO TEMP_B7
    mvDirB7_2()

    # COLLECTS FILE(S) WITH .XLSX FORMAT (SHOULD ONLY BE ONE) IN ORDER TO PARSE IT
    fileNamesArray = []
    fileNamesArray = Dir["./*.xlsx"]
    puts "fileNamesArray:"
    ap fileNamesArray

    # CREATE ARRAY OF ALL BAND NUMBS FOR ALL NEW GBLS LISTED IN THE SHEET
    workbookB7first = RubyXL::Parser.parse("#{fileNamesArray[0]}")
    worksheet = workbookB7first[0]
    cellBandNumArray = []
    index = 1
    while index < worksheet.sheet_data.rows.size - 1
        cellBandNum = worksheet.sheet_data[index][0].value
        cellBandNumArray << cellBandNum
        index += 1
    end
    gblBandNumArray = cellBandNumArray.uniq
    gblbandNumArrayLength = gblBandNumArray.length

    # 
    adminNumbs = adminCounter(bandNumber, band, worksheet)

    i = 1
    bandNum = 0
    while i < eventNumsArray.length

        workbookB7first = RubyXL::Parser.parse("#{fileNamesArray[0]}")

        # DEFINES WORKBOOK AS WORKSHEET (DONT DELETE)
        worksheet = workbookB7first[0]

        #  ASSIGNS BAND OBJECT FROM ARRAY
        band = bandsArraywDates[i]

=begin
        # ASSIGNING GBLS FROM ARRAY OF GBLS ONE AT A TIME
        bandNumber = gblBandNumArray[bandNum]
=end
        # ASSIGNING GBLS FROM ARRAY OF GBLS ONE AT A TIME
        bandNumber = gblBandNumArray[bandNum]

        parserb72(bandNumber, band, worksheet, adminNumbs)

        #nruCount = dateRangeAndRowCount(worksheet, band.datesArray)
        resultsB7_2(band.eventName, band, worksheet)
    
        i += 1 
        bandNum += 1 
    end
end






=begin

# bandsArraywDates PARAMETER IN ORDER TO STORE INSTANCE VARIABLES FOR RESULTS, eventNumsArray TO ACCESS BANDS.NUMS
def b7_2Parse(eventNumsArray, bandsArraywDates)

    # MOVE TO TEMP_B7
    mvDirB7_2()

    # COLLECTS FILE(S) WITH .XLSX FORMAT (SHOULD ONLY BE ONE) IN ORDER TO PARSE IT
    fileNamesArray = []
    fileNamesArray = Dir["./*.xlsx"]
    puts "fileNamesArray:"
    ap fileNamesArray

    # CREATE ARRAY OF ALL BAND NUMBS FOR ALL NEW GBLS LISTED IN THE SHEET
    workbookB7first = RubyXL::Parser.parse("#{fileNamesArray[0]}")
    worksheet = workbookB7first[0]
    cellBandNumArray = []
    index = 0
    while index < worksheet.sheet_data.rows.size - 1
        cellBandNum = worksheet.sheet_data.[index][0]
        cellBandNumArray << cellBandNum
        index += 1
    end
    gblBandNumArray = cellBandNumArray.uniq
    gblbandNumArrayLength = gblBandNumArray.length

    i = 0
    bandNum = 0
    while i < gblbandNumArrayLength
        puts "gblbandNumArrayLength = #{gblbandNumArrayLength}"

        workbookB7first = RubyXL::Parser.parse("#{fileNamesArray[0]}")

        # DEFINES WORKBOOK AS WORKSHEET (DONT DELETE)
        worksheet = workbookB7first[0]

        #  ASSIGNS BAND OBJECT FROM ARRAY
        band = bandsArraywDates[i]

        bandNumber = gblBandNumArray[bandNum]

        adminNumbs = adminCounter(bandNumber, band, worksheet)

        parser(bandNumber, band, worksheet, adminNumbs)

        #nruCount = dateRangeAndRowCount(worksheet, band.datesArray)
        resultsB7_2(band.eventName, band, worksheet)
    
        i += 1
        bandNum += 1
    end
end


=end