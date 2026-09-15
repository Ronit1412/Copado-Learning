*** Settings ***
Library    String
Documentation           New test suite
# You can change imported library to "QWeb" if testing generic web application, not Salesforce.
Library                 QForce
Suite Setup             Open Browser    about:blank    chrome
Suite Teardown          Close All Browsers

*** Test Cases ***
    Login To Salesforce
    ClickText    Leads
    Sleep        2s
    CLickText    NSDGSDUSAE
    VerifyText    NSDGSDUSAE
    ClickText     Details
    ${title}=    GetFieldValue    Title
    IF                    ${title} == "abc"
        Log           New Lead
    ELSE
        Log           Old Lead
    END  