*** Settings ***
Library    Browser

*** Test Cases ***
Open Login Page
    New Browser    chromium
    New Page    https://authentication-6o1.pages.dev/

    Get Title    ==    Example application

    Close Browser

