*** Settings ***
Library    Browser
Resource   ../resources/variables.robot
Resource   ../resources/keywords.robot

Suite Setup       Open Website
Suite Teardown    Close Browser

*** Test Cases ***
TC02 Delete Poll
    Login
    Open Poll Settings
    Delete Poll
    Logout
