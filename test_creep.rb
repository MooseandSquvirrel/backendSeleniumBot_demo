require 'rubygems'
require 'selenium-webdriver'
require 'pp'
require 'rspec/expectations'
require 'io/console'


"TEST BAND #"
"Warmhammer BAND"
"75037032"


puts "Enter BAND Number:"
bandNum = gets.chomp
#### puts "Enter Naver Username:"
#### naverUser = gets.chomp
#### puts "Enter Naver Password:"
#### naverPwd = STDIN.noecho(&:gets).chomp

browser = Selenium::WebDriver.for :chrome
browser.get "https://iims.navercorp.com/login?targetUrl=https://iims.navercorp.com/"
 
wait = Selenium::WebDriver::Wait.new(:timeout => 15)
 
# USR DATA ENTRY
form = wait.until {
    element = browser.find_element(:name, "user")
    element if element.displayed?
}
sleep(1)
form.send_keys("CAZ0412")
#### form.send_keys("#{naverUser}")
 
# PW DATA ENTRY
form = wait.until {
    element = browser.find_element(:name, "password")
    element if element.displayed?
}
sleep(1)
form.send_keys("Ihavethepower1!")
#### form.send_keys("#{naverPwd}")


# FINDS THE FORM BUTTON WITH XPATH AND THEN USES .execute_script (A JAVASCRIPT ACTION I BELIEVE)
if button = browser.find_element(:xpath, "//*[@id='login-btn']")
    puts "Found form 'Submit' 'login-btn'."
    button = browser.find_element(:xpath, "//*[@id='login-btn']").click
    sleep(1)
else
    puts "No form 'Submit' login-btn found."
end

# FINDS THE CARD LINK TO CLICK TO GO TO THE MAIN BACKEND MENU
if card = browser.find_element(:xpath, "//*[@id='card-view-search-area']/li")
    puts "Card link found.\n"
    card = browser.find_element(:xpath, "//*[@id='card-view-search-area']/li").click
    sleep(1)
    puts "================================="
    puts "Main menu of BAND backend reached.\n"
    puts "================================="
else
    puts "Card link not found for clickable 'square' card before Main Menu screen."
end

# FIND THE LINK TO STATISTICS PAGE, ACCES STATISTICS PAGE
sleep(3)
if statistics = browser.find_element(:xpath, "//*[@id='carousel']/div[1]/ul/li[8]/div/a")
    puts "Statistics link found.\n"
    card = browser.find_element(:xpath, "//*[@id='carousel']/div[1]/ul/li[8]/div/a").click
    sleep(1)
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
    puts "Statistics menu of BAND backend reached.\n"
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
else
    puts "Statistcs link not found."
end

# FRAME/IFRAME SWITCH REQUIRED TO CONTINUE ACCESSING INNER BROWSER NON-POP-UP WINDOWS/ELEMENTS
browser.switch_to.frame("svc-iframe")

# STORING ALL FUNCTION OPTIONS AND SELECTING B7
# INTERACTING WITH DROPDOWN BOX
select_list = wait.until {
    if element = browser.find_element(:xpath, "//*[@id='templateNo']")
        element = browser.find_element(:xpath, "//*[@id='templateNo']")
    end
}
puts "Function collected from dropdown function options. (into select_list):"
pp select_list
 
# EXTRACTING ALL OPTIONS FROM THE DROPDOWN BOX
options=select_list.find_elements(:tag_name => "option")

# REFERENCE URL http://elementalselenium.com/tips/5-select-from-a-dropdown
dropdown = browser.find_element(id: 'templateNo') #### Comma needed between id: and 'templateNo' ?
    select_list = Selenium::WebDriver::Support::Select.new(dropdown)
    select_list.select_by(:value, '45')
    puts "Dropdown option selected:"
    puts selected_option = select_list.selected_options[0].text
    sleep(2)

# USING BAND PARAMETERS FROM COMMANDLINE GETS AT START OF CREEPER (ARRAY?)
form = wait.until {
    if element = browser.find_element(:tag_name, "textarea")
        puts "Inputing BAND name into data field."
        element = browser.find_element(:tag_name, "textarea")
    else
        puts "BAND data not entered into text field."
    end
    element if element.displayed?
}
form.send_keys("#{bandNum}")
sleep(1)






