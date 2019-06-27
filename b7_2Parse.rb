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

def adminCounterB72(band, worksheet)
    adminNumbArray = adminNumbers()
    return adminNumbArray
end


def parserb72(band, worksheet, adminNumbArray)
    # CLEANS USERS THAT DIDN'T JOIN FROM THIS SPECIFIC EVENT
    index = 1
    totalMemberCounter = 0
    nruCounter = 0
    gblNru = 0
    counter = 0
    nruArray = []
    
    while counter < worksheet.sheet_data.rows.size - 1
        cellOriginalBandNum = worksheet.sheet_data[index][7].value
        puts "cellOringalBandNum now #{cellOriginalBandNum}"
        if band.newBandNumbsb7_2.include?("#{cellOriginalBandNum}")
            nruArray << cellOriginalBandNum
            nruCounter += 1
            puts "cellOringalBandNum: #{cellOriginalBandNum} counted as NRU !!!! \nnruCounter: #{nruCounter}"
            index += 1
        else
            index += 1
        end
        counter += 1
    end

    puts "nruArray.length #{nruArray.length}"
    finalNruArray = nruArray - adminNumbArray
    puts "band.adminCOunt: #{band.adminCount}"
    gblNru= finalNruArray.length - band.adminCount

    puts "nruCounter for b7_2 parse: #{nruCounter}"
    #puts "adminNumbs subtracted from nruCounter (to equal band.gblNru): #{adminNumbs}"
    puts "gblNru: #{gblNru}"
    # **FINAL RESULT** gblNru, nruPerGbl, totalNru
   # gblNru = (nruCounter - adminNumbs).to_f
    band.gblNru = gblNru.to_f
    puts "band.newGblCount: #{band.newGblCount}"
    band.nruPerGbl = (gblNru / band.newGblCount)
    band.totalNru = (band.nruCount + gblNru).to_f
   
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
=begin
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
=end

    i = 0
    bandNum = 0
    while i < eventNumsArray.length

        puts "eventNumsArray.length: #{eventNumsArray.length}"

        workbookB7first = RubyXL::Parser.parse("#{fileNamesArray[0]}")

        # DEFINES WORKBOOK AS WORKSHEET (DONT DELETE)
        worksheet = workbookB7first[0]

        #  ASSIGNS BAND OBJECT FROM ARRAY
        band = bandsArraywDates[i]

        #  GETTING COUNT OF ADMIN NUMBS IN SPREADSHEET TO ME SUBTRACTED FROM TOTAL NRU COUNTS IN PARSERB72 (MIGHT BE NO ADMINS IN B7_2, THIS IS JUST FOR EDGE CASE POTENTIALLY)
        adminNumbArray = adminCounterB72(band, worksheet)


=begin
        # ASSIGNING GBLS FROM ARRAY OF GBLS ONE AT A TIME
        bandNum = gblBandNumArray[bandNum]
=end

        parserb72(band, worksheet, adminNumbArray)

        #nruCount = dateRangeAndRowCount(worksheet, band.datesArray)
        resultsB7_2(band.eventName, band, worksheet)
    
        i += 1 
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

        bandNum = gblBandNumArray[bandNum]

        adminNumbs = adminCounterB72(band, worksheet)

        parser(band, worksheet, adminNumbs)

        #nruCount = dateRangeAndRowCount(worksheet, band.datesArray)
        resultsB7_2(band.eventName, band, worksheet)
    
        i += 1
        bandNum += 1
    end
end


=end