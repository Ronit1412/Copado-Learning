*** Settings ***
Library    String
Documentation           New test suite
# You can change imported library to "QWeb" if testing generic web application, not Salesforce.
Library                 QForce
Suite Setup             Open Browser    about:blank    chrome
Suite Teardown          Close All Browsers




*** Keywords ***
Login To Salesforce
    OpenBrowser        ${login_url}        chrome
    TypeText           Username            ${username}
    ClickText          Log In
    TypeText           Password            ${password}
    ClickText          Log In
    TypeText           Verification Code    ${Verification}
    ClickText          Verify
*** Test Cases ***
Create a Account Record

    ClickText        Accounts
    VerifyText       Accounts
    ClickText        New                       partial_match=False 
    Sleep            5s
    VerifyText       Account Information
    UseModal         On
    TypeText         Account Name                  Agarwal Ronit
    ClickText        Save                      partial_match=False 
    Sleep             5s
    Verifytext        Agarwal

Edit account
    ClickText    Accounts
    ClickText    Agarwal Ronit 
    ClickText    Details
    ClickText    Edit Website
    TypeText     Website    abc
    ClickText    Save

# Required Field Validation

#     ClickText        Save                       partial_match=False
#     VerifyText       Complete this field 

*** Keywords ***
# Create Account Keyword
#     [Arguments]            ${account_name}
#     ClickText              New
#     VerifyText             Account Information
#     UseModal               On
#     TypeText               Account Name    ${account_name}
#     ClickText              Save

# Creating Test Account 1
#     Create Account Keyword    ABC Corporation

# Creating Test Account 2
#     Create Account Keyword    XYZ Corporation

Create a Lead Record
    Login To Salesforce
    ClickText    Leads
    VerifyText   Change Owner
    ClickText    New                partial_match=False
    VerifyText   Lead Information
    PickList     Salutation         Mr. 
    VerifyPicklist        Salutation    Mr.   selected=True
    ClickText    First Name
    TypeText     First Name         Lead
    Sleep        2s
    ClickText    Last Name
    TypeText     Last Name          01
    Sleep        2s
    CLickText    Company
    TypeText     Company            Cyntexa
    Sleep        2s
    Picklist     Lead Status        Open - Not Contacted
    Sleep        2s
    VerifyPicklist        Lead Status         Open - Not Contacted       selected=True
    Sleep                 2s
    ClickText             Save                partial_match=False
    VerifyText            Lead 01

Creating a dynamic lead
    Login To Salesforce
    ${random_Last_Name}=    Generate Random String    10    [UPPER]
    ${random_Company_Name}=     Generate Random String    8    [UPPER]
    Set Suite Variable    ${LAST_NAME}               ${random_Last_Name}
    Set Suite Variable    ${COMPANY}                 ${random_Company_Name}
    ClickText              Leads
    ClickText     New
    ClickText     Last Name
    Sleep         2s
    TypeText      Last Name                         ${LAST_NAME}
    ClickText     Company
    Sleep         2s
    TypeText      Company                         ${COMPANY}
    ClickText     Save                         partial_match=False

Converting A Lead
    ClickText     Leads
    ClickText      ${LAST_NAME}
    ClickText      Show more actions
    ClickText      Convert
    UseModal       On
    ClickText      Convert     partial_match=False
    UseModal        On
    UseModal        On
    ClickText       Go to Leads    

Verifying the Accounts And Contact
    ClickText     Accounts
    ClickText     ${COMPANY}
    VerifyText    ${COMPANY}
    ClickText     ${LAST_NAME}
    ClickText     ${COMPANY}
    VerifyText    ${COMPANY}

Practice For IF ELSE
    Login To Salesforce
    Sleep    2s
    ClickText    Accounts
    IF           "Account Name" == "Ronit"    partial_match= False
        Log      Account IS Present
    ELSE
        Log      Account IS Not Present    
    END

Checking Lead Status Using If ELSE
    Login To Salesforce
    ClickText    Leads
    Sleep        2s
    CLickText    NSDGSDUSAE
    VerifyText    NSDGSDUSAE
    ClickText     Details
    ${selected}=    GetPickList    Status    selected=True
    IF                    ${status} == "Open - Not Contacted"
        Log           New Lead
    ELSE
        Log           Old Lead
    END            

# Practice For Loop
#     Login To Salesforce
    
