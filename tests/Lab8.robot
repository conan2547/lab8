*** Settings ***
Library    SeleniumLibrary
Documentation    UAT automation using Robot Framework running in Jenkins container

*** Variables ***
${URL}    https://computing.kku.ac.th
${BROWSER}    headlesschrome

*** Test Cases ***
Open KKU Website Successfully
    [Tags]    smoke    uat
    Open Browser To Website
    Title Should Not Be Empty
    Close Browser

*** Keywords ***
Open Browser To Website
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    
    # Set path to Chrome binary
    ${options.binary_location}=    Set Variable    /usr/bin/chromium
    
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --window-size\=1920,1080
    
    # Create Service with path to ChromeDriver
    ${service}=    Evaluate    sys.modules['selenium.webdriver.chrome.service'].Service(executable_path='/usr/bin/chromedriver')    sys, selenium.webdriver.chrome.service
    
    Create Webdriver    Chrome    options=${options}    service=${service}
    Go To    ${URL}

Title Should Not Be Empty
    ${title}=    Get Title
    Should Not Be Empty    ${title}