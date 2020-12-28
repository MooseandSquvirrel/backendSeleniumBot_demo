#!/usr/env/bin ruby

####################################
# EXCELTESTPARSER REQUIRES
####################################
require 'rubyXL'
require 'rubyXL/convenience_methods'
require 'rubygems'
require 'awesome_print'
require 'date'
require 'capybara'
####################################
# TEST_CREEP REQUIRES
####################################
require 'selenium-webdriver'
require 'pp'
require 'ap'
require 'rspec/expectations'
require 'io/console'
require 'twilio-ruby'
####################################
# MY FILES
####################################
require './fileMoveOldXlsx.rb'
require './welcomeLogin.rb'
require './bandClass.rb'
require './adminsList'
require './datesSection.rb'
require './driverLogin.rb'
require './allDrivers.rb'
require './productionDownloadFile'
require './timeStamps.rb'
require './allDrivers.rb'
require './b7_1Driver.rb'
require './grabXlsxB71.rb'
require './b7-1Parse.rb'
require './b3Driver.rb'
require './grabXlsxB3.rb'
require './b3Parse.rb'
require './a2_Driver.rb'
require './grabXlsxA2.rb'
require './a2Parse.rb'
require './b7_2Driver.rb'
require './B72ProductionDownloadFile.rb'
require './grabXlsxB7_2.rb'
require './b7_2Parse.rb'
require './writer2.rb'
require './finalResultsToWrite.rb'
require './send_sms.rb'
require './headlessNavigate.rb'
require './browserDownload.rb'
####################################

# FUNCTION TO CHECK IF USER LOGGED INTO VPN AND BACKENDSYSTEM
def didYouLogin()
    puts "\n\nDID YOU LOG INTO -- VPN PULSE SECURE-- YET?! \n\n "
    sleep (3)
    puts "IF NOT, DO SO *** NOW *** OR THIS PROGRAM WILL CRASH AND INPUT WILL BE LOST :)...FOREVER.\n\n"
    sleep (5)
    puts "Press 'Enter' to begin."
    gets.strip
    puts "\n\n\n\n"
    puts "----------------------------------------------------------------"
end

# FUNCTION TO PRINT BANNERS
def bannerOutPut(file)
    File.open("#{file}").each do |line|
        puts line
        sleep (0.10)
    end
    sleep (2)
end

# FUNCTION RETURNS ARRAY OF EVENT NAMES FROM EACH EVENT
def getEventNamesArray(bandsArray)
    eventNamesArray = bandsArray.collect {|x| x.bandNum}         
end

# FUNCTION RETURNS NEW BANDS FROM EVENTS COLLECTS FROM B3 PARSE FOR B7_2 DOWNLOADING CHECK (IF CELL CONTAINS ANY BANDNUMS FROM THIS ARRAY)
def getB72bandNums(bandsArray)
    b7_2bandNumsArray = bandsArray.collect {|x| x.newBandNumbsb7_2}         
end

# FUNCTION TO MOVE TO NEXT ARRAY OF EVENTS WTIH SAME DATE OR BEGIN NAVIGATION/DRIVER/ANALYSIS
def outerLoopOrGo()
    puts "\n"
    puts "----------------------------------------------------------------------------------"
    puts "If no more BANDs with -- different start dates -- to enter info for, type 'go' and hit 'Enter'."
    puts "Otherwise, hit 'Enter' to begin submitting a Summer Camp group with different dates."
    gets.strip != "go"
end

# SUPERFLOUS INTEGRAL LOADING MESSAGE
def loadingMessage()
    puts "\n"
    print "Thank you #{$_userNameVar}. Now I will do work for you :)"
    sleep(1)
    print '.'
    sleep(1)
    print '.'
    sleep(1)
    print '.'
    sleep(1)
    puts '.'
end

