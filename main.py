import json
import pathlib
from datetime import datetime
import pandas as pd
from sqlalchemy import create_engine
from utils.constants import DBCredentials, Query, AllPath, TableNames
import os

print(AllPath.DB_FILE_PATH)
pd.set_option('display.max_columns', None)    # this option will show all columns of a df
pd.set_option("display.precision", 3)
# Don't use scientific notation
pd.options.display.float_format = '{:.2f}'.format
# Don't wrap repr(DataFrame) across additional lines
pd.set_option("display.expand_frame_repr", False)
# Set max rows displayed in output to 25
pd.set_option("display.max_rows", 25)

root_folder_path = pathlib.Path().absolute()
root_folder_path = pathlib.Path().absolute()
SourceFile = root_folder_path / 'rowstest.json'

current_date = datetime.now().strftime("%Y%m%d%H%M%S")
current_date1 = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

#Check to make sure file is correctly downloaded
while(1) :
  response=os.system('curl -o rowstest.json https://data.cdc.gov/api/views/cjae-szjv/rows.json?accessType=DOWNLOAD')
  print(response)
  if response == 0:
    break

Mysql_DataBase_URI = 'mysql+pymysql://'+DBCredentials.USERNAME+':'+DBCredentials.PASSWORD+'@'+DBCredentials.DB_SERVER+'/'+DBCredentials.SQL_DB

sqlalchemy_connection = create_engine(Mysql_DataBase_URI).connect()

with open(SourceFile) as json_file:
         d = json.load(json_file)
         cols = []
         #print(d['meta']['view']['columns'])
         columns = d['meta']['view']['columns']
         for column in columns:
             cols.append(column['name'])
         df = d['data']
         #df1 = pd.json_normalize(d,record_path =['data'], meta =[cols],errors='ignore')
         df2 = pd.DataFrame.from_records(d['data'])
# way to add column name to a dataframe
         #Frame = pd.DataFrame(df2.values, columns=cols)
#another way to add column names
         df2.columns = cols
# drop records that have null values in all columns
         df2.dropna(how='all')
# Write to DB using sqlalchemy connection(sql server or Mysql)
         df2.to_sql(TableNames.output_table, sqlalchemy_connection, schema='ravi', if_exists='replace',
                 index=False)


