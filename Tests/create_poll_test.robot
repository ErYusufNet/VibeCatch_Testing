*** Settings ***
Library    Browser
Resource    ../Resources/variables.resource
Resource   ../Resources/keywords.resource
Library    ../libs/poll_generator.py    WITH NAME    PollGen
Library    ../libs/env_utils.py    WITH NAME    Env

Suite Setup       Open Website
Suite Teardown    Close Browser

*** Test Cases ***
TC01 Create New Poll
    ${EMAIL}=      PollGen.Get Env    VC_EMAIL     required=True
    ${PASSWORD}=   PollGen.Get Env    VC_PASSWORD  required=True
    Login          ${EMAIL}    ${PASSWORD}

    ${poll_name}=  PollGen.Generate Poll Name    prefix=QWL
    Create Poll    ${poll_name}
    Logout
