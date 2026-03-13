import os
from dotenv import load_dotenv

load_dotenv()

DB_CONFIG = {
    "host": os.getenv("DB_HOST"),
    "database": os.getenv("DB_NAME"),
    "user": os.getenv("DB_USER"),
    "password": os.getenv("DB_PASSWORD"),
    "port": os.getenv("DB_PORT"),
}

CNPJS = [
    "00394577",
    "01517658",
    "23086176",
    "11633713"
]

DATA_INICIO = "2022-01"
DATA_FIM = "2026-03"

LIMITE_LINHAS = 780000