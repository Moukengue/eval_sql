Q. 1- Liste des clients français 
R. 
SELECT companyname,contactname,contacttitle,phone FROM customers 
WHERE country ='france'

Q.2- Liste des produits vendus par le fournisseur "Exotic Liquids" 
R.
SELECT productname,unitprice FROM products
NATURAL JOIN suppliers  
WHERE companyname ='Exotic Liquids'

Q. 
3- Nombre de produits mis à disposition par les fournisseurs français (tri par nombre de produits décroissant)
R.
SELECT  companyname AS 'fournisseur',COUNT(productID) AS  'nbre produits' FROM suppliers
NATURAL JOIN products
WHERE country= 'france'
GROUP BY companyname
ORDER BY COUNT(productID) DESC 

Q. 4- Liste des clients français ayant passé plus de 10 commandes :
Exotic Liquids
R.
SELECT  companyname,COUNT(orderID) FROM customers 
NATURAL JOIN orders 
WHERE country= 'france'
GROUP BY companyname
HAVING COUNT(orderID)> 10;


5- Liste des clients dont le montant cumulé de toutes les commandes passées est supérieur à 30000 € :


R.
SELECT companyname,SUM(unitprice*quantity) AS CA,country FROM customers
NATURAL JOIN order_details
NATURAL JOIN orders
GROUP BY customerID
HAVING  SUM(unitprice*quantity)> 30000 
ORDER BY CA  DESC 

Q. 6- Liste des pays dans lesquels des produits fournis par "Exotic Liquids" ont été livrés
R. 
SELECT shipcountry FROM orders
NATURAL JOIN suppliers
NATURAL JOIN products 
NATURAL JOIN order_details
WHERE  companyname= 'Exotic Liquids'
GROUP BY shipcountry 
ORDER BY shipcountry 

Q. 7- Chiffre d'affaires global sur les ventes de 1997
