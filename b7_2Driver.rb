"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                  Function Entering Bands for Second B7                                 "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

def mvDirRoot()
    puts "----- Moving Directories to reach Main Directory of Fixit -----"
    puts "Directory before:"
    puts Dir.pwd
    mainDir = '~/fixit'
    Dir.chdir(File.expand_path(mainDir))
    puts "Directory is now:"
    puts Dir.pwd
end

def b7_2Driver(bandsArray)

    mvDirRoot()
    navigate($_userNameVar)
    # COUNTER FOR INNER LOOP OF NESTED UNTIL LOOP BELOW TO REACH ALL NEW BAND NUMBERS FROM GBLS INSIDE EACH EVENT IN EVENT ARRAY
    ap bandsArray
    #### bandsLength = bandsArray.newBandNumbsb7_2.length #this might not be necessary if collect works


    "I need a counter for conditional of until/while loop for how long the new numbs array is inside each event AND counter for events array itself"
    "question is how to double loop to get all newbands in each event"

    #eventNewBandsArrayLength = band.newBandNumbsb7_2.bandsLength
    ap bandsArray

    # GETTING ALL BAND NUMBS WITH .collect (ALREADY PERFORMED ABOVE TO GET THE (JUST STORED THAT ARRAY INTO bandsArray)))
    bandsInnerArray = bandsArray.collect {|x| x.newBandNumbsb7_2}

    # .compact REMOVES ANY POTENTIAL NIL VALUES OF NO GBLS/BAND NUMBERS FOR NEW BANDS CREATED FROM B3 -- POTENTIAL EDGE CASE
    bandsInnerArray = bandsInnerArray.compact

    puts "bandsInnerArray:"
    ap bandsInnerArray

    bandNameCounter = 0
    bandsArray[bandNameCounter]

    # STORING ALL FUNCTION OPTIONS AND SELECTING B7
    # INTERACTING WITH DROPDOWN BOX
    select_list = $_wait.until {
        element = $_browser.find_element(:xpath, "//*[@id='templateNo']")
        element if element.displayed?
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
    # NESTED LOOP TO ACCOUNT FOR ALL THE NEW BAND NUMBS ARRAYS IN EACH EVENT IN THE EVENT ARRAY
    # i = 0
    # j = 0
    # eventNameCounter = 0
    # until i == ength
    #     until bandNumbCounter == bandsLength
    #         $_form.send_keys("#{bandsArray[eventNameCounter].newBandNumbsb7_2[bandNumbCounter]}\n")
    #         bandNumCounter += 1
    #     end
    #     eventNameCounter += 1
    #     i += 1
    # end
    system('say "Second, B, 7, Bands, in, 10, seconds."')
    sleep(10)
    system('say "Beginning input."')

    ########   IT MIGHT WORK TO TRY '\n' LIKE IN b7_1Driver.rb INSTEAD OF COMMA BELOW INSIDE IF STATEMENT INTERPOLATION
    $_keys = false
    lengthCounter = bandsInnerArray.length
    eventNameCounter = 1
        bandsInnerArray.each do |bandNum|
            if bandNum.nil?
                next
            else
                sleep (5)
                puts "\n\n\n\n\n\n\n\n(b7_2Driver) bandNum 'ap' before .join(','):"
                ap bandNum
                bandNum = bandNum.join(",")
                puts "\n(b7_2Driver) bandNum 'ap' before .join(','):"
                if eventNameCounter < lengthCounter
                    $_form.send_keys("#{bandNum}\n")
                    #   CREATE A GLOBAL BOOLEAN HERE TO CHECK IF ANY KEYS ENTERED FOR ANY ARRAY, THAT IS FOR WHETHER TO SUBMIT/CLICK THIS SECOND B7 (IF NO GBLS FROM B3 AT ALL GO TO 'next')
                    $_keys = true
                else
                    $_form.send_keys("#{bandNum} ")
                    $_keys = true
                end
            end
            sleep(1)
            eventNameCounter += 1
            puts "bandNum: #{bandNum}"
        end
        puts "bandArray: #{bandsArray}"
    sleep(5)
    puts"\n\n\n\n\nSCREEN SHOT SAVED 'wtf.png'"
    $_browser.save_screenshot('wtf8.png')
    puts "New Band Numbers entered into b7-2 text field for submission..."
    puts "\n\nSCREEN SHOT SAVED 'wtf.png'"
    $_browser.save_screenshot('wtf9.png')
end
  
# def clickit()
#     $_form = $_wait.until {
#         element = $_browser.find_element(:id, "execute")
#         element if element.displayed?
#     }
#     $_form.click
#     sleep(5)
#     puts "Execute Clicked"
# end

# def alert_clickit()
#     # alert = $_browser.switch_to.alert
#     $_form = $_wait.until {
#         alert = $_browser.switch_to.alert
#     }
#     $_form.accept
#     sleep(5)
#     puts "Alert Clicked"
# end
