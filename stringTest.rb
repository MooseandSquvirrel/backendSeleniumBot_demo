require 'rubygems'
require 'date'

puts "start date:"
start_date = gets.chomp
puts "total days"
total_days = gets.chomp.to_i

puts "start dates:"
puts start_date
daysParsed = Date.parse(start_date)
datesArray = []
i = 0
while i < total_days
    datesArray << daysParsed.to_s
    if total_days == 1
        break
    else
        daysParsed += 1
        puts "Dates Array:"
        puts "========"
        puts datesArray
        puts "\n"
        i += 1
    end
end
