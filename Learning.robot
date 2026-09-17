*** Settings ***
Library                        String
Documentation                  New test suite
# You can change imported library to "QWeb" if testing generic web application, not Salesforce.
Library                        QForce
Library                        DateTime
Suite Setup                    Open Browser                about:blank                 chrome
Suite Teardown                 Close All Browsers
*** Variables ***
@{ACCOUNT_NAMES}               Account                     Account1                    Account2
${account_name}




*** Keywords ***
Login To Salesforce
    OpenBrowser                ${login_url}                chrome
    TypeText                   Username                    ${username}
    ClickText                  Log In
    TypeText                   Password                    ${password}
    ClickText                  Log In
    TypeText                   Verification Code           ${Verification}
    ClickText                  Verify
*** Test Cases ***
Create a Account Record

    ClickText                  Accounts
    VerifyText                 Accounts
    ClickText                  New                         partial_match=False
    Sleep                      5s
    VerifyText                 Account Information
    UseModal                   On
    TypeText                   Account Name                Agarwal Ronit
    ClickText                  Save                        partial_match=False
    Sleep                      5s
    Verifytext                 Agarwal

Edit account
    ClickText                  Accounts
    ClickText                  Agarwal Ronit
    ClickText                  Details
    ClickText                  Edit Website
    TypeText                   Website                     abc
    ClickText                  Save

    # Required Field Validation

    #                          ClickText                   Save                        partial_match=False
    #                          VerifyText                  Complete this field

*** Keywords ***
    # Create Account Keyword
    #                          [Arguments]                 ${account_name}
    #                          ClickText                   New
    #                          VerifyText                  Account Information
    #                          UseModal                    On
    #                          TypeText                    Account Name                ${account_name}
    #                          ClickText                   Save

    # Creating Test Account 1
    #                          Create Account Keyword      ABC Corporation

    # Creating Test Account 2
    #                          Create Account Keyword      XYZ Corporation

Create a Lead Record
    Login To Salesforce
    ClickText                  Leads
    VerifyText                 Change Owner
    ClickText                  New                         partial_match=False
    VerifyText                 Lead Information
    PickList                   Salutation                  Mr.
    VerifyPicklist             Salutation                  Mr.                         selected=True
    ClickText                  First Name
    TypeText                   First Name                  Lead
    Sleep                      2s
    ClickText                  Last Name
    TypeText                   Last Name                   01
    Sleep                      2s
    CLickText                  Company
    TypeText                   Company                     Cyntexa
    Sleep                      2s
    Picklist                   Lead Status                 Open - Not Contacted
    Sleep                      2s
    VerifyPicklist             Lead Status                 Open - Not Contacted        selected=True
    Sleep                      2s
    ClickText                  Save                        partial_match=False
    VerifyText                 Lead 01

Creating a dynamic lead
    Login To Salesforce
    ${random_Last_Name}=       Generate Random String      10                          [UPPER]
    ${random_Company_Name}=    Generate Random String      8                           [UPPER]
    Set Suite Variable         ${LAST_NAME}                ${random_Last_Name}
    Set Suite Variable         ${COMPANY}                  ${random_Company_Name}
    ClickText                  Leads
    ClickText                  New
    ClickText                  Last Name
    Sleep                      2s
    TypeText                   Last Name                   ${LAST_NAME}
    ClickText                  Company
    Sleep                      2s
    TypeText                   Company                     ${COMPANY}
    ClickText                  Save                        partial_match=False

Converting A Lead
    ClickText                  Leads
    ClickText                  ${LAST_NAME}
    ClickText                  Show more actions
    ClickText                  Convert
    UseModal                   On
    ClickText                  Convert                     partial_match=False
    UseModal                   On
    UseModal                   On
    ClickText                  Go to Leads

Verifying the Accounts And Contact
    ClickText                  Accounts
    ClickText                  ${COMPANY}
    VerifyText                 ${COMPANY}
    ClickText                  ${LAST_NAME}
    ClickText                  ${COMPANY}
    VerifyText                 ${COMPANY}

Practice For IF ELSE
    Login To Salesforce
    Sleep                      2s
    ClickText                  Accounts
    IF                         "Account Name" == "Ronit"
        Log                    Account IS Present
    ELSE
        Log                    Account IS Not Present
    END

