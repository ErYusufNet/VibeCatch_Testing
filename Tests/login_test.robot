*** Settings ***
Resource   ../Resources/keywords.resource
Library    ../libs/env_utils.py    WITH NAME    Env

Suite Setup       Open Website
Suite Teardown    Close Browser

*** Test Cases ***
TC01 Login To Vibe catch
    ${EMAIL}=      Env.Get Env    VC_EMAIL     required=True
    ${PASSWORD}=   Env.Get Env    VC_PASSWORD  required=True
    Login          ${EMAIL}    ${PASSWORD}
