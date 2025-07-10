*** Settings ***
Library     Browser
Resource    ../Resources/keywords.robot
Resource    ../Resources/variables.robot

*** Test Cases ***
*** Test Cases ***
TC01 Delete Poll
    Open website
    Login

    Open Poll Settings    # <== bunu ekle
    Delete Poll
    Logout


