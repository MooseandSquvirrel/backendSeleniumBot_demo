#!/usr/env/bin ruby

####################################
# EXCELTESTPARSER REQUIRES
####################################
require 'rubyXL'
require 'rubyXL/convenience_methods'
require 'rubygems'
require 'awesome_print'
require 'date'
####################################
# TEST_CREEP REQUIRES
####################################
require 'selenium-webdriver'
require 'pp'
require 'ap'
require 'rspec/expectations'
require 'io/console'
####################################

puts "\n\n"
print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n"
print "                                            WELCOME TO Parser!                                          \n"
print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n"

print "\n\nThis program will continue until 'exit' is entered on the command line.\nIf exited, 'Up Arrow' then 'Enter' will restart.\n\n"
print "\n**** MAKE SURE BEFORE YOU BEGIN TO CONNECT TO --VPN PULSE SECURE-- ****\n\n"

# USERNAME AND PASSWORD ENTERING WITH HIDDEN INPUT AND TOKENIZATION

# USERAME
def userName()
    userName_check = ""
    while userName_check != 'y' || userName_check != "exit"
        puts "Begin by entering your backend Username (employee i.d.):"
        userName = gets.strip
        if userName == 'exit'
            return
        end
        puts "\n"
        puts "Is '#{userName}' the correct user name?\nPress 'y' for 'Yes' or 'n' for 'No' and press 'Enter'."
        userName_check = gets.strip
        if userName_check == "exit"
            return
        end
        if userName_check == 'y'
            $_userNameVar = userName 
            break
        end
        if userName_check == 'n'
            puts "\n"
            puts "-------------------------------------------------------"
            puts "Re-Enter the correct user name and press 'Enter':"
            redo
        end
        if userName_check != 'y' || userName_check != 'n'
            puts "Please press 'y' for 'Yes' or 'n' for 'No' and hit the 'Enter' Key."
            puts "If you'd like to exit the program, type 'exit' and hit the 'Enter' Key."
            puts "\n"
            puts "**** Now Re-Enter the correct user name and hit 'Enter'. ****"
            redo
        end
    end
end

# PASSWORD
def pwd()
    pwd_check = ""
    while pwd_check != 'y' || pwd_check != "exit"
        print "Enter backend password -- TEXT WILL BE INVISIBLE, AFTER TYPING PASSWORD HIT ENTER TWICE:\n"
        pwd = STDIN.noecho(&:gets).chomp
        if pwd == 'exit'
            return
        end
        puts "\n"
        puts "Did you enter the correct password? (Even though it is invisible :) ....)\nPress 'y' for 'Yes' or 'n' for 'No' and press 'Enter'."
        pwd_check = gets.strip
        if pwd_check == "exit"
            return
        end
        if pwd_check == 'y'
            $_pwd = pwd
            break
        end
        if pwd_check == 'n'
            puts "\n"
            puts "-------------------------------------------------------"
            puts "Re-Enter the correct password and press 'Enter':"
            redo
        end
        if pwd_check != 'y' || pwd_check != 'n'
            puts "Please press 'y' for 'Yes' or 'n' for 'No' and hit the 'Enter' Key."
            puts "If you'd like to exit the program, type 'exit' and hit the 'Enter' Key."
            puts "\n"
            puts "**** Now Re-Enter the correct password and hit 'Enter'. ****"
            redo
        end
    end
end

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
                    @brandName = brand_name_check
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
                    @startDate = start_date_check
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
          
        # GETTER TO DEFINE FINAL @startDate RESULT FOR ACCESSING THE INSTANCE VARIABLE OUTSIDE THE CLASS WITH DOT NOTATION
        def startDate
            @startDate
        end

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

        "-----------------------------------------------------------------------------------------------------------------------------------------------------"
        "                                                           Result Variables for B7.1, B3, A2, and B7.2"
        "-----------------------------------------------------------------------------------------------------------------------------------------------------"
            
        attr_accessor :campDates, :totalMembers, :activitySum, :actvPerMem, :nruCount, :newMemberAvg, :newLeaderCounter, :newLeaderAvg, :new_GBL_LeaderCount,
            :gblAvg, :gblNru, :nruPerGbl

        "-----------------------------------------------------------------------------------------------------------------------------------------------------"
        "-----------------------------------------------------------------------------------------------------------------------------------------------------"

        # puts "bandsArray << stringsHash (Before hitting 'go')"
        # bandsArray << stringsHash
        def loopOrGo()
            puts "\n"
            puts "----------------------------------------------------------------------------------"
            puts "If no more BANDs to enter info for, type 'go' and hit 'Enter'."
            puts "Otherwise, hit 'Enter' to begin submitting another Summer Camp BAND's info."
            gets.strip != "go"
        end
