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


# bandsArray PARAMETER IN ORDER TO STORE INSTANCE VARIABLES FOR RESULTS, eventNumsArray TO ACCESS BANDS.NUMS
def b71Parse()

    # Move to TEMP_B7
    mvDir()

    fileNamesArray = []
    fileNamesArray = Dir["./*.xlsx"]
    puts "fileNamesArray:"
    ap fileNamesArray
    i = 0
    while i < 2
        workbookB7first = RubyXL::Parser.parse("#{fileNamesArray[i]}")
        i += 1
    end
end
b71Parse()