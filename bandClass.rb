
class Band
        
    @@stringsHash = {:band_name => "Enter Event Name:", 
        :start_date => "\nEnter starting date of event:\n(ex: for June 21, 2019 enter: 21/06/2019)\n",
        :total_days => "\nEnter number of days for the event: (ex: 4)", :band_num => "\nEnter BAND number:", :brand_name => "\nEnter bRand Name (ex. UCA):"}

    # OLD CODE FOR REFERENCE ONLY
    # puts stringsHash[:total_days]
    # stringsHash[:total_days] = gets.strip

    # COUNTER TO IGNORE THE 'puts stringsHash[:band_name]' THE SECOND TIME THROUGH IF 'n' IS SELECTED BY USER
    def getEventName()
        counter = 0
        event_name_check = ""
        event_name = ""
        @eventName = ""
        while event_name_check != 'y' || event_name_check != "exit"
            if counter == 0
                puts @@stringsHash[:band_name]
            end
            counter += 1
            event_name = gets.strip
            if event_name == 'exit'
                return
            end
            puts "\n"
            puts "Is '#{event_name}' the correct event name?\nPress 'y' for 'Yes' or 'n' for 'No' and press 'Enter'."
            event_name_check = gets.strip
            if event_name_check == "exit"
                return
            end
            if event_name_check == 'y'
                @eventName = event_name
                break
            end
            if event_name_check == 'n'
                puts "\n"
                puts "-------------------------------------------------------"
                puts "Re-Enter the Event Name and press 'Enter':"
                redo
            end
            if event_name_check != 'y' || event_name_check != 'n'
                puts "Please press 'y' for 'Yes' or 'n' for 'No' and hit the 'Enter' Key."
                puts "If you'd like to exit the program, type 'exit' and hit the 'Enter' Key."
                puts "\n"
                puts "**** Now Re-Enter the event name and hit 'Enter'. ****"
                redo
            end
        end
    end

    # GETTER TO DEFINE FINAL @eventName RESULT FOR ACCESSING THE INSTANCE VARIABLE OUTSIDE THE CLASS WITH DOT NOTATION
    def eventName
        @eventName
    end
  
    # COUNTER TO IGNORE THE 'puts @@stringsHash[:band_name]' THE SECOND TIME THROUGH IF 'n' IS SELECTED BY USER
    def getBrand(eventName)
        counter = 0
        brand_name_check = ""
        @brandName = ""
        while brand_name_check != 'y' || brand_name_check != "exit"
            if counter == 0
                puts @@stringsHash[:brand_name]
            end
            counter += 1
            brand_name = gets.strip
            if brand_name == 'exit'
                return
            end
            puts "\n"
            puts "Is '#{brand_name}' the correct bRand name?\nPress 'y' for 'Yes' or 'n' for 'No' and press 'Enter'."
            brand_name_check = gets.strip
            if brand_name_check == "exit"
                return
            end
            if brand_name_check == 'y'
                @brandName = brand_name
                break
            end
            if brand_name_check == 'n'
                puts "\n"
                puts "-------------------------------------------------------"
                puts "Re-Enter the bRand Name and press 'Enter':"
                redo
            end
            if brand_name_check != 'y' || brand_name_check != 'n'
                puts "Please press 'y' for 'Yes' or 'n' for 'No' and hit the 'Enter' Key."
                puts "If you'd like to exit the program, type 'exit' and hit the 'Enter' Key."
                puts "\n"
                puts "**** Now Re-Enter the bRand name and hit 'Enter'. ****"
                redo
            end
        end
    end

    # GETTER TO DEFINE FINAL @brandName RESULT FOR ACCESSING THE INSTANCE VARIABLE OUTSIDE THE CLASS WITH DOT NOTATION
    def brandName
        @brandName
    end    
 
    # COUNTER TO IGNORE THE 'puts stringsHash[:start_date]' THE SECOND TIME THROUGH IF 'n' IS SELECTED BY USER
    def getStartDate(eventName)
        counter = 0
        start_date_check = ""
        @startDate = ""
        while start_date_check != 'y' || start_date_check != "exit"
            if counter == 0
                puts @@stringsHash[:start_date]
            end
            counter += 1
            start_date = gets.strip
            if start_date == 'exit'
                return
            end
            puts "\n"
            puts "Is '#{start_date}' the correct start date? ---> ex. (??/??/????)\nPress 'y' for 'Yes' or 'n' for 'No' and press 'Enter'."
            start_date_check = gets.strip
            if start_date_check == 'exit'
                return
            end
            if start_date_check == 'y'
                @startDate = start_date
                break
            end
            if start_date_check == 'n'
                puts "\n"
                puts "-------------------------------------------------------"
                puts "Re-Enter the Start Date of '#{@eventName}' and press 'Enter':"
                redo
            end
            if start_date_check != 'y' || start_date_check != 'n'
                puts "\n"
                puts "Please press 'y' for 'Yes' or 'n' for 'No' and hit the 'Enter' Key."
                puts "If you'd like to exit the program, type 'exit' and hit the 'Enter' Key."
                puts "\n"
                puts "**** Now Re-Enter the Start Date of '#{@eventName}' and hit 'Enter'. ****"
            redo
            end
        end
    end
      
    # GETTER/SETTER TO DEFINE FINAL @startDate RESULT FOR ACCESSING THE INSTANCE VARIABLE OUTSIDE THE CLASS WITH DOT NOTATION
    attr_accessor :startDate

        # COUNTER TO IGNORE THE 'puts stringsHash[:total_days]' THE SECOND TIME THROUGH IF 'n' IS SELECTED BY USER
    def getTotalDays(eventName)
        counter = 0
        total_days_check = ""
        @totalDays = ""
        while total_days_check != 'y' || total_days_check != "exit"
            if counter == 0
                puts @@stringsHash[:total_days]
            end
            counter += 1
            total_days = gets.strip
            if total_days == 'exit'
                return
            end
            puts "\n"
            puts "Is '#{total_days}' the total amount of days of #{@eventName}?\nPress 'y' for 'Yes' or 'n' for 'No' and press 'Enter'."
            total_days_check = gets.strip
            if total_days_check == "exit"
                return
            end
            if total_days_check == 'y'
                @totalDays = total_days
                break
            end
            if total_days_check == 'n'
                puts "\n"
                puts "-------------------------------------------------------"
                puts "Re-Enter the correct amount of days for '#{@eventName}' and press 'Enter':"
                redo
            end
            if total_days_check != 'y' || total_days_check != 'n'
                puts "Please press 'y' for 'Yes' or 'n' for 'No' and hit the 'Enter' Key."
                puts "If you'd like to exit the program, type 'exit' and hit the 'Enter' Key."
                puts "\n"
                puts "**** Now Re-Enter the amount of days for '#{@eventName}' and hit 'Enter'. ****"
                redo
            end
        end
    end

    # GETTER TO DEFINE FINAL @totalDays RESULT FOR ACCESSING THE INSTANCE VARIABLE OUTSIDE THE CLASS WITH DOT NOTATION
    def totalDays
        @totalDays
    end

    # COUNTER TO IGNORE THE 'puts stringsHash[:band_num]' THE SECOND TIME THROUGH IF 'n' IS SELECTED BY USER
    def getBandNum(eventName)
        counter = 0
        band_num_check = ""
        @bandNum = ""
        while band_num_check != 'y' || band_num_check != "exit"
            if counter == 0
                puts @@stringsHash[:band_num]
            end
            counter += 1
            band_num = gets.strip
            if band_num == "exit"
                return
            end
            puts "\n"
            puts "Is '#{band_num}' the correct BAND number for #{@eventName}?\nPress 'y' for 'Yes' or 'n' for 'No' and press 'Enter'."
            band_num_check = gets.strip
            if band_num_check == "exit"
                return
            end
            if band_num_check == 'y'
                @bandNum = band_num 
                break
            end
            if band_num_check == 'n'
                puts "\n"
                puts "-------------------------------------------------------"
                puts "Re-Enter the correct BAND number for '#{@eventName}' and press 'Enter':"
                redo
            end
            if band_num_check != 'y' || band_num_check != 'n'
                puts "Please press 'y' for 'Yes' or 'n' for 'No' and hit the 'Enter' Key."
                puts "If you'd like to exit the program, type 'exit' and hit the 'Enter' Key."
                puts "\n"
                puts "**** Now Re-Enter the BAND number for #{@eventName} 'Enter'. ****"
                redo
            end
        end
    end

    # GETTER TO DEFINE FINAL @bandNum RESULT FOR ACCESSING THE INSTANCE VARIABLE OUTSIDE THE CLASS WITH DOT NOTATION
    def bandNum
        @bandNum
    end

    # FOR ARRAY OF DATES TO INCLUDE OR EXCLUDE WHILE PARSING EACH B7/B3
    attr_accessor :datesArray, :a2StartDate, :a2EndDate

    # FOR NEW BAND NUMBERS FROM THE NEW BANDS CREATING DURING EVENT FOR B7-2 DRIVE/PARSE.RB
    attr_accessor :newBandNumbsb7_2

    # FOR HOLDING THE adminsCount FOR SUBTRACTING FROM VARIABLES IN THE LATER PARSING
    attr_accessor :adminCount

    # FOR TOTAL BANDSARRAY AND EVENTNAMESARRAY STORAGE IN ORDER TO ACCESS IN 'GO' FUNCTIONS IN RUN
    attr_accessor :bandsArray, :eventNamesArray

    "-----------------------------------------------------------------------------------------------------------------------------------------------------"
    "                                                           Result Variables for B7.1, B3, A2, and B7.2"
    "-----------------------------------------------------------------------------------------------------------------------------------------------------"
        
    attr_accessor :campDates, :totalMemberCount, :coachesCount, :nruCount, :nruPercentage, :totalLeaderCount, :newLeaderCount, :newLeaderPerc, :newGblCount, 
        :gblAvg, :gblNru, :nruPerGbl, :totalNru, :activitySum, :uniqueUserActivity, :sumTotalMemberAvg, :uniqueMemberavg, :testCoachesCount, :newGblPerc

    # hoursMinutes2 IS TO ACCOUNT FOR EXTRA MINUTE THAT MIGHT NEED TO BE ACCOUNTED FOR FOR CHECKING TIME SUBMITED FOR CELL CHECKING FOR DOWNLOAD LINKS
    attr_accessor :a2_ , :a2_ , :a2_ , :a2_ , :hoursMinutesA2_backUp, :hoursMinutesB71_backUp, :hoursMinutesB3_backUp, :hoursMinutes2, :hoursMinutesB72_backUp
    "-----------------------------------------------------------------------------------------------------------------------------------------------------"
    "-----------------------------------------------------------------------------------------------------------------------------------------------------"

    # puts "bandsArray << stringsHash (Before hitting 'go')"
    # bandsArray << stringsHash
    def loopOrGo()
        puts "\n"
        puts "----------------------------------------------------------------------------------"
        puts "If no more BANDs with the date ** #{@startDate} ** to enter info for, type 'go' and hit 'Enter'."
        puts "Otherwise, hit 'Enter' to begin submitting another Summer Camp BAND's info."
        gets.strip != "go"
    end
end ### END OF BAND CLASS ###
