--	Andrew Rutherford
--	CSCI 3287
--	Homework 3
--4.5.3
--	Ships(name, yearLaunched)
--	SisterOf(name, sisterName)
--4.5.4.a
--	Contracts(Stars, Studios, Movies, Salary)
--	Stars(name, address)
--	Studios(name, address)
--	Movies(title, year, length, genre)
--6.2.2.a
SELECT R.maker AS manf,
	L.speed AS ghz
FROM Product R, Laptop L
WHERE L.hd >= 30
	AND R.model = L.model
	AND R.type = ‘laptop’;
--6.2.2.b
SELECT R.model, P.price FROM Product R, PC P
WHERE R.maker=‘B’ AND R.model=P.model
UNION
SELECT R.model, L.price FROM Product R, Laptop L
WHERE R.maker=’B’ AND R.model=L.model
UNION
SELECT R.model, T.price FROM Product R, Printer T
WHERE R.maker=’B’ AND R.model=T.model;
--6.2.2.c
SELECT R.maker
FROM Product R, Laptop L
WHERE R.model=L.model and R.type=’Laptop’
EXCEPT
SELECT R.maker
FROM Product R, PC P
WHERE R.model=P.model and R.Type=’PC’;
--6.2.2.d
SELECT DISTINCT P1.hd
FROM PC P1, PC P2
WHERE P1.hd=P2.hd AND P1.model>P2.model;
--6.2.2.e
SELECT P1.model, P2.model
FROM PC P1, PC P2
WHERE P1.speed=P2.speed
AND P1.ram=P2.ram
AND P1.model < P2.model;
--6.2.2.f
SELECT M.maker FROM
	(SELECT maker, R.model FROM PC P, Product R
	WHERE speed >= 3.0 AND P.model=R.model
	UNION
	SELECT maker, R.model FROM Laptop L, Product R
	WHERE speed >= 3.0 AND L.model=R.model) M
GROUP by M.maker
HAVING COUNT(M.model) >= 2;
--6.4.6.a
SELECT AVG(speed) AS Average_Speed FROM PC;
--6.4.6.b
SELECT AVG(speed) AS Average_Speed FROM PC WHERE price > 1000;
--6.4.6.c
	SELECT AVG(P.price) AS Average_Price FROM Product R, PC P
	WHERE R.model=P.model AND R.maker=’A’;
--6.4.6.d
SELECT AVG(M.price) AS Average_Price FROM
	(SELECT P.price FROM Product R, PC P
	WHERE R.model=P.model AND R.maker=’D’
	UNION ALL
	SELECT L.price FROM Product R, Laptop L
	WHERE R.model=L.model AND R.maker=’D’) M;
--6.4.6.e
SELECT SPEED, AVG(price) AS Average_Price FROM PC 
GROUP BY speed;
--6.4.6.f
SELECT maker, AVG(speed) FROM Product P JOIN Laptop l
ON p.type=”Laptop” AND p.model=l.model 
GROUP BY maker;
--6.4.6.g
SELECT Product.maker, COUNT(Product.model) FROM Product WHERE Product.type=’PC’
GROUP BY maker HAVING COUNT(Product.model) >= 3;
--6.4.6.h
SELECT DISTINCT maker, MAX(PC.price) AS Max_Price FROM Product, PC WHERE
PRODUCT.type=’PC’ AND PC.price=(SELECT DISTINCT MAX(price) FROM PC WHERE PC.model=Product.model)
GROUP BY maker;
--6.4.6.i
SELECT DISTINCT speed, Avg(PC.price) AS Avg_price FROM PC INNER JOIN Product ON PC.model=Product.model
WHERE PC.speed>20 
GROUP BY PC.speed;
--6.4.6.j
	SELECT Avg(hd) FROM PC NATURAL JOIN (SELECT maker FROM Product NATURAL JOIN Printer);
--6.5.1.a
	INSERT INTO Product VALUES(‘C’,1100,’PC’);
	INSERT INTO PC VALUES(1100,3.2,1024,180,,2499.00);
--6.5.1.b
INSERT INTO Product(maker,model,type)
(SELECT maker,model+1100,’Laptop’ FROM Product WHERE type=’PC’);
INSERT INTO Laptop(model,speed,ram,hd,screen,price)
(SELECT model+1100,speed,ram,hd,17,price+500 FROM PC);
--6.5.1.c
	DELETE FROM PC WHERE hd<100;
--6.5.1.d
DELETE FROM Laptop
WHERE model IN (SELECT model FROM Product WHERE maker IN 
	(SELECT maker FROM Product NATURAL JOIN Laptop)
	MINUS
	(SELECT maker FROM Product NATURAL JOIN Printer));
--6.5.1.e
	UPDATE Product SET maker=’A’ WHERE maker=’B’;
--6.5.1.f
	UPDATE PC SET ram=ram*2, hd=hd+60;
--6.5.1.g
UPDATE Laptop
SET screen=screen+1, price=price-100
WHERE model IN
	(SELECT Product.model FROM Laptop, Product WHERE Laptop.model=Product.model AND maker=’B’);
