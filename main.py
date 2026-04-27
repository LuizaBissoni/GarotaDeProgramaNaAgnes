import pandas as pd
import psycopg2
import os
from datetime import datetime
from config import DB_CONFIG, CNPJS, DATA_INICIO, DATA_FIM, LIMITE_LINHAS

print("Iniciando extração...")

conn = psycopg2.connect(
    host=DB_CONFIG["host"],
    database=DB_CONFIG["database"],
    user=DB_CONFIG["user"],
    password=DB_CONFIG["password"],
    port=DB_CONFIG["port"]
)

cnpjs_sql = ",".join([f"'{c}'" for c in CNPJS])


def dividir_periodo(inicio, fim):
    """divide período no meio sem repetir mês"""

    inicio_dt = datetime.strptime(inicio, "%Y-%m")
    fim_dt = datetime.strptime(fim, "%Y-%m")

    meio = inicio_dt + (fim_dt - inicio_dt) / 2
    meio = meio.replace(day=1)

    meio_str = meio.strftime("%Y-%m")

    if meio.month == 12:
        proximo_mes = meio.replace(year=meio.year + 1, month=1)
    else:
        proximo_mes = meio.replace(month=meio.month + 1)

    proximo_mes_str = proximo_mes.strftime("%Y-%m")

    return (inicio, meio_str), (proximo_mes_str, fim)


for arquivo_sql in os.listdir("queries"):

    if not arquivo_sql.endswith(".sql"):
        continue

    evento = arquivo_sql.replace(".sql", "").upper()

    print("\n==============================")
    print("Evento:", evento)
    print("==============================")

    with open(f"queries/{arquivo_sql}", "r", encoding="utf-8") as f:
        query_base = f.read()

    query_base = query_base.replace("{cnpjs}", cnpjs_sql)

    periodos = [(DATA_INICIO, DATA_FIM)]

    while periodos:

        inicio, fim = periodos.pop(0)

        print(f"\nConsultando período {inicio} até {fim}")

        query = query_base.replace("{data_inicio}", inicio).replace("{data_fim}", fim)

        # -------- NOVA PARTE (COUNT) --------
        query_count = f"""
        SELECT COUNT(*) 
        FROM (
        {query}
        ) q
        """

        try:
            total = pd.read_sql(query_count, conn).iloc[0, 0]
        except Exception as e:
            print("Erro ao contar registros:", e)
            break
        # ------------------------------------

        if total == 0:
            print("Sem dados.")
            continue

        print("Registros encontrados:", total)

        if total > LIMITE_LINHAS:

            print("Acima do limite, dividindo período...")

            p1, p2 = dividir_periodo(inicio, fim)

            periodos.insert(0, p2)
            periodos.insert(0, p1)

            continue

        # -------- CONSULTA REAL SÓ AQUI --------
        try:
            df = pd.read_sql(query, conn)
        except Exception as e:
            print("Erro na query:", e)
            break
        # ---------------------------------------

        if inicio == DATA_INICIO and fim == DATA_FIM:
            nome = f"{evento} amapa unificado.xlsx"
        else:
            nome = f"{evento} amapa unificado - per_apur ({inicio} a {fim}).xlsx"

        df.to_excel(nome, index=False)

        print("Arquivo salvo:", nome)

print("\nExtração concluída.")