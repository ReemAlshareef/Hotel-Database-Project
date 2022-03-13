CREATE SCHEMA Hotel ;

CREATE TABLE Guest(
ID             VARCHAR(20) NOT NULL,
Email          VARCHAR(20) NOT NULL,
FName          VARCHAR(45)  NULL,
LName          VARCHAR(45)  NULL,
Nationality    VARCHAR(20)  NULL,
City           VARCHAR(15)  NULL,
CONSTRAINT Guest_PK PRIMARY KEY (ID,Email),
CONSTRAINT Guest_FK FOREIGN KEY (City) REFERENCES GuestAddress(City)ON DELETE CASCADE 
);


  
INSERT INTO guest (ID, Email, FName, LName, Nationality, City) 
VALUES ('1939756833', 'moh@ hotmail.com', 'mohammed', 'ahmed', 'egyption', 'cairo');
INSERT INTO guest (ID, Email, FName, LName, Nationality, City) 
VALUES ('6757868111', 'sara@gmail.com', 'sara', 'ali', 'emirates', 'dubai');
INSERT INTO guest (ID, Email, FName, LName, Nationality, City) 
VALUES ('1257768745', 'fahd@gmail.com', 'fahd', 'yasir', 'saudi', 'makkah');
INSERT INTO guest (ID, Email, FName, LName, Nationality, City) 
VALUES ('1246465641', 'omar@hotmail.com', 'omar', 'faisal', 'saudi', 'jeddah');
INSERT INTO guest (ID, Email, FName, LName, Nationality, City) 
VALUES ('1276833444', 'mona@gmail.com', 'mona', 'hamza', 'saudi', 'riyadh');


SELECT *
FROM guest;


SELECT COUNT(ID) AS 'Number Of Guest', Nationality
FROM guest
GROUP BY Nationality;


SELECT g.ID,FName,restaurantName,quantitiy
FROM guest g, guestorder c
WHERE g.ID=c.guestID
ORDER BY FName DESC;


select FName
from Guest 
order by FName desc;


SELECT FName, LName
FROM guest 
WHERE ID=(SELECT guestID
			   FROM guestorderdate 
               WHERE guestID='1939756833' AND restaurantName='Sun Deck');


DELETE FROM Guest
WHERE ID='6757868111';



CREATE TABLE GuestAddress(
City           VARCHAR(15) NOT NULL,
Street         VARCHAR(20) NUll,
Zip            INT(7) NULL,
CONSTRAINT GuestAddress_PK PRIMARY KEY (City));

INSERT INTO guestaddress (City, Street, Zip)
VALUES ('cairo', 'Al-azhar', '78912');    
INSERT INTO guestaddress (City, Street, Zip)
VALUES ('dubai', 'El-shikh zayed', '33445');    
INSERT INTO guestaddress (City, Street, Zip)
VALUES ('makkah', 'Al-marg', '6432');     
INSERT INTO guestaddress (City, Street, Zip)
VALUES ('jeddah', 'hira', '7371'); 
INSERT INTO guestaddress (City, Street, Zip)
VALUES ('riyadh', 'alia', '4118'); 


SELECT *
FROM guestaddress;


CREATE TABLE guestphone (
  guestID         VARCHAR(20) NOT NULL,
  guestEmail      VARCHAR(20) NOT NULL,
  phone           VARCHAR(15) NOT NULL,
  CONSTRAINT guestphone_PK PRIMARY KEY (guestID, guestEmail, phone),
  CONSTRAINT guestphone_FK1  FOREIGN KEY (guestID) REFERENCES Guest (ID) ,
  CONSTRAINT guestphone_FK2 FOREIGN KEY (guestEmail) REFERENCES Guest (Email));

INSERT INTO guestphone (guestID, guestEmail, phone)
VALUES ('1939756833', 'moh@ hotmail.com', '+966 554437959');
INSERT INTO guestphone (guestID, guestEmail, phone)
VALUES ('6757868111', 'sara@gmail.com', '+966 509948664');
INSERT INTO guestphone (guestID, guestEmail, phone)
VALUES ('1257768745', 'fahd@gmail.com', '+966 566788345');    
INSERT INTO guestphone (guestID, guestEmail, phone)
VALUES ('1246465641', 'omar@hotmail.com', '+966 509988811');
INSERT INTO guestphone (guestID, guestEmail, phone)
VALUES ('1276833444', 'mona@gmail.com', '+966 577099666');

