 USE dbs;
 SHOW Tables;
 
 # Query 1 - sort out the customer and their grade who made an order
 
 SELECT customer.cust_name AS "Customer",
customer.grade AS "Grade",orders.ord_no AS "Order No."

FROM orders, salesman, customer

WHERE orders.customer_id = customer.custemor_id
AND orders.salesman_id = salesman.salesman_id
AND salesman.city IS NOT NULL
AND customer.grade IS NOT NULL ORDER BY customer.grade DESC;
 
# Query 2 - Earned the maximum commission

SELECT ord_no, purch_amt, ord_date, salesman_id 
FROM orders 

WHERE salesman_id IN(
SELECT salesman_id 
FROM salesman
WHERE commision = (
SELECT MAX(commision) 
FROM salesman));

#Query 3 - Orders retrieve only ord_no, purch_amt, ord_date, ord_date, salesman_id where salesman’s city is Nagpur

SELECT ord_no, purch_amt, ord_date, salesman_id 
FROM orders
WHERE salesman_id IN (
SELECT salesman_id 
FROM salesman WHERE city='nagpur');

# Query 4 - the total commission for that date is 15 % for all sellers

SELECT ord_date, SUM(purch_amt), 
SUM(purch_amt)*.15 
FROM orders 
GROUP BY ord_date 
ORDER BY ord_date;

#Query 5 - 

SELECT ord_no, purch_amt, ord_date, salesman_id 
FROM orders
WHERE purch_amt >
    (SELECT  AVG(purch_amt) 
     FROM orders 
      );
      
# Query 6 - Nth (Say N=5) highest purch_amt from Orders table.
# DESC LIMIT N-1, 1; if N = 5:

SELECT purch_amt FROM orders ORDER BY purch_amt DESC LIMIT 4, 1;

# Quey 7 - Entities and Relationships :
## An entity relationship diagram (ERD), also known as an entity relationship model, is a graphical representation that depicts relationships among people, objects, places, concepts or events within an information technology (IT) system.
## An entity can be a real-world object, either animate or inanimate, that can be easily identifiable
## An association entites are known a relationship

#Query 8 - if balance_amount is nil then assign transaction_amount for account_type = "Credit Card"

SELECT customer_id , bank_account_details.account_number,
 CASE WHEN ifnull(balance_amount,0) = 0 
 THEN Transaction_amount 
 ELSE balance_amount 
 END AS balance_amount
 FROM bank_account_details 
 INNER JOIN bank_account_transaction
 ON bank_account_details.account_number = bank_account_transaction.account_number
 AND account_type = "Credit Card";
 
 # Query 9 - Bank_Account_Details and bank_account_transaction for all the transactions occurred during march, 2020 and april, 2020

SELECT bank_account_details.account_number, balance_amount, transaction_amount
FROM bank_account_details 
INNER JOIN bank_account_transaction 
ON bank_account_details.account_number = bank_account_transaction.account_number
AND (date_format(Transaction_Date , '%Y-%m')  BETWEEN "2020-03" AND "2020-04"); 

# Query 10 - excluding all of their transactions in march, 2020 month 

SELECT bank_account_details.customer_id, bank_account_details.account_number, balance_amount, transaction_amount
FROM bank_account_details LEFT JOIN bank_account_transaction ON bank_account_details.account_number = bank_account_transaction.account_number
LEFT JOIN bank_customer ON bank_account_details.customer_id = bank_customer.customer_id
AND NOT ( date_format(Transaction_Date , '%Y-%m') = "2020-03" );
