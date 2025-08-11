*** Settings ***
Library    Browser
Resource   variables.robot

*** Keywords ***
Open website
    [Arguments]    ${browser}=chromium

    New Browser    browser=${browser}    headless=False    args=["--start-maximized"]
    New Context    viewport=${None}

    New Page    ${url}

    Click    //div[contains(@class,'adroll_button_text') and text()='Allow All']
    Click    //a[@class='login']

Login
    Wait For Elements State    input#username    visible    timeout=10s
    Fill Text    input#username    ${email}

    Wait For Elements State    input#password    visible    timeout=10s
    Fill Text    input#password    ${password}
    Click    //input[@type='submit' and @value='Login']
    Wait For Load State    load    timeout=30s

Create Poll
    [Arguments]    ${poll_name}
    Wait For Elements State    xpath=//body/vibe-app/div[@id='masterContainer']/vibe-list/div[2]/div[1]/a[1]    visible    timeout=15s
    Click                      xpath=//body/vibe-app/div[@id='masterContainer']/vibe-list/div[2]/div[1]/a[1]
    Wait For Elements State    xpath=//input[@id='addProjectName']    visible    timeout=10s
    Fill Text                  xpath=//input[@id='addProjectName']    ${poll_name}
    Wait For Elements State    xpath=//button[normalize-space()='Create a QWL poll']    visible    timeout=10s
    Click                      xpath=//button[normalize-space()='Create a QWL poll']

Open Basic Settings
    Scroll To Element        //vibe-settings-advanced-button[@icon='cog']//div[@class='accordionTitle']
    Click    //vibe-settings-advanced-button[@icon='cog']//div[@class='accordionTitle']

Save Changes
    Click    //a[@id='save']
    Wait For Load State    load    timeout=15s

Open Poll Settings

    Click    //i[@class='fa fa-fw fa-gears fa-fw']

Delete Poll


    Scroll To Element          //vibe-settings-advanced-button[contains(@class, 'removal-section')]//div[contains(@class,'accordionTitle')]
    Click                      //vibe-settings-advanced-button[contains(@class, 'removal-section')]//div[contains(@class,'accordionTitle')]

    # 2. Delete butonuna scroll yap ve tıkla
    Wait For Elements State    //a[contains(@class, 'btn-danger') and contains(@class, 'delete-project')]    visible    timeout=15s
    Scroll To Element          //a[contains(@class, 'btn-danger') and contains(@class, 'delete-project')]
    Click                      //a[contains(@class, 'btn-danger') and contains(@class, 'delete-project')]

    # 3. Onay penceresinde "Delete now" butonuna tıkla
    Wait For Elements State    //button[normalize-space()='Delete now']    visible    timeout=15s
    Click                      //button[normalize-space()='Delete now']

    # 4. Silme onay inputu görünene kadar bekle, "DESTROY" yaz, OK butonuna tıkla
    Wait For Elements State    input.promptInput    visible    timeout=15s
    Fill Text                  input.promptInput    ${confirm_text}
    Click                      //button[normalize-space()='OK']

    # 5. İşlem tamamlanana kadar logout linkinin görünmesini bekle
    Wait For Elements State    //a[normalize-space()='Log out']    visible    timeout=20s

Logout
    Wait For Elements State    //a[normalize-space()='Log out']    visible    timeout=10s
    Click                      //a[normalize-space()='Log out']
    Wait For Load State        load    timeout=15s
