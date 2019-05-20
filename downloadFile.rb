require 'rubygems'
require 'selenium-webdriver'
require 'pp'
require 'rspec/expectations'
require 'io/console'
require 'httparty'
require 'rest-client'
require 'open-uri'
require 'pp'

"=="
# IF THIS WORKS MAKE downloadResult equal to the bandNum variable from beginning of program or whatever file is created with the band number from chngee i think
"=="

"-----------------------------------------------------------------------------------------------"
"--------------- BELOW THIS IS OLD DELETABLE CODE FOR USE IN TESTING MODULE ONLY ---------------"
"-----------------------------------------------------------------------------------------------"

bandNum = "75308330"

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

sleep(2)
card = wait.until {
    element = browser.find_element(:xpath, "//*[@id='card-view-search-area']/li")
}

# FINDS THE CARD LINK TO CLICK TO GO TO THE MAIN BACKEND MENU
if card
    card.click
    puts "Card link found.\n"
    "BANNER TEXT FILES WILL NEED TO BE INCLUDED WITH THE EXECUTABLE FOR WHEN OTHER COMPUTERS USE"
    bannerMainMenu = File.read("./backendBanner.txt")
    puts bannerMainMenu
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
    puts "\tStatistics link found.\n"
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

$cellReturnText = ""
files_href = []

"GOING TO NEED TO INTERPOLATE EMPLOYEE ID BELOW IN 'IF'"
# FUNCTION TO ITERATE BACK TO CELL WITH "RUNNING/SUCEED" TEXT IN ORDER TO BREAK WHILE LOOP OF 'STILL RUNNING'
def iterate_to_cell(table, bandNum)
    table.find_elements(:tag_name, "tr").each do |r|  
        if r.text.include? "CAZ0412"
            if r.text.include? "#{bandNum}"
                i = 0
                r.find_elements(:tag_name, "td").each do |cell|
                    i += 1
                    if i == 2
                        puts "Inside iterate_to_cell, cell.text == #{cell.text}"
                        return cell.text
                    end
                end
            end
        end
    end
end

"GOING TO NEED TO INTERPOLATE EMPLOYEE ID BELOW IN 'IF'"
# FUNCTION TO ITERATE TO CELL WITH HREF DOWNLOAD LINK
def iterate_to_hrefCell(table, bandNum, files_href)
    table.find_elements(:tag_name, "tr").each do |r|  
        if r.text.include? "CAZ0412"
            if r.text.include? "#{bandNum}"
                i = 0
                r.find_elements(:tag_name, "td").each do |cell|
                    i += 1
                    if i == 7
                        puts "Inside iterate_to_hrefCell"
                        cell.find_elements(:tag_name, "a").each do |n|
                            puts "n.attribute(\"href\") storing into array files_href" 
                            files_href << n.attribute("href")
                        end
                    end
                end
            end
        end
    end
end


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
table.find_elements(:tag_name, "tr").each do |r|  
    if r.text.include? "CAZ0412"
        if r.text.include? "#{bandNum}"
            puts "***********************************************"
            puts "\t Empl. # and bandNum found in table."
            puts "***********************************************"
            # puts "Row text:"
            # puts r.text
    
            i = 0
            r.find_elements(:tag_name, "td").each do |cell|
                i += 1
                puts "Cell #{i}:"
                puts cell.text
                puts "__________"
                if i == 2 # THIS REACHES THE DOWNLOAD LINK CELL IN THE TABLE
                    while cell.text == 'RUNNING'
                        $cellReturnText = iterate_to_cell(table, bandNum)
                        puts "$cellReturnText: #{$cellReturnText}"
                        if $cellReturnText == 'SUCCEED'
                           return $cellReturnText
                        end
                        #"elapsedTime = Figure out timer ++++++ "
                        puts "STILL RUNNING..."
                        sleep(10) # change this to 30 or 60
                        reloadButton = browser.find_element(:id, "refresh").click
                        # GRABS NEW REFERENCE TO TABLE AFTER REFRESH
                        table = wait.until {
                            element = browser.find_element(:tag_name, "table")
                        }
                        puts "After Reload, table:"
                        puts table
                        puts "---------------------------------------------------------"
                        sleep(5)
                        redo
                    end
                end
            end
        end
    end
end

$cellReturnText = iterate_to_cell(table, bandNum)
puts "above if"
puts "$cellReturnText == #{$cellReturnText}"
if $cellReturnText == 'SUCCEED'
    puts "in if"
    iterate_to_hrefCell(table, bandNum, files_href)
end

puts "Download links from files_href array:"
pp files_href


#"NAVIGATE GOES TO URI WHICH DOWNLOADS EXCEL FILE"
downloadFileee = browser.navigate().to("http://dev-stats.admin.band.us/extractResult/downloadResult.nhn?no=18617&filetype=xlsx")
open

#"SWITCH BACK TO FRAME TO CONTINUE SEARCHING TABLE"
##browser.switch_to.frame("svc-iframe")











"LINKS READY TO DOWNLOAD, BUT I ALSO NEED TO FIGURE OUT FLOW. AFTER B7 INPUT, IT SHOULD PUT IN B3 RIGHT AWAY 
(OR ELSE DOUBLE WAIT TIME. MIGHT NOT BE POSSIBLE BUT TRY). THEN SHOULD WAIT FOR --BOTH--, THEN DOWNLOAD, FIXEM, 
THEN USE DATA FOR FINAL B7" "SO AFTER SUBMITTING BOTH B3 AND B7, THEN INSIDE THE 'STILL RUNNING' CHECK, NEED TO 
FIND A WAY TO CHECK ALL ROWS OF TABLE FOR bandNum and Empl# AGAIN TO CHECK CELL 2 OF OTHER FUNCTION CALL (EITHER B3 OR B7
DEPENDING WHICH WAS CALLED FIRST)"

"BELOW IS DOWNLOAD AND NAVIGATION TO GET NEXT DOWNLOAD."
#files_href.each do |i|
 #   browser.navigate().to("#{i}")
    # might need the the brower.switch_to.frame("svc-iframe") here to make it work with each link to get back to main page.
#end
#"NAVIGATE GOES TO URI WHICH DOWNLOADS EXCEL FILE"
#browser.navigate().to("http://dev-stats.admin.band.us/extractResult/downloadResult.nhn?no=18617&filetype=xlsx")
#"SWITCH BACK TO FRAME TO CONTINUE SEARCHING TABLE"
##browser.switch_to.frame("svc-iframe")




