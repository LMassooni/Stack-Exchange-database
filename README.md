# Analysis of Stack exchange data analysis database 

The goal of the project is to integrate SQL queries with python analysis using tha stack exchange database of data science to it. In the process, SQLAlchemy was used to link python and MySQL databse.

The process stabilish is explained below.

## First, get the .XML files from:  **`https://dn720201.ca.archive.org/0/items/stackexchange/`**
and download **`datascience.stackexchange.com.7z`**

## Transform and upload to MySQL database
After extracting, it will be necessary to transform the .XML files to .csv, create the database, and insert each .csv file as a table in the new database.

The **`xml_to_csv.py`** file take care of the transform mentioned. 

The file **`Posts.xml`** has a column named 'body' that exceed the size supported by pandas do convert to csv file. To contour that, etree was used.

After that, we can upload the csv files into a new database created in MySQL.

To perform, we use SQLAlchemy, logging into the database (I called stack) with the engine variable, and them, performing a loop in the .csv files, we use df.to_sql function of pandas.

## Dealing with the tables

Before we continue to the queries, although the tables are not too big, it's a good practice to construct indexers and define primary and foreign keys, since the XML files do not carry these informations.

The file **`index.sql`** take care of that, using columns such as "Id" or "TagId" to build these references.

## SQL files

In the folder sql, we have the queries in .sql files. Each of them perform one query that will be saved in a .csv file. The information contained in each one of the files are displayed in **`analise.ipynb`**