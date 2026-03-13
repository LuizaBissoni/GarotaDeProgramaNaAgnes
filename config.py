# =========================
# DADOS DO BANCO
# =========================

import os
from dotenv import load_dotenv

load_dotenv()

DB_HOST = os.getenv("DB_HOST")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_PORT = os.getenv("DB_PORT")

# =========================
# CNPJS (RAIZ)
# =========================

CNPJS = [
"00394577",
"01517658",
"23086176",
"11633713"
]


# =========================
# PERÍODO DE APURAÇÃO
# formato AAAA-MM
# =========================

DATA_INICIO = "2025-06"
DATA_FIM = "2026-03"


# =========================
# LIMITE PARA PARSE
# =========================

LIMITE_LINHAS = 780000