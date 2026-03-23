import pandas as pd
'''
df_badges = pd.read_xml('datascience.stackexchange/Badges.xml')
df_badges.to_csv('Badges.csv',index=False)
df_comment = pd.read_xml('datascience.stackexchange/Comments.xml')
df_comment.to_csv('Comments.csv',index=False)
df_history = pd.read_xml('datascience.stackexchange/PostHistory.xml')
df_history.to_csv('PostHistory.csv',index=False)
df_links = pd.read_xml('datascience.stackexchange/PostLinks.xml')
df_links.to_csv('PostLinks.csv',index=False)
df_tags = pd.read_xml('datascience.stackexchange/Tags.xml')
df_tags.to_csv('Tags.csv',index=False)
df_users = pd.read_xml('datascience.stackexchange/Users.xml')
df_users.to_csv('Users.csv',index=False)
df_votes = pd.read_xml('datascience.stackexchange/Votes.xml')
df_votes.to_csv('Votes.csv',index=False)
'''
from lxml import etree

xml_file = "datascience.stackexchange/Posts.xml"
csv_file = "Posts.csv"

parser = etree.XMLParser(huge_tree=True, recover=True)

tree = etree.parse(xml_file, parser)
root = tree.getroot()

data = []

for row in root.findall(".//row"):
    data.append(row.attrib)  # pega todos os atributos da tag

df = pd.DataFrame(data)

df.to_csv(csv_file, index=False)

## PASSAGEM DOS ARQUIVOS .CSV PARA O MYSQL
import pandas as pd
from sqlalchemy import create_engine
import os
from dotenv import load_dotenv

## Keys for acess the database
load_dotenv()

## Acessing the database throught SQLAlchemy -> the database is local
engine = create_engine(f"mysql+mysqlconnector://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}@{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/{os.getenv('DB_NAME')}",
    echo=True)
arquivos = ["Badges","Comments","PostHistory","Posts","PostLinks","Tags","Users","Votes"]
for nome in arquivos:
    df = pd.read_csv(f"CSV/{nome}.csv")
    print(f"{nome}")
    df.to_sql(name = f'{nome}',con=engine,if_exists = 'replace',index = False)