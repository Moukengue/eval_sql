Evaluation SQL

Q. 1- Liste des clients français 
R. 
SELECT companyname,contactname,contacttitle,phone FROM customers 
WHERE country ='france';

Q.2- Liste des produits vendus par le fournisseur "Exotic Liquids" 
R.
SELECT productname,unitprice FROM products
NATURAL JOIN suppliers  
WHERE companyname ='Exotic Liquids';

Q. 
3- Nombre de produits mis à disposition par les fournisseurs français (tri par nombre de produits décroissant)
R.
SELECT  companyname AS 'fournisseur',COUNT(productID) AS  'nbre produits' FROM suppliers
NATURAL JOIN products
WHERE country= 'france'
GROUP BY companyname
ORDER BY COUNT(productID) DESC ;

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
ORDER BY CA  DESC;

Q. 6- Liste des pays dans lesquels des produits fournis par "Exotic Liquids" ont été livrés
R. 
SELECT shipcountry FROM orders
NATURAL JOIN suppliers
NATURAL JOIN products 
NATURAL JOIN order_details
WHERE  companyname= 'Exotic Liquids'
GROUP BY shipcountry 
ORDER BY shipcountry;

Q. 7- Chiffre d'affaires global sur les ventes de 1997
R.
SELECT SUM(UnitPrice*Quantity) AS "Chiffre d'affaire" FROM `order details`
 NATURAL JOIN orders WHERE YEAR(orders.OrderDate) = '1997';
R.8
SELECT MONTH(orders.OrderDate) 'Mois 97', SUM(UnitPrice*Quantity) 'Montant ventes' FROM `order details` 
NATURAL JOIN orders WHERE YEAR(orders.OrderDate) = '1997' GROUP BY MONTH(orders.OrderDate);
R.9
SELECT MAX(orders.OrderDate) FROM orders
 NATURAL JOIN customers WHERE customers.CompanyName = 'Du monde entier';
R.10
SELECT ROUND(AVG(DATEDIFF(orders.ShippedDate, orders.OrderDate)), 0) 'Delai moyen de livraison' FROM orders; 

Exercice hotel 
Lot 1 : SELECT - FROM - WHERE - AND
Quelles sont les commandes du fournisseur n°9120 ?
 1. SELECT hot_nom,hot_ville FROM hotel
 2.
 SELECT cli_nom,cli_prenom,cli_adresse FROM client
WHERE cli_nom LIKE '%White%';

3 select  sta_nom,sta_altitude FROM station
WHERE sta_altitude < 1000;
4. SELECT cha_numero,cha_capacite FROM chambre
WHERE cha_capacite > 1;
5.
SELECT client.cli_nom, client.cli_ville FROM client WHERE client.cli_ville != 'Londres';

SELECT client.cli_nom, client.cli_ville FROM client WHERE client.cli_ville <> 'Londres';
6. SELECT hot_nom,hot_ville hot_categorie FROM hotel
WHERE hot_categorie  > 3

Lot 2 : JOIN
7. 
SELECT sta_nom, hot_nom,hot_categorie,hot_ville from hotel, station
8.
SELECT hot_nom,hot_categorie,hot_ville,cha_numero FROM chambre NATURAL JOIN hotel
9.
SELECT hotel.hot_nom, hotel.hot_ville, hotel.hot_categorie, chambre.cha_numero, chambre.cha_capacite FROM hotel 
INNER JOIN chambre on hotel.hot_id = chambre.cha_hot_id 
WHERE chambre.cha_capacite > 1;

10. 
SELECT client.cli_nom, hotel.hot_nom, reservation.res_date FROM client 
INNER JOIN reservation on reservation.res_cli_id = client.cli_id 
INNER JOIN chambre on chambre.cha_id = reservation.res_cha_id 
INNER JOIN hotel on hotel.hot_id = chambre.cha_hot_id;

11.
SELECT sta_nom,hot_nom,cha_numero,cha_capacite FROM chambre
INNER JOIN hotel on hot_id = chambre.cha_hot_id
INNER JOIN station on station.sta_id = hot_sta_id 
12.
SELECT client.cli_nom 'nom du client', hotel.hot_nom "nom de l’hôtel", reservation.res_date_debut 'date de début du séjour', datediff(reservation.res_date_fin, reservation.res_date_debut) 'durée du séjour' FROM client 
INNER JOIN reservation on reservation.res_cli_id = client.cli_id 
INNER JOIN chambre on chambre.cha_id = reservation.res_cha_id 
INNER JOIN hotel on hotel.hot_id = chambre.cha_hot_id;


Lot 3 : fonctions d'agrégation
13.
SELECT COUNT(hot_id) 'nbre hotel',sta_id 'station' FROM hotel, station;

