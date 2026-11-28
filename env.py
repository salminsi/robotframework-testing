from pathlib import Path
from dotenv import dotenv_values
from robot.api.types import Secret

def get_variables():
    arvot = dotenv_values(Path(__file__).parent / ".env")
    return {nimi: Secret(arvo) for nimi, arvo in arvot.items()}