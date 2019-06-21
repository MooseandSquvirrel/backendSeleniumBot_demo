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
def adminsList()
    rightDir = '~/fixit/backendSelenium'
    Dir.chdir(File.expand_path(rightDir))
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
    adminsArray = adminsArray.push("Vinny Guglietta")
    rightDir = '~/fixit/backendSelenium/TEMP_B3'
    Dir.chdir(File.expand_path(rightDir))
    return adminsArray
end

=begin
puts "adminsArray"
ap adminsArray

data_file = "~/Downloads/#{sdf}.xlsx"
file = File.open(File.expand_path(data_file), 'r')
=end

