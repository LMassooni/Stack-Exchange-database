import pandas as pd

df = pd.read_csv('texto_maior_reputation.csv', on_bad_lines = 'skip' ,engine='python')

print(df)