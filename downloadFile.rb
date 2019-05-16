require 'rubygems'
require 'selenium-webdriver'
require 'pp'
require 'rspec/expectations'
require 'io/console'
require 'watir'

"-----------------------------------------------------------------------------------------------"
"--------------- BELOW THIS IS OLD DELETABLE CODE FOR USE IN TESTING MODULE ONLY ---------------"
"-----------------------------------------------------------------------------------------------"

bandNum = "75037032"

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
sleep(4)
if statistics = browser.find_element(:xpath, "//*[@id='carousel']/div[1]/ul/li[8]/div/a")
    puts "Statistics link found.\n"
    card = browser.find_element(:xpath, "//*[@id='carousel']/div[1]/ul/li[8]/div/a").click
    sleep(2)
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
    puts "Statistics menu of BAND backend reached.\n"
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
else
    puts "Statistcs link not found."
end

sleep(1)
# FRAME/IFRAME SWITCH REQUIRED TO CONTINUE ACCESSING INNER BROWSER NON-POP-UP WINDOWS/ELEMENTS
browser.switch_to.default_content
browser.switch_to.frame("svc-iframe")
sleep(1)

"-----------------------------------------------------------------------------------------------"
"--------------- ABOVE THIS IS OLD DELETABLE CODE FOR USE IN TESTING MODULE ONLY ---------------"
"-----------------------------------------------------------------------------------------------"

# Check that the table with the given id is displayed
table = wait.until {
    element = browser.find_element(:tag_name, "table")
    element if element.displayed?
}

# SHOULD PRINT ALL TABLE ELEMENTS
# puts "BAND Table found" if table

"========="
# Print full table contents
# puts "Table with :tag_name=:\n" + table.text
 "========="

=begin
# Iterate through all cells of the table
table.find_elements(:tag_name, "td").each do |r|
    puts "Cell Value: " + r.text
end
=end
sleep(3)
# Iterate through all cells of the table
# table.find_element(:xpath, "//tr/td[contains(text(),'#{bandNum}')]/../td/a[contains(text(),'Excel')]").click
files_href = []

table.find_elements(:tag_name, "tr").each do |r|  "MAKE ANDY a gets.chomp variable at beginning of program (First and last name)"
    # PRINTS ALL CELL VALUES (1 CELL PER LINE)
    # puts "Cell Value: " + r.text
    if r.text.include? "CAZ0412" && "#{bandNum}"   # Use {bandNum} interpolation in place of my BAND empl. # 
        puts "*******************************************"
        puts "\t Empl. # cell found in table."
        puts "*******************************************"
        puts "Row text:"
        puts r.text
        r.find_elements(:tag_name, "td").each do |c|
            next if c.text != "Excel"
            c.find_elements(:tag_name, "a").each do |n|
                files_href << n.attribute("href")
            end
        end        
    end
end

p files_href
=begin
#### Print the value from the 1'st column of the 2'nd row of the table
puts "Value from the 1'st column of the 2'nd row of the table: " + browser.find_elements(:xpath => "//table[@id='booktable']/tbody/tr")[1].text.split(' ')[0]
 
#### Print the value from the 2'nd column of the 1'st row of the table
puts "Value from the 2'nd column of the 1'st row of the table: " + browser.find_elements(:xpath => "//table[@id='booktable']/tbody/tr")[0].text.split(' ')[1]
 
puts form
=end