end ### END OF BAND CLASS ###

    # FUNCTION RETURNS ARRAY OF EVENT NAMES FROM EACH EVENT
    def eventNumsArray(bandsArray)
        eventNumsArray = bandsArray.collect {|x| x.bandNum}         #" I NEED TO FIGURE OUT HOW TO COLLECT ALL THE BAND NUMBERS INTO AN ARRAY FROM THEIR OBJECTS"
    end

    def loadingMessage()
        puts "\n"
        print "THANK YOU. NOW I WILL DO WORK FOR YOU :)"
        sleep(1)
        print '.'
        sleep(1)
        print '.'
        sleep(1)
        print '.'
        sleep(1)
        puts '.'
    end
  

"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                        Driver Login  (up to iFrame switch)                             "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
 
def navigate(userNameVar)
    $_browser = Selenium::WebDriver.for :chrome
    $_browser.get "https://iims.navercorp.com/login?targetUrl=https://iims.navercorp.com/"
    
    $_wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    
    # USR DATA ENTRY
    form = $_wait.until {
        element = $_browser.find_element(:name, "user")
        element if element.displayed?
    }
    sleep(1)
    form.send_keys("#{$_userNameVar}")
    #### form.send_keys("#{naverUser}")
    
    # PW DATA ENTRY
    form = $_wait.until {
        element = $_browser.find_element(:name, "password")
        element if element.displayed?
    }
    sleep(1)
    form.send_keys("#{$_pwd}")
    #### form.send_keys("#{naverPwd}")


    # FINDS THE FORM BUTTON WITH XPATH AND THEN USES .execute_script (A JAVASCRIPT ACTION I BELIEVE)
    if button = $_browser.find_element(:xpath, "//*[@id='login-btn']")
        puts "Found form 'Submit' 'login-btn'."
        button = $_browser.find_element(:xpath, "//*[@id='login-btn']").click
        sleep(1)
    else
        puts "No form 'Submit' login-btn found."
    end

    # FINDS THE CARD LINK TO CLICK TO GO TO THE MAIN BACKEND MENU
    if card = $_browser.find_element(:xpath, "//*[@id='card-view-search-area']/li")
        puts "Card link found.\n"
        card = $_browser.find_element(:xpath, "//*[@id='card-view-search-area']/li").click
        sleep(1)
        puts "================================="
        puts "Main menu of BAND backend reached.\n"
        puts "================================="
    else
        puts "Card link not found for clickable 'square' card before Main Menu screen."
    end

    # FIND THE LINK TO STATISTICS PAGE, ACCES STATISTICS PAGE
    sleep(3)
    if statistics = $_browser.find_element(:xpath, "//*[@id='carousel']/div[1]/ul/li[8]/div/a")
        puts "Statistics link found.\n"
        card = $_browser.find_element(:xpath, "//*[@id='carousel']/div[1]/ul/li[8]/div/a").click
        sleep(1)
        puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
        puts "Statistics menu of BAND backend reached.\n"
        puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
    else
        puts "Statistcs link not found."
    end

    # FRAME/IFRAME SWITCH REQUIRED TO CONTINUE ACCESSING INNER BROWSER NON-POP-UP WINDOWS/ELEMENTS
    $_browser.switch_to.frame("svc-iframe")
end

"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                  Function Entering Bands for First B7                                  "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

def b7_1(eventBandNumsArray, bandsLength)
    bandsNumArray = eventBandNumsArray

    # GETTING ALL BAND NUMBS WITH .collect (ALREADY PERFORMED ABOVE TO GET THE eventNumsArray ((JUST STORED THAT ARRAY INTO bandsNumArray)))
    # bandsNumArray = bandsArray.collect {|x| x.bandNum}

    bandNameCounter = 0
    # until bandNameCounter == bandsLength
        bandsNumArray[bandNameCounter]
        # STORING ALL FUNCTION OPTIONS AND SELECTING B7
        # INTERACTING WITH DROPDOWN BOX
        select_list = $_wait.until {
            if element = $_browser.find_element(:xpath, "//*[@id='templateNo']")
                element = $_browser.find_element(:xpath, "//*[@id='templateNo']")
            end
        }
        puts "Function collected from dropdown function options. (into select_list):"
        pp select_list
        
        # EXTRACTING ALL OPTIONS FROM THE DROPDOWN BOX
        options=select_list.find_elements(:tag_name => "option")

        # REFERENCE URL http://elementalselenium.com/tips/5-select-from-a-dropdown
        dropdown = $_browser.find_element(id: 'templateNo') #### Comma needed between id: and 'templateNo' ?
            select_list = Selenium::WebDriver::Support::Select.new(dropdown)
            select_list.select_by(:value, '45')
            puts "Dropdown option selected:"
            puts selected_option = select_list.selected_options[0].text
            sleep(2)

        # USING BAND PARAMETERS FROM COMMANDLINE GETS AT START OF CREEPER (ARRAY?)
        $_form = $_wait.until {
            if element = $_browser.find_element(:tag_name, "textarea")
                puts "Inputing BAND name into data field."
                element = $_browser.find_element(:tag_name, "textarea")
            else
                puts "BAND data not entered into text field."
            end
            element if element.displayed?
        }
        until bandNameCounter == bandsLength
            $_form.send_keys("#{bandsNumArray[bandNameCounter]}\n")
            bandNameCounter += 1
        end
        sleep(1)

        puts "Good"
