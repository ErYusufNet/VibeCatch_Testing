*** Settings ***
Library    Browser
Resource   ../resources/variables.robot
Resource   ../resources/keywords.robot
Library    ../libs/poll_generator.py    WITH NAME    PollGen

Suite Setup       Open website
Suite Teardown    Close Browser

*** Test Cases ***
TC01 Create New Poll
    Login
    ${poll_name}=    PollGen.Generate Poll Name
    Create Poll    ${poll_name}
    Open Basic Settings
    # Eğer dili de ayarlamak istiyorsan şu satırı aç:
    # Select Language    ${language}
    Save Changes
    Open Poll Settings
    Logout
