# ruby-selenium-browserstack

## Prerequisite
a. Ruby setup on your machine
```
ruby -v
```

b. bundler gem
```
gem install bundler
```

## Steps for running test session

1. Clone the repo, navigate to the cloned folder then install the dependencies:
```
bundle install
```
2. Configure the capabilties for the test and use your credentials <br>
(Context: For running single test session). <br>
i. Navigate to ./scripts/single.rb <br>
ii. Change the capabilities and swap the credentials.

You can export Browserstack Username and Access key or hard code them in script.
```
export BROWSERSTACK_USER_NAME="YOUR_USER_NAME";
export BROWSERSTACK_ACCESS_KEY="YOUR_ACCESS_KEY";
```
  ```ruby
# change capabilities
caps = Selenium::WebDriver::Remote::Capabilities.new
caps['device'] = 'iPhone 11'
caps['realMobile'] = 'true'
caps['os_version'] = '14.0'
caps['javascriptEnabled'] = 'true'
caps['name'] = 'BStack-[Ruby] Sample Test' # test name
caps['build'] = 'BStack Build Number 1' # CI/CD job or build name
  ```
  
3. Run test session
For running single test
```
bundle exec ruby ./scripts/single.rb
```

For running local test (in ./scripts/local.rb)

```
bundle exec ruby ./scripts/local.rb
```

For running parallel tests
```
bundle exec ruby ./scripts/parallel.rb
```