end
  
def clickit()
    $_form = $_wait.until {
        element = $_browser.find_element(:id, "execute")
        element if element.displayed?
    }
    $_form.click
    sleep(5)
    puts "Execute Clicked"
end

def alert_clickit()
    # alert = $_browser.switch_to.alert
    $_form = $_wait.until {
        alert = $_browser.switch_to.alert
    }
    $_form.accept
    sleep(5)
    puts "Alert Clicked"
end


"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                  Function Entering Bands for First B3                                  "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

def b3(eventBandNumsArray, bandsLength)
    bandsNumArray = eventBandNumsArray

    # GETTING ALL BAND NUMBS WITH .collect (ALREADY PERFORMED ABOVE TO GET THE eventNumsArray ((JUST STORED THAT ARRAY INTO bandsNumArray)))
    # bandsNumArray = bandsArray.collect {|x| x.bandNum}

    bandNameCounter = 0
    # until bandNameCounter == bandsLength
        bandsNumArray[bandNameCounter]
        # STORING ALL FUNCTION OPTIONS AND SELECTING B7
        # INTERACTING WITH DROPDOWN BOX
        select_list = $_wait.until {
            if element = $_browser.find_element(:xpath, "//*[@id='templateNo']")
                element = $_browser.find_element(:xpath, "//*[@id='templateNo']")
            end
        }
        puts "Function collected from dropdown function options. (into select_list):"
        pp select_list
        
        # EXTRACTING ALL OPTIONS FROM THE DROPDOWN BOX
        options=select_list.find_elements(:tag_name => "option")

        # REFERENCE URL http://elementalselenium.com/tips/5-select-from-a-dropdown
        dropdown = $_browser.find_element(id: 'templateNo') #### Comma needed between id: and 'templateNo' ?
            select_list = Selenium::WebDriver::Support::Select.new(dropdown)
            select_list.select_by(:value, '45')
            puts "Dropdown option selected:"
            puts selected_option = select_list.selected_options[0].text
            sleep(2)

        # USING BAND PARAMETERS FROM COMMANDLINE GETS AT START OF CREEPER (ARRAY?)
        $_form = $_wait.until {
            if element = $_browser.find_element(:tag_name, "textarea")
                puts "Inputing BAND name into data field."
                element = $_browser.find_element(:tag_name, "textarea")
            else
                puts "BAND data not entered into text field."
            end
            element if element.displayed?
        }
        until bandNameCounter == bandsLength
            $_form.send_keys("#{bandsNumArray[bandNameCounter]}\n")
            bandNameCounter += 1
        end
        sleep(1)

        puts "Good"
end
  
def clickit()
    $_form = $_wait.until {
        element = $_browser.find_element(:id, "execute")
        element if element.displayed?
    }
    $_form.click
    sleep(5)
    puts "Execute Clicked"
end

def alert_clickit()
    # alert = $_browser.switch_to.alert
    $_form = $_wait.until {
        alert = $_browser.switch_to.alert
    }
    $_form.accept
    sleep(5)
    puts "Alert Clicked"
end

    def RUN
        userName()
        pwd()
        eventTitleCounter = 0
        bandsArray = []
        loop do 
            eventTitleCounter += 1
            event = Band.new
            event.getEventName()
            event.getBrand(event.eventName)
            event.getStartDate(event.eventName)
            event.getTotalDays(event.eventName)
            event.getBandNum(event.eventName)
            if event.loopOrGo() == false
                # event.bandName = event    HOW DO I RENAME THE OBJECT WITH THE NAME OF THE EVENT ITSELF (WHICH IS STORED IN Band.eventName (event.eventName))
                bandsArray << event
                break
            else 
               bandsArray << event
            end
        end
        "----------------------------------------------------------------------------------------------"
        # TEST PRINT STATEMENTS TO CHECK THAT ABOVE METHODS AND INSTANCE VARIABLES WORK -- Delete this section later
    
        # INITIALIZING ONE OF THE RESULT VARIABLES FOR TESTING
        bandsArray[0].campDates = "DOOPY"
    
        puts "Results Test (bandsArray[0].campDates):"
        ap bandsArray[0].campDates
        "----------------------------------------------------------------------------------------------"
    
        "MAKE THIS SECTION A FUNCTION? WITH ARGUEMENTS BEING PASSED IN THAT ARE REQUIRED"
        # CALLING eventNumsArray FUNCTION TO EXTRACT FROM bandsArray ALL EVENT NAMES INTO ARRAY eventNumsArray
        eventBandNumsArray = Array.new
        eventBandNumsArray = eventNumsArray(bandsArray)
        bandsLength = bandsArray.length
        puts "bandsArray:"
        ap bandsArray
        puts "bands in Array (bandsArrayLength):"
        puts bandsLength
        puts "eventBandNumsArray Test:"
        ap eventBandNumsArray
    
        loadingMessage()

        "-------------------- b7_1 -----------------------" # MAKE THIS A FUNCTION?
        navigate($_userNameVar)
        b7_1(eventBandNumsArray, bandsLength)
        clickit()
        alert_clickit()
        "-------------------- b3 -------------------------" # MAKE THIS A FUNCTION?
        "MIGHT NEED TO navigate TO iFrame FOR THIS TO BE ABLE TO WORK"
        

    end
    RUN()
    puts "successful run"
    

