SELECT *FROM bank_loan_data;

-- total loan application
SELECT COUNT(id) AS Total_loan_Applications fROM bank_loan_data

-- MTD total loan applications
SELECT COUNT(id) AS MTD_Total_loan_Applications fROM bank_loan_data
WHERE MONTH(issue_date)= 12 AND YEAR(issue_date)= 2021	

-- PMTD total loan applications
SELECT COUNT(id) AS PMTD_Total_loan_Applications fROM bank_loan_data
WHERE MONTH(issue_date)= 11 AND YEAR(issue_date)= 2021	

-- Total Funded Amount
SELECT SUM(loan_amount) as Total_Funded_Amount FROM bank_loan_data

-- Total amount received
SELECT SUM(total_payment) AS Total_Amount_Received FROM bank_loan_data

-- Total amount received for current month
SELECT SUM(total_payment) AS MTD_Total_Amount_Received FROM bank_loan_data
WHERE MONTH(issue_date)= 12 AND YEAR(issue_date)= 2021	

-- Average interest rate
SELECT ROUND(AVG(int_rate),4) *100 AS Avg_Interest_Rate FROM bank_loan_data

-- Month to date average interest rate
SELECT ROUND(AVG(int_rate),4) *100 AS MTD_Avg_Interest_Rate FROM bank_loan_data
WHERE MONTH(issue_date)= 12 AND YEAR(issue_date)= 2021	

--Previous Month to date average interest rate
SELECT ROUND(AVG(int_rate),4) *100 AS MTD_Avg_Interest_Rate FROM bank_loan_data
WHERE MONTH(issue_date)= 11 AND YEAR(issue_date)= 2021	

-- Average Debt to income ratio
SELECT ROUND(AVG(dti),4) *100 AS Avg_DTI from bank_loan_data

-- Average Debt to income ratio for current month
SELECT ROUND(AVG(dti),4) *100 AS Avg_DTI from bank_loan_data
WHERE MONTH(issue_date)= 12 AND YEAR(issue_date)= 2021	

-- Average Debt to income ratio for previous month
SELECT ROUND(AVG(dti),4) *100 AS Avg_DTI from bank_loan_data
WHERE MONTH(issue_date)= 11 AND YEAR(issue_date)= 2021	

-- Good Loan
SELECT
    (COUNT(CASE WHEN loan_status='Fully Paid' OR loan_status='Current' THEN id END)*100)
    /
    COUNT(id) AS Good_loan_Percentge
FROM bank_loan_data


-- Good loan Applications
SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan_data
WHERE loan_status='Fully Paid' OR loan_status='Current'

-- Good Loan funded Amount
SELECT SUM(loan_amount) AS Good_Loan_funded_Amount FROM bank_loan_data
WHERE loan_status='Fully Paid' OR loan_status='Current'

-- Good Loan total received amount
SELECT SUM(total_payment) AS Good_Loan_Received_Amount FROM bank_loan_data
WHERE loan_status='Fully Paid' OR loan_status='Current'

-- Percentage of bad loan
SELECT
    (COUNT (CASE WHEN loan_status='Charged Off' THEN id END)*100)/
    COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data

-- total applications of bad loan
SELECT COUNT(id) AS bad_loan_applications from bank_loan_data
WHERE loan_status='Charged Off'

-- Bad loan funded Amount
SELECT SUM(loan_amount) AS bad_loan_funded_amount from bank_loan_data
WHERE loan_status='Charged Off'

-- Bad Loan amount received 
SELECT SUM(total_payment) AS bad_loan_amount_received from bank_loan_data
WHERE loan_status='Charged Off'

-- Loan status grid view 
SELECT
        loan_status,
        COUNT(id) AS Total_Loan_Applications,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate *100) AS Interest_Rate,
        AVG(dti *100) AS dti
    FROM 
        bank_loan_data
    GROUP BY 
        loan_status

-- loan status month to date
SELECT
        loan_status,
        SUM(total_payment) AS MTD_Total_Amount_Received,
        SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date)=12
GROUP BY loan_status

-- Monthly trend by issue date
SELECT
    MONTH(issue_date),
    DATENAME(MONTH,issue_date) AS Month_Name,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH,issue_date)
ORDER BY MONTH(issue_date)

-- Regional analysis by state
SELECT
    address_state,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state

-- Total loan Application by state
SELECT
    address_state,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY address_state
ORDER BY COUNT(id) DESC

-- Loan Term Analysis
SELECT
    term,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY term
ORDER BY term

-- Employee length analysis
SELECT
    emp_length,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length

-- Loan Purpose Breakdown
SELECT
    purpose,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY purpose
ORDER BY COUNT(id) DESC

-- Home ownership analysis
SELECT
    home_ownership,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC