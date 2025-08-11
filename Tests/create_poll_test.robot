*** Settings ***
Library    Browser
Resource   ../resources/variables.robot
Resource   ../resources/keywords.robot
Library    ../libs/poll_generator.py    WITH NAME    PollGen

Suite Setup       Open Website
Suite Teardown    Close Browser

*** Test Cases ***
TC01 Create New Poll
    Login
    ${poll_name}=    Generate Poll Name
    Create Poll      ${poll_name}
    Open Basic Settings
    Save Changes
    Open Poll Settings
    Logout

