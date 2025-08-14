*** Settings ***
Library    Browser
Resource   ../Resources/variables.resource
Resource   ../Resources/keywords.resource
Library    ../libs/poll_generator.py    WITH NAME    PollGen

Suite Setup       Open Website
Suite Teardown    Close Browser

*** Test Cases ***
TC02 Delete Poll
    ${EMAIL}=       PollGen.Get Env    VC_EMAIL     required=True
    ${PASSWORD}=    PollGen.Get Env    VC_PASSWORD  required=True
    Login           ${EMAIL}    ${PASSWORD}

    ${poll_name}=   PollGen.Generate Poll Name    prefix=QWL-TO-DELETE
    Create Poll     ${poll_name}
    Log To Console  Deleting: ${poll_name}

    Delete Poll     ${poll_name}    ${CONFIRM_TEXT}
    Logout
