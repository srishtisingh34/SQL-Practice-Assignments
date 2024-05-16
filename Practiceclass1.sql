Select * from classicmodels.products;

Select orderNumber, orderLineNumber, round(priceEach) as price_rounded 
from classicmodels.orderdetails;

Select concat(productcode,'--',productname)
from classicmodels.products;

Select sysdate()+1;

Select * from classicmodels.products 
where productCode = 'S10_1678 ';

Select * from classicmodels.customers 
where city = country;