SELECT *
FROM guestphone;


UPDATE guestphone
SET phone='+966 450743011'
WHERE guestID='1276833444';

SELECT *
FROM guestphone;
    

CREATE TABLE GuestOrder (
guestID VARCHAR(20) NOT NULL,
guestEmail VARCHAR(20) NOT NULL,
restaurantName VARCHAR(45) NOT NULL,
quantitiy   VARCHAR(15) NULL,
CONSTRAINT GuestOrder_PK PRIMARY KEY (guestID,guestEmail,restaurantName),
CONSTRAINT guestID FOREIGN KEY (guestID) REFERENCES Guest (ID) ,
CONSTRAINT guestEmail FOREIGN KEY (guestEmail) REFERENCES Guest (Email),
CONSTRAINT restaurantName FOREIGN KEY (restaurantName) REFERENCES restaurant (name)
);

INSERT INTO guestorder (guestID, guestEmail, restaurantName, quantitiy) 
VALUES ('1939756833', 'moh@ hotmail.com', 'Serẽa', '1meal');
INSERT INTO guestorder (guestID, guestEmail, restaurantName, quantitiy) 
VALUES ('6757868111', 'sara@gmail.com', 'Crown Room Brunch', '2meals');
INSERT INTO guestorder (guestID, guestEmail, restaurantName, quantitiy) 
VALUES ('1257768745', 'fahd@gmail.com', 'Sun Deck', '3meals');
INSERT INTO guestorder (guestID, guestEmail, restaurantName, quantitiy) 
VALUES ('1246465641', 'omar@hotmail.com', 'Sheerwater Breakfast', '1meal');
INSERT INTO guestorder (guestID, guestEmail, restaurantName, quantitiy) 
VALUES ('1276833444', 'mona@gmail.com', 'ENO Market & Pizzeria', '2meals');

SELECT *
FROM guestorder ;

UPDATE guestorder
SET quantitiy='3meal'
WHERE guestID='1246465641';

SELECT *
FROM guestorder ;


CREATE TABLE guestorderdate (
  guestID               varchar(20) NOT NULL,
  guestEmail            varchar(20) NOT NULL,
  restaurantName        varchar(45) NOT NULL,
  date                  varchar(20) NOT NULL,
  time                  varchar(20) DEFAULT NULL,
  PRIMARY KEY (guestID,guestEmail,restaurantName,date),
  CONSTRAINT guestorderdate_FK1 FOREIGN KEY (guestID) REFERENCES Guest (ID) ,
  CONSTRAINT guestorderdate_FK2 FOREIGN KEY (guestEmail) REFERENCES Guest (Email),
  CONSTRAINT guestorderdate_FK3 FOREIGN KEY (restaurantName) REFERENCES restaurant (name));


INSERT INTO guestorderdate 
VALUES ('1939756833', 'moh@ hotmail.com', 'Sun Deck', '11-11-2020', '4:00 PM');
INSERT INTO guestorderdate
VALUES ('6757868111', 'sara@gmail.com', 'ENO Market & Pizzeria', '5-4-2020', '3:15 PM');
INSERT INTO guestorderdate
VALUES ('1257768745', 'fahd@gmail.com', 'Sheerwater Breakfast', '7-9-2020', '9:10 AM');
INSERT INTO guestorderdate
VALUES ('1246465641', 'omar@hotmail.com', 'Serẽa', '13-11-2020', '11:00 AM');
INSERT INTO guestorderdate
VALUES ('1276833444', 'mona@gmail.com', 'Crown Room Brunch', '11-11-20202', '10:30 AM');

SELECT *
FROM guestorderdate ;


SELECT *
FROM guestorderdate
HAVING date = '11-11-2020';

DELETE from guestorderdate
WHERE time ='9:10 AM';

