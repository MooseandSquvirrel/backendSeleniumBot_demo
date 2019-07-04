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
####################################

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
    eventNamesArray = bandsArray.collect {|x| x.bandNum}         #" I NEED TO FIGURE OUT HOW TO COLLECT ALL THE BAND NUMBERS INTO AN ARRAY FROM THEIR OBJECTS"
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
    
    # PRINTOUTS OF VARIABLES ESTABLISHED
    puts "bandsArray:"
    ap bandsArray
    puts "bandsLength (bandsArrayLength):"                                        
    puts bandsLength
    puts "eventNamesArray Test:"
    ap eventNamesArray

    loadingMessage()

    # STORES INSTANCE VARIABLE datesArrays FOR EACH BAND, RETURNS NEW OBJS OF BANDS WITH ARRAY OF DATES STORED (ARRAY USED TO PARSE OUT INCORRECT DATES IN B7/B3)
    dates(bandsArray)

    # DRIVERLOGIN.RB FUNCTION TO LOG INTO BACKEND AND FIND PROPER PAGE/IFRAME
    navigate($_userNameVar)                                                           ########################################
    sleep (7) ###"CHANGE THIS TO form = wait.until"

    # ARRAY FOR TIME STAMPS FOR TABLE TO IDENTIFY BY MINUTE AND HOUR WHICH EXCEL SHEETS TO DOWNLOAD WHEN READY
    initialCellTimeStampArray = []

    b71_b3_a2_Drivers(eventNamesArray, bandsLength, bandsArray, initialCellTimeStampArray)

    puts "initialCellTimeStampArray Array:"
    ap initialCellTimeStampArray
    
    storeTable($_browser)
    p $_table
    ap $_files_href
    checkTableDownload(bandsArray, initialCellTimeStampArray)
    downloadFile($_browser, $_files_href)

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
end

# ALL FUNCTION FOR B7_2
def go_B72(eventNamesArray, bandsArray)
    b7_2Driver(eventNamesArray, bandsArray)
    clickit()
    alert_clickit()
    b7_2CellTimeStamp = timestamp()
    puts "\n\n\n\n\n\n\n\n b7_2CellTimeStamp: #{b7_2CellTimeStamp}"
    puts b7_2CellTimeStamp

    b72StoreTable($_browser)
    p $_table
    ap $_files_href
    b72CheckTableDownload(bandsArray, b7_2CellTimeStamp)
    b72DownloadFile($_browser, $_files_href)

    grabXlsxB72()

    tempB7_2Dir()
    ap bandsArray
    b7_2Parse(eventNamesArray, bandsArray)
    ap bandsArray
end

"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                               RUN                                                      "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

def RUN
    #### fileMoveOldXlsx()
    bannerOutPut("banner_Welcome.txt")
     helloMessage()
     usrNumber = textMessage()
     userName()
     pwd()                   
     eventTitleCounter = 0
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
             # event.bandName = event    HOW DO I RENAME THE OBJECT WITH THE NAME OF THE EVENT ITSELF (WHICH IS STORED IN Band.eventName (event.eventName))
             bandsArray << event
             break
         else 
            bandsArray << event
         end
     end
    go_B71_B3_A2(bandsArray)
    go_B72(band.eventNamesArray, band.bandsArray)

    # CLEAN/CLEAR OUT DIRECTORIES AND THEIR FILES
    removeTEMPB7()
    removeTEMPB3()
    removeTEMPB7_2()

    # PRINTING OUT FINAL RESULTS BEFORE WRITING
    finalResults()

    writer2(bandsArray)

    "FINAL IF STATEMENT FOR TWILIO -- IF usrNumber not .nil?, call twilio(usrNumber)"
    puts "usrNumber:"
    puts usrNumber
    twilio(usrNumber)
end

RUN()
puts "Successful run completed."

