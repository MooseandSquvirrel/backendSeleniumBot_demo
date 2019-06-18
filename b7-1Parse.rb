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
# REQUIRE ADMINS.LIST.RB
############################
require './adminsList.rb' 
############################

=begin TESTING COMMENTING OUT TO SEE IF THIS IS EXTRA CODE FOR THIS MODULE
# SETTING UP ARRAY OF ADMINS NAMES FROM ADMINS EXCEL SPREADSHEET -- FOR USE IN B3 (AND B7.1?) TO REMOVE ADMINS WHO CREATED BANDS
adminsArray = adminsList()

puts "adminsArray"
ap adminsArray
=end

def dateRange()
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

def resultsB7(eventName, band, rowCount, worksheet)
    nruCount = worksheet.sheet_data.rows.size - 1
    puts "nruCout: #{nruCount}"

    puts "=============================="
    puts "Results of first B7 (#{eventName}):"
    # to_f BELOW SO THAT DIVISION FOR PERCENTAGE DOESN'T EQUAL 0
    band.nruCount = nruCount.to_f
    puts "NRUs: #{band.nruCount}"
    band.newMemberAvg = ((nruCount / rowCount.to_f) * 100).round(2)
    puts "NRUs Percentage for the event '#{band.eventName}': #{band.newMemberAvg}%"
    puts "=============================="
end


# bandsArray PARAMETER IN ORDER TO STORE INSTANCE VARIABLES FOR RESULTS, eventNumsArray TO ACCESS BANDS.NUMS
def b71Parse(bandsArray, eventNumsArray)

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
        band = bandsArray[i]
    
        # SAVE ROWCOUNT FOR MATH OF TOTAL MEMBERS -- subtract 1 FOR TITLE ROW AT INDEX[0]
        rowCount = worksheet.sheet_data.rows.size - 1
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
        ap bandsArray
        resultsB7(band.eventName, band, rowCount, worksheet)
        puts "band"
        print band
        puts "band.eventName"
        puts band.eventName
        i += 1
        bandNum += 1
    end
end

