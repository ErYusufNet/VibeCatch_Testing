*** Settings ***
Resource    ./variables.resource
Resource    ./locators.resource
Library     Browser

*** Keywords ***
Open Website
    New Browser    browser=chromium    headless=${False}    args=["--start-maximized"]
    New Context    viewport=${None}
    New Page       ${URL}
    Run Keyword And Ignore Error    Wait For Elements State    ${BTN_ALLOW_COOKIES}    visible    timeout=8s
    Run Keyword And Ignore Error    Click    ${BTN_ALLOW_COOKIES}

Go To Login
    ${form_visible}=    Run Keyword And Return Status    Wait For Elements State    ${INPUT_EMAIL}    visible    timeout=1s
    IF    not ${form_visible}
        Wait For Elements State    ${BTN_LOGIN}    visible    timeout=15s
        Click    ${BTN_LOGIN}
        Wait For Elements State    ${INPUT_EMAIL}    visible    timeout=20s
    END

Login
    [Arguments]    ${email}    ${password}
    Go To Login
    Fill Text    ${INPUT_EMAIL}       ${email}
    Fill Text    ${INPUT_PASSWORD}    ${password}
    Click        ${BTN_SUBMIT_LOGIN}
    Wait For Load State    networkidle    timeout=45s
    Run Keyword And Ignore Error    Wait For Elements State    css=.dialog-overlay    hidden    timeout=10s

# ——————————————————————————————————————————————————————————
# CREATE POLL (senin verdiğin Xpath'lere göre)
# 1) Create → 2) Name → 3) Create a QWL poll → 4) Basic Settings
# 5) Translations: Finnish ekle → 6) Save
# ——————————————————————————————————————————————————————————
Create Poll
    [Arguments]    ${poll_name}
    # 1) Create butonuna tıkla
    Wait For Elements State    xpath=//body/vibe-app/div[@id='masterContainer']/vibe-list/div[2]/div[1]/a[1]    visible    timeout=20s
    Click                      xpath=//body/vibe-app/div[@id='masterContainer']/vibe-list/div[2]/div[1]/a[1]

    # 2) İsim alanına yaz
    Wait For Elements State    xpath=//input[@id='addProjectName']    visible    timeout=20s
    Fill Text                  xpath=//input[@id='addProjectName']    ${poll_name}

    # 3) QWL create
    Wait For Elements State    xpath=//button[normalize-space()='Create a QWL poll']    visible    timeout=15s
    Click                      xpath=//button[normalize-space()='Create a QWL poll']
    Wait For Load State        networkidle    timeout=30s

    # 4) Basic Settings açıldıysa Kaydet (optional/fallback)
    ${BASIC_SECT}=    Set Variable    xpath=//vibe-settings-advanced-button[@icon='cog']//div[contains(@class,'accordionTitle')]
    ${on_settings}=    Run Keyword And Return Status    Wait For Elements State    ${BASIC_SECT}    visible    timeout=8s
    IF    ${on_settings}
        Scroll To Element          ${BASIC_SECT}
        Click                      ${BASIC_SECT}
        ${can_save}=    Run Keyword And Return Status    Wait For Elements State    xpath=//a[@id='save']    visible    timeout=10s
        IF    ${can_save}
            Scroll To Element      xpath=//a[@id='save']
            Click                  xpath=//a[@id='save']
            Wait For Load State    networkidle    timeout=20s
        END
    END

# ——————————————————————————————————————————————————————————
# SETTINGS / NAVIGATION
# ——————————————————————————————————————————————————————————
Open Basic Settings
    [Arguments]    ${poll_name}=${NONE}
    ${BASIC_SECT}=    Set Variable    xpath=//vibe-settings-advanced-button[@icon='cog']//div[contains(@class,'accordionTitle')]
    ${ok}=    Run Keyword And Return Status    Wait For Elements State    ${BASIC_SECT}    visible    timeout=5s
    IF    not ${ok}
        Run Keyword    Open Poll Settings    ${poll_name}
        ${ok}=    Run Keyword And Return Status    Wait For Elements State    ${BASIC_SECT}    visible    timeout=8s
        IF    not ${ok}
            Wait For Elements State    ${BASIC_SECT}    visible    timeout=8s
        END
    END
    Scroll To Element          ${BASIC_SECT}
    Click                      ${BASIC_SECT}
    Wait For Elements State    ${BTN_SAVE}    visible    timeout=10s