return 

"DO B3"

"DOWNLOAD B7 AND B3 RESULTS (ONLY NEW ONES FROM SPREADSHEET) S0 HAVE TO IDENTIFY BY **DATE OF SUBMIT**"

"SEPERATE DOWNLOADS INTO SEPERATE TEMP DIRECTORIES (mix of downloadFile.rb and test_chngee or chngee"

"STORE VARIABLE DATA FROM B7 PARSING INTO ARRAY/HASH (THIS IS ALREADY DONE FOR ONE SO FIGURE OUT LOOP)"

"STORE VARIABLE DATA FROM B3 PARSING INTO ARRAY/HASH (THIS IS ALREADY DONE FOR ONE SO FIGURE OUT LOOP)"

=begin

"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                            Dates Section                                               "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    
    # COVER THE DATES OF THE :starting_date UNTIL 3 DAYS AFTER
    puts "stringHash[:start_date]"
    puts stringsHash[:start_date]
    daysParsed = Date.parse(stringsHash[:start_date])
    datesArray = []
    i = 0
    # EVENT DATE RANGE PLUS 3 DAYS AFTER
    while i < ((stringsHash[:total_days].to_i) + 3)
        datesArray << daysParsed.to_s
        if stringsHash[:total_days] == 1
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

    # COVERS THE DATES LEADING UP TO THE EVENT'S :start_date (7 DAYS BEFORE :start_date)
    daysParsed = Date.parse(stringsHash[:start_date])
    i = 0
    # -14 for two weeks before event 
    earlyDaysParsed = daysParsed - 14
    while i < 14
        datesArray << earlyDaysParsed.to_s
        earlyDaysParsed += 1
        i += 1
    end
    
    datesArray = datesArray.sort
    p datesArray

    # CREATING DATE RANGE FOR FINAL RESULTS TABLE (EX. "6/23 - 6/26")
    days = Date.parse(stringsHash[:start_date])
    puts "days:"
    # EXTRACTS MONTH AND DAY FROM PARSED DATE STRING
    dateMonth = days.strftime('%m')
    dateDayBeg = days.strftime('%d').to_i
    # GETS ENDING DATE OF EVENT ( -1 TO :total_days SO THE ARITHMATIC GETS THE CORRECT DAY)
    dateDayEnd = days.strftime('%d').to_i + (stringsHash[:total_days].to_i - 1)
    campDates = "#{dateMonth}/#{dateDayBeg} - #{dateMonth}/#{dateDayEnd}"

    puts "dateMonth:"
    puts dateMonth
    puts "dateDayBeg:"
    puts dateDayBeg
    puts "dateDayEnd:"
    puts dateDayEnd
    puts "campDates:"
    puts campDates



"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                            1st B7 Loop                                     "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


    "Creeper/Download file codes here"

"REMEMBER TO GRAB DOWNLOAD FILE NAME FOR INTERPOLATION BELOW IN THE END OF THE PATH STRING BELOW SO FINDING FILE WILL BE POSSIBLE"
    # LOCATE FILE TO PARSE, OPEN AND READ
    "PATH OUTSIDE OF CURRENT DIRECTORY OF BACKENDSELENIUM ISN'T WORKING, FIGURE OUT HOW TO GET PATH FROM DESKTOP WHERE TEMP_DATA IS"
    workbookB7first = RubyXL::Parser.parse("b71.xlsx")

    # DEFINES WORKBOOK AS WORKSHEET (DONT DELETE)
    worksheet = workbookB7first[0]
  
    # i = 1 TO SKIP TOP ROW OF TITLES IN SPREADSHEET
    i = 1
    # SAVE ROWCOUNT FOR MATH OF TOTAL MEMBERS -- subtract 1 FOR TITLE ROW AT INDEX[0]
    rowCount = worksheet.sheet_data.rows.size - 1
    puts "Initial row count (rowCount) of sheet before filtering: #{rowCount}"

