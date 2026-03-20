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
import pandas as pd
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