Open Poll Settings
    [Arguments]    ${poll_name}
    ${BASIC_SECT}=    Set Variable    xpath=//vibe-settings-advanced-button[@icon='cog']//div[contains(@class,'accordionTitle')]
    ${on_settings}=    Run Keyword And Return Status    Wait For Elements State    ${BASIC_SECT}    visible    timeout=3s
    IF    ${on_settings}
        [Return]
    END

    ${CARD1}=    Set Variable    css=.project:has(h3:has-text("${poll_name}"))
    ${CARD2}=    Set Variable    css=.project:has(:text("${poll_name}"))
    ${CARD3}=    Set Variable    xpath=//*[contains(@class,'project')][.//*[self::h1 or self::h2 or self::h3 or self::a][normalize-space()="${poll_name}"]]

    ${ok}=    Run Keyword And Return Status    Wait For Elements State    ${CARD1}    visible    timeout=6s
    IF    not ${ok}
        ${ok}=    Run Keyword And Return Status    Wait For Elements State    ${CARD2}    visible    timeout=6s
        IF    not ${ok}
            Wait For Elements State    ${CARD3}    visible    timeout=10s
            ${CARD}=    Set Variable    ${CARD3}
        ELSE
            ${CARD}=    Set Variable    ${CARD2}
        END
    ELSE
        ${CARD}=    Set Variable    ${CARD1}
    END

    Hover    ${CARD}
    ${clicked}=    Run Keyword And Return Status    Click    ${CARD} >> css=i.fa-gears
    IF    not ${clicked}
        ${clicked}=    Run Keyword And Return Status    Click    ${CARD} >> css=i.fa-cog
        IF    not ${clicked}
            ${clicked}=    Run Keyword And Return Status    Click    ${CARD} >> xpath=.//i[contains(@class,'fa') and (contains(@class,'gears') or contains(@class,'cog'))]
            IF    not ${clicked}
                Click    ${CARD}
            END
        END
    END
    Wait For Load State    networkidle    timeout=20s

Save Changes
    Wait For Elements State    ${BTN_SAVE}    visible    timeout=20s
    Scroll To Element          ${BTN_SAVE}
    Click                      ${BTN_SAVE}
    Wait For Load State        networkidle    timeout=30s

Delete Poll
    [Arguments]    ${poll_name}    ${confirm_text}
    Open Poll Settings    ${poll_name}
    Wait For Elements State    ${SECT_REMOVE}           visible    timeout=15s
    Scroll To Element          ${SECT_REMOVE}
    Click                      ${SECT_REMOVE}
    Wait For Elements State    ${BTN_DELETE_PROJECT}    visible    timeout=15s
    Scroll To Element          ${BTN_DELETE_PROJECT}
    Click                      ${BTN_DELETE_PROJECT}
    Wait For Elements State    ${BTN_DELETE_NOW}        visible    timeout=15s
    Click                      ${BTN_DELETE_NOW}
    Wait For Elements State    ${INPUT_DESTROY_PROMPT}  visible    timeout=15s
    Fill Text                  ${INPUT_DESTROY_PROMPT}  ${confirm_text}
    Click                      ${BTN_OK}
    Wait For Elements State    ${BTN_LOGOUT}            visible    timeout=20s

Logout
    Wait For Elements State    ${BTN_LOGOUT}    visible    timeout=20s
    Click                      ${BTN_LOGOUT}
    Wait For Load State        networkidle      timeout=20s
