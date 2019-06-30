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
require './welcomeLogin.rb'
####################################
require './bandClass.rb'
####################################
require './productionDownloadFile'
####################################
require './adminsList'
####################################
require './fileMoveOldXlsx.rb'
####################################
require './grabXlsxB71.rb'
####################################
require './grabXlsxB3.rb'
####################################
require './b7-1multipleBands.rb'
####################################
require './send_sms.rb'
####################################
require './datesSection.rb'
####################################
require './b7-1Parse.rb'
####################################
require './b3Driver.rb'
####################################
require './b3Parse.rb'
####################################
require './driverLogin.rb'
####################################
require './b7_1Driver.rb'
####################################
require './b7_2Driver.rb'
####################################
require './grabXlsxB7_2.rb'
####################################
require './b7_2Parse.rb'
####################################
require './writer2.rb'
####################################
require './a2_Driver.rb'
####################################
require './B72ProductionDownloadFile.rb'
####################################
require './grabXlsxA2.rb'
####################################

# FUNCTION RETURNS ARRAY OF EVENT NAMES FROM EACH EVENT
def getEventNamesArray(bandsArray)
    eventNamesArray = bandsArray.collect {|x| x.bandNum}         #" I NEED TO FIGURE OUT HOW TO COLLECT ALL THE BAND NUMBERS INTO AN ARRAY FROM THEIR OBJECTS"
end

"OK TO REMOVE SECONDS IF THIS ISN'T MATCHING CELL ON TABLE, MINUTES IS ENOUGH TO MATCH FOR THIS."
def timestamp(bandsArray)
    band = bandsArray[0]
    # MINUS 8 FOR SOUTH KOREA TIME ZONE
    minutes1 = Time.now.strftime '%M'
    puts "minutes1 #{minutes1}"
    minutes2 = ((minutes1.to_i) + 1).to_s
    puts "minutes2 #{minutes2}"
    tmpHours = ((Time.now.strftime '%H').to_i - 8).to_s
    puts "tmpHours : #{tmpHours}"
    band.hoursMinutes2 = "#{tmpHours}:#{minutes2}"
    hoursMinutes1 = "#{tmpHours}:#{minutes1}"
end

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

    def RUN
        fileMoveOldXlsx()
        helloMessage()
        usrNumber = textMessage()
        userName()
        # COMMENT OUT PWD() TO LET TEST SCRIPT WORK
        pwd()                   ##############################################
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
    
        # CALLING eventNamesArray FUNCTION TO EXTRACT FROM bandsArray ALL EVENT NAMES INTO ARRAY eventNamesArray
        eventNamesArray = []
        eventNamesArray = getEventNamesArray(bandsArray)

# =begin
        bandsLength = bandsArray.length
        puts "bandsArray:"
        ap bandsArray
        puts "bands in Array (bandsArrayLength):"                                        #########################################
        puts bandsLength
        puts "eventNamesArray Test:"
        ap eventNamesArray
# =end

        loadingMessage()

        # STORES INSTANCE VARIABLE datesArrays FOR EACH BAND, RETURNS NEW OBJS OF BANDS WITH ARRAY OF DATES STORED (ARRAY USED TO PARSE OUT INCORRECT DATES IN B7/B3)
        dates(bandsArray)

        navigate($_userNameVar)                                                             ########################################
        sleep (7) ###"CHANGE THIS TO form = wait.until"



"TIMESTAMP CELL INTEGRATION NEEDED FOR THIS INITIAL DOWNLOADPRODUCTIONFILE.RB WITH TIMESTAMPS FOR EACH B7/B3/A2 (SO EACHTIME NEW EVENT ANALYSIS IS DONE 
ON THE SAME DAY FOR OTHER EVENTS WITH DIFFERENT DATES OF EVENT, IT WON'T DONWLOAD SAME XLSX FILES."



        "-------------------- b7_1Driver -----------------------" # MAKE THIS A FUNCTION?
        b7_1Driver(eventNamesArray, bandsLength)
        clickit()
        initialCellTimeStamp = timestamp(bandsArray)
        alert_clickit()
        puts "\n\n\n\n\n\n\n\n initialCellTimeStamp: #{initialCellTimeStamp}"

