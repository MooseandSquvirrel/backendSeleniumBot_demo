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

# FUNCTION RETURNS ARRAY OF EVENT NAMES FROM EACH EVENT
def getEventNamesArray(bandsArray)
    eventNamesArray = bandsArray.collect {|x| x.bandNum}         #" I NEED TO FIGURE OUT HOW TO COLLECT ALL THE BAND NUMBERS INTO AN ARRAY FROM THEIR OBJECTS"
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

"MIGHT NOT BE POSSIBLE TO AUTOMATE A2 BECAUSE OF SPECIAL CALENDAR MODULE"
=begin
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                     Function Entering Bands for A2                                     "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

"****** MAKE A2 A SEPERATE MODULE THAT REQUESTS BANDS INDIVIDUALLY BY DATE AND WRITES SEPERATE RESULTS 
(THEN FIGURE OUT LATER HOW TO INCLUDE THEM IN FINAL RESULTS ******"

"NEED TO CREATE FUNCTION FROM 'DATES' SECTION THAT EXTRACTS FIRST DATE OF TWO WEEK WINDOW AND LAST DATE FOR US IN 'Period' INPUT FOR A2"
# TEST INPUT FOR DATES -- DELETE LATER
startDate = "12122019"
endDate = "12152019"

def a2(eventNamesArray, bandsLength, startDate, endDate)
    bandsNumArray = eventNamesArray

    # GETTING ALL BAND NUMBS WITH .collect (ALREADY PERFORMED ABOVE TO GET THE eventNamesArray ((JUST STORED THAT ARRAY INTO bandsNumArray)))
    # bandsNumArray = bandsArray.collect {|x| x.bandNum}

    bandNameCounter = 0
    until bandNameCounter == bandsLength
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
            select_list.select_by(:value, '3')
            puts "Dropdown option selected:"
            puts selected_option = select_list.selected_options[0].text
            sleep(2)

        # USING BAND PARAMETERS FROM COMMANDLINE GETS AT START OF CREEPER (ARRAY?)
        $_form = $_wait.until {
            if element = $_browser.find_element(:tag_name, "textarea")
                puts "Found data field, will now input BAND num..."
                element = $_browser.find_element(:tag_name, "textarea")
            else
                puts "Data field not found, BAND data not entered into field."
            end
            element if element.displayed?
        }

        $_form.send_keys("#{bandsNumArray[bandNameCounter]}\n")
        bandNameCounter += 1

        # FINDING startDate TEXT BOX FOR INPUT
        $_dateStartInput = $_wait.until {
            if element = $_browser.find_element(:id, "startedAt")
                puts "Found dateStarted box, will now input date..."
            else
                puts "dateStarted box not found."
            end
            element if element.displayed?
        }

        "CHANGE THIS TO DRAW FROM ARRAY OF 2 DATE SUB ARRAYS FOR START DATE AND END DATE OF EACH EVENT -- 
        ITERATES LIKE bandNum"
        $_dateStartInput.send_keys("#{startDate}")

        # FINDING startDate TEXT BOX FOR INPUT
        $_dateEndInput = $_wait.until {
            if element = $_browser.find_element(:id, "endedAt")
                puts "Found dateStarted box, will now input date..."
            else
                puts "dateStarted box not found."
            end
            element if element.displayed?
        }

        "CHANGE THIS TO DRAW FROM ARRAY OF 2 DATE SUB ARRAYS FOR START DATE AND END DATE OF EACH EVENT"
        "STRINGS IN THIS ARRAY MUST BE FORMATED MMDDYYYY WITH '/' EXTRACTED"
        $_dateEndInput.send_keys("#{endDate}")


    end
        sleep(2)

        puts "a2 complete..."
        return # remove this return (test return to break)
end #### "MOVE THIS until 'END' TO AFTER THE CLICKS ONCE MY FIELD INPUT AND DATE INPUTS ARE WORKING"


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

=end


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

=begin
        bandsLength = bandsArray.length
        puts "bandsArray:"
        ap bandsArray
        puts "bands in Array (bandsArrayLength):"                                        #########################################
        puts bandsLength
        puts "eventNamesArray Test:"
        ap eventNamesArray
=end

        loadingMessage()

        # STORES INSTANCE VARIABLE datesArrays FOR EACH BAND, RETURNS NEW OBJS OF BANDS WITH ARRAY OF DATES STORED (ARRAY USED TO PARSE OUT INCORRECT DATES IN B7/B3)
        dates(bandsArray)
=begin # Comment out to b3 below
        navigate($_userNameVar)                                                             ########################################
        sleep (7) ###"CHANGE THIS TO form = wait.until"
=end

=begin
        "-------------------- b7_1Driver -----------------------" # MAKE THIS A FUNCTION?
        b7_1Driver(eventNamesArray, bandsLength)
        clickit()
        alert_clickit()

=begin
        "-------------------- b3 -------------------------" # MAKE THIS A FUNCTION?
        "MIGHT NEED TO navigate() (SLIGHTLY ALTERED NAVIGATE) TO iFrame FOR THIS TO BE ABLE TO WORK"
        b3(eventNamesArray, bandsLength)
        clickit() # "CHANGE THIS TO INCLUDE NEW DATA"
        alert_clickit() # "CHANGE THIS TO INCLUDE NEW DATA"
=end
     
=begin
        "==================== a2 =========================" # MAKE THIS A FUNCTION?
        "MIGHT NEED TO navigate() (SLIGHTLY ALTERED NAVIGATE) TO iFrame FOR THIS TO BE ABLE TO WORK"
        # TEST INPUT FOR DATES -- DELETE LATER
        startDate = "12122019"
        endDate = "12152019"
        a2(eventNamesArray, bandsLength, startDate, endDate)

        "RELOAD 2UNTIL DOWNLOADABLE"
=end

=begin
        storeTable($_browser)
        p $_table
                                                                                     ################################################
        ap $_files_href
        checkTableDownload(bandsArray)
        downloadFile($_browser, $_files_href)
=end

        tempB7Dir()
=begin
        grabXlsxB71()

=end
        b71Parse(eventNamesArray, bandsArray)
        puts "Check for event.Bands results being set:"
        ap bandsArray
        
        puts "B71Parsed"
        tempB3Dir()
        puts "tempB3Dir"
=begin
        grabXlsxB3()
=end
        b3Parse(eventNamesArray, bandsArray)
        puts "b3Parse"
        # need the remove TEMP for b3 here

        # MIGHT NEED navigate() here to find proper page or switch to iframe

        # test below b72 drive and wait and download after checking parsing working
=begin
        b7_2Driver(eventNamesArray, bandsArray)
        clickit()
        alert_clickit()

        storeTable($_browser)
        p $_table
        ap $_files_href
        checkTableDownload(bandsArray)
        downloadFile($_browser, $_files_href)

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


return 



=begin


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






