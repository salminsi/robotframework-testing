# Keskeneräinen harjoitustyö

Tässä vaiheessa ensimmäinen testi (login.robot) varmistaa vain selaimen ja sivuston aukeamisen.

Riippuvuudet käyvät ilmi tiedostosta requirements.txt (pip install -r requirements.txt). Versionumeroiden tallentaminen tiedostoon mahdollistaa, että mahdolliset muut projektin jäsenet, taikka kuka vaan voi pystyttää testit täysin samanlaisessa ympäristössä.

Virtuaalisen ympäristön saa halutessaan perustettua windowsille (asenna ennen muita robot frameworkin asennuksia):

cmd:
python -m venv .venv
.venv\Scripts\activate.bat

Virtuaalinen ympäristö eristää projektin riippuvuudet, estäen mahdolliset kirjastojen versioristiriidat, tehden projekteista toimintavarmempia (vanhat projektit ei rikkoudu version muuttuessa, kun tehdään uusia projekteja). Samalla myös järjestelmä ja esimerkiksi Python-asennus pysyy puhtaampana, kun aliriippuvuudet ovat omissa virtuaaliympäristöissään. (https://docs.python.org/3/library/venv.html).

Mielenkiinnosta aihetta kohtaan löysin artikkelin, jossa kehittäjä Marcin Kozak kehoittaa käyttämään Pythonin kanssa virtuaaliympäristöjä heti alusta alkaen, jotta aloittelija voi säästyä myöhemmiltä harmeilta: https://medium.com/data-science/python-virtual-environments-why-and-when-should-you-use-them-be57b0c0323d.








<!-- 
# Tänne tulee Ohjelmistokehityksen teknologioiden kurssin harkkatyön raportti!

Syventävää tietoa Robot Frameworkista.

Harkkatyön videoesittely erikseen. 

Muistan lisätä tänne myös linkit Ohjelmistoprojekti 1 tekemiini automaatiotesteihin, sekä esittelen ne videolla myös.


Lisää kuva onnistuneista testeistä (tässä repossa olevat). -->

<!-- Tunnukset piiloon. -->


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

! When using Browser Library, you should install NodeJS too (https://medium.com/@zorozeri/test-automation-using-robot-framework-with-browser-library-1-f994af6f78b1).

You can check is node installed:
node -v
npm -v

If it's, you get something like that:
node -v
v26.7.0
npm -v
11.19.0

## Run tests

```bash
py -m robot tests
py -m robot tests/login.robot
```
