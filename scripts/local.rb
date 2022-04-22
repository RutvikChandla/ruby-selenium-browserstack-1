require 'rubygems'
require 'selenium-webdriver'
require "browserstack/local"

USER_NAME = ENV['BROWSERSTACK_USER_NAME'] || "YOUR_USER_NAME"
ACCESS_KEY = ENV['BROWSERSTACK_ACCESS_KEY'] || "YOUR_ACCESS_KEY"

# Creates an instance of Local
bs_local = BrowserStack::Local.new

# You can also set an environment variable - "BROWSERSTACK_ACCESS_KEY".
bs_local_args = { "key" => ACCESS_KEY, "force" => "true" }

# Starts the Local instance with the required arguments
bs_local.start(bs_local_args)

# Check if BrowserStack local instance is running
puts bs_local.isRunning
# Input capabilities
options = Selenium::WebDriver::Options.chrome
options.browser_version = 'latest'
options.platform_name = 'MAC'
bstack_options = {
    "os" => "OS X",
    "osVersion" => "Sierra",
    "buildName" => "Final-Snippet-Test",
    "sessionName" => "Selenium-4 Ruby snippet test",
    "local" => "true",
    "seleniumVersion" => "4.0.0",
}

options.add_option('bstack:options', bstack_options)

driver = Selenium::WebDriver.for(:remote,
  :url => "https://#{USER_NAME}:#{ACCESS_KEY}@hub-cloud.browserstack.com/wd/hub",
  :capabilities => options)
begin
    # opening the bstackdemo.com website
    driver.navigate.to "http://bs-local.com:45691/check"
    wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
    
    body = driver.find_element(:css, 'body')
    wait.until { body.displayed? }
    body_text = body.text

    if body_text.eql? "Up and running"
        # marking test as 'passed' local ran succesfully
        driver.execute_script('browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"passed", "reason": "Local ran successfully"}}')
    else
        # marking test as 'failed' 
        driver.execute_script('browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"failed", "reason": "Local setup failed"}}')
    end
end
driver.quit 

# Stop the Local instance
bs_local.stop