Checking Lead Status Using If ELSE
    Login To Salesforce
    ClickText                  Leads
    Sleep                      2s
    CLickText                  NSDGSDUSAE
    VerifyText                 NSDGSDUSAE
    ClickText                  Details
    ${selected}=               GetFieldValue               Lead Status
    IF                         $selected == "Open Not Contacted"
        Log                    Lead Status is ${selected}
    ELSE
        Log                    Old Lead


    END

Opportunity IF ELSE
    Login To Salesforce
    ClickText                  Opportunities
    Sleep                      2s
    ClickText                  PHDUKCXF-
    VerifyText                 PHDUKCXF-
    ClickText                  Details
    ${stage_value}             GetText                     xpath\=//records-record-layout-item[@field-label\='Stage']
    IF                         $stage_value == "Prospecting"
        LOG                    Stage is ${stage_value}
    ELSE
        LOG                    Stage is nothing
    END

Create Accounts With Enumerate
@{ACCOUNT_NAMES}    Account1    Account2    Account
    Login To Salesforce
    ClickText                  Accounts
    FOR                        ${index}                    ${account_name}             IN ENUMERATE                @{ACCOUNT_NAMES}
        ClickText              New
        TypeText               xpath\=//records-record-layout-base-input[@data-input-element-id\='input-field']    ${account_name}
        Log                    Create Account ${index}: ${account_name}
        ClickText              Save & New                  partial_match= True
    END

Assignment Module 4
    Login To Salesforce
    ${ran_string}=             Generate Random String      5
    ${current_date}=           Get Current Date            result_format= %H:%M
    ${closed_date}=            Get Current Date            increment= 7days            result_format=%m/%d/%Y
    ${opp_name}                Catenate                    ${ran_string}               ${current_date}
    ClickText                  Opportunities
    ClickText                  New                         partial_match= False
    Sleep                      2s
    UseModal                   On
    ClickText                  Opportunity Name
    TypeText                   Opportunity Name            ${opp_name}
    Sleep                      2s
    ClickText                  Close Date
    TypeText                   Close Date                  ${closed_date}
    Sleep                      2s
    CLickText                  Stage
    PickList                   Stage                       Qualification
    Sleep                      2s
    ClickText                  Save                        partial_match= False
    ClickText                  Details
    ClickText                  xpath\=//article[@aria-label\='Products']//div[@class\='actionsContainer']
    UseModal                   On
    CLickText                  Choose Price Book           partial_match= True
    Sleep                      5s
    ClickText                  Price Book
    TypeText                   Price Book                  Standard
    ClickText                  Save                        partial_match= False
    Sleep                      2s
    ClickText                  xpath\=//article[@aria-label\='Products']//div[@class\='actionsContainer']
    ClickText                  Add Products
    ClickElement               xpath=//input[@aria-describedby='Search']
    ${product_name}            Create List                 GenWatt Diesel 1000kW       Installation: Portable      Installation: Industrial - Low
    ${product_quantity}        Create Dictionary           GenWatt Diesel 1000kW=1     Installation: Portable=3    Installation: Industrial - Low=2
    # ClickCheckbox            GenWatt Diesel 1000kW       on
    # ClickText                Next                        partial_match= False
    # UseModal                 On
    # ClickText                Quantity
    # TypeText                 Quantity                    1
    # CLickText                Save                        partial_match= False
    FOR                        ${product_item}             IN                          @{product_name}
        TypeText               Search Products             ${product_item}
        ClickElement           xpath=//lightning-icon[@icon-name='utility:search']
        ClickElement           xpath=//div[@role='listbox']
        ClickCheckbox          ${product_item}             on
    END
    ClickText                  Next                        partial_match= False
    # FOR                      ${Product}                  IN                          @{product_name}
    #                          ClickElement                xpath=//tr[.//a[text()='${Product}']]//button[contains(@title,'Edit Quantity')]
    #                          Sleep                       1s
    #                          TypeText                    Quantity                    1
    # END
    FOR                        ${index}                    ${Product}                  IN ENUMERATE                @{product_name}
        ClickElement           xpath=//tr[.//a[text()='${Product}']]//button[contains(@title,'Edit Quantity')]     clicks=2
        TypeText               Quantity                    ${product_quantity}[${index}]                           anchor=${Product}
    END
    ClickText                  Save
