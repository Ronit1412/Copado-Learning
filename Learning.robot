*** Settings ***

Documentation           New test suite
# You can change imported library to "QWeb" if testing generic web application, not Salesforce.
Library                 QForce 
Suite Setup             Open Browser    about:blank    chrome
Suite Teardown          Close All Browsers

*** Test Cases ***

*** Keywords ***
Login To Salesforce
    OpenBrowser        ${login_url}        chrome
    TypeText           Username            ${username}
    ClickText          Log In
    TypeText           Password            ${password}
    ClickText          Log In
    TypeText           Verification Code    ${Verification}
    ClickText          Verify
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

# *** Keywords ***
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

Converting A Lead
