USE classicmodels;

-- nomor1
SELECT productCode, productName, buyPrice
FROM products
WHERE buyPrice > (SELECT AVG(buyPrice) FROM products);

SELECT AVG(buyPrice)
FROM products
group by productline;


-- nomor2
SELECT o.orderNumber, o.orderDate
FROM orders o
JOIN customers c ON o.customerNumber = c.customerNumber
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices ofc ON e.officeCode = ofc.officeCode
WHERE ofc.city = 'Tokyo';


-- nomor3
SELECT customers.customerName, orders.orderNumber, orders.orderDate, 
       orders.shippedDate, orders.requiredDate, products.productName, 
       orderdetails.quantityOrdered, employees.firstName, employees.lastName
FROM orders
JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
JOIN products ON orderdetails.productCode = products.productCode
JOIN customers ON orders.customerNumber = customers.customerNumber
JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
WHERE orders.shippedDate > orders.requiredDate;

-- nomor4
SELECT products.productName, 
       products.productLine AS category, 
       SUM(orderdetails.quantityOrdered) AS totalQuantityOrdered
FROM products
JOIN orderdetails ON products.productCode = orderdetails.productCode
where products.productline in(
select t1.kategori from
(select p.productline kategori
from products p
join orderdetails od using(productcode)
group by p.productline
order by sum(od.quantityOrdered) desc
limit 3) as t1)
group by products.productName;







