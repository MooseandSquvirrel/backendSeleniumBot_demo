#!/usr/env/bin ruby

require 'date'
require 'time'
require 'rubygems'



puts "How many days?"
days = gets.chomp.to_i
puts "Starting Date?"
startDate = gets.chomp
daysParsed = Date.parse(startDate)
puts "daysParsed"
puts daysParsed
datesArray = []
i = 0
while i < days
    datesArray << daysParsed = (daysParsed += 1)
    puts "Dates Array:"
    puts "========"
    puts datesArray
    puts "\n"
    i += 1
end

