require 'rubygems'
require 'selenium-webdriver'
require 'pp'
require 'rspec/expectations'

puts "Enter BAND Number:"
bandNum = gets.chomp

browser = Selenium::WebDriver.for :chrome
browser.get "https://iims.navercorp.com/login?targetUrl=https://iims.navercorp.com/"
 
wait = Selenium::WebDriver::Wait.new(:timeout => 15)
 
# Add text to a text box
form = wait.until {
    element = browser.find_element(:name, "user")
    element if element.displayed?
}
sleep(1)
form.send_keys("CAZ0412")
 
# Add text to a text box
form = wait.until {
    element = browser.find_element(:name, "password")
    element if element.displayed?
}
sleep(1)
form.send_keys("Ihavethepower1!")

# FINDS THE FORM BUTTON WITH XPATH AND THEN USES .execute_script (A JAVASCRIPT ACTION I BELIEVE)
if button = browser.find_element(:xpath, "//*[@id='login-btn']")
    puts "Found *******"
    button = browser.find_element(:xpath, "//*[@id='login-btn']").click
    sleep(1)
else
    puts "Nope ____"
end

# FINDS THE CARD LINK TO CLICK TO GO TO THE MAIN BACKEND MENU
# if card = browser.find_element(:xpath, "//*[@id='card-view-search-area']/li/a]");
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
    puts "Card link found.\n"
    card = browser.find_element(:xpath, "//*[@id='carousel']/div[1]/ul/li[8]/div/a").click
    sleep(1)
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
    puts "Statistics menu of BAND backend reached.\n"
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
else
    puts "Statistcs link not found."
end


browser.switch_to.frame("svc-iframe")


# STORING ALL FUNCTION OPTIONS AND SELECTING B7
#### Interact with the drop down box
select_list = wait.until {
    if element = browser.find_element(:xpath, "//*[@id='templateNo']")
        element = browser.find_element(:xpath, "//*[@id='templateNo']")
    end
}
puts "select_list"
pp select_list
 
#### Extract all options from the select box
options=select_list.find_elements(:tag_name => "option")

# Reference URL http://elementalselenium.com/tips/5-select-from-a-dropdown
dropdown = browser.find_element(id: 'templateNo')
    select_list = Selenium::WebDriver::Support::Select.new(dropdown)
    select_list.select_by(:value, '45')
    puts "Dropdown option selected:"
    puts selected_option = select_list.selected_options[0].text
    sleep(2)

# (:xpath, "//*[@id='input']")
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

"THE NEXT STEP HERE WOULD BE TO ENTER SUBMIT BUT I NEED TO TRY TO WAIT ON THAT LONG AS I CAN
TO AVOID SPAMMING THE BACKEND LIST OF REPORTS SO I DON'T HURT WORKFLOW FOR OTHERS"








#form.find_element(:name, "login-btn").submit()
# input = wait.until{
#    element = browser.find_element(:id, "login-btn")
# }
#browser.find_element(:id, "login-btn")
#puts "Test Passed: Form input found" if input.displayed?
 
# Click the button based the form it is in (you can also call 'submit' method)

#browser.quit