SELECT COUNT(hot_nom),sta_nom FROM station
INNER JOIN  hotel  on hot_sta_id = sta_id GROUP BY sta_nom;
R.14
SELECT COUNT(cha_hot_id) 'nbre de chambres',sta_nom FROM hotel 
INNER JOIN chambre ON hot_id = cha_hot_id
INNER JOIN station on sta_id = hot_sta_id
  GROUP BY  hot_sta_id ;
R.15
SELECT COUNT(cha_hot_id) 'nbre de chambres',sta_nom FROM hotel 
INNER JOIN chambre ON hot_id = cha_hot_id
INNER JOIN station on sta_id = hot_sta_id
WHERE cha_capacite > 1
 GROUP BY  hot_sta_id ;Quelles sont les commandes du fournisseur n°9120 ?
SELECT hot_nom,cli_nom FROM reservation
INNER JOIN clientt ON  res_cli_id = cli_id
INNER JOIN chambre ON  res_cha_id = cha_id
INNER JOIN hotel on cha_hot_id = hot_id
WHERE cli_nom LIKE '%squire';

R.17

SELECT sta_nom,AVG(DATEDIFF(res_date_debut, res_date_fin)) FROM reservation
INNER JOIN chambre on res_cha_id = cha_id  
INNER JOIN hotel on cha_hot_id = hot_id 
INNER JOIN station on hot_sta_id = sta_id
GROUP  BY  hot_sta_id

 Cas Papyrus 

 1.
 Quelles sont les commandes du fournisseur n°9120 ?
 R.
 SELECT DISTINCT  numfou FROM entcom
WHERE numfou ='9120';
Q 2. 
Afficher le code des fournisseurs pour lesquels des commandes ont été passées.
R.
SELECT numfou, COUNT(numfou) FROM entcom
GROUP BY numfou;
Q.3
Afficher le nombre de commandes fournisseurs passées, et le nombre de fournisseur concernés.
R.
SELECT COUNT(numfou), COUNT( DISTINCT  numfou) FROM  entcom


Q. 4 Extraire les produits ayant un stock inférieur ou égal au stock d'alerte, et dont la quantité annuelle est inférieure à 1000.

        Informations à fournir : n° produit, libellé produit, stock actuel, stock d'alerte, quantité annuelle)
        R.
        SELECT codart,libart,stkale,stkphy FROM produit 
WHERE stkphy<= stkale AND qteann<1000;


Q. 5Quels sont les fournisseurs situés dans les départements 75, 78, 92, 77 ?

        L’affichage (département, nom fournisseur) sera effectué par département décroissant, puis par ordre alphabétique.

Q. 6 Quelles sont les commandes passées en mars et en avril ?

Q. 7 Quelles sont les commandes du jour qui ont des observations particulières ?

        Afficher numéro de commande et date de commande

Q. 8 Lister le total de chaque commande par total décroissant.

        Afficher numéro de commande et total

Q. 9 Lister les commandes dont le total est supérieur à 10000€ ; on exclura dans le calcul du total les articles commandés en quantité supérieure ou égale à 1000.

        Afficher numéro de commande et total

Q. 10 Lister les commandes par nom de fournisseur.

        Afficher nom du fournisseur, numéro de commande et date

Q. 11 Sortir les produits des commandes ayant le mot "urgent' en observation.

        Afficher numéro de commande, nom du fournisseur, libellé du produit et sous total (= quantité commandée * prix unitaire)

Q. 12 Coder de 2 manières différentes la requête suivante : Lister le nom des fournisseurs susceptibles de livrer au moins un article.

Q. 13 Coder de 2 manières différentes la requête suivante : Lister les commandes dont le fournisseur est celui de la commande n°70210.

        Afficher numéro de commande et date

Q. 14 Dans les articles susceptibles d’être vendus, lister les articles moins chers (basés sur Prix1) que le moins cher des rubans (article dont le premier caractère commence par R).

        Afficher libellé de l’article et prix1

Q. 15 Sortir la liste des fournisseurs susceptibles de livrer les produits dont le stock est inférieur ou égal à 150 % du stock d'alerte.

        La liste sera triée par produit puis fournisseur

Q. 17 Sortir la liste des fournisseurs susceptibles de livrer les produits dont le stock est inférieur ou égal à 150 % du stock d'alerte, et un délai de livraison d'au maximum 30 jours.

        La liste sera triée par fournisseur puis produit

Q. 18 Avec le même type de sélection que ci-dessus, sortir un total des stocks par fournisseur, triés par total décroissant.

Q.19 En fin d'année, sortir la liste des produits dont la quantité réellement commandée dépasse 90% de la quantité annuelle prévue.

    Calculer le chiffre d'affaire par fournisseur pour l'année 2018, sachant que les prix indiqués sont hors taxes et que le taux de TVA est 20%.



