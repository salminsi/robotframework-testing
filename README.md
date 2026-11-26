# Keskeneräinen harjoitustyö

Tämä harjoitustyö on toteutettu osana kurssia Ohjelmistokehityksen teknologioita (ajankohtaiset teknologiat).

## Taustat

Tässä tiedostossa kerron ohjeet tämän projektin pystyttämiseen, pyrkien syventämään tietoutta tarvittavista vaiheista, kun otetaan Robot Framework käyttöön. Kerron hieman yleistä tietoutta Robot Frameworkista sekä ohjeistuksen siitä mitä on tarkoitus Robot Frameworkilla testata tässä projektissa. Ohjeistus mukailee kurssin tehtävänantoa, joka on laadittu Playwright-testien tekemiseen. Olen siis kurssilla aiemmin toteuttanut nämä samat testit kertaalleen, mutta Playwrightillä. Nyt opettelen itsenäisesti Robot Frameworkia tämän harjoitustyön parissa, kokemusta Robot Frameworkista minulla ei ennestään ole. Lisäksi osana harjoitustyötä laadin testit toiseen sovellukseen, tähän palaan dokumentin myöhemmässä vaiheessa. 

*”Tutustun Robot Frameworkiin ja koitan tehdä saman harjoituksen kuin teimme Playwright-tehtävässä. Mahdollisuuksien mukaan, kun aikaa riittää, kirjoitan Robot-testejä Ohjelmistoprojekti 1 -sovelluksellemme.”*

## Aloitus ja asennus

Harjoitustyön aloitin luomalla Ohjelmistoprojekti 1 -sovelluksellemme testejä. Sen jälkeen perustin tämän repositorion ja sille virtuaalisen ympäristön.

Virtuaalisen ympäristön saat halutessasi näillä komennoilla (Windows), jotka ajetaan projektin juuressa, ennen muita Robot Frameworkin asennuksia:

```cmd
python -m venv .venv
.venv\Scripts\activate.bat
```

Virtuaalinen ympäristö eristää projektin riippuvuudet, estäen mahdolliset kirjastojen versioristiriidat, tehden projekteista toimintavarmempia (vanhat projektit ei rikkoudu version muuttuessa, kun tehdään uusia projekteja). Samalla myös järjestelmä ja Python-asennus pysyy puhtaampana, kun aliriippuvuudet ovat omissa virtuaaliympäristöissään. (https://docs.python.org/3/library/venv.html).

Mielenkiinnosta aihetta kohtaan löysin artikkelin, jossa Python-kehittäjä Marcin Kozak kehoittaa käyttämään virtuaaliympäristöjä heti alusta alkaen, jotta aloittelija voi säästyä myöhemmiltä harmeilta: https://medium.com/data-science/python-virtual-environments-why-and-when-should-you-use-them-be57b0c0323d.


Tämän jälkeen otetaan käyttöön Robot Framework:

```cmd
pip install robotframework
pip install robotframework-browser
rfbrowser init
```

HUOM. Itse ajoin nämä komennot ongelmitta, koska koneellani on NodeJS. Mikäli se puuttuu, rfbrowser init ei luultavasti onnistu (https://medium.com/@zorozeri/test-automation-using-robot-framework-with-browser-library-1-f994af6f78b1). Tämän vuoksi voi olla suositellumpaa suorittaa asennus seuraavalla komennolla, jolloin NodeJS:ää ei tarvita (https://robotframework-browser.org/#start), koska se tulee lisäosana:

```cmd
py -m pip install "robotframework-browser[bb]"
```

Halutessasi voit tarkastaa onko NodeJS asennettuna:
```cmd
node -v
npm -v
```

Jos on, saat tuloksena versionumerot, esimerkiksi näin:

node -v
v26.7.0
npm -v
11.19.0

Saatuasi asennukset kuntoon, voit muutaman testin tehtyäsi, taikka myöhemmin, ajaa vielä tämän:

```cmd
pip freeze > requirements.txt
```

Tiedostosta requirements.txt käyvät ilmi projektin riippuvuudet. Versionumeroiden tallentaminen tiedostoon mahdollistaa, että muut projektin jäsenet (tässä projektissa heitä ei ole), taikka kuka vaan voi pystyttää testit täysin samanlaisessa ympäristössä. Mikäli et perustanut virtuaalista ympäristöä, requirements.txt listaa muidenkin projektiesi riippuvuudet, lista saattaa siinä tapauksessa olla pitkä.

## Ensimmäinen laatimani testi 

Aloitan laatimalla yksinkertaisen testin tiedostoon login.robot. Testi varmistaa vain selaimen ja testattavan sivuston aukeamisen. Sivuston title on nimetty "Example application", joten hyödynnän sitä:

*** Settings ***
Library    Browser

*** Test Cases ***
Open Login Page
    New Browser    chromium
    New Page    https://authentication-6o1.pages.dev/

    Get Title    ==    Example application

    Close Browser

### Ajan testin:

```cmd
py -m robot tests/login.robot
```

==============================================================================
Login                                                                         
==============================================================================
Open Login Page                                                       | PASS |
------------------------------------------------------------------------------
Login                                                                 | PASS |
1 test, 1 passed, 0 failed
==============================================================================


### Testien suorittamisen jälkeen muodostuvat:

report.html – testiraportti
log.html – testiloki
output.xml – testitulokset

Muitakin tiedostoja, tai kansioita (kuten browser) saattaa tulla, ja nämä kannattaa lisätä .gitignoreen, jos projekti siirretään githubiin:

```gitignore
.venv/              # Virtuaaliympäristö

log.html            # Robot Framework -loki
report.html         # Robot Framework -raportti
output.xml          # Robot Framework -tulokset

browser/            # Browser-kirjaston tiedostot
```





# Harjoitustyön toinen osuus

Sisällytin harjoitustyöhöni tässä repositoriossa tekemieni testien lisäksi testien tekemisen kurssille Ohjelmistoprojekti 1. Olemme ko. kurssilla tehneet lipunmyynti-sovellusta Fullstack -työnä ja otin tehtäväkseni koodata työhön käyttöliittymää (käyttäjän näkökulmasta) testaavia automaatiotestejä (end-to-end) Robot Frameworkilla. Kaikki Robot-testit sekä tiimitovereitani varten laatima readme.md -ohjeistus ovat minun käsialaani, ja ne löytyvät osoitteesta: https://github.com/YKKOSET/Lippumyynti-ohjelma/tree/main/robot-tests. Päivitän ja lisään testejä joulukuulle 2026 asti, jolloin projektityömme on määrä valmistua. 


# Tietoa työkalusta Robot Framework




<!-- 
# Tänne tulee Ohjelmistokehityksen teknologioiden kurssin harkkatyön raportti!

Syventävää tietoa Robot Frameworkista.

Harkkatyön videoesittely erikseen. 

Muistan lisätä tänne myös linkit Ohjelmistoprojekti 1 tekemiini automaatiotesteihin, sekä esittelen ne videolla myös.


Lisää kuva onnistuneista testeistä (tässä repossa olevat). -->

<!-- Tunnukset piiloon. -->



-------------
# Tiivistelmä projektin teknologioista in english

# Robot Framework Authentication Tests

Test automation project built with Robot Framework and Browser Library.

## Features

- Login testing
- Registration testing
- Positive and negative test cases
- Browser automation

## Technologies

- Robot Framework
- Browser Library
- Playwright Engine
- Python

## Run tests

```cmd
py -m robot tests
py -m robot tests/login.robot
```
