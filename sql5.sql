USE northwind;

-- nom des produits de la categorie 'condiments'
SELECT pRODUCTnAME 
FROM Products p INNER JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE CategoryName= 'condiments';

-- nom et prenom des 3 employes les plus jeunes
SELECT LastName, FirstName, BirthDate
FROM employees
ORDER BY Birthdate DESC LIMIT 0, 3;

-- commandes du client 'bon app' expediées par united package
-- avec des frais de port inferieurs a 100E
	SELECT o.*
    FROM customers c INNER JOIN orders o ON c.CustomerID = o.CustomerID
    inner join sHIPPERS S on Shipvia = ShipperID
    WHERE c.CompanyName = 'Bon app\'' AND S.companyName = 'United package' AND Freight < 100;
    
    -- productname des produits approvisionnés par le fournisseur
    -- 'ma maison' ET RELEVANT DE LA CATEGORIE 4MEAT/poultry'
    SELECT ProductName
    FROM Suppliers S INNER JOIN Products P ON S.SupplierID = P.SupplierID
    INNER JOIN Categories C ON P.CategoryID = C.CategoryID                         
    WHERE S.CompanyName = 'Ma Maison' AND C.CategoryName = 'Meat/Poultry';
    
    -- MEME UTILITE ET FONCTION entre left outer join, right outer join et requete imbrique NOT IN--------
    -- montre qu il n y a pas de correspondance entre 2 champs
    
    -- jointure externe : gauche
    -- FROM table1 LEFT OUTER JOIN table2 ON table1.col1 = table2.col2
    -- retourne toutes les lignes de table1, y compris celles pour lesquelles
    -- il n 'esxiste pas de correspondance dans table2
    
    -- jointure externe : droite (detecte les anomalies) sert a importer des donnees csv
    -- FROM table1 RIGHT OUTER JOIN table2 ON table1.col1 = table2.col2
    -- retourne toutes les lignes de table2, y compris celles pour lesquelles
    -- il n existe pas de correspondance dans table1
    
    -- liste des companyName, orderID (jointure interne) : 830 lignes
    SELECT CompanyName, OrderID
    FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID;
    
    -- liste des companyname, orderid (jointure externe gauche)
    SELECT CompanyName, OrderID
    FROM Customers c LEFT OUTER JOIN Orders o ON c.CustomerID = o.CustomerID;
    
    -- requete en non- correspondance
    -- companyname des clients n'ayant rien commandé
    -- 1/ JOINTURE
    SELECT CompanyName, c.CustomerID, Phone
    FROM Customers c LEFT OUTER JOIN Orders o ON c.CustomerID = o.CustomerID
    WHERE OrderID is NULL;
    
    -- 2/REQUETE IMBRIQUEE (produit meme resultat que LEFT OUTER JOIN
    SELECT CustomerID, CompanyName, PHONE
    FROM Customers
    WHERE CustomerID NOT IN(
    SELECT DISTINCT CustomerID
    FROM Orders);
    
    -- productname des produits n ayant fait l objet d aucune vente
    SELECT ProductName 
    FROM Products p LEFT OUTER JOIN `Order Details` od ON p.ProductID = od.ProductID
    WHERE od.productId IS NULL; -- on agit sur la cle primaires, c est elle qui nous dit tout
    
    SELECT ProductName
    FROM Products
    WHERE ProductID NOT IN(-- relier avec la cle primaire les 2 table, ici c est productId
    SELECT DISTINCT ProductID
    FROM `ORDER DETAILS`);
    
    
