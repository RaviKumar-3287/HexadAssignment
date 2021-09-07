CREATE USER 'ravi'@'localhost' IDENTIFIED BY 'abcd1234';

GRANT ALL PRIVILEGES ON * . * TO 'ravi'@'localhost';


Download the json file using curl.
As file contains both data and metadata:
	we need to extract both separately
	Extract column names in a list for the table to be populated
	create a dataframe for data extracted from json (contains rows as list of list)
	assign column names to the df
	write it down to DBMS(Mysql, SQL server)




SELECT 
    SUM(value * 1), ReportYear
FROM
    ravi.final_df
WHERE
    MeasureName = 'Number of days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard'
GROUP BY ReportYear
ORDER BY ReportYear


select ReportYear,value from(
select row_number() over (order by (value *1) desc) as ranks, ReportYear,value
from ravi.final_df
where ReportYear >=2008 and MeasureName='Number of days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard'
) a where ranks =1 


select StateName,MeasureName,ReportYear,value
from(
select row_number() over (partition by StateName,MeasureName order by (value * 1) desc) as ranks, StateName,MeasureName,ReportYear,value
from ravi.final_df
)a where ranks =1
order by StateName, MeasureName, ReportYear


select distinct averagevalue, StateName,MeasureName,ReportYear
from(
select avg((value * 1)) over (partition by StateName,ReportYear ) as averageValue, StateName,MeasureName,ReportYear,(value * 1) as value
from ravi.final_df
where MeasureName='Number of person-days with PM2.5 over the National Ambient Air Quality Standard (monitor and modeled data)'
)a
order by averagevalue 


select 
#distinct 
StateName,Sumvalue
from(
select Sumvalue, StateName,(value *1) as value,row_number() over(order by SumValue desc) as ranks
from(
select sum((value * 1)) over (partition by StateName ) as SumValue, StateName,value
from ravi.final_df
where MeasureName='Number of days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard'
)a
)b 
#order by SumValue desc
where ranks=1



SELECT 
    AVG((value * 1)) AS AvgValue
FROM
    ravi.final_df
WHERE
    MeasureName = 'Number of person-days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard'
        AND StateName = 'Florida'
		
		