SELECT *
FROM guestorderdate ;



CREATE TABLE room (
    roomNo INT NOT NULL,
    roomType VARCHAR(45) DEFAULT NULL,
    status VARCHAR(45) DEFAULT NULL,
    PRIMARY KEY (roomNo),
    KEY status_idx (roomType , status),
    KEY status_idx1 (status),
    CONSTRAINT roomType FOREIGN KEY (roomType)REFERENCES roomtype (roomType)ON DELETE CASCADE ,
    CONSTRAINT status FOREIGN KEY (status)REFERENCES roomstatus (status)ON DELETE CASCADE 
);

INSERT INTO room 
VALUES ('105', 'Triple', 'CO - Check-Out');
INSERT INTO room
VALUES ('106', 'Double', 'LC - Late Check out');
INSERT INTO room
VALUES ('206', 'Suite', 'VC - Vacant and Clean');
INSERT INTO room
VALUES ('103', 'Single', 'VR - Vacant and Ready ');
INSERT INTO room
VALUES ('102', 'Quad', 'OCC - Occupied');

SELECT *
FROM room ;


UPDATE room
SET status = 'OCC - Occupied'
WHERE status =  'VR - Vacant and Ready';

SELECT *
FROM room ;


SELECT roomNo, roomType, status
FROM room
ORDER BY roomNo DESC;

SELECT *
FROM room
WHERE roomType IN (SELECT roomType
                  FROM roomtype
                  WHERE view = 'park');


SELECT FName,LName,ID,Email
FROM guest 
WHERE ID =(SELECT guestID 
			FROM roomstatus
            WHERE status IN(SELECT status
                            FROM room 
                            WHERE status='VR - Vacant and Ready ' ));


SELECT g.FName,g.LName,g.ID,g.Email,r.roomNo,r.roomType,r.status
FROM guest g,room r,roomstatus s
WHERE g.ID=s.guestID AND r.status=s.status
ORDER BY g.FName ;


CREATE TABLE roomtype (
  roomType            varchar(45) NOT NULL,
  numberOfBeds        int DEFAULT NULL,
  view                varchar(45) DEFAULT NULL,
  smoke               varchar(45) DEFAULT NULL,
  PRIMARY KEY (roomType)
);

INSERT INTO roomtype
VALUES ('Single', '1', 'park', 'allowed');
INSERT INTO roomtype
VALUES ('Double', '1', 'pool', 'allowed');
INSERT INTO roomtype
VALUES ('Triple', '2', 'sea', 'not allowed');
INSERT INTO roomtype
VALUES ('Quad', '3', 'park', 'not allowed');
INSERT INTO roomtype
VALUES ('Suite', '4', 'sea', 'not allowed');

SELECT *
FROM roomtype ;


SELECT  r.roomNo,s.status,t.roomType,t.smoke
FROM    room r,roomstatus s,roomtype t
WHERE   s.status=r.status AND t.roomType=r.roomType AND t.smoke='allowed'
ORDER BY r.roomNo ;

DELETE FROM roomtype
WHERE roomType = 'Suite';



CREATE TABLE roomstatus (
  status             varchar(45) NOT NULL,
  guestID            varchar(20) DEFAULT NULL,
  guestEmail         varchar(20) DEFAULT NULL,
  PRIMARY KEY (status),
  CONSTRAINT roomstatus_FK1 FOREIGN KEY (guestID) REFERENCES Guest (ID) ,
  CONSTRAINT roomstatus_FK2 FOREIGN KEY (guestEmail) REFERENCES Guest (Email)
);


INSERT INTO roomstatus
VALUES ('OCC - Occupied', '1939756833', 'moh@ hotmail.com');
INSERT INTO roomstatus
VALUES ('LC - Late Check out', '6757868111', 'sara@gmail.com');
INSERT INTO roomstatus
VALUES ('CO - Check-Out', '1257768745', 'fahd@gmail.com');
INSERT INTO roomstatus
VALUES ('VC - Vacant and Clean', '1246465641', 'omar@hotmail.com');
INSERT INTO roomstatus
VALUES ('VR - Vacant and Ready ', '1276833444', 'mona@gmail.com');


SELECT *
FROM roomstatus ;



CREATE TABLE roomservice (
  roomNo             int NOT NULL,
  roomService        varchar(45) NOT NULL,
  CONSTRAINT roomservice_PK PRIMARY KEY (roomService,roomNo),
  CONSTRAINT roomservice_FK FOREIGN KEY (roomNo) REFERENCES room(roomNo));

 INSERT INTO roomservice (roomNo, roomService)
 VALUES (105, 's12');
 INSERT INTO roomservice (roomNo, roomService)
 VALUES (106, 's13');
 INSERT INTO roomservice (roomNo, roomService)
 VALUES (206, 's14');
 INSERT INTO roomservice (roomNo, roomService)
 VALUES (103, 's15');
 INSERT INTO roomservice (roomNo, roomService)
 VALUES (102, 's16');

SELECT *
FROM roomservice ;


SELECT g.FName,g.LName,g.ID,r.roomNo,s.roomService
FROM guest g,room r,roomservice s,roomstatus t
WHERE g.ID=t.guestID AND t.status=r.status AND s.roomNo=r.roomNo
ORDER BY g.FName ;


CREATE TABLE reservation (
  reservationNumber         int NOT NULL,
  roomNo                    int DEFAULT NULL,
  guestID                   varchar(20) DEFAULT NULL,
  guestEmail                varchar(20) DEFAULT NULL,
 CONSTRAINT reservation_PK  PRIMARY KEY (reservationNumber),
 CONSTRAINT reservation_FK1 FOREIGN KEY (roomNo) REFERENCES room(roomNo),
 CONSTRAINT reservation_FK2 FOREIGN KEY (guestID) REFERENCES Guest (ID),
 CONSTRAINT reservation_FK3 FOREIGN KEY (guestEmail) REFERENCES Guest (Email)
);


 INSERT INTO reservation (reservationNumber, roomNo, guestID, guestEmail)
 VALUES (123, 105,1257768745 , 'fahd@gmail.com');
 INSERT INTO reservation (reservationNumber, roomNo, guestID, guestEmail)
 VALUES (124, 106, 6757868111,'sara@gmail.com');
 INSERT INTO reservation (reservationNumber, roomNo, guestID, guestEmail)
 VALUES (125, 206, 1246465641,'omar@hotmail.com');
 INSERT INTO reservation (reservationNumber, roomNo, guestID, guestEmail)
 VALUES (126, 103, 1276833444, 'mona@gmail.com');
 INSERT INTO reservation (reservationNumber, roomNo, guestID, guestEmail)
 VALUES (127, 102, 1939756833, 'moh@ hotmail.com');

SELECT *
FROM reservation ;


CREATE TABLE datecheck (
  guestID              varchar(20)  NOT NULL,
  guestEmail           varchar(20) NOT NULL,
  dateCheckIn          varchar(45) DEFAULT NULL,
  dateCheckOut         varchar(45)DEFAULT NULL,
CONSTRAINT datecheck_PK PRIMARY KEY (guestID,guestEmail),
CONSTRAINT datecheck_FK1 FOREIGN KEY (guestID) REFERENCES Guest (ID),
CONSTRAINT datecheck_FK2 FOREIGN KEY (guestEmail) REFERENCES Guest (Email)
);


INSERT INTO datecheck(guestID, guestEmail, dateCheckIn, dateCheckOut) 
VALUES (1939756833, 'moh@ hotmail.com', '10/11/2020', '15/11/2020');
INSERT INTO datecheck(guestID, guestEmail, dateCheckIn, dateCheckOut) 
VALUES (6757868111, 'sara@gmail.com', '5/4/2020', '8/4/2020');
INSERT INTO datecheck(guestID, guestEmail, dateCheckIn, dateCheckOut) 
VALUES (1257768745, 'fahd@gmail.com', '8/9/2020', '10/9/2020');
INSERT INTO datecheck(guestID, guestEmail, dateCheckIn, dateCheckOut) 
VALUES (1246465641, 'omar@hotmail.com', '12/11/2020', '16/11/2020');
INSERT INTO datecheck(guestID, guestEmail, dateCheckIn, dateCheckOut) 
VALUES (1276833444, 'mona@gmail.com', '11/11/2020', '13/11/2020');


