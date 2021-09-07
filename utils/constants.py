import configparser
import os
import pathlib

db = configparser.ConfigParser()



class AllPath:
    root_folder_path = pathlib.Path().absolute()
    LOG_FILE_PATH = root_folder_path / 'logs'
    DB_FILE_PATH = root_folder_path / 'utils' / 'db_credentials.txt'
    SQL_DRIVER_PATH = root_folder_path / 'utils' / 'mssql_driver_jar' / 'mssql-jdbc-8.4.1.jre8.jar'
    SQL_PATH = root_folder_path / 'sql_queries'
    ADHOC_PATH = root_folder_path / 'adhoc'

    db.read(DB_FILE_PATH)


class DBCredentials:
    # db config
    db.read(AllPath.DB_FILE_PATH)

    DB_SERVER = db['credentials']['db_server']
    SQL_DB = db['credentials']['out_database']
    USERNAME = db['credentials']['username']
    PASSWORD = db['credentials']['password']

    DRIVER = 'com.microsoft.sqlserver.jdbc.SQLServerDriver'
    DATAHUB_SCHEMA = 'ravi'
    ALL_DB = [
        'ravi'
    ]



class TableNames:
    output_table = 'final_df'

class Query:
    CHECK_First_QUERY = '''
    select sum(value * 1),ReportYear from ravi.df2_pd_test
    where MeasureName='Number of days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard'
    group by ReportYear
    order by ReportYear
    '''

    CURRENT_TIMESTAMP_QUERY = '''
    select format(getdate(),'yyyy-MM-dd HH:mm:ss');
    '''

    
    BACKUP_DATABASE_QUERY = "BACKUP DATABASE {} TO DISK = '{}'"

    SET_NOCOUNT_QUERY = 'SET NOCOUNT ON;'

    SET_WARNINGS_OFF_QUERY = 'SET ANSI_WARNINGS OFF;'

    CHECK_TERMINATION_QUERY = '''
        select * from Ingestion.CustomExecutionConfiguration
        where JobType = 'Ingestion' and isActive = 'Y' and ScenarioName='emr_termination'
    '''
