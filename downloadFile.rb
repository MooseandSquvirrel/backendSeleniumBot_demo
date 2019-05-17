require 'rubygems'
require 'selenium-webdriver'
require 'pp'
require 'rspec/expectations'
require 'io/console'
require 'httparty'
require 'rest-client'
require 'open-uri'

"=="
# IF THIS WORKS MAKE downloadResult equal to the bandNum variable from beginning of program or whatever file is created with the band number from chngee i think
"=="

"-----------------------------------------------------------------------------------------------"
"--------------- BELOW THIS IS OLD DELETABLE CODE FOR USE IN TESTING MODULE ONLY ---------------"
"-----------------------------------------------------------------------------------------------"

bandNum = "75131431"

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

# GETS COOKIE NAMES OF PAGES
# puts "browser.manage.all_cookies"
# puts browser.manage.all_cookies

"Make this a wait.until when done with download part"
# FINDS THE FORM BUTTON WITH XPATH AND THEN USES .execute_script (A JAVASCRIPT ACTION I BELIEVE)
if button = browser.find_element(:xpath, "//*[@id='login-btn']")
    puts "Found form 'Submit' 'login-btn'."
    button = browser.find_element(:xpath, "//*[@id='login-btn']").click
    sleep(1)
else
    puts "No form 'Submit' login-btn found."
end

card = wait.until {
    element = browser.find_element(:xpath, "//*[@id='card-view-search-area']/li")
}

# FINDS THE CARD LINK TO CLICK TO GO TO THE MAIN BACKEND MENU
if card
    card.click
    puts "Card link found.\n"
    puts "======================================================="
    puts "\tMain menu of BAND backend reached.\n"
    puts "======================================================="
else
    puts "Card link not found for clickable 'square' card before Main Menu screen."
end

=begin
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
=end


# FIND THE LINK TO STATISTICS PAGE, ACCES STATISTICS PAGE
sleep(4)
if statistics = browser.find_element(:xpath, "//*[@id='carousel']/div[1]/ul/li[8]/div/a")
    puts "Statistics link found.\n"
    card = browser.find_element(:xpath, "//*[@id='carousel']/div[1]/ul/li[8]/div/a").click
    sleep(2)
    puts "% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %"
    puts "\tStatistics menu of BAND backend reached.\n"
    puts "% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %"
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



"THESE WILL NEED TO BE IMPLEMENTED INTO THE THE LOOP BELOW IN DOWNLOADING ALONG WITH 'WAIT UNTIL EXCEL LINK EXISTS'"

"NAVIGATE GOES TO URI WHICH DOWNLOADS EXCEL FILE"
#browser.navigate().to("http://dev-stats.admin.band.us/extractResult/downloadResult.nhn?no=18617&filetype=xlsx")
"SWITCH BACK TO FRAME TO CONTINUE SEARCHING TABLE"
#browser.switch_to.frame("svc-iframe")



# STORE THE TABLE INTO table OBJECT
table = wait.until {
    element = browser.find_element(:tag_name, "table")
    element if element.displayed?
}

"========="
# Print full table contents
# puts "Table with :tag_name=:\n" + table.text
 "========="

 sleep(3)
 # ITERATE THROUGH TABLE ROWS, THEN TABLE CELLS THEN STORE HREF LINKS OF DOWNLOAD LINK INTO ARRAY files_href
 files_href = []
 table.find_elements(:tag_name, "tr").each do |r|  "MAKE ANDY a gets.chomp variable at beginning of program (First and last name)"
     # PRINTS ALL CELL VALUES (1 CELL PER LINE)
    # puts "Cell Value: " + r.text
    if r.text.include? "CAZ0412"
        if r.text.include? "#{bandNum}"
            puts "***********************************************"
            puts "\t Empl. # and bandNum found in table."
            puts "***********************************************"
            # puts "Row text:"
            # puts r.text
            # next if cell.text != "Excel"
            # puts cell.methods
            # next if cell.text != "Excel"
            i = 0
            r.find_elements(:tag_name, "td").each do |cell|
                i += 1
                puts "Cell #{i}:"
                puts cell.text
                puts "__________"
                if i == 2 # THIS REACHES THE DOWNLOAD LINK CELL IN THE TABLE
                    while cell.text == 'RUNNING'
                        puts "STILL RUNNING..."
                        sleep(10) # change this to 30 or 60
                        redo
                    end
                    if cell.text == 'SUCCEED'
                        cell.find_elements(:tag_name, "a").each do |n|
                            files_href << n.attribute("href")
                        end
                    end
                end
                #if cell.find_element(:tag_name, "span")
                #  puts "span"
                #end
                # cell.find_elements(:tag_name, "a").each do |n|
                #  files_href << n.attribute("href")
                # end
            end
        end
    end
 end






 
=begin
sleep(3)
# ITERATE THROUGH TABLE ROWS, THEN TABLE CELLS THEN STORE HREF LINKS OF DOWNLOAD LINK INTO ARRAY files_href
files_href = []
table.find_elements(:tag_name, "tr").each do |r|  "MAKE ANDY a gets.chomp variable at beginning of program (First and last name)"
    # PRINTS ALL CELL VALUES (1 CELL PER LINE)
    # puts "Cell Value: " + r.text
    if r.text.include? "CAZ0412" && "#{bandNum}"
        puts "*******************************************"
        puts "\t Empl. # cell found in table."
        puts "*******************************************"
        puts "Row text:"
        puts r.text
        r.find_elements(:tag_name, "td").each do |cell|
            # next if cell.text != "Excel"
            # puts cell.methods
            # next if cell.text != "Excel"
            next if cell.find_element(:tag_name, "span") 
            cell.find_elements(:tag_name, "a").each do |n|
                files_href << n.attribute("href")
            end
        end        
    end
end
=end



p files_href

