Q. 1- Liste des clients français 
Q.2- Liste des produits vendus par le fournisseur "Exotic Liquids" 

Q. 
3- Nombre de produits mis à disposition par les fournisseurs français (tri par nombre de produits décroissant)

Q. 4- Liste des clients français ayant passé plus de 10 commandes :

5- Liste des clients dont le montant cumulé de toutes les commandes passées est supérieur à 30000 € :


R.
SELECT companyname,SUM(unitprice*quantity) AS CA,country FROM customers
NATURAL JOIN order_details
NATURAL JOIN orders
GROUP BY customerID
HAVING  SUM(unitprice*quantity)> 30000 
ORDER BY CA  DESC 

Q. 6- Liste des pays dans lesquels des produits fournis par "Exotic Liquids" ont été livrés
Q. 7- Chiffre d'affaires global sur les ventes de 1997
 dfdfdfdf