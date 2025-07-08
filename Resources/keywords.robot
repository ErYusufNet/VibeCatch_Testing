*** Settings ***
Library    Browser
Resource    variables.robot

*** Keywords ***
Open website
    New Browser    headless=False
    New Page    ${url}
    Click    //div[contains(@class,'adroll_button_text') and text()='Allow All']
    Click    //a[@class='login']
Login
    Wait For Elements State    input#username    visible    timeout=10s
    Fill Text    input#username    ${email}
    Wait For Elements State    input#password    visible    timeout=10s
    Fill Text    input#password    ${password}
    Click    //input[@type='submit' and @value='Login']

Create Poll
    Wait For Elements State    //a[@class='btn add-project']    visible    timeout=10s
    Click    //a[@class='btn add-project']
    Wait For Elements State    input#addProjectName    visible    timeout=10s
    Fill Text    input#addProjectName    ${poll_name}
    Press Keys    input#addProjectName    ENTER
Open Basic Settings
    Scroll To Element        //vibe-settings-advanced-button[@icon='cog']//div[@class='accordionTitle']
    Click    //vibe-settings-advanced-button[@icon='cog']//div[@class='accordionTitle']
Select Language

    Wait For Elements State   //select[contains(@class,'ng-pristine')]    visible    timeout=10s
    Select Options By         //select[contains(@class,'ng-pristine')]    label=${LANGUAGE}

Save Changes
    Click    //a[@id='save']
    Wait For Navigation    timeout=10s

Open Poll Settings
    Wait For Elements State    //i[@class='fa fa-fw fa-gears fa-fw']    visible    timeout=10s
    Click    //i[@class='fa fa-fw fa-gears fa-fw']
    Scroll                    0    1000





    
Save Changes
    


    