#  CLEANS USERS THAT DIDN'T JOIN FROM THIS SPECIFIC EVENT
    index = 1
    while index < worksheet.sheet_data.rows.size
        #### p "#{worksheet.sheet_data.rows.size} - #{index}" ####
        firstCell = worksheet.sheet_data[index][0].value
        lastCell = worksheet.sheet_data[index][7].value
       #### p "firstCell = #{firstCell} lastCell = #{lastCell}" ####
        if firstCell != lastCell
       ####    p "DELETE" ####
            worksheet.delete_row(index)
            # puts "Not new user. Row #a#{i} Deleted."
        else
            index += 1
        end
    end

    
    finalScanRowCount = index - 1
    puts "FIRST B7 While loop. CLEAN USERS THAT DIDN'T JOIN FROM THIS EVENT (joined in earlier BAND). (finalScanRowCount): #{finalScanRowCount}"

    workbookB7first.write("firstScan.xlsx")


    puts "worksheet.sheet_data.rows.size BEFORE second loop: #{worksheet.sheet_data.rows.size}"

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

    nruCount = worksheet.sheet_data.rows.size - 1
    puts "nruCout: #{nruCount}"


    puts "=============================="
    puts "Results of first B7 (#{stringsHash[:band_name]}):"
    # to_f BELOW SO THAT DIVISION FOR PERCENTAGE DOESN'T EQUAL 0
    nruCount = nruCount.to_f
    puts "NRUs: #{nruCount}"
    newMemberAvg = ((nruCount / rowCount.to_f) * 100).round(2)
    puts "NRUs Percentage for the event '#{stringsHash[:band_name]}': #{newMemberAvg}%"
    puts "=============================="

    workbookB7first.write("secondScan.xlsx")



    "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    "                                            B3 Loop                                     "
    "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

    # B3 PARSE LOOP
    "REMEMBER TO GRAB DOWNLOAD FILE NAME FOR INTERPOLATION BELOW IN THE END OF THE PATH STRING BELOW SO FINDING FILE WILL BE POSSIBLE"
    # LOCATE FILE TO PARSE, OPEN AND READ
    "PATH OUTSIDE OF CURRENT DIRECTORY OF BACKENDSELENIUM ISN'T WORKING, FIGURE OUT HOW TO GET PATH FROM DESKTOP WHERE TEMP_DATA IS"
    workbookB3 = RubyXL::Parser.parse("b3.xlsx")
    # DEFINES WORKBOOK AS WORKSHEET (DONT DELETE)
    worksheet = workbookB3[0]

  
    # SAVE ROWCOUNT FOR MATH OF TOTAL MEMBERS - NEW COUNT
    rowCount = worksheet.sheet_data.rows.size
    puts "rowCount: #{rowCount}"


    newRowCount = worksheet.sheet_data.rows.size
    newLeaderArray = Array.new
    finalLeaderArray = Array.new
    cell = ""
    index = 1
    #   GRAB AND STORE ALL LEADERS AND THEN USE .uniq  TO DELETE REPEAT NAMES AND GET newLeaderCount (CHECKS IF DATE CREATED CELL IS nil?, IF NOT, STORE)
    while index < newRowCount
        if not worksheet.sheet_data[index][10].nil?
            #  STORING ALL LEADER NAMES (MULTIPLES INCLUDED)
            newLeaderArray << worksheet.sheet_data[index][5].value
           #### puts "worksheet.sheet_data[index][5]: #{worksheet.sheet_data[index][5]}"
        end
        index += 1
    end
    
    puts "\nnewLeaderArray.length (count) -- before .uniq: #{newLeaderArray.length}"
    
    # DELETES MULTIPLES OF LEADERS
    finalLeaderArray = newLeaderArray.uniq
    puts "\nnewLeaderArray.length (count) -- after .uniq: #{finalLeaderArray.length}"
    puts "\nfinalLeaderArray"
    ap finalLeaderArray
    
    # TOTAL LEADERS
    totalLeaderCount = finalLeaderArray.length 

