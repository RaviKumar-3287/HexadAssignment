Introduction:
=============
	This is an automated solution to download the json file from a shared url("https://data.cdc.gov/api/views/cjae-szjv/rows.json?accessType=DOWNLOAD"), read it and store the data in open source RDBMS(MySQL).


Assumptions:
============
	Internet connectivity will be there and file will always be available to download from the shared url.
	Meta field(['meta']['view']['columns']) contains all the columns.
	We do have MySql database with below configurations:
	usename: `ravi` with all access
	schema : `ravi`

Process:
========
	Read json file through python.
	Extract column names from ['meta']['view']['columns']
	Extract data from nested list in a dataframe
	assign column names to the dataframe
	write it down to the RDBMS

 
requirements.txt: 	contains the dependencies list to be installed.
start.sh:		driver program which will install all the dependencies mentioned in the above requirement file, set up the env and 		
	 		triggers the execution of python code.
main.py: 		python code to download and process json file.
constant.py: 		contains the classes for path variables, tablenames, DB variables, sql queries.
db_credentials.txt: 	contains the DB variables.

Note: If we are running from linux system then directly run sh start.sh and if we have to run it through notebook we can copy the content of start.sh in a cell and execute the line of code through os.system()
