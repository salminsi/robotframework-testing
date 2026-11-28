*** Settings ***
Documentation           Kirjautumisen testit
Library                 Browser
Resource                ../resources/common.resource
Variables               ../env.py

Suite Setup             New Browser    chromium    headless=False
Suite Teardown          Close Browser


*** Variables ***
# mallipohja muuttujille:
#${VARIABLE}  This is a Variable
#${COMPOSITE VARIABLES}  ${VARIABLE} with other variables.

${BASE_URL}             https://authentication-6o1.pages.dev

${SIGN_IN}              role=button[name="Sign in"s]
${LOGOUT}               role=button[name="Logout"s]

${VALID_EMAIL}          test@example.com
${VALID_PASSWORD}       Password123
${INVALID_EMAIL}        nonono@nono.com
${INVALID_PASSWORD}     nononononon!!456
${newname}=             Matti Meikäläinen
${newemail}=            matti.meikalainen@example.com
${newpassword}=         Password123


*** Test Cases ***
#mallipohja testin rakenteelle:
#Test Case
#    [Documentation]
#    [Tags]
#    [Timeout]
#    [Setup]
#    [Template]
#    Static Variable Assignments
#    Keyword Calls
#    Verification Keyword Call
#    [Teardown]


# ensimmäinen testi toimi apuna seuraavien laatimisessa: 
# avaa selaimen, jonka avulla voi tarkistaa elementtien nimet
#Poimi selektori
#    New Browser           chromium    headless=False
#    New Page              https://authentication-6o1.pages.dev/
#    ${selektori}=         Record Selector
#    Log To Console        ${selektori}
#    [Teardown]            Close Browser


Open Login Page
    [Documentation]        Testataan, että sivusto aukeaa
    New Page               https://authentication-6o1.pages.dev/

    Get Title        ==    Example application

    Close Browser


Kirjautumislomake etusivulla
    [Documentation]            Varmistetaan, että kirjautumislomake sisältää vaaditut kentät.
    [Tags]    smoke            login

    New Context
    New Page                    ${BASE_URL}

    Wait For Elements State    input[type="email"]           visible
    Wait For Elements State    input[type="password"]        visible
    Wait For Elements State    ${SIGN_IN}                    visible

    Close Context

Jane Doe kirjautuu
    [Documentation]             Käyttäjä ohjataan kirjautumisen jälkeen /dashboard, jossa tervetuloa-viesti.
    New Page                    ${BASE_URL}
    Fill Secret                 input[type="email"]       ${JANE_USERNAME}
    Fill Secret                 input[type="password"]    ${JANE_PASSWORD}
    Click                       ${SIGN_IN}
    Wait For Elements State     text=Welcome Jane Doe!    visible
    Get Url         contains    dashboard

John Doe kirjautuu
    [Documentation]             Rekisteröitynyt käyttäjä kirjautuu sisään sähköpostilla ja salasanalla.
    New Page                    ${BASE_URL}
    Fill Secret                 input[type="email"]       ${JOHN_USERNAME}
    Fill Secret                 input[type="password"]    ${JOHN_PASSWORD}
    Click                       ${SIGN_IN}
    Wait For Elements State     text=Welcome John Doe!    visible
    Get Url         contains    dashboard

Salasana vaaditaan
    [Documentation]            Salasanaa ei voi jättää tyhjäksi kirjautuessa.
    Yritä kirjautua            ${JANE_USERNAME}    ${EMPTY}
    Wait For Elements State    text=Password must be at least 6 characters long.    visible

Käyttäjätunnus vaaditaan
    [Documentation]            Käyttäjätunnusta ei voi jättää tyhjäksi kirjautuessa.
    Yritä kirjautua            ${EMPTY}            ${JANE_PASSWORD}
    Wait For Elements State    text=Please enter a valid email address.    visible

Salasana liian lyhyt
    [Documentation]             Salasana ei voi olla liian lyhyt.
    Yritä kirjautua             ${JANE_USERNAME}    sala 
    Wait For Elements State     text=Password must be at least 6 characters long.    visible

Käyttäjätunnus väärässä muodossa
    [Documentation]             Käyttäjä antaa virheellisen käyttäjätunnuksen.
    Yritä kirjautua             ${INVALID_EMAIL}    ${JANE_PASSWORD} 
    Wait For Elements State     text=Invalid email or password    visible

Virheellinen salasana
    [Documentation]             Käyttäjä antaa virheellisen salasanan.
    Yritä kirjautua             ${JANE_USERNAME}    ${INVALID_PASSWORD} 
    Wait For Elements State     text=Invalid email or password    visible

Tuntematon käyttäjätunnus
    [Documentation]             Kirjautumista yritetään tuntemattomalla käyttäjätunnuksella.
    Yritä kirjautua             ${INVALID_EMAIL}    salasana1!
    Wait For Elements State     text=Invalid email or password    visible

Dashboardille ei pääse kirjautumatta
    [Documentation]             Kirjautumaton käyttäjä siirretään Dashboardilta kirjautumiseen.
    New Page                    ${BASE_URL}/dashboard
    Get Url        ==           ${BASE_URL}/  
    Wait For Elements State     ${SIGN_IN}        visible
    Get Url    not contains     dashboard

Alice kirjautuu ulos
    [Documentation]             Ulos kirjautuessa käyttäjä siirretään kirjautumissivulle.
    New Page                    ${BASE_URL}
    Fill Secret                 input[type="email"]       ${ALICE_USERNAME}
    Fill Secret                 input[type="password"]    ${ALICE_PASSWORD}
    Click                       ${SIGN_IN}
    Click                       ${LOGOUT}
    Get Url        ==           ${BASE_URL}/ 
    Wait For Elements State     ${SIGN_IN}    visible
    Get Url     not contains    dashboard


*** Keywords ***
Yritä kirjautua
    [Arguments]            ${email}    ${password}
    New Page               ${BASE_URL}
    Täytä kenttä          input[type="email"]       ${email}
    Täytä kenttä          input[type="password"]    ${password}
    Click                  ${SIGN_IN}

#seuraava ehto siksi, että voidaan antaa arvo käsin tai salaisella muuttujalla:
Täytä kenttä
    [Arguments]    ${selektori}    ${arvo}
    IF    type($arvo).__name__ == "Secret"
        Fill Secret    ${selektori}    ${arvo}
    ELSE
        Fill Text      ${selektori}    ${arvo}
    END