# FILTERING CELLS FOR B3 AND STORING NEW LEADERS AND THEIR NEW BANDS IN ARRAYS, AND FINDING TOTAL LEADER COUNT (newLeaderCount)
newLeaderCount = 0
new_GBL_LeaderCount = 0
cellDateCreated = ""
newLeaderArray = Array.new
newBandsArray = Array.new
index = 1
while index < rowCount
    # puts "index: #{index}  --  rowCount: #{rowCount}"
    #### puts "ROW COUNT: #{rowCount} -- INDEX: #{index}"
    if worksheet.sheet_data[index][10].nil?
        #### puts "EMPTY CELL: SKIPPED NIL row skipped at index #{index}."
        index += 1
    elsif not worksheet.sheet_data[index][10].nil?
        #### puts "-------------------------------------------------------------------------------------------------------------"
        # p "worksheet.sheet_data.rows.size: #{worksheet.sheet_data.rows.size} -- index: #{index}"
        cellDateCreated = worksheet.sheet_data[index][10].value
        cellMemberSize = worksheet.sheet_data[index][14].value.to_i
        #### puts "Row: #{index}"
        #### p "cellDateCreated = #{cellDateCreated}"
        #### p "cellMembersize = #{cellMemberSize}"
        #### p datesArray
        #### puts "\n"
        if not datesArray.include?("#{cellDateCreated}")
            #### puts "SKIPPED : WRONG CELL DATE cellDateCreated: #{cellDateCreated} is not one of the dates of #{stringsHash[:band_name]}."
            index += 1
            #### puts "----------------------------------------------------------------------------------------------------------"
        elsif not cellMemberSize > 1
            #### puts "SKIPPED : worksheet.sheet_data[index][14] = #{worksheet.sheet_data[index][14].value}."
            newLeaderCount += 1
            index += 1
        else
            newBandsArray << worksheet.sheet_data[index][7].value
            newLeaderArray << worksheet.sheet_data[index][5].value
            #### puts "\n\n\n\n$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\n"
            #### puts "newBandsArray Band: #{worksheet.sheet_data[index][7].value}"
            #### puts "newLeaderArray: #{worksheet.sheet_data[index][5].value}"
            new_GBL_LeaderCount += 1
            #### puts "new_GBL_LeaderCount: #{new_GBL_LeaderCount}"
            #### puts "\n$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\n\n\n\n"
            index += 1
        end
    end
end

puts "\n"

#   GRAB ORIGINAL BAND COUNT FOR DIVISION WITH NEW B
totalMembers = worksheet.sheet_data[1][2].value.to_f
puts "Total Members:"
puts totalMembers
puts "\n"
newLeaderCount = newLeaderArray.length.to_f


puts "B3 Results (and Total Members):"
puts "---------------------------------------------------------------------------------------------------------------------------------------"
puts "Total Leaders (totalLeaderCount):"
p totalLeaderCount
puts "New Leaders (newLeaderCount):"
p newLeaderCount
puts "newBandsArray:"
p newBandsArray
puts "newLeaderArray:"
p newLeaderArray
puts "GBLs (new_GBL_LeaderCount):"
p new_GBL_LeaderCount
puts "New Leader Avg (newLeaderAvg):"
p newLeaderAvg = (newLeaderCount/totalMembers) * 100
puts "Total Members:"
puts totalMembers
puts "Camp Date:"
p "ADD FORMULA USING :start_date AND :total_days TO GET STARTING DATE AND ENDING DATE FOR THIS CELL"
puts "Activity Sum:"
p "STILL NEED TO GET A:2 AND PARSE"
puts "NRU's:"
p "#{nruCount}"
puts "New Member Avg:"
p (nruCount/totalMembers)

puts "\n\nfinalLeaderArray"
ap finalLeaderArray

workbookB3.write("b3write.xlsx")

puts "rowCount #{rowCount}"

puts "next steps reached"






"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                            2nd B7 Loop                                     "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

" USE THE newBandsArray TO ENTER ALL THE NEW GBLs INTO THE TEXT BOX WITH THE DRIVER "



    "Creeper/Download file codes here"

"REMEMBER TO GRAB DOWNLOAD FILE NAME FOR INTERPOLATION BELOW IN THE END OF THE PATH STRING BELOW SO FINDING FILE WILL BE POSSIBLE"
    # LOCATE FILE TO PARSE, OPEN AND READ
    "PATH OUTSIDE OF CURRENT DIRECTORY OF BACKENDSELENIUM ISN'T WORKING, FIGURE OUT HOW TO GET PATH FROM DESKTOP WHERE TEMP_DATA IS"
    workbookB7second = RubyXL::Parser.parse("b72.xlsx")
    puts workbookB7second.worksheets[0] # Returns first worksheet
    # DEFINES WORKBOOK AS WORKSHEET (DONT DELETE)
    worksheet = workbookB7second[0]
  
    # i = 1 TO SKIP TOP ROW OF TITLES IN SPREADSHEET
    i = 1
    # SAVE ROWCOUNT FOR MATH OF TOTAL MEMBERS - NEW COUNT
    rowCount = worksheet.sheet_data.rows.size
    puts "rowCount: #{rowCount}"
    p worksheet.sheet_data[1][0].value
    p worksheet.sheet_data[1][7].value
#   pp worksheet

