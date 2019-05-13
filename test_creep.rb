require 'rubygems'
require 'selenium-webdriver'
 
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
    sleep(2)
else
    puts "Nope ____"
end

# FINDS THE CARD LINK TO CLICK TO GO TO THE MAIN BACKEND MENU
# if card = browser.find_element(:xpath, "//*[@id='card-view-search-area']/li/a]");
if card = browser.find_element(:xpath, "//*[@id='card-view-search-area']/li")
    puts "Card link found.\n"
    card = browser.find_element(:xpath, "//*[@id='card-view-search-area']/li").click
    sleep(3)
    puts "================================="
    puts "Main menu of BAND backend reached.\n"
    puts "================================="
else
    puts "Card link not found for clickable 'square' card before Main Menu screen."
end







#form.find_element(:name, "login-btn").submit()
# input = wait.until{
#    element = browser.find_element(:id, "login-btn")
# }
#browser.find_element(:id, "login-btn")
#puts "Test Passed: Form input found" if input.displayed?
 
# Click the button based the form it is in (you can also call 'submit' method)

#browser.quit