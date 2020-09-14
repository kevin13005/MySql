USE northwind;

-- complement DDL
-- creer une table dotee d'une structure identique a celle d'une table existante
-- CREATE TABLE NouvTable LIKE TableExistante;
DROP TABLE IF EXISTS Commandes;
CREATE TABLE Commandes LIKE orders;
SELECT * FROM Commandes;

-- doter une table d'une nouvelle colonne
-- ALTER TABLE NomTable ADD NomColonne TypeColonne NOT NULL DEFAULT 'valeurParDefaut';
ALTER TABLE Commandes
ADD litiges VARCHAR(30) NOT NULL DEFAULT 'neant';
SELECT * FROM Commandes;

-- DML : DATA MANIPULATION LANGUAGE
-- INSERT INTO : inserer des lignes
-- INSERER LES LIGNES D UNE TABLE DANS UNE AUTRE
-- INSERT INTO table1
-- SELECT *
-- FROM table2
-- WHERE condition;

-- CREER UNE TABLE Commandes97 SIMILAIRE A Orders
-- peupler la table avec les commandes de l'annee 1997

DROP TABLE IF EXISTS Commandes97;
CREATE TABLE Commandes97 LIKE Orders;
INSERT INTO Commandes97 
SELECT * 
FROM Orders
WHERE YEAR(OrderDate) = '1997';

SELECT * FROM Commandes97;

-- INSERT INTO table(champ2, champ3) VALUES(val2, val3)
-- INSERT INTO table VALUES(val1, val2, val3)

-- CREER UNE TABLE Transporteurs SIMILAIRE A Shippers
-- INSERER DANS LA TABLE Transporteurs
-- LE TRANSPORTEUR Calberson DONT LE TEL EST 01.42.38.38.38
DROP TABLE IF EXISTS Transporteurs;
CREATE TABLE Transporteurs LIKE Shippers;
SELECT * FROM Transporteurs;
INSERT INTO Transporteurs(CompanyName, Phone) VALUES('Calberson', '01.42.38.38.38');
SELECT * FROM Transporteurs;

-- INSERER DANS LA TABLE Transporteurs LES TRANSPORTEURS (1 seule requete)
-- 'chronopost', '01.85.12.13.14'
-- 'colissimo', '08.00.36.03.60'

INSERT INTO Transporteurs(CompanyName, Phone) VALUES('chronopost', '01.85.12.13.14'), ('colissimo', '08.00.36.03.60');
SELECT * FROM Transporteurs;

-- UPDATE : modifier des lignes
-- UPDATE NomTable
-- SET champ = expr1, champ2 = expr2..
-- WHERE condition

-- CREER UNE TABLE Clients SIMILAIRE A customers
-- PEUPLER CETTE TABLE AVEC LES CLIENTS FRANCAIS
DROP TABLE IF EXISTS Clients;
CREATE TABLE Clients LIKE Customers;
INSERT INTO Clients
SELECT * 
FROM Customers
WHERE country = 'france';

SELECT * FROM Clients WHERE companyname = 'folies gourmandes';

UPDATE Clients
SET contactname = 'julia levingston', contacttitle = 'marketing manager'
WHERE companyname = 'folies gourmandes';

SELECT * FROM Clients WHERE companyname = 'folies gourmandes';

-- requete UPDATE et DELETE SANS clause WHERE
-- SAFE MODE ACTIF PAR DEFAUT
-- POUR DESACTIVER SAFE MODE, 2 possibilités :
-- 1 Edit > Preferences > sql Editor > decocher Safe Updates et se reconnecter
-- 2 REQ CHANGER VARIABLE D'ENVIRONNEMENT

SET SQL_SAFE_UPDATES = 0;
-- METTRE EN MAJUSCULES L' ENSEMBLE DES Contactname DES CLIENTS
UPDATE Clients
SET contactName = UPPER(contactname);

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM Clients;

-- DELETE : supprimer des lignes
-- DELETE FROM table WHERE condition;

-- SUPPRIMER DANS LA TABLE Clients CEUX NE RESIDANT PAS A paris
DELETE FROM Clients
WHERE NOT city = 'paris';

SELECT * FROM Clients;

-- supprimer tous les clients
SET SQL_SAFE_UPDATES = 0;

DELETE FROM clients;

SET SQL_SAFE_UPDATES = 1;

-- CREER TABLE produit ayant la meme
-- structure que la table products
-- peupler cette table avec les produits des categories 1, 2, 3
-- majorer de 10% les prix unitaires des produits de la categorie 1
DROP TABLE IF EXISTS produit;
CREATE TABLE produit LIKE products;

INSERT INTO produit
SELECT *
FROM products
WHERE categoryID in ('1', '2', '3');

SELECT * FROM produit;

SET @rate = 10/100;
UPDATE produit
SET UnitPrice = ROUND(Unitprice * (1 + @rate), 2)
WHERE categoryID = '1';

SELECT * FROM produit;

-- CREER UNE TABLE Commandes SIMILAIRE LA TABLE Orders
-- PEUPLER Commandes AVEC TOUTES LES COMMANDES EXPEDIEES
-- DOTER Commandes D'UNE COLONNE FreightWithTax (MEME TYPE QUE FREIGHT)
-- VALORISER LA COLONNE DU MONTANT DE FRAIS DE PORT TTC (tva 20%)
DROP TABLE IF EXISTS Commandes;
CREATE TABLE Commandes LIKE Orders;

SELECT * FROM Orders;
INSERT INTO Commandes
SELECT *
FROM Orders
WHERE NOT shippedDate IS NULL;

SELECT * FROM Commandes;

ALTER TABLE Commandes
ADD FreightWithTax DECIMAL(10, 4) NOT NULL DEFAULT 0;
SELECT * FROM Commandes;

SET SQL_SAFE_UPDATES = 0;
SET @rate2 = 20/100;

UPDATE Commandes
SET Freight = round(freight * (1 + @rate2), 4);
SET SQL_SAFE_UPDATES = 1;

SELECT * 
FROM Commandes
LIMIT 5;

-- CREER UNE TABLE Clients PEUPLEE AVEC LES CLIENTS RESIDANT EN FRANCE
-- DOTER LA TABLE D UNE COLONNE score de type int
-- VALORISER CETTE COLONNE AVEC LE NOMBRE DE COMMANDES DE CHACUN DES CLIENTS
DROP TABLE IF EXISTS clients;
CREATE TABLE clients LIKE Customers;
INSERT INTO clients
SELECT *
FROM Customers
WHERE Country = 'france';

ALTER TABLE clients
ADD score INT(20) NOT NULL DEFAULT 0;

SET SQL_SAFE_UPDATES = 0;
UPDATE clients
SET score = 
(SELECT COUNT(*)
FROM Orders -- c est une requete correlé pour chaque ligne
WHERE Orders.customerid = clients.customerid); -- pour un calcul pas besoin de jointure, 
SET SQL_SAFE_UPDATES = 1;-- de plus on ne veut pas afficher des colonnes des 2 tables donc pas de jointure necessaire
SELECT * FROM Clients;

-- verification du score
SELECT customerid, count(*)
FROM orders o
GROUP BY customerid;