# ALL FUNCTIONS FOR B7_1 B3 A2
def go_B71_B3_A2(bandsArray)
    # CALLING eventNamesArray FUNCTION TO EXTRACT FROM bandsArray ALL EVENT NAMES INTO ARRAY eventNamesArray
    eventNamesArray = []
    eventNamesArray = getEventNamesArray(bandsArray)

    # COUNTER FOR LENGTH OF BANDS ARRAY FOR USE IN FUNCTIONS BELOW
    bandsLength = bandsArray.length
    band = bandsArray[0]    
    loadingMessage()
    
    # STORES INSTANCE VARIABLE datesArrays FOR EACH BAND, RETURNS NEW OBJS OF BANDS WITH ARRAY OF DATES STORED (ARRAY USED TO PARSE OUT INCORRECT DATES IN B7/B3)
    dates(bandsArray)

    # DRIVERLOGIN.RB FUNCTION TO LOG INTO BACKEND AND FIND PROPER PAGE/IFRAME
    navigate($_userNameVar)                                                           
    sleep (7) ## "CHANGE THIS TO form = wait.until" ##

    # ARRAY FOR TIME STAMPS FOR TABLE TO IDENTIFY BY MINUTE AND HOUR WHICH EXCEL SHEETS TO DOWNLOAD WHEN READY
    initialCellTimeStampArray = []

    b71_b3_a2_Drivers(eventNamesArray, bandsLength, bandsArray, initialCellTimeStampArray)
    storeTable($_browser)
    checkTableDownload(bandsArray, initialCellTimeStampArray)
    browserDownloadFiles($_files_href)
    grabXlsxB71()
    b71Parse(eventNamesArray, bandsArray)
    puts "\n\nB71 Parsed\n\n"
    grabXlsxB3()
    b3Parse(eventNamesArray, bandsArray)
    puts "\n\nB3 Parsed\n\n"
    grabXlsxA2()
    a2Parse(eventNamesArray, bandsArray)
    puts "\n\nA2 Parsed\n\n"
    band.bandsArray = bandsArray
    band.eventNamesArray = eventNamesArray
    # RESET GLOBAL ARRAY TO EMTPY FOR B7_2
    $_files_href = []
end

# ALL FUNCTION FOR B7_2
def go_B72(events, bandsArray)
    b7_2Driver(bandsArray)
    # $_keys IS GLOBAL VARIABLE THAT DECIDES WHETHER ANY GBL WAS ENTERED INTO TEXT AREA (WHETHER TO RUN DATA)
    if $_keys == true
        clickit()
        band = bandsArray[0]
        b7_2CellTimeStamp1 = timestampB72(bandsArray)
        b7_2CellTimeStamp2 = $_hoursMinutesB72_backUp
        b7_2CellTimeStamp3 = $_hoursMinutesB72_backUp2
        alert_clickit()
        b7_2bandNumsArray = getB72bandNums(bandsArray)
        b72StoreTable($_browser)
        b72CheckTableDownload(bandsArray, b7_2CellTimeStamp1, b7_2CellTimeStamp2, b7_2CellTimeStamp3, b7_2bandNumsArray)
        browserDownloadFiles($_files_href)
        grabXlsxB72()
        b7_2Parse(events, bandsArray)
        removeTEMPB7_2()
    else
        $_browser.quit
    end
end

"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                               RUN                                                      "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

def RUN
    fileMoveOldXlsx()
    bannerOutPut("banner_Welcome.txt")
    didYouLogin()
    helloMessage()
    usrNumber = textMessage()
    userName()
    pwd()    
    eventTitleCounter = 0
    bandCounter = 0
    outerBandsArray = []
    a = 0 ##
    b = 0 ##
    loop do
        bandsArray = []
        loop do 
            eventTitleCounter += 1
            event = Band.new
            event.getEventName()
            event.getBrand(event.eventName)
            if eventTitleCounter == 1
                event.getStartDate(event.eventName)
            else
                event.startDate = bandsArray[0].startDate
            end
            event.getTotalDays(event.eventName)
            event.getBandNum(event.eventName)
            if event.loopOrGo() == false
                bandsArray << event
                break
            else 
                bandsArray << event
            end
            b += 1 ##
        end
        if outerLoopOrGo() == false
            outerBandsArray << bandsArray
            break
        else
            outerBandsArray << bandsArray
        end
        a += 1
        eventTitleCounter = 0
    end
    lenOuterArray = outerBandsArray.length

    i = 0
    page = 0
    until i == lenOuterArray
        bandsArray = outerBandsArray[i]
        go_B71_B3_A2(bandsArray)
        removeTEMPB7()
        removeTEMPB3()
        removeTEMPA2()
        events = bandsArray.length
        go_B72(events, bandsArray)
        writer2(bandsArray, lenOuterArray)
        # PRINTING OUT FINAL RESULTS BEFORE WRITING
        finalResults(bandsArray)
        i += 1
        page += 1
        system('say "Analysis, completed. Moving to next, date, group"')
    end
    system('say "Program, Finished."')
    twilio(usrNumber)
end

RUN()
puts "Successful run completed."
