*** Settings ***
Library    Browser
Resource   variables.robot

*** Keywords ***
Open Website
    [Arguments]    ${browser}=chromium
    New Browser    browser=${browser}    headless=False    args=["--start-maximized"]
    New Context    viewport=${None}
    New Page       ${url}
    Wait For Elements State    ${BTN_ALLOW_COOKIES}    visible    timeout=10s
    Click    ${BTN_ALLOW_COOKIES}
    # Login linkine burada TIKLAMA; Login keyword’ü kendi içinde durumu kontrol ediyor.

Go To Login
    ${form_visible}=    Run Keyword And Return Status    Wait For Elements State    ${INPUT_EMAIL}    visible    timeout=1s
    IF    not ${form_visible}
        Click    ${BTN_LOGIN}
        Wait For Elements State    ${INPUT_EMAIL}    visible    timeout=20s
    END

Login
    Go To Login
    Fill Text    ${INPUT_EMAIL}       ${email}
    Fill Text    ${INPUT_PASSWORD}    ${password}
    Click       ${BTN_SUBMIT_LOGIN}
    Wait For Load State    networkidle    timeout=45s
    Run Keyword And Ignore Error    Wait For Elements State    css=.dialog-overlay    hidden    timeout=10s

Go To Projects
    ${ok}=    Run Keyword And Return Status    Click    xpath=//a[normalize-space(.)='Projects']
    IF    not ${ok}
        Go To    ${url}#/projects
    END
    Wait For Load State    networkidle    timeout=30s

Wait Until Create Poll Visible (with retries)
    ${found}=    Set Variable    ${False}
    FOR    ${i}    IN RANGE    1    8
        ${ok}=    Run Keyword And Return Status    Wait For Elements State    ${BTN_CREATE_POLL}    visible    timeout=5s
        IF    ${ok}
            ${found}=    Set Variable    ${True}
            Exit For Loop
        END
        Sleep    1s
        Reload
        Wait For Load State    networkidle    timeout=15s
    END
    Run Keyword Unless    ${found}    Fail    'Create new poll button not visible after retries'

Create Poll
    [Arguments]    ${poll_name}
    Wait Until Create Poll Visible (with retries)
    Click                       ${BTN_CREATE_POLL}
    Wait For Elements State     ${INPUT_POLL_NAME}   visible    timeout=10s
    Fill Text                   ${INPUT_POLL_NAME}   ${poll_name}
    Wait For Elements State     //button[normalize-space()='Create a QWL poll']    visible    timeout=10s
    Click

Open Basic Settings
    Scroll To Element    ${SECTION_BASIC_SETTINGS}
    Click                ${SECTION_BASIC_SETTINGS}

Save Changes
    Click    ${BTN_SAVE}
    Wait For Load State    load    timeout=15s

Open Poll Settings
    Click    ${BTN_POLL_SETTINGS}

Delete Poll
    Scroll To Element    //vibe-settings-advanced-button[contains(@class, 'removal-section')]//div[contains(@class,'accordionTitle')]
    Click                //vibe-settings-advanced-button[contains(@class, 'removal-section')]//div[contains(@class,'accordionTitle')]
    Wait For Elements State    //a[contains(@class, 'btn-danger') and contains(@class, 'delete-project')]    visible    timeout=15s
    Scroll To Element          //a[contains(@class, 'btn-danger') and contains(@class, 'delete-project')]
    Click                      //a[contains(@class, 'btn-danger') and contains(@class, 'delete-project')]
    Wait For Elements State    //button[normalize-space()='Delete now']    visible    timeout=15s
    Click                      //button[normalize-space()='Delete now']
    Wait For Elements State    css:input.promptInput    visible    timeout=15s
    Fill Text                  css:input.promptInput    ${confirm_text}
    Click                      //button[normalize-space()='OK']
    Wait For Elements State    //a[normalize-space()='Log out']    visible    timeout=20s

Logout
    Wait For Elements State    //a[normalize-space()='Log out']    visible    timeout=10s
    Click                      //a[normalize-space()='Log out']
    Wait For Load State        load    timeout=15s
