*** Settings ***
Library     Browser
Resource    ../Resources/keywords.robot
Resource    ../Resources/variables.robot

*** Test Cases ***
TC01 Create New Poll
    Open Website
    Login
    Create Poll



