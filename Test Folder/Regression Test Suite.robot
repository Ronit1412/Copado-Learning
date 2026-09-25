*** Settings ***
Library                        String
Documentation                  New test suite
# You can change imported library to "QWeb" if testing generic web application, not Salesforce.
Library                        QForce
Library    QWeb
Suite Setup                    Open Browser                about:blank                 chrome
Suite Teardown                 Close All Browsers

*** Test Cases ***
Login In Salesforce
    OpenBrowser                ${login_url}                chrome
    TypeText                   Username                    ${username}
    ClickText                  Log In
    TypeText                   Password                    ${password}
    ClickText                  Log In
    TypeText                   Verification Code           GXMJO8MK8Q
    ClickText                  Verify
    SLeep                      5s
Creating lead
    [Tags]    Regression
    CLickText    Leads
    ClickText    New    partial_match=False
    UseModal     On
    ${random_name}=     Generate Random String    8
    ${company_name}=    Generate Random String    10
    Set Suite Variable                        ${lead_name}    ${random_name}
    Set Suite Variable                        ${lead_company_name}    ${company_name}
    ClickText                        Last Name
    TypeText                        Last Name                        ${lead_name}
    ClickText                       Company
    TypeText                       Company                        ${lead_company_name}
    ClickText                       Save                        partial_match=False
    ClickText                       Show more actions
    CLickText                       Convert
    UseModal                        On
    ClickText                       Convert                     partial_match=False
    UseModal                        On
    ClickText                       Go to Leads                 partial_match=False

Verify Account
    ClickText    Accounts
    VerifyText    ${lead_name}

Verify Contact
    ClickText    Contacts
    VerifyText    ${lead_company_name}

Verify Opportunity
    ClickText    Opportunities
    VerifyText    ${lead_company_name}
    ClickText     ${lead_company_name}

Adding Products
    ClickText                  xpath\=//article[@aria-label\='Products']//div[@class\='actionsContainer']
    ClickText                  Add Products
    ClickElement               xpath=//input[@aria-describedby='Search']
    @{product_name}            Create List                 GenWatt Diesel 1000kW       Installation: Portable      Installation: Industrial - Low
    @{product_quantity}        Create List                 1 

    FOR                        ${product_item}             IN                          @{product_name}
        TypeText               Search Products             ${product_item}
        ClickElement           xpath=//lightning-icon[@icon-name='utility:search']
        ClickElement           xpath=//div[@role='listbox']
        ClickCheckbox          ${product_item}             on
    END
    ClickText                  Next                        partial_match= False

    FOR                        ${index}                    ${Product}                  IN ENUMERATE                @{product_name}
        ClickElement           xpath=//tr[.//a[text()='${Product}']]//button[contains(@title,'Edit Quantity')]     clicks=2
        TypeText               Quantity                    ${product_quantity}[${index}]                           anchor=${Product}
                                                                                   
    END
    ClickText              Save
    ClickText              Products                        partial_match=False      
    
