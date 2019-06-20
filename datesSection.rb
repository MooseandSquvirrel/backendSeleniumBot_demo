

"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                            Dates Section                                               "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    

def dates(bandsArray)
    bandsArray.each do |x|
        puts "print x:"
        ap x
        # COVER THE 3 DATES AFTER event.startDate
        puts "event.startDate:"
        puts x.startDate
        daysParsed = Date.parse(x.startDate)
        datesArray = []
        i = 0
        # EVENT DATE RANGE PLUS 3 DAYS AFTER --------- MIGHT BE ABLE TO REMOVE 3 DAYS AFTER EVENT OR USE FOR MAIN BANDS (NOT SUMMER CAMPS)
        while i < 3
            datesArray << daysParsed.to_s
            if x.totalDays == 1
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

        # COVERS THE DATES LEADING UP TO THE EVENT'S :start_date (14 DAYS BEFORE :start_date)
        daysParsed = Date.parse(x.startDate)
        i = 0
        # -14 for two weeks before x 
        earlyDaysParsed = daysParsed - 14
        while i < 15
            datesArray << earlyDaysParsed.to_s
            earlyDaysParsed += 1
            i += 1
        end
        
        datesArray = datesArray.sort
        # SETTING datesArray INSIDE EVENT INSTANCE VARIABLE
        x.datesArray = datesArray
        puts "p x.datesArray"
        p x.datesArray
        puts "ap x.datesArray"
        ap x.datesArray

        # CREATING DATE RANGE FOR FINAL RESULTS TABLE (EX. "6/23 - 6/26")
        days = Date.parse(x.startDate)
        puts "days:"
        # EXTRACTS MONTH AND DAY FROM PARSED DATE STRING
        dateMonth = days.strftime('%m')
        dateDayBeg = days.strftime('%d').to_i
        # GETS ENDING DATE OF EVENT ( -1 TO :total_days SO THE ARITHMATIC GETS THE CORRECT DAY)
        dateDayEnd = days.strftime('%d').to_i + (x.totalDays.to_i - 1)
        x.campDates = "#{dateMonth}/#{dateDayBeg} - #{dateMonth}/#{dateDayEnd}"
        puts "dateMonth:"
        puts dateMonth
        puts "dateDayBeg:"
        puts dateDayBeg
        puts "dateDayEnd:"
        puts dateDayEnd
        puts "campDates stored in event.campDates as:"
        puts x.campDates
        puts "x.datesArray:"
        print x.datesArray
        ap x.datesArray
    end
end
