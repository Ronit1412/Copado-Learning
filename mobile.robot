*** Settings ***
Library                        String
Documentation                  New test suite
# You can change imported library to "QWeb" if testing generic web application, not Salesforce.
Library                        QForce
Library    QWeb
Suite Setup                    Open Browser                about:blank                 chrome
Suite Teardown                 Close All Browsers

*** Test Cases ***
Login
OpenBrowser                ${login_url}                chrome
    TypeText                   Username                    ${username}
    ClickText                  Log In
    TypeText                   Password                    ${password}
    ClickText                  Log In
    TypeText                   Verification Code           3AQHOM9AKQ
    ClickText                  Verify