SELECT *
FROM datecheck ;


SELECT guestID,guestEmail,dateCheckIn
FROM datecheck
WHERE dateCheckIn BETWEEN '10/11/2020' AND'12/11/2020';

SELECT dateCheckIn,dateCheckOut
FROM datecheck
WHERE guestID=(SELECT guestID 
			   FROM roomstatus
               WHERE status IN(SELECT status
							FROM room 
                            WHERE roomNo = '105'));



CREATE TABLE roomprice (
  roomNo              int NOT NULL,
  price               double DEFAULT NULL,
CONSTRAINT roomprice_PK PRIMARY KEY (roomNo),
CONSTRAINT roomprice_FK FOREIGN KEY (roomNo) REFERENCES room(roomNo));

 INSERT INTO roomprice (roomNo, price)
 VALUES (105, 350);
 INSERT INTO roomprice (roomNo, price)
 VALUES (106, 400);
 INSERT INTO roomprice (roomNo, price)
 VALUES (206, 200);
 INSERT INTO roomprice (roomNo, price)
 VALUES (103, 350);
 INSERT INTO roomprice (roomNo, price)
 VALUES (102, 350);

SELECT *
FROM roomprice ;

SELECT r.roomNo,r.roomType,r.status,p.price
FROM roomprice p ,room r,roomstatus s
WHERE r.status=s.status AND r.roomNo=p.roomNo
ORDER BY p.price DESC;



  CREATE TABLE restaurant (
  name            VARCHAR(45) NOT NULL,
  type            VARCHAR(45) NULL,
  CONSTRAINT restaurant_PK PRIMARY KEY (name),
  CONSTRAINT restaurant_FK FOREIGN KEY (type) REFERENCES restauranttype (type));
  
INSERT INTO restaurant (name, type) 
VALUES ('Sun Deck', 'Café');
INSERT INTO restaurant (name, type)
VALUES ('ENO Market & Pizzeria', 'Italian');
INSERT INTO restaurant (name, type) 
VALUES ('Serẽa', 'sea restaurant');
INSERT INTO restaurant (name, type) 
VALUES ('Sheerwater Breakfast', 'Coronado Beach restaurant');
INSERT INTO restaurant (name, type) 
VALUES ('Crown Room Brunch', 'buffet');

SELECT *
FROM restaurant ;  
  
  
  
  CREATE TABLE restauranttype (
  type            VARCHAR(45) NOT NULL,
  capacity        INT NULL,
  workingTime     VARCHAR(45) NULL,
  PRIMARY KEY (type));

INSERT INTO restauranttype (type, capacity, workingTime) 
VALUES ('Café', '100', 'Daily 11:30am - 7pm');
INSERT INTO restauranttype (type, capacity, workingTime) 
VALUES ('Italian', '400', 'Sun-Thu: 6am - 8pm');
INSERT INTO restauranttype (type, capacity, workingTime) 
VALUES ('sea restaurant', '600', 'Sat - Sun : 11am - 2:30pm');
INSERT INTO restauranttype (type, capacity, workingTime) 
VALUES ('Coronado Beach restaurant', '200', 'Fri - Sun 7 - 11am');
INSERT INTO restauranttype (type, capacity, workingTime) 
VALUES ('Buffet', '1000', 'Sun-Thu: 10:30am - 5pm');

SELECT *
FROM restauranttype ;
  

UPDATE restauranttype
SET  workingTime='Fri - Sun 7 am- 11pm'
WHERE type ='Coronado Beach restaurant';  
  
  

CREATE TABLE restaurantmenu (
  restaurantName         VARCHAR(45) NOT NULL,
  menu                   VARCHAR(300) NOT NULL,
  CONSTRAINT restaurantName_PK PRIMARY KEY (restaurantName, menu),
  CONSTRAINT restaurantName_FK FOREIGN KEY (restaurantName) REFERENCES restaurant (name)  );  

