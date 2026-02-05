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
    ${options.binary_location}=    Set Variable    /usr/bin/chromium
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --disable-gpu
    
    Create Webdriver    Chrome    options=${options}
    Go To    ${URL}

Title Should Not Be Empty
    ${title}=    Get Title
    Should Not Be Empty    ${title}