#  CLEANS USERS THAT DIDN'T JOIN FROM THIS SPECIFIC EVENT
    index = 1
    while index < worksheet.sheet_data.rows.size
        #### p "#{worksheet.sheet_data.rows.size} - #{index}"
        firstCell = worksheet.sheet_data[index][0].value
        lastCell = worksheet.sheet_data[index][7].value
        #### p "firstCell = #{firstCell} lastCell = #{lastCell}"
        if firstCell != lastCell
            #### p "DELETE"
            worksheet.delete_row(index)
            # puts "Not new user. Row #a#{i} Deleted."
        else
            index += 1
        end
    end

    workbookB7second.write("firstScan.xlsx")

    firstScanRowCount = index - 1
    puts "firstScanRowCount = :#{firstScanRowCount}"

    # USE USER INPUT FROM INITIAL GETS.CHOMPS (stringsHash[:start_date]) ABOVE TO REMOVE DATES OUTSIDE EVENT RANGE TO GET FINAL N.R.U.
    index = 1
    while index < worksheet.sheet_data.rows.size
        #### puts "-------------------------------------------------------------------------------------------------------------"
        #### p "worksheet.sheet_data.rows.size: #{worksheet.sheet_data.rows.size} -- index: #{index}"
        cellDate = worksheet.sheet_data[index][3].value
        #### p "cellDate = #{cellDate}"
        #### p datesArray
        if not datesArray.include?("#{cellDate}")
            #### puts "cellDate: #{cellDate} is not one of the dates of #{stringsHash[:band_name]}."
            worksheet.delete_row(index)
            #### puts "Not new user. Row #{index} Deleted."
            #### puts "----------------------------------------------------------------------------------------------------------"
        else
            index += 1
        end
    end

    puts "firstScanRowCount: #{firstScanRowCount}"
    puts "finalScanRowCount: #{index}"
    finalScanRowCount = index - 1

    puts "=============================="
    puts "Results of Second B7 (#{stringsHash[:band_name]}):"
    # to_f BELOW SO THAT DIVISION FOR PERCENTAGE DOESN'T EQUAL 0
    gblNru = finalScanRowCount.to_f
    puts "Second B7 NRUs: #{gblNru}"
    newMemberAvg_2 = (finalScanRowCount / rowCount.to_f) * 100
    puts "NRUs Percentage for the event '#{stringsHash[:band_name]}': #{newMemberAvg_2}%"

    workbookB7second.write("secondScan.xlsx")

   
    p datesArray


"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                            A2? Activity Loop                                     "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"








"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                            Adjustments to Variables                                    "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"




"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                        Final Results to be Written                                    "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


puts "Results of first B7 for (#{stringsHash[:band_name]}):"
puts "---------------------------------------------------------------------------------------------------------------------------------------"
# to_f BELOW SO THAT DIVISION FOR PERCENTAGE DOESN'T EQUAL 0
nruCount = nruCount.to_f
puts "NRUs: #{nruCount}"
nruPercentage = ((nruCount / rowCount.to_f) * 100).round(2)
puts "NRUs Percentage for the event '#{stringsHash[:band_name]}': #{nruPercentage}%"


puts "B3 Results (and Total Members) for (#{stringsHash[:band_name]}):"
puts "---------------------------------------------------------------------------------------------------------------------------------------"
puts "Total Leaders (totalLeaderCount):"
p totalLeaderCount
puts "New Leaders (newLeaderCount):"
p newLeaderCount
puts "newBandsArray:"
p newBandsArray
puts "newLeaderArray:"
p newLeaderArray
puts "GBLs (new_GBL_LeaderCount):"
p new_GBL_LeaderCount
puts "New Leader Avg (newLeaderAvg):"
p newLeaderAvg = (newLeaderCount/totalMembers) * 100
puts "Total Members:"
puts totalMembers
puts "Camp Date:"
p "ADD FORMULA USING :start_date AND :total_days TO GET STARTING DATE AND ENDING DATE FOR THIS CELL"
puts "NRU's:"
p "#{nruCount}"
puts "New Member Avg:"
p (nruCount/totalMembers)


puts "Results of second B7 for (#{stringsHash[:band_name]}):"
puts "---------------------------------------------------------------------------------------------------------------------------------------"
puts "Results of Second B7 (#{stringsHash[:band_name]}):"
# to_f BELOW SO THAT DIVISION FOR PERCENTAGE DOESN'T EQUAL 0
gblNru = finalScanRowCount.to_f
puts "Second B7 NRUs: #{gblNru}"
nruPercentage = (finalScanRowCount / rowCount.to_f) * 100
puts "NRUs Percentage for the event '#{stringsHash[:band_name]}': #{nruPercentage}%"


puts "Results of A2 Activity for (#{stringsHash[:band_name]}):"
puts "---------------------------------------------------------------------------------------------------------------------------------------"
puts "Activity Sum:"
p "STILL NEED TO GET A:2 AND PARSE"
puts "_____TBD_____"



"THE BELOW RESULTS NOW NEEDS TO BE IN LOOP TO ACCOUNT FOR EACH BAND OBJECT IN ARRAY FROM INITIAL USER ENTRY"

puts "Results for Final Table of (#{stringsHash[:band_name]}):"
puts "---------------------------------------------------------------------------------------------------------------------------------------"
puts "Band Name:"
puts stringsHash[:band_name]
puts "Band Number:"
puts stringsHash[:band_num]
puts "Brand Name:"
puts stringsHash[:brand_name]
puts "Camp Date:"
puts campDates
puts "Total Members:"
puts totalMembers
puts "Activity Sum:"