=begin 
        "-------------------- b3 -------------------------" # MAKE THIS A FUNCTION?
        "MIGHT NEED TO navigate() (SLIGHTLY ALTERED NAVIGATE) TO iFrame FOR THIS TO BE ABLE TO WORK"
        b3(eventNamesArray, bandsLength)
        clickit() # "CHANGE THIS TO INCLUDE NEW DATA"
        alert_clickit() # "CHANGE THIS TO INCLUDE NEW DATA"

        "==================== a2 =========================" # MAKE THIS A FUNCTION?
        "MIGHT NEED TO navigate() (SLIGHTLY ALTERED NAVIGATE) TO iFrame FOR THIS TO BE ABLE TO WORK"
        
        # THIS IS TO GRAB A2 INFO FROM JUST ONE (OR IN THIS CASE THE FIRST) BAND FOR ENTERING START AND END DATES INTO FIELD IN DRIVER
        band = bandsArray[0]

        a2_Driver(eventNamesArray, bandsLength, band)
        clickit()
        alert_clickit()
        alert_clickit()

=end
        storeTable($_browser)
        p $_table
                                                                                     ################################################
        ap $_files_href
        checkTableDownload(bandsArray, initialCellTimeStamp)
        downloadFile($_browser, $_files_href)


        tempB7Dir()

        grabXlsxB71()

        b71Parse(eventNamesArray, bandsArray)
        puts "Check for event.Bands results being set:"
        ap bandsArray
        
        puts "B71Parsed"
        tempB3Dir()
        puts "tempB3Dir"

        grabXlsxB3()

        b3Parse(eventNamesArray, bandsArray)
        puts "b3Parse"
        # need the remove TEMP for b3 here

        # MIGHT NEED navigate() here to find proper page or switch to iframe

        #   a2Parse
        # PARSER NEEDED!


        # test below b72 drive and wait and download after checking parsing working


##################### TEST OUT IF CELL TIME STAMP WORK FOR CODE BELOW --- I HAVE TO JUMP AHEAD TO TESTING INITIAL B7/B3/A2
=begin
        b7_2Driver(eventNamesArray, bandsArray)
        clickit()
        alert_clickit()
        b7_2CellTimeStamp = timestamp()
        puts "\n\n\n\n\n\n\n\n b7_2CellTimeStamp: #{b7_2CellTimeStamp}"
        puts b7_2CellTimeStamp

        B72StoreTable($_browser)
        p $_table
        ap $_files_href
        B72CheckTableDownload(bandsArray, b7_2CellTimeStamp)
        B72DownloadFile($_browser, $_files_href)

        tempB7_2Dir()

        grabXlsxB72()
=end 
        # remove below and change to grabXlsxB7_2 (which includes TempB7_2
        tempB7_2Dir()
        ap bandsArray
        b7_2Parse(eventNamesArray, bandsArray)
        ap bandsArray
        # CLEAN/CLEAR OUT DIRECTORIES AND THEIR FILES
        # removeTEMPB7()
        # removeTEMPB3()
        # removeTEMPB7_2()

        writer2(bandsArray)


        "FINAL IF STATEMENT FOR TWILIO -- IF usrNumber not .nil?, call twilio(usrNumber)"
        puts "usrNumber:"
        puts usrNumber
        twilio(usrNumber)

        "Chatbot functionality for running next round of Bands stored in larger array? (ability to start or continue logging full 'data analaysis sessions'
            run current session or store a new one, then chatbot would notify completed session, remotely ask run next session?"

end
RUN()
puts "successful run"


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



"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                               RUN                                                      "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



"TO DO:
- Test if storeReadyDownloadLink is redundant function
- Test if b3 and b7.1 download for multiple bands
- Work on new b3 with all admins in an array removed from file returned
- Work on new b7.1 (in while loop?) to grab data for multiple bands
    - Store data in instance variables of event.bands for final results 
- Work on new b3 (in while loop?) to grab data from multiple bands?
    - Store data in instance variables of event.bands for final results 
- Work on b7.2 (in while loops?) to grab data from multiple bands?
    - Store data in instance variables of event.bands for final results 
- Work on A.2 (can I do this for multiple bands? Based on dates I don’t remember check with Taylor)
    - Store data in instance variables of event.bands for final result
- Write All data from bands."






