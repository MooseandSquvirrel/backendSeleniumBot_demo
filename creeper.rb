require 'rubygems'
require 'selenium-webdriver'
 
browser = Selenium::WebDriver.for :chrome
browser.get "https://iims.navercorp.com/login?targetUrl=https://iims.navercorp.com/"
wait = Selenium::WebDriver::Wait.new(:timeout => 15)

 
# Add text to a text box
input = wait.until {
    element = browser.find_element(:name, "user")
    element if element.displayed?
}
input.send_keys("CAZ0412")
 
# Add text to a text box
input = wait.until {
    element = browser.find_element(:name, "password")
    element if element.displayed?
}
input.send_keys("Ihavethepower1!")

#element.send_keys [:, ''], :ENTER

# Check that the form exists
form = wait.until {
    element = browser.find_element(:id, "login-btn")
    element if element.displayed?
}
# form.send_keys("\ue007")

browser.quit