puts "Avg Activity Per Member:"

puts "NRUs:"
puts nruCount
puts "New Member Avg:"
puts newMemberAvg
puts "New Leaders:"
puts newLeaderCount
puts "New Leader Avg:"
puts newLeaderAvg
puts "GBLs:"
puts new_GBL_LeaderCount
puts "GBL Average:"
puts 
puts "GBL NRUs:"
puts gblNru
puts "NRUs Per GBL:"
puts


"NOW NEED TO STORE RESULTS OF SOME OF INITIAL USER INPUT AND FINAL RESULTS IN ARRAY OF ARRAYS OR ARRAY OF SINGLE KEY VALUE ARRAY = [ { (KEY) BANDNAME => {ALL INFO IN NESTED ARRAY (VALUE) } ]"
"THIS IS TO HANDLE MULTIPLE BANDS AT ONCE"

"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                               Writter                                                  "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



bandsArrayCounter = 0
"(CHANGE NAME FOR EACH WRITTEN ANALYSIS AND SPECIFY NEW DIRECTORY)"
# LOOP UNTIL ALL BANDS IN bandsArray HAVE BEEN WRITTEN IN SEPERATE DOCUMENTS (CHANGE NAME FOR EACH AND SPECIFY NEW DIRECTORY)
until bandsArryCounter > bandsLength

    
    workbookFinal = RubyXL::Workbook.new
    worksheet = workbookFinal[0]

    worksheet.insert_row(0)
    worksheet.insert_row(1)

    titlesArray = Array.new
    titlesArray = ["Band Name", "Band Number", "Brand", "Camp Date", "Total Members", "Activity Sum", "Avg Activity Per Member", "New Member Avg", "New Leaders", "New Leader Avg", "GBLs", "GBL NRUs", "NRUs Per GBL"]

    # CONVERTING ORIGINAL bandsArray (ARRAY OF HASHES OF BANDS' INFO) INTO ARRAY OF ARRAYS SO THAT EACH ARRAY CAN ITERATE ITS INFO INTO SHEET AT CORRECT CELL (HASH .each WOULDN'T WORK FOR THIS WHILE LOOP TO FILL EACH CELL INDIVIDUALLY, WOULD FILL ONE WITH ALL K/V PAIRS)
    i = 0
    bandsArray = bandsArray.map{|x| [x[:band_name], x[:band_num], x[:brand_name]]}

    puts "bandArrayOfArrays before pushing result variables into array:"
    ap bandsArray


    # TITLE ROW CELL FILLING
    i = 0
    while i < 15
        worksheet.add_cell(0, i, "#{titlesArray[i]}")
        worksheet.change_column_width(i, 25)
        worksheet.change_row_height(0, 40)  # Sets first row height to 30
        # worksheet[0][i].change_font_bold(true)
        worksheet.change_column_font_name(i, 'Calibri')
        worksheet.change_column_font_size(i, 14)
        # HOZONTALLY CENTERS TEXT
        worksheet.sheet_data[0][i].change_horizontal_alignment('center')
        # VERTICALLY CENTERS TEXT
        worksheet.change_row_vertical_alignment(0, 'distributed')
        # TITLE ROW BOTTOM UNDERLINE
        worksheet.sheet_data[0][i].change_border(:bottom, 'medium')
        worksheet.change_row_border_color(0, :bottom, 'ed553b')
        # FILL TITLE ROW WITH GREY
        worksheet.change_row_fill(0, 'dcdcdc')   
        i += 1
    end

    # DATA ROW FILING
    i = 0
    j = 0
    while i < 15
        worksheet.add_cell(0, i, "#{bandArray[i][j]}")
        worksheet.change_column_width(i, 25)
        worksheet.change_row_height(0, 40)  # Sets first row height to 30
        # worksheet[0][i].change_font_bold(true)
        worksheet.change_column_font_name(i, 'Calibri')
        worksheet.change_column_font_size(i, 14)
        # HOZONTALLY CENTERS TEXT
        worksheet.sheet_data[0][i].change_horizontal_alignment('center')
        # VERTICALLY CENTERS TEXT
        worksheet.change_row_vertical_alignment(0, 'distributed')
        # TITLE ROW BOTTOM UNDERLINE
        worksheet.sheet_data[0][i].change_border(:bottom, 'medium')
        worksheet.change_row_border_color(0, :bottom, 'ed553b')
        # FILL TITLE ROW WITH GREY
        worksheet.change_row_fill(0, 'dcdcdc')   
        i += 1
    end

    workbookFinal.write("#{bandsArray}.xlsx")
    bandsArrayCounter += 1


end



=end

"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                               RUN                                                      "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"