INSERT INTO restaurantmenu (restaurantName, menu) 
VALUES ('Sun Deck', 'coffee & Drinks ,STARTERS‏,SALADS & BOWLS,HANDHELDS‏,ENTREES,DESSERT');
INSERT INTO restaurantmenu (restaurantName, menu) 
VALUES ('ENO Market & Pizzeria', 'MARGHERITA,PEPPERONI,MELANZANA,BIANCA,FUNGHI,CARCIOFI,SALSICCIA,QUATTRO FORMAGGI');
INSERT INTO restaurantmenu (restaurantName, menu) 
VALUES ('Serẽa', 'SALADS,APPETIZERS,DAILY SELECTION OF OYSTERS,SASHIMI,WOOD GRILLED,FLASH FRIED');
INSERT INTO restaurantmenu (restaurantName, menu) 
VALUES ('Sheerwater Breakfast', 'SEASONAL FRUIT PLATE (V/GF),GREEK YOGURT BOWL (VEG),CLASSIC HEART HEALTHY OATMEAL (V/GF),MORNING BREAKFAST BASKET (VEG),BELGIAN STYLE SUGAR WAFFLES (VEG),BREAKFAST CHEESEBURGER,CLASSIC AMERICAN BREAKFAST');
INSERT INTO restaurantmenu (restaurantName, menu) 
VALUES ('Crown Room Brunch', 'Eggs Benedict,Egg Soufflé,Rosemary hollandaise,Breakfast Meats,Roasted Potatoes,Pancakes and Waffles,Honeycomb Yogurt & Granola,California and Baja Cheeses,Artisan Bread,Seasonal Melons, Fruits and Berries, Whole Fruit Market,coffee & Drinks');

SELECT *
FROM restaurantmenu ; 


SELECT restaurantName,COUNT(menu) AS 'Menu' 
FROM restaurantmenu
GROUP BY restaurantName;


 
 CREATE TABLE membership (
  reservationNumber      INT NOT NULL,
  guestID                VARCHAR(20) NOT NULL,
  guestEmail             VARCHAR(20) NOT NULL,
  idMemberShip           varchar(20) NOT NULL,
  gold                   VARCHAR(1) NULL,CHECK (gold IN ('*')),
  silver                 VARCHAR(1) NULL,CHECK (silver IN ('*')),
  diamond                VARCHAR(1) NULL,CHECK (diamond IN ('*')),
  CONSTRAINT membership_PK PRIMARY KEY (reservationNumber,guestID,guestEmail,idMemberShip),
  CONSTRAINT membership_FK1 FOREIGN KEY (reservationNumber) REFERENCES reservation (reservationNumber),
  CONSTRAINT membership_FK2 FOREIGN KEY (guestID) REFERENCES Guest (ID)  ,
  CONSTRAINT membership_FK3 FOREIGN KEY (guestEmail) REFERENCES Guest (Email) 
  );  
    
    
INSERT INTO membership (reservationNumber, guestID, guestEmail, idMemberShip, diamond) 
VALUES ('123', '1939756833', 'moh@ hotmail.com', '3246957812', '*');
INSERT INTO membership (reservationNumber, guestID, guestEmail, idMemberShip, silver) 
VALUES ('124', '6757868111', 'sara@gmail.com', '3268992455', '*');
INSERT INTO membership (reservationNumber, guestID, guestEmail, idMemberShip, gold) 
VALUES ('125', '1257768745', 'fahd@gmail.com', '4521787231', '*');
INSERT INTO membership (reservationNumber, guestID, guestEmail, idMemberShip, diamond) 
VALUES ('126', '1246465641', 'omar@hotmail.com', '4234742332', '*');
INSERT INTO membership (reservationNumber, guestID, guestEmail, idMemberShip, gold) 
VALUES ('127', '1276833444', 'mona@gmail.com', '3548736245', '*');

SELECT *
FROM membership ;     
   
   
SELECT *
FROM membership
WHERE gold is null AND silver is null and diamond is not null;   
   
DELETE FROM membership
WHERE gold='*' ;   
