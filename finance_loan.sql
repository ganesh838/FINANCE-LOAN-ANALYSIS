CREATE DATABASE bank_loan_db; 
show databases 
use bank_loan_db;  
ALTER TABLE financial_loan_data
ADD PRIMARY KEY (id); 
select * from financial_loan_data;  
ALTER TABLE financial_loan_data
MODIFY COLUMN address_state VARCHAR(50),
MODIFY COLUMN application_type VARCHAR(100),
MODIFY COLUMN emp_length VARCHAR(50),
MODIFY COLUMN emp_title VARCHAR(100),
MODIFY COLUMN grade VARCHAR(50),
MODIFY COLUMN home_ownership VARCHAR(50);
select count(id) as total_loan_applications from financial_loan_data; 

ALTER TABLE financial_loan_data
MODIFY COLUMN issue_date DATE; 
ALTER TABLE financial_loan_data
ADD COLUMN temp_date DATE;
SET SQL_SAFE_UPDATES = 0;
UPDATE financial_loan_data
SET temp_date = STR_TO_DATE(issue_date, '%d-%m-%Y'); 
ALTER TABLE financial_loan_data
DROP COLUMN issue_date;

ALTER TABLE financial_loan_data
CHANGE COLUMN temp_date issue_date DATE; 

select count(id) as mtd_total_loan_applications from financial_loan_data where month(issue_date)=12 and year(issue_date)=2021;
select sum(loan_amount)as total_funded_amount from financial_loan_data; 

select sum(loan_amount)as PREVIOUS_MTD_total_funded_amount from financial_loan_data where month(issue_date)=11 and year(issue_date)=2021;

SELECT SUM(total_payment) as total_amount_recived from financial_loan_data;  
SELECT SUM(total_payment) as mtd_total_amount_recived from financial_loan_data where month(issue_date)=12 and year(issue_date)=2021;
SELECT SUM(total_payment) as Pmtd_total_amount_recived from financial_loan_data where month(issue_date)=11 and year(issue_date)=2021;

select round(avg(int_rate), 5)*100 as Average_intrest_rate from financial_loan_data;  
select round(avg(int_rate), 5)*100 as MTD_Average_intrest_rate from financial_loan_data where month(issue_date)=12 and year(issue_date)=2021; 
select round(avg(int_rate), 5)*100 as PMTD_Average_intrest_rate from financial_loan_data WHERE month(issue_date)=11 and year(issue_date)=2021;  

SELECT round(AVG(dti),4)*100 as avg_DTI from financial_loan_data;  
SELECT round(AVG(dti),5)*100 as MTD_avg_DTI from financial_loan_data where month(issue_date)=12 and year(issue_date)=2021;

good loan persentage-- 
alter table financial_loan_data modify column loan_status varchar(50);
 select loan_status from financial_loan_data;

 
 SELECT 
    ROUND((SUM(CASE 
                WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' 
                THEN 1 ELSE 0 END) * 100) / COUNT(*), 2) AS good_loan_percentage
FROM financial_loan_data; 

select count(id) as good_loan_applications from financial_loan_data where loan_status= 'Fully Paid'  or loan_status='Current';
select sum(loan_amount) as good_loan_funded_amount from financial_loan_data where loan_status= 'Fully Paid'  or loan_status='Current';
select sum(total_payment) as good_loan_recived_amount from financial_loan_data where loan_status= 'Fully Paid'  or loan_status='Current';

select 
      ROUND((sum(CASE when loan_status='Charged Off' 
      then 1 else 0 end )*100)/count(*),2) as bad_loan_persentage 
from financial_loan_data;
select count(id) as bad_loan_applications from financial_loan_data where loan_status= 'Charged Off' ;  
select sum(loan_amount) as bad_loan_funded_amount from financial_loan_data where loan_status= 'Charged Off' ;   
select sum(total_payment) as bad_loan_recived_amount from financial_loan_data where loan_status= 'Charged Off' ; 


      