"submit"







# FINDS THE CARD LINK TO CLICK TO GO TO THE MAIN BACKEND MENU
if card = browser.find_element(:xpath, "/html/body/div/table/tbody/tr[1]/td[7]/a")
    puts "Download file found.\n"
    card = browser.find_element(:xpath, "/html/body/div/table/tbody/tr[1]/td[7]/a").click
    sleep(1)
    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    print "File Downloading"
    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    sleep(1)
    print "."
    sleep(1)
    print "."
    sleep(1)
    print "."
else
    puts "Card link not found for clickable 'square' card before Main Menu screen."
end

/html/body/div/table/tbody/tr[1]/td[7]/a





"TO DO:"
"================================================================================================="
"THE NEXT STEP HERE WOULD BE TO CLICK SUBMIT BUT I NEED TO TRY TO WAIT ON THAT LONG AS I CAN
TO AVOID SPAMMING THE BACKEND LIST OF REPORTS SO I DON'T HURT WORKFLOW FOR OTHERS. THE STEP AFTER
THAT WOULD ALSO BE TO REPEAT THIS OPERATION FOR B3 AND THEN CLICK SUBMIT (AND HANDLE BELOW ALERT
FOR BOTH)."

"AFTER SUBMIT, ALERT HAPPENS NOTIFIYING SUCCESSFUL 'SUBMIT'"
"driver.switchTo().alert().accept()  <-- I THINK THAT IS THE SOLUTION"

"NEXT: CHECKING IF B-7 RESULT IS TRUE OR FALSE OR DOWNLOADABLE FILE/FILE OR NOT.
AND CHECKING IF B-3 IS DONE AS WELL. IF NOT, RELOAD PAGE, CHECK EVERY 30 SECS OR 1 MINUTE"

# "NEXT: IF NEW MAIN DIRECTORY WITH NAME 'CAMP_DATA' DOESN'T EXIST --ALREADY-- ON THE DESKTOP, THEN
# CREATE IT ON THE DESKTOP"

# "NEXT: IF NEW TEMP_DATA DIRECTORY DOESN'T EXIT ON DESKTOP --ALREADY--, THEN CREATE IT ON DESKTOP"

# "NEXT: OPEN/CHECK CAMP_DATA DIRECTORY, IF SUBDIRECTORY OF TODAYS DATE DOESN'T EXIST ALREADY, CREATE SUBDIRECTORY
# WITH TODAYS DATE (FIND RUBY OR SYSTEM DATE CALL AS VARIABLE)"

# "NEXT: OPEN/CHECK TODAY'S DATE DIRECTORY, IF SUBDIRECTORY OF BANDNUMBER == TO 'bandNum' ENTERED AT BEGINNING,
# CREATE DIRECTORY WITH THAT BAND NUMBER AS NAME"

"NEXT: DOWNLOAD EXCEL SHEET FOR B-7 AND B-3 TO TEMP_DATA SUBDIRECTORY.
THIS ACTION MIGHT NEED TO WAIT/CHECK FOR BOTH TO BE READY TO DOWNLOAD,
SO NOTHING GOES CRAZY OR REQUIRES ASYNCHRONICITY."

"NEXT: OPEN FILE IN TEMP_DATA SUBDIRECTORY WITH RUBY-EXCEL-FILTERING LIBRARY"

"NEXT: PERFORM FILTERING OPERATIONS ON B-7 AND B-3" "*** CHECK WHAT ACTUAL DATA NEEDED FOR FINAL TABLE ***"

"NEXT: SAVE IMPORTANT DATA (AS VARIABLES?) FOR USE IN SECOND B-7"

"MORE :)"

"BE ABLE TO WORK ON MICROSOFT OR MAC FOR SELINIUM AND DOWNLOAD ANY LIBRARIES AND REQUIRES LANGUAGES, 
AND CHROMEDRIVER (CHANGE CHROMEDRIVER TO :CHROME)"




#browser.quit