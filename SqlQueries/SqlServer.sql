Design Doc
Code
Sample result
repository link


select sum(cast(value as int)),ReportYear from [CPQDataHub].[df2_pd_test]
where MeasureName='Number of days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard'
group by ReportYear
order by ReportYear

select ReportYear,value from(
select row_number() over (order by value desc) as ranks, ReportYear,value
from [CPQDataHub].[df2_pd_test]
where ReportYear >=2008 and MeasureName='Number of days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard'
) a where ranks =1 
order by value desc

--select ReportYear,value
--from [CPQDataHub].[df2_pd_test]
--where value in(
--select max(value) from [CPQDataHub].[df2_pd_test]
--where ReportYear >=2008 and MeasureName='Number of days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard'
--)
--and ReportYear >=2008 and MeasureName='Number of days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard'

select StateName,MeasureName,ReportYear,value
from(
select row_number() over (partition by StateName,MeasureName order by value desc) as ranks, StateName,MeasureName,ReportYear,value
from [CPQDataHub].[df2_pd_test]
)a where ranks =1
order by StateName, MeasureName, ReportYear

select distinct averagevalue, StateName,MeasureName,ReportYear
from(
select avg(cast(value as float)) over (partition by StateName,ReportYear ) as averageValue, StateName,MeasureName,ReportYear,value
from [CPQDataHub].[df2_pd_test]
where MeasureName='Number of person-days with PM2.5 over the National Ambient Air Quality Standard (monitor and modeled data)'
)a
order by averagevalue desc


select 
--distinct 
StateName,Sumvalue
from(
select Sumvalue, StateName,value,row_number() over(order by SumValue desc) as ranks
from(
select sum(cast(value as float)) over (partition by StateName ) as SumValue, StateName,value
from [CPQDataHub].[df2_pd_test]
where MeasureName='Number of days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard'
)a
)b 
--order by SumValue desc
where ranks=1






select avg(cast(value as float)) as AvgValue
from [CPQDataHub].[df2_pd_test]
where MeasureName= 'Number of person-days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard'
and StateName='Florida'



select StateName, CountyName,ReportYear,value as minValue
from(
select row_number() over (partition by StateName,ReportYear order by value asc ) as ranks, StateName,CountyName,ReportYear,value
from [CPQDataHub].[df2_pd_test]
where MeasureName='Number of days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard'
)a
where ranks=1
order by StateName,ReportYear




select avg(cast(value as float)) as AvgValue
from [CPQDataHub].[df2_pd_test]
where MeasureName= 'Number of person-days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard'
and StateName='Florida'



select StateName, CountyName,ReportYear,value as minValue
from(
select row_number() over (partition by StateName,ReportYear order by value asc ) as ranks, StateName,CountyName,ReportYear,value
from [CPQDataHub].[df2_pd_test]
where MeasureName='Number of days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard'
)a
where ranks=1
order by StateName,ReportYear




select StateName, CountyName,ReportYear,value as minValue
from(
select row_number() over (partition by StateName,ReportYear order by (value * 1) asc ) as ranks, StateName,CountyName,ReportYear,value
from ravi.df_pd_test
where MeasureName='Number of days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard'
)a
where ranks=1
order by StateName,ReportYear

