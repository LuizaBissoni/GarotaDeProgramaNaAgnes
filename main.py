import os
import pandas as pd
import psycopg2
from datetime import datetime
from dateutil.relativedelta import relativedelta

from config import *

print("Iniciando extração...")

conn = psycopg2.connect(
    host=DB_HOST,
    port=DB_PORT,
    database=DB_NAME,
    user=DB_USER,
    password=DB_PASSWORD
)

queries_path = "queries"

data_hoje = datetime.now().strftime("%d-%m-%Y")
output_path = f"Amapá Atualizado {data_hoje}"

os.makedirs(output_path, exist_ok=True)


def gerar_periodos(inicio, fim):

    data_inicio = datetime.strptime(inicio, "%Y-%m")
    data_fim = datetime.strptime(fim, "%Y-%m")

    periodos = []

    atual = data_inicio

    while atual <= data_fim:

        proximo = atual + relativedelta(months=6)

        if proximo > data_fim:
            proximo = data_fim

        periodos.append((atual.strftime("%Y-%m"), proximo.strftime("%Y-%m")))

        atual = proximo + relativedelta(months=1)

    return periodos


def salvar_excel(df, evento, inicio, fim, parte=None):

    if parte:
        nome = f"{evento.upper()} Amapá Unificado per_apur {inicio} a {fim}_parte{parte}.xlsx"
    else:
        nome = f"{evento.upper()} Amapá Unificado per_apur {inicio} a {fim}.xlsx"

    caminho = os.path.join(output_path, nome)

    with pd.ExcelWriter(caminho, engine="xlsxwriter") as writer:
        df.to_excel(writer, index=False)
        worksheet = writer.sheets["Sheet1"]
        worksheet.set_column(0, len(df.columns), 20)

    print("Arquivo salvo:", nome)


periodos = gerar_periodos(DATA_INICIO, DATA_FIM)


for cnpj in CNPJS:

    print("\n=================================")
    print("Extraindo CNPJ raiz:", cnpj)
    print("=================================")

    for sql_file in os.listdir(queries_path):

        if not sql_file.endswith(".sql"):
            continue

        evento = sql_file.replace(".sql", "")

        caminho_sql = os.path.join(queries_path, sql_file)

        with open(caminho_sql, "r", encoding="utf-8") as f:
            query_base = f.read()

        for inicio, fim in periodos:

            print(f"Evento {evento.upper()} | {inicio} até {fim}")

            query = query_base.replace("{cnpj}", cnpj)
            query = query.replace("{data_inicio}", inicio)
            query = query.replace("{data_fim}", fim)

            try:
                df = pd.read_sql(query, conn)
            except Exception as e:
                print("Erro na query:", e)
                continue

            if df.empty:
                print("Sem dados.")
                continue

            total = len(df)

            print(total, "registros encontrados.")

            if total > LIMITE_LINHAS:

                print("Parse automático ativado")

                partes = (total // LIMITE_LINHAS) + 1

                for i in range(partes):

                    inicio_linha = i * LIMITE_LINHAS
                    fim_linha = (i + 1) * LIMITE_LINHAS

                    df_parte = df.iloc[inicio_linha:fim_linha]

                    salvar_excel(df_parte, evento, inicio, fim, i + 1)

            else:

                salvar_excel(df, evento, inicio, fim)


print("\nExtração concluída.")