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

browser = Watir::Browser.new
brower = browser.goto("https://iims.navercorp.com/login?targetUrl=https://iims.navercorp.com/")

# USR DATA ENTRY
form = browser.wait_until {
    element = browser.text_field(name: "user")
}
sleep(1)
form.set("CAZ0412")
#### form.send_keys("#{naverUser}")
sleep(1)
# PW DATA ENTRY
form = browser.wait_until {
    element = browser.text_field(name: "password")
}
sleep(1)
form.set("Ihavethepower1!")
#### form.send_keys("#{naverPwd}")

# FINDS THE FORM BUTTON WITH XPATH AND THEN USES .execute_script (A JAVASCRIPT ACTION I BELIEVE)
if button = browser.button(:xpath, "//*[@id='login-btn']")
    puts "Found form 'Submit' 'login-btn'."
    button = browser.button(:xpath, "//*[@id='login-btn']").click
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

browser = Watir::Browser.new
browser.goto("https://iims.navercorp.com/login?targetUrl=https://iims.navercorp.com/")
 
wait = Watir::Browser.new


table = driver.table(:class => ["table table-striped table-bordered table-hover"])
  textRow = table.td(:text => "TestingName1").parent
  if textRow.a(:id => "lnkDeleteVendor").exists?
    textRow.a(:id => "lnkDeleteVendor").click
  end




















  "-----------------------------------------------------------------------------------------------"
  "--------------------------------- ABOVE THIS IS Watir ATTEMPT ---------------------------------"
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
            puts "c.text:"
            puts c.text
            if c.text.include? "Excel"
                c = c.find_element(:xpath, "//a[@href=contains(hfref, 'extractResult')]") # Might need to remove '//' so doesn't search whole tree
                # c = c.click(:xpath, '//a[@href=contains()]')
                c.click
            end

            #if c.text.include? "Excel"
             #   c = c.find_element(:link_text, "Excel")
              #  puts "*********** CLICKING EXCEL ***********"
               # puts "\t\tClick."
                #print c.click
                #puts "**************************************"
            #else
             #   "RELOAD PAGE EVERY 10 - 30 seconds (sleep 10 - 30 seconds, then Reload/refresh page function)"
            #end
        end        
    end
end

=begin
#### Print the value from the 1'st column of the 2'nd row of the table
puts "Value from the 1'st column of the 2'nd row of the table: " + browser.find_elements(:xpath => "//table[@id='booktable']/tbody/tr")[1].text.split(' ')[0]
 
#### Print the value from the 2'nd column of the 1'st row of the table
puts "Value from the 2'nd column of the 1'st row of the table: " + browser.find_elements(:xpath => "//table[@id='booktable']/tbody/tr")[0].text.split(' ')[1]
 
puts form
=end


