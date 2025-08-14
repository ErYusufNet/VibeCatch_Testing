*** Variables ***


# Locators
${BTN_ALLOW_COOKIES}         //div[contains(@class,'adroll_button_text') and normalize-space(.)='Allow All']
${BTN_LOGIN}                 //a[@class='login']
${INPUT_EMAIL}               input#username
${INPUT_PASSWORD}            input#password
${BTN_SUBMIT_LOGIN}          //input[@type='submit' and @value='Login']

${BTN_CREATE_POLL}    xpath=(//a[contains(@class,'add-project')])[1]

${INPUT_POLL_NAME}           input#addProjectName
${BTN_CREATE_QWL_POLL}       //button[normalize-space()='Create a QWL poll']

${SECT_BASIC_SETTINGS}    css=vibe-settings-advanced-button[icon='cog'] .accordionTitle
${BTN_SAVE}                  //a[@id='save']
${BTN_POLL_SETTINGS}         //i[contains(@class,'fa-gears')]

${SECT_REMOVE}               //vibe-settings-advanced-button[contains(@class,'removal-section')]//div[contains(@class,'accordionTitle')]
${BTN_DELETE_PROJECT}        //a[contains(@class,'btn-danger') and contains(@class,'delete-project')]
${BTN_DELETE_NOW}            //button[normalize-space()='Delete now']
${INPUT_DESTROY_PROMPT}      input.promptInput
${BTN_OK}                    //button[normalize-space()='OK']

${BTN_LOGOUT}                //a[normalize-space()='Log out']