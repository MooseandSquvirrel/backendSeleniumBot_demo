"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                  Function Entering Bands for Second B7                                 "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

def mvDirRoot()
    puts "----- Moving Directories to reach Main Directory of Fixit -----"
    puts "Directory before:"
    puts Dir.pwd
    mainDir = '~/fixit/backendSelenium'
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
    puts "bandsInnerArray:"
    ap bandsInnerArray

    bandNameCounter = 0
    bandsArray[bandNameCounter]

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

    lengthCounter = bandsInnerArray.length
    eventNameCounter = 1
        bandsInnerArray.each do |bandNum|
            bandNum = bandNum.join(",")
            if eventNameCounter < lengthCounter
                $_form.send_keys("#{bandNum}, ")
            else
                $_form.send_keys("#{bandNum} ")
            end
            eventNameCounter += 1
            puts "bandNum: #{bandNum}"
        end
        puts "bandArray: #{bandsArray}"
    sleep(2)
    puts "New Band Numbers entered into b7-2 text field for submission..."
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
