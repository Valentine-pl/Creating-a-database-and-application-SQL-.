USE master
GO

IF EXISTS(SELECT * FROM SYS.DATABASES WHERE NAME = 'Lucky Trip')
    DROP DATABASE [Lucky Trip]
GO

CREATE DATABASE [Lucky Trip]
GO



-----"Lucky Trip" Travel Company ltd.----------


USE [Lucky Trip]
GO

--------------------Branches Table---------------------------
CREATE TABLE Branches
(Branch_ID          smallint       identity (1,1) constraint br_p_k Primary Key,
 Branch_Name        varchar (20))

-------------------Cars Table---------------------------------
CREATE TABLE Cars
(Car_ID            varchar (8)     constraint car_p_k Primary Key,
 Maker             varchar (30),
 Model             varchar (30),
 Color             varchar (20),
 Start_EXP         date            Not Null,
 End_EXP           date,
 Branch_ID         smallint        constraint brC_id_fk references Branches(Branch_ID) on delete cascade)

 ------------------Employees Table-----------------------------
CREATE TABLE Employees
(Emp_ID           int            identity (1,1)  constraint emp_p_k Primary Key,
 First_Name       varchar (30)                   Not Null,
 Last_Name        varchar (30)                   Not Null,
 Title            varchar (30),
 Gender           char (1)                       check (Gender in ('M','F')),
 Phone_Number     varchar (13)   unique          check (Phone_Number like '(___)%'),
 Branch_ID        smallint                       constraint brE_id_fk references Branches(Branch_ID) on delete cascade)

  -----------------Drivers Table-----------------------------------
CREATE TABLE Drivers
(Driver_License   varchar (7)                   constraint dvr_p_k Primary Key,
 License_Type     char (1)       default ('B'),
 Issue_Date       date                          check (datediff(yy, Issue_Date ,Getdate())>=5),
 Emp_ID           int                           constraint emp_id_fk references Employees(Emp_ID) on delete cascade)

   -----------Customer Types Table-----------------------------------
CREATE TABLE "Customer Types"
(Type_ID       smallint                        constraint ct_p_k Primary Key,
 Type_Name     varchar (20)                    Not Null)

   ---------------Customers Table----------------------------------
CREATE TABLE Customers
(Cust_ID         int            identity (1,1)  constraint cus_p_k Primary Key,
 Type_ID         smallint                       constraint ct_id_fk references "Customer Types"(Type_ID) on delete cascade,
 Contact_Name    varchar (30),
 Phone_Number    varchar (13)   unique          check (Phone_Number like '(___)%'),
 Email           varchar (50)   unique          check (Email like '%@%.%'))
	
	-------------Orders Table------------------------------------------
CREATE TABLE Orders
(Order_ID      int                             constraint ord_p_k Primary Key,
 Cust_ID       int                             constraint cus_id_fk references Customers(Cust_ID) on delete no action,
 Driver        varchar(7)                      constraint drv_id_fk references Drivers(Driver_License) on delete no action,
 Branch_ID     smallint                        constraint brO_id_fk references Branches(Branch_ID) on delete no action,
 Order_Date    date                            Not Null)

	 ------------Discounts Table-------------------------------------------------
CREATE TABLE Discounts
(Discount_Type  smallint      identity (1,1) constraint dsc_p_k Primary Key,
 Discount_Name  varchar (20),
 Disc_Level     real                         check(Disc_Level between 0 and 0.5))
 
	 ---------------Order Details Table----------------------------------------
CREATE TABLE Order_Details
(Order_ID      int                            constraint or_id_fk references Orders(Order_ID) on delete cascade,
 Car_ID        varchar (8)                    constraint car_id_fk references Cars(Car_ID ) on delete no action,
 Distance_KM   int,
 Price_per_KM  money                          Not Null,
 Discount_Type smallint                       constraint dis_id_fk  references Discounts(Discount_Type) on delete cascade,
 constraint od_car_id_pk Primary Key  (Order_ID,Car_ID))




-----------Insert Braches Table-----------------------------------------
insert into Branches
values ('North'),
       ('South'),
       ('West'),
       ('East')

-----------Insert Cars Table--------------------------------------------

insert into Cars 
values (2965644, 'Mazda', 'MX-5','White', '2019-03-02', '2021-11-26', 1),
       (1138091, 'GMC', 'Sonoma','Black', '2019-06-10', '2022-06-22', 3),
       (3330923, 'Chevrolet', 'Corvette','Black', '2019-01-26', '2022-11-19', 2),
       (4961095, 'GMC', 'Sierra 3500','Red' ,'2018-01-12', '2022-01-31', 4),
       (8933435, 'Buick', 'Reatta','Black', '2018-04-18', '2023-02-26', 1),
       (5303644, 'Ford', 'Explorer Sport Trac','White', '2018-03-25', '2022-02-28', 3),
       (8395402, 'Chevrolet', '2500','White', '2017-11-25', '2022-03-08', 3),
       (5823074, 'Daewoo', 'Nubira','Black' ,'2018-03-10', '2023-07-07', 4),
       (1191297, 'Ford', 'Thunderbird','Red', '2019-03-17', '2021-12-15', 1),
       (4437281, 'Toyota', 'Corolla','Yellow', '2018-10-20', '2021-12-27', 3),
       (3110704, 'Acura', 'RDX','White', '2018-02-12', '2023-10-10', 4),
       (2359220, 'Toyota', '4Runner','Black', '2019-10-13', '2023-10-06', 3),
       (4884496, 'Volkswagen', 'Eos','White', '2018-05-12', '2023-05-22', 4),
       (8469520, 'Lotus', 'Esprit','Silver', '2018-06-15', '2022-09-03', 2),
       (9204991, 'Pontiac', 'Grand Prix','White', '2019-10-08', '2022-11-30', 1),
       (4891233, 'Oldsmobile', 'Achieva','White', '2019-11-02', '2023-06-02', 3),
       (7938727, 'Jeep', 'Compass','Silver', '2018-04-16', '2022-04-26', 2),
       (4774886, 'Pontiac', 'Trans Sport','Black', '2017-11-14', '2023-09-08', 4),
       (4754874, 'Mercury', 'Mountaineer','Silver', '2019-04-04', '2022-12-29', 2),
       (4413901, 'Mitsubishi', 'Eclipse','Silver', '2017-12-08', '2023-08-07', 4),
       (2265318, 'Infiniti', 'I','White', '2019-09-19', '2023-09-19', 1),
       (4725602, 'Dodge', 'Shadow','Yellow', '2018-12-30', '2023-02-28', 4),
       (2827133, 'Pontiac', 'Grand Am','Black', '2018-12-29', '2023-03-08', 4),
       (9720383, 'Mitsubishi', '3000GT','Black', '2019-05-05', '2022-11-04', 3),
       (9161930, 'Lotus', 'Esprit','White', '2018-10-27', '2023-01-14', 3),
       (9929300, 'Toyota', 'T100 Xtra','White', '2019-05-27', '2022-05-13', 2),
       (8937732, 'Ford', 'Taurus','Red', '2017-12-10', '2021-11-13', 2),
       (4494707, 'Mazda', 'CX-9','Silver', '2018-06-24', '2023-11-05', 1),
       (8529283, 'Pontiac', 'LeMans','Black', '2018-09-20', '2022-03-19', 1),
       (6960930, 'GMC', 'Sierra 3500HD','White', '2017-11-14', '2022-06-15', 2),
       (8967993, 'Chevrolet', 'Tahoe','White', '2019-08-05', '2023-09-01', 2),
       (6185248, 'BMW', 'Z4','Black', '2018-10-23', '2022-05-08', 2),
       (6404858, 'Oldsmobile', 'Alero','Red', '2018-01-09', '2022-08-09', 4),
       (9337299, 'Porsche', '968','White', '2019-04-05', '2021-12-11', 1),
       (5145824, 'Chevrolet', 'Corvette','White', '2019-05-29', '2023-05-12', 4),
       (4618504, 'Volkswagen', 'GTI','Silver', '2019-08-26', '2023-03-13', 1),
       (6588756, 'Buick', 'LaCrosse','Black', '2018-08-07', '2022-06-06', 4),
       (1895168, 'Porsche', '911','White', '2018-06-09', '2023-07-31', 3),
       (6963858, 'Oldsmobile', '88','Red', '2018-11-14', '2022-08-24', 4),
       (7203149, 'Lincoln', 'Town Car','White', '2018-06-03', '2023-04-23', 4)

-----------Insert Emploees Table--------------------------------------------
INSERT INTO Employees  
VALUES ('Leland', 'Gres', 'Administration', 'F', '(137) 6326365', 3),
       ('Pren', 'Jillard', 'Driver', 'M', '(552) 3992585', 1),
       ('Noella', 'Rummings', 'Manager', 'F', '(784) 1702913', 2),
       ('Cyndia', 'Storer', 'Administration', 'F', '(883) 4467415', 1),
       ('Gerhardine', 'Cometson', 'Administration', 'F', '(950) 9902872', 4),
       ('Melony', 'Longhorn', 'Administration', 'F', '(222) 8157389', 1),
       ('Ford', 'Segges', 'Driver', 'M', '(821) 8985103', 1),
       ('Alana', 'Bonallack', 'Administration', 'F', '(309) 7798174', 3),
       ('Ariana', 'Leve', 'Administration', 'F', '(148) 8352899', 4),
       ('Etty', 'Gilliland', 'Administration', 'F', '(641) 8882968', 3),
       ('Misti', 'De Paepe', 'Administration', 'F', '(820) 5850359', 1),
       ('Rebe', 'Eglington', 'Administration', 'F', '(948) 9167408', 3),
       ('Svend', 'Novill', 'Driver', 'M', '(753) 9551899', 4),
       ('Bartholomeo', 'Beacroft', 'Driver', 'M', '(138) 1613830', 2),
       ('Albrecht', 'Swaysland', 'Driver', 'M', '(724) 3697045', 2),
       ('Cordell', 'Mary', 'Driver', 'M', '(872) 9827790', 3),
       ('Morly', 'Mousby', 'Driver', 'M', '(754) 7766726', 1),
       ('Briggs', 'Simeoli', 'Driver', 'M', '(927) 9394282', 4),
       ('Talbert', 'Shead', 'Manager', 'M', '(714) 9160138', 3),
       ('Eulalie', 'Hrihorovich', 'Administration', 'F', '(716) 9048833', 1),
       ('Ganny', 'MacKenney', 'Manager', 'M', '(524) 9954973', 1),
       ('Rollin', 'Zincke', 'Driver', 'M', '(644) 9565575', 4),
       ('Julienne', 'Datte', 'Administration', 'F', '(702) 5252560', 2),
       ('Yelena', 'Sewley', 'Administration', 'F', '(405) 7075778', 3),
       ('Hussein', 'Pescod', 'Driver', 'M', '(883) 3882030', 4),
       ('Garner', 'Hallwell', 'Driver', 'M', '(602) 3166359', 1),
       ('Walsh', 'Lowton', 'Driver', 'M', '(713) 6308990', 1),
       ('Grantley', 'Guinan', 'Administration', 'M', '(873) 3021562', 1),
       ('Neale', 'Clubb', 'Driver', 'M', '(986) 4972463', 3),
       ('Theodoric', 'Nunnery', 'Driver', 'M', '(425) 1153362', 3),
       ('Aubrey', 'Wimp', 'Driver', 'M', '(637) 6407740', 2),
       ('Micah', 'Bloodworthe', 'Driver', 'M', '(355) 8722290', 3),
       ('Skippie', 'Vell', 'Driver', 'M', '(874) 3728342', 4),
       ('Flint', 'Tomkies', 'Driver', 'M', '(478) 2623503', 4),
       ('Peg', 'Odegaard', 'Administration', 'F', '(544) 7491938', 2),
       ('Rafa', 'Van den Velde', 'Administration', 'F', '(154) 7014520', 4),
       ('Lind', 'Flury', 'Administration', 'F', '(959) 9223494', 2)

-----------Insert Drivers Table--------------------------------------------
INSERT INTO Drivers
VALUES (6653876, 'B', '2007-10-27', 2),
       (3775413, 'B', '2012-05-11', 7),
       (6936499, 'C', '2006-02-15', 13),
       (7252939, 'B', '1992-05-22', 14),
       (9585301, 'B', '2008-08-20', 15),
       (6183835, 'B', '1991-05-10', 16),
       (5635583, 'C', '1998-05-06', 17),
       (7183069, 'D', '2007-05-12', 18),
       (5334556, 'B', '2012-10-05', 22),
       (8273795, 'B', '1997-01-03', 25),
       (7449234, 'C', '2002-06-19', 26),
       (2722641, 'B', '1991-10-02', 27),
       (6290280, 'B', '2009-06-19', 29),
       (7220969, 'B', '2011-03-22', 30),
       (9469107, 'B', '2002-04-02', 31),
       (2238453, 'B', '2009-09-24', 32),
       (2557362, 'C', '2008-07-19', 33),
       (5894565, 'B', '1998-08-09', 34)

-----------Insert Customers Types Table--------------------------------------------
INSERT INTO [Customer Types]
VALUES (1,'Private'),
       (2,'Bussines'),
	   (3,'Public')

-----------Insert Customers Table-------------------------------------------------
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Joann Jewise', '(914) 7216770', 'jjewise0@webmd.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Evelyn Humburton', '(508) 7337671', 'ehumburton1@patch.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Lorne Losel', '(765) 9710426', 'llosel2@ovh.net');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Lorine Habden', '(151) 9900417', 'lhabden3@pagesperso-orange.fr');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Lari Geall', '(779) 6639401', 'lgeall4@unc.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Gabi Cockell', '(899) 1216998', 'gcockell5@ovh.net');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Michal Jeynes', '(443) 4129032', 'mjeynes6@wikimedia.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Cyrill Gobell', '(458) 8478014', 'cgobell7@wired.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Nikki Owthwaite', '(332) 2692300', 'nowthwaite8@msn.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Katherina Doge', '(584) 4445119', 'kdoge9@w3.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Tome Hurley', '(999) 9336526', 'thurleya@marketwatch.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Jennee Sweating', '(692) 7354490', 'jsweatingb@twitpic.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Karney Claisse', '(851) 2721356', 'kclaissec@cdbaby.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Marillin Ladlow', '(363) 4474025', 'mladlowd@rediff.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Storm Thickins', '(900) 1290253', 'sthickinse@symantec.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Rossy Swate', '(666) 4425205', 'rswatef@hp.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Lancelot Devil', '(514) 7214946', 'ldevilg@omniture.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Lucky Jellicorse', '(694) 3572950', 'ljellicorseh@arizona.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Nico Boldt', '(321) 2104124', 'nboldti@goodreads.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Cly De Giorgio', '(697) 8655698', 'cdej@elegantthemes.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Norean Creebo', '(309) 2643800', 'ncreebok@google.cn');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Hal Cutteridge', '(348) 9438564', 'hcutteridgel@cnet.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Holli Stuer', '(706) 7010868', 'hstuerm@diigo.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Tully Zeal', '(875) 2457523', 'tzealn@google.cn');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Romeo Beadel', '(255) 3008993', 'rbeadelo@buzzfeed.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Raven Rollinshaw', '(527) 4043053', 'rrollinshawp@webnode.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Brenden Neill', '(300) 8833560', 'bneillq@woothemes.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Hanni McCorley', '(800) 7760307', 'hmccorleyr@blogs.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Bret Emanuelli', '(309) 6653435', 'bemanuellis@facebook.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Karly Renowden', '(651) 7995563', 'krenowdent@army.mil');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Jamie Myall', '(396) 5070609', 'jmyallu@cafepress.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Ginny Peschka', '(975) 5520799', 'gpeschkav@squidoo.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Natale Lates', '(391) 1133213', 'nlatesw@myspace.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Amalia Stollhofer', '(603) 9026142', 'astollhoferx@desdev.cn');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Dania Arney', '(662) 3705918', 'darneyy@go.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Bran Crix', '(331) 4233422', 'bcrixz@sogou.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Corey Lavarack', '(122) 4232501', 'clavarack10@xing.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Dennie Phythien', '(137) 8410661', 'dphythien11@weibo.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Eliot Paladino', '(901) 6382448', 'epaladino12@unc.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Nikola Overpool', '(304) 8170014', 'noverpool13@yale.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Aline Ewebank', '(827) 4003910', 'aewebank14@cornell.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Andee Rook', '(718) 8986860', 'arook15@over-blog.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Linnea Braksper', '(806) 3742602', 'lbraksper16@un.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Rudolfo Thomasen', '(103) 3312510', 'rthomasen17@printfriendly.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Corabella Chellam', '(890) 7999394', 'cchellam18@rakuten.co.jp');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Cobbie Brabin', '(409) 1579611', 'cbrabin19@biblegateway.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Tedie Dameisele', '(649) 9574635', 'tdameisele1a@usa.gov');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Yancy Heckle', '(195) 8686222', 'yheckle1b@drupal.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Emmeline Liddy', '(461) 7225261', 'eliddy1c@instagram.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Terri Fuxman', '(896) 2872900', 'tfuxman1d@huffingtonpost.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Nico Pidgeley', '(266) 2694764', 'npidgeley1e@wikipedia.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Zelig Rayne', '(114) 5980408', 'zrayne1f@jigsy.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Amery Hopkins', '(432) 7055959', 'ahopkins1g@nasa.gov');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Ganny Scutter', '(687) 3639643', 'gscutter1h@vk.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Anallise Touhig', '(492) 5179421', 'atouhig1i@ustream.tv');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Leoline Crummey', '(326) 1270846', 'lcrummey1j@facebook.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Preston Maestro', '(700) 1109789', 'pmaestro1k@ow.ly');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Tiphanie Phipps', '(785) 3145444', 'tphipps1l@tmall.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Moria Howselee', '(387) 8462787', 'mhowselee1m@issuu.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Wilie Fothergill', '(217) 9959575', 'wfothergill1n@nbcnews.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Edan Daltrey', '(869) 7684932', 'edaltrey1o@ted.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Sydney Petrovykh', '(630) 7324226', 'spetrovykh1p@loc.gov');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Georges MacVaugh', '(415) 1424894', 'gmacvaugh1q@shinystat.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Neel Monelli', '(199) 4972617', 'nmonelli1r@apple.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Goddart Matten', '(488) 9284104', 'gmatten1s@angelfire.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Rafaelia Martland', '(538) 7247074', 'rmartland1t@linkedin.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Blair Braden', '(350) 8355354', 'bbraden1u@pagesperso-orange.fr');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Keriann Luquet', '(484) 5490566', 'kluquet1v@e-recht24.de');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Gallagher Christofol', '(290) 1453970', 'gchristofol1w@joomla.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Peggie Kobiela', '(959) 3284804', 'pkobiela1x@xing.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Goldie Gowing', '(268) 8418507', 'ggowing1y@ucoz.ru');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Gabriellia Chapell', '(608) 5298299', 'gchapell1z@soundcloud.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Virgilio Mangin', '(961) 9030487', 'vmangin20@ehow.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Dorey Winchcum', '(427) 7582087', 'dwinchcum21@flavors.me');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Camella Callear', '(254) 9891230', 'ccallear22@ow.ly');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Keven Castellaccio', '(273) 9308298', 'kcastellaccio23@biblegateway.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Asia Chittock', '(251) 1426007', 'achittock24@storify.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Clyve Fooks', '(372) 2327723', 'cfooks25@vistaprint.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Ammamaria Rutter', '(597) 9625383', 'arutter26@4shared.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Thorsten deKnevet', '(350) 9705557', 'tdeknevet27@miibeian.gov.cn');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Meg Ceschelli', '(342) 9021908', 'mceschelli28@opensource.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Pavlov D''Ambrosio', '(184) 9566006', 'pdambrosio29@dagondesign.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Eleanora Dreghorn', '(438) 8845683', 'edreghorn2a@51.la');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Davie Corringham', '(572) 3829479', 'dcorringham2b@youku.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Paulette Duddell', '(875) 8283100', 'pduddell2c@amazon.de');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Stacie Rush', '(212) 2112701', 'srush2d@cbsnews.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Nicolas Perse', '(721) 7788771', 'nperse2e@ovh.net');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Annissa Brombell', '(446) 2437122', 'abrombell2f@cbc.ca');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Belinda Capron', '(146) 4359818', 'bcapron2g@nasa.gov');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Amalle Huncote', '(330) 9116349', 'ahuncote2h@marketwatch.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Staford Deeprose', '(480) 4197495', 'sdeeprose2i@europa.eu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Ania Lemmers', '(363) 4065896', 'alemmers2j@microsoft.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Paula Hinder', '(326) 5528332', 'phinder2k@engadget.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Onfre Cardenoso', '(265) 5251213', 'ocardenoso2l@squidoo.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Rowland Orto', '(905) 9730280', 'rorto2m@etsy.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Etan Harrisson', '(188) 6697989', 'eharrisson2n@wordpress.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Debor Zamorrano', '(182) 8349480', 'dzamorrano2o@illinois.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Ina Flemming', '(932) 5958505', 'iflemming2p@sakura.ne.jp');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Phineas Klessmann', '(699) 2342617', 'pklessmann2q@umn.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Roley Head', '(603) 8795675', 'rhead2r@liveinternet.ru');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Ginger Crossley', '(855) 3592183', 'gcrossley2s@nsw.gov.au');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Janessa Grcic', '(792) 7879566', 'jgrcic2t@mlb.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Irving Blackly', '(239) 7762337', 'iblackly2u@jugem.jp');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Evie Binstead', '(559) 5325820', 'ebinstead2v@dagondesign.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Erhart Swine', '(549) 9615877', 'eswine2w@ameblo.jp');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Aland Millard', '(722) 7403922', 'amillard2x@hc360.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Mallorie Pendock', '(747) 1933204', 'mpendock2y@pen.io');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Ashleigh Frontczak', '(823) 3039406', 'afrontczak2z@people.com.cn');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Tommi Peterffy', '(944) 1436598', 'tpeterffy30@sitemeter.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Aron Spight', '(101) 4326186', 'aspight31@lulu.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Kathryne Whitter', '(361) 3679365', 'kwhitter32@t.co');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Eddie Mustoo', '(935) 5856707', 'emustoo33@alexa.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Blanche Gori', '(476) 4848281', 'bgori34@independent.co.uk');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Tanitansy Varley', '(172) 4698756', 'tvarley35@wisc.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Gusta Koppe', '(407) 8551743', 'gkoppe36@examiner.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Kilian Bohlmann', '(550) 9508346', 'kbohlmann37@mapy.cz');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Arie Spencley', '(684) 5346004', 'aspencley38@army.mil');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Tilly Denford', '(205) 2322266', 'tdenford39@drupal.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Kissie Suscens', '(418) 4293093', 'ksuscens3a@unicef.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Ursala Leeburne', '(731) 9887036', 'uleeburne3b@oracle.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Druci Brisco', '(744) 5203038', 'dbrisco3c@prlog.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Armstrong Shoutt', '(279) 7264794', 'ashoutt3d@uiuc.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Nickolaus Crucitti', '(922) 2320091', 'ncrucitti3e@fastcompany.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Kirk Gerhold', '(991) 5607127', 'kgerhold3f@ihg.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Antonietta Basilotta', '(484) 7252762', 'abasilotta3g@jigsy.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Byrann Storrier', '(222) 8975314', 'bstorrier3h@gmpg.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Gaye Garrard', '(825) 6114784', 'ggarrard3i@1und1.de');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Sharon Goreisr', '(824) 9167242', 'sgoreisr3j@4shared.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Gerianna Bouch', '(923) 7823098', 'gbouch3k@soup.io');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Theodoric Okroy', '(481) 8470981', 'tokroy3l@bbc.co.uk');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Ramona Kitchingman', '(325) 7238044', 'rkitchingman3m@list-manage.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Rubie Orme', '(299) 1461478', 'rorme3n@123-reg.co.uk');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Valaree Edwicke', '(696) 8751175', 'vedwicke3o@unblog.fr');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Ginger Gouth', '(786) 1593908', 'ggouth3p@youtube.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Mercedes O''Scannill', '(606) 5525079', 'moscannill3q@typepad.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Johnny Casse', '(192) 6885044', 'jcasse3r@imgur.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Courtnay Chaperlin', '(771) 2700955', 'cchaperlin3s@elpais.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Richart Block', '(817) 8642365', 'rblock3t@amazon.co.uk');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Pascale Prydden', '(518) 3626673', 'pprydden3u@nationalgeographic.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Lindsay Antognetti', '(176) 7721333', 'lantognetti3v@zdnet.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Ashla Oliveira', '(861) 9353197', 'aoliveira3w@wordpress.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Hannah Berrow', '(385) 6397800', 'hberrow3x@eepurl.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Ludwig McEwan', '(940) 7413656', 'lmcewan3y@wikispaces.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Minnnie Beckwith', '(350) 6898397', 'mbeckwith3z@ft.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Mufi Rintoul', '(402) 7693782', 'mrintoul40@mlb.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Rustin Eaken', '(258) 8257146', 'reaken41@cornell.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Sydney Buddleigh', '(416) 2178777', 'sbuddleigh42@about.me');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Lanie Aries', '(100) 2485558', 'laries43@upenn.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Kirstyn Lammerich', '(302) 7765491', 'klammerich44@hao123.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Edna Losseljong', '(619) 5096936', 'elosseljong45@google.pl');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Armando Tillot', '(445) 7450532', 'atillot46@accuweather.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Gwyneth Beaushaw', '(999) 5198259', 'gbeaushaw47@yelp.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Danice Matveyev', '(996) 9286495', 'dmatveyev48@xinhuanet.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Benetta Trice', '(862) 2901802', 'btrice49@1und1.de');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Raquel Brasner', '(967) 7118197', 'rbrasner4a@oakley.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Sheffie Lyburn', '(634) 5544715', 'slyburn4b@google.it');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Denis Elvin', '(434) 3482541', 'delvin4c@mlb.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Seamus Dawkes', '(336) 2538228', 'sdawkes4d@mit.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Rutherford Sowrah', '(972) 9397411', 'rsowrah4e@multiply.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Vinita McLagan', '(587) 9346103', 'vmclagan4f@canalblog.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Judas Menary', '(342) 1631604', 'jmenary4g@wunderground.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Fairleigh Elms', '(498) 5930689', 'felms4h@google.com.br');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Maryrose Tukely', '(131) 3766928', 'mtukely4i@omniture.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Juliette Schuricke', '(491) 8132222', 'jschuricke4j@usda.gov');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Claudius Phizackarley', '(291) 4508335', 'cphizackarley4k@sina.com.cn');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Gearard Semmence', '(485) 1626395', 'gsemmence4l@theglobeandmail.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Renard Pounder', '(625) 3102682', 'rpounder4m@dailymotion.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Willi Igonet', '(296) 6258183', 'wigonet4n@t-online.de');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Aurea Roggers', '(281) 4947074', 'aroggers4o@unesco.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Vivia Dunlop', '(426) 5687017', 'vdunlop4p@gizmodo.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Ximenez Mieville', '(658) 7379762', 'xmieville4q@canalblog.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Marchelle Vennart', '(173) 4741678', 'mvennart4r@bigcartel.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Atlanta Van Arsdall', '(175) 4029858', 'avan4s@free.fr');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Brook Cogger', '(336) 1397257', 'bcogger4t@blogger.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Alistair Ducaen', '(377) 5143169', 'aducaen4u@msn.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Christie Gulston', '(518) 8995820', 'cgulston4v@squarespace.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Clem Sollowaye', '(530) 5344492', 'csollowaye4w@jugem.jp');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Raina Mcmanaman', '(801) 8462978', 'rmcmanaman4x@fema.gov');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Sianna Groucock', '(877) 7431339', 'sgroucock4y@ebay.co.uk');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Aila Trowill', '(667) 5270034', 'atrowill4z@plala.or.jp');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Don Antoinet', '(949) 4861440', 'dantoinet50@google.it');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Minerva Scardafield', '(696) 8502408', 'mscardafield51@mtv.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Electra Scraggs', '(877) 3625316', 'escraggs52@de.vu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Gregorius Bacup', '(817) 3735661', 'gbacup53@pinterest.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Madalyn Oliveira', '(434) 9075213', 'moliveira54@wordpress.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Carree Sherreard', '(967) 3202355', 'csherreard55@prnewswire.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Doro Lambshine', '(607) 3740892', 'dlambshine56@geocities.jp');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Camile Shekle', '(176) 1705909', 'cshekle57@pen.io');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Kalila Disley', '(451) 1475320', 'kdisley58@gravatar.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Viola Rattery', '(116) 1205360', 'vrattery59@guardian.co.uk');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Lainey Castanone', '(865) 6950070', 'lcastanone5a@360.cn');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Candice Belvard', '(398) 8951584', 'cbelvard5b@moonfruit.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Nicky O''Doherty', '(457) 2114949', 'nodoherty5c@patch.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Fletcher Andress', '(444) 5485980', 'fandress5d@vkontakte.ru');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Dania Teliga', '(344) 3447527', 'dteliga5e@tamu.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Auroora Meake', '(378) 7520227', 'ameake5f@earthlink.net');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Sim Steinor', '(693) 9314117', 'ssteinor5g@yelp.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Bernie Kenright', '(433) 6117362', 'bkenright5h@bizjournals.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Dugald Spellard', '(930) 6632441', 'dspellard5i@multiply.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Ronny Bailes', '(119) 4423867', 'rbailes5j@senate.gov');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Aubrie Jardin', '(890) 7929552', 'ajardin5k@reuters.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Bertine Accombe', '(499) 2922233', 'baccombe5l@wiley.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Aurlie Starbuck', '(533) 1939142', 'astarbuck5m@craigslist.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Wilow Boulder', '(505) 7366412', 'wboulder5n@fda.gov');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Dalli Puckey', '(854) 6993404', 'dpuckey5o@cornell.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Deeanne Guillford', '(298) 3510424', 'dguillford5p@mapy.cz');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Nariko Wilding', '(843) 7149650', 'nwilding5q@edublogs.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Abdel Fisbey', '(803) 4693976', 'afisbey5r@ft.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Monty Coventry', '(510) 9884449', 'mcoventry5s@un.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Inna Pain', '(892) 1661891', 'ipain5t@fc2.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Catharina Espinazo', '(125) 7560677', 'cespinazo5u@ihg.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Benton Pleace', '(344) 4581028', 'bpleace5v@java.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Ferrel Gerretsen', '(735) 5104990', 'fgerretsen5w@twitter.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Kylynn Thwaite', '(423) 1261413', 'kthwaite5x@weebly.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Uta Guillerman', '(959) 9277765', 'uguillerman5y@nationalgeographic.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Iggie Braemer', '(796) 4674865', 'ibraemer5z@wix.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Deonne Breffitt', '(422) 8907354', 'dbreffitt60@plala.or.jp');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Katleen Giabucci', '(471) 2453996', 'kgiabucci61@wufoo.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Mikel Guiducci', '(688) 5174605', 'mguiducci62@t-online.de');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Care Astell', '(403) 1867556', 'castell63@auda.org.au');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Andreana McGuiney', '(118) 8698587', 'amcguiney64@pcworld.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Katusha Basnall', '(232) 6427112', 'kbasnall65@fotki.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Marcela McBrearty', '(327) 2493550', 'mmcbrearty66@sina.com.cn');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Billy Meddemmen', '(257) 4345639', 'bmeddemmen67@dropbox.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Nevins Goodreid', '(292) 8794504', 'ngoodreid68@rediff.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'June Alwin', '(951) 5108717', 'jalwin69@skype.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Darice Smallwood', '(435) 4350325', 'dsmallwood6a@sourceforge.net');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Henka Yakunkin', '(469) 9414489', 'hyakunkin6b@cdbaby.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Carolin Banbrick', '(509) 6182785', 'cbanbrick6c@accuweather.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Lela Twittey', '(515) 3196452', 'ltwittey6d@freewebs.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Sybilla Merton', '(260) 2377749', 'smerton6e@wikimedia.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Carmen Burdikin', '(339) 4714176', 'cburdikin6f@theglobeandmail.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Scotty Lindberg', '(895) 2280698', 'slindberg6g@wisc.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Teriann Rigts', '(687) 2611878', 'trigts6h@tiny.cc');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Tadd Stonestreet', '(917) 7949784', 'tstonestreet6i@slashdot.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Nannette Vasyunichev', '(482) 1758885', 'nvasyunichev6j@moonfruit.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Roxi Pautard', '(523) 6028755', 'rpautard6k@stanford.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Jerrold Galgey', '(580) 2575152', 'jgalgey6l@multiply.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Rennie Stockings', '(997) 7024867', 'rstockings6m@fema.gov');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Edi Basindale', '(442) 6154524', 'ebasindale6n@parallels.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Eldin Portt', '(380) 6609758', 'eportt6o@techcrunch.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Fulton Ipwell', '(690) 8128259', 'fipwell6p@mozilla.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Cristine Yeardley', '(289) 8728156', 'cyeardley6q@github.io');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Barny Boerderman', '(877) 4060099', 'bboerderman6r@51.la');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Meryl Denyer', '(428) 7551072', 'mdenyer6s@techcrunch.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Ase Rash', '(180) 9071918', 'arash6t@rambler.ru');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Roddie Claus', '(186) 4404869', 'rclaus6u@imgur.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Laural Andreassen', '(657) 7820719', 'landreassen6v@behance.net');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Prent Bail', '(108) 1049823', 'pbail6w@independent.co.uk');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Dita Swaile', '(426) 7310748', 'dswaile6x@diigo.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Maurizia Rayson', '(577) 3192690', 'mrayson6y@irs.gov');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Dahlia Smorthit', '(534) 4540713', 'dsmorthit6z@cargocollective.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Martainn Varren', '(540) 2517066', 'mvarren70@unesco.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Sheena Vokes', '(138) 8393925', 'svokes71@icio.us');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Darnall Bulfoy', '(383) 2831909', 'dbulfoy72@i2i.jp');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Ronda Merrison', '(563) 8489595', 'rmerrison73@nature.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Merci Kinmond', '(675) 2189256', 'mkinmond74@engadget.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Sydney Evenden', '(560) 1116611', 'sevenden75@istockphoto.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Hurley MacDuff', '(224) 8007908', 'hmacduff76@xrea.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'York GiacobbiniJacob', '(152) 1041488', 'ygiacobbinijacob77@addthis.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Wilmer Welling', '(464) 6681214', 'wwelling78@bbb.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Ketty Diess', '(773) 6408813', 'kdiess79@instagram.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Farlie Perrelli', '(344) 6013191', 'fperrelli7a@nyu.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Casey Arter', '(834) 6292030', 'carter7b@businesswire.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Meir Skeleton', '(395) 9547252', 'mskeleton7c@ucsd.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Adriaens Felipe', '(949) 7814898', 'afelipe7d@ted.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Bald Leates', '(309) 5817591', 'bleates7e@cmu.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Eirena Seivwright', '(382) 7573615', 'eseivwright7f@creativecommons.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Adrian Leith-Harvey', '(137) 5325220', 'aleithharvey7g@tripod.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Shelba O''Cannon', '(892) 7050983', 'socannon7h@jalbum.net');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Marylou Widmoor', '(475) 8636949', 'mwidmoor7i@woothemes.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Nicky Boneham', '(561) 4954033', 'nboneham7j@loc.gov');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Drucy Tardiff', '(462) 6186718', 'dtardiff7k@chron.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Trefor Wragg', '(821) 4721620', 'twragg7l@gnu.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Pernell Peaddie', '(952) 5306530', 'ppeaddie7m@cdc.gov');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Pegeen Askaw', '(158) 5764892', 'paskaw7n@umn.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Augusta Nourse', '(974) 8834445', 'anourse7o@merriam-webster.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Stefanie Gotthard.sf', '(553) 5595094', 'sgotthardsf7p@epa.gov');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Noah Childerhouse', '(146) 7374140', 'nchilderhouse7q@odnoklassniki.ru');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Theodor Amphlett', '(242) 1626183', 'tamphlett7r@mapy.cz');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Reube Matusov', '(311) 2060022', 'rmatusov7s@netlog.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Mathias Hugnet', '(925) 1533773', 'mhugnet7t@chronoengine.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Karel Edson', '(213) 7242806', 'kedson7u@163.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Daren Wrenn', '(338) 4313988', 'dwrenn7v@bing.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Pancho Adam', '(869) 3889344', 'padam7w@archive.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Daisie Arnout', '(515) 1107170', 'darnout7x@indiegogo.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Tadeo Iacovaccio', '(373) 6117895', 'tiacovaccio7y@nasa.gov');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Gwendolyn Babon', '(700) 2839339', 'gbabon7z@discuz.net');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Valma Janosevic', '(485) 8527902', 'vjanosevic80@businessweek.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Evelyn Egger', '(365) 8227728', 'eegger81@ovh.net');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Sascha Giacomazzo', '(255) 7980202', 'sgiacomazzo82@hostgator.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Darell McAvaddy', '(270) 7778271', 'dmcavaddy83@chron.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Judah Tattam', '(763) 1769877', 'jtattam84@ask.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Reginald Blade', '(285) 8398958', 'rblade85@networksolutions.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Everard Barwick', '(489) 9544897', 'ebarwick86@lulu.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Davey Craythorne', '(903) 8367324', 'dcraythorne87@youku.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Adams Tomashov', '(214) 7425037', 'atomashov88@shop-pro.jp');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Freddi Oxe', '(755) 5045477', 'foxe89@hibu.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Karoline Dominighi', '(757) 4127328', 'kdominighi8a@51.la');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Thane Jakoviljevic', '(495) 3551729', 'tjakoviljevic8b@jugem.jp');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Antonie Duckering', '(180) 4891079', 'aduckering8c@squarespace.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Berty Mc Cahey', '(583) 7918381', 'bmc8d@home.pl');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Skipton Henricsson', '(724) 4776362', 'shenricsson8e@goodreads.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Daniel Guswell', '(463) 3266320', 'dguswell8f@blogtalkradio.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Zulema Kettlestringe', '(837) 9921077', 'zkettlestringe8g@usatoday.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Frankie Grinaway', '(202) 8543125', 'fgrinaway8h@sogou.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Angelico Kupec', '(405) 8650019', 'akupec8i@theguardian.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Ximenes Sharphouse', '(723) 6242745', 'xsharphouse8j@typepad.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Patsy Joules', '(818) 3020552', 'pjoules8k@addtoany.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Alfreda Wolfers', '(229) 1524211', 'awolfers8l@msu.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Margaret Gasson', '(177) 1749114', 'mgasson8m@google.ru');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Derrek Hortop', '(942) 6538242', 'dhortop8n@reverbnation.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Kaitlin Cartwright', '(882) 1310564', 'kcartwright8o@theatlantic.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Moria Donnett', '(809) 7586546', 'mdonnett8p@digg.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Debora Capon', '(199) 4246370', 'dcapon8q@usa.gov');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Moselle Lacotte', '(916) 8039730', 'mlacotte8r@t-online.de');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Kettie Stavers', '(602) 2607632', 'kstavers8s@sciencedirect.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Rodrigo Cashen', '(537) 8406492', 'rcashen8t@storify.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Elsey Ebbens', '(418) 7664563', 'eebbens8u@nih.gov');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Brandyn Grassick', '(356) 6795686', 'bgrassick8v@purevolume.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Quill Malby', '(802) 6767539', 'qmalby8w@ezinearticles.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Valerie Blackstock', '(995) 1882920', 'vblackstock8x@delicious.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Chicky Tessier', '(865) 8643852', 'ctessier8y@studiopress.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Buddie Klimp', '(837) 9309472', 'bklimp8z@wikispaces.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Marlon Kayser', '(449) 1755423', 'mkayser90@youtube.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Berri Gromley', '(242) 4948939', 'bgromley91@accuweather.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Juline Govern', '(990) 8758152', 'jgovern92@mail.ru');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Flory Iglesia', '(518) 7665570', 'figlesia93@mtv.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Gretna Popham', '(724) 8395153', 'gpopham94@symantec.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Marianne Anton', '(852) 3214648', 'manton95@is.gd');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Dedra Pratchett', '(761) 1950125', 'dpratchett96@geocities.jp');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Haskel Matskiv', '(440) 1100397', 'hmatskiv97@mit.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Kiley Kaemena', '(600) 6063422', 'kkaemena98@marriott.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Raynell Cotty', '(353) 8706687', 'rcotty99@flavors.me');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Curcio Saipy', '(695) 5873755', 'csaipy9a@hc360.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Wright Tokell', '(787) 9581271', 'wtokell9b@microsoft.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Haley Coughlan', '(643) 2918630', 'hcoughlan9c@pagesperso-orange.fr');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Cate Chantree', '(987) 7576436', 'cchantree9d@msn.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Rickert Kirimaa', '(648) 4261545', 'rkirimaa9e@drupal.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Malinda Harrower', '(367) 4527263', 'mharrower9f@i2i.jp');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Missy Boagey', '(896) 5829340', 'mboagey9g@blogtalkradio.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Eveline Phlippi', '(599) 8871507', 'ephlippi9h@ebay.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Elnora Cogar', '(661) 6012415', 'ecogar9i@dailymotion.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Claudian De Lascy', '(264) 8487548', 'cde9j@jugem.jp');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Mohandis Jewson', '(420) 3338254', 'mjewson9k@fastcompany.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Danila Cowie', '(942) 6977427', 'dcowie9l@fda.gov');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Linnea Durbin', '(340) 1000953', 'ldurbin9m@google.com.hk');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Ramsey Penwarden', '(948) 2454481', 'rpenwarden9n@paypal.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Ripley Jacquemot', '(918) 8230770', 'rjacquemot9o@geocities.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Emma Denley', '(729) 1876357', 'edenley9p@skyrock.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Waring Ropars', '(394) 6344081', 'wropars9q@dedecms.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Debee Issacoff', '(310) 8586374', 'dissacoff9r@engadget.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Adara Jerams', '(630) 4055232', 'ajerams9s@wordpress.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Noland McCullough', '(374) 6269730', 'nmccullough9t@dion.ne.jp');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Zsa zsa De Bernardis', '(482) 9538797', 'zzsa9u@storify.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Lucinda Farnham', '(600) 4410952', 'lfarnham9v@sciencedirect.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Vernice Royse', '(894) 6896886', 'vroyse9w@is.gd');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Janeczka Deroche', '(444) 7040199', 'jderoche9x@w3.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Gus Peterken', '(646) 2492661', 'gpeterken9y@squidoo.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Janice Russam', '(143) 4704906', 'jrussam9z@desdev.cn');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Jimmy Fausset', '(362) 1787960', 'jfausseta0@de.vu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Elisha Tarbard', '(912) 1441557', 'etarbarda1@meetup.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Emelda Fawson', '(507) 6388454', 'efawsona2@bizjournals.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Jeannie Faucherand', '(767) 2272748', 'jfaucheranda3@yelp.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Bette Lempel', '(189) 2105704', 'blempela4@buzzfeed.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Katti Butteris', '(749) 3106793', 'kbutterisa5@topsy.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Rufe Judkins', '(672) 5307347', 'rjudkinsa6@angelfire.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Corinna Latchmore', '(489) 8818240', 'clatchmorea7@facebook.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Lorine Edeson', '(125) 7124845', 'ledesona8@ning.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Justina Dedon', '(527) 7656823', 'jdedona9@google.nl');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Maren Brownhall', '(784) 6494014', 'mbrownhallaa@un.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Courtney Crossgrove', '(802) 7847990', 'ccrossgroveab@toplist.cz');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Ambrosio McNeil', '(301) 3551095', 'amcneilac@istockphoto.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Nathanial Seabrocke', '(941) 1463382', 'nseabrockead@engadget.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Antonio Kippin', '(229) 3381750', 'akippinae@csmonitor.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Harley Fromont', '(180) 3013228', 'hfromontaf@japanpost.jp');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Allyn Tuminini', '(999) 6925923', 'atumininiag@examiner.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Delilah Bettaney', '(108) 2995855', 'dbettaneyah@scribd.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Aldous Atty', '(418) 1400384', 'aattyai@lulu.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Shelbi Hartwell', '(286) 9072131', 'shartwellaj@pen.io');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Grissel Antoniottii', '(222) 4740444', 'gantoniottiiak@t-online.de');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Jaquelyn Vasilic', '(455) 3913560', 'jvasilical@jugem.jp');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Merrie Goering', '(875) 2692364', 'mgoeringam@rakuten.co.jp');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Mariele Pedroli', '(481) 2117185', 'mpedrolian@wikimedia.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Damon Shemmans', '(852) 1204343', 'dshemmansao@prlog.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Britni Haigh', '(232) 1711931', 'bhaighap@dion.ne.jp');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Raffarty Walkey', '(964) 3880963', 'rwalkeyaq@indiatimes.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Emelyne Springer', '(946) 2391562', 'espringerar@hugedomains.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Gabriell Hicklingbottom', '(605) 5318553', 'ghicklingbottomas@lycos.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Connor Smethurst', '(320) 3523674', 'csmethurstat@digg.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Pearla Utterson', '(894) 1126332', 'puttersonau@webs.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Algernon Maycey', '(277) 3364916', 'amayceyav@tumblr.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Allyn Lyle', '(279) 9319994', 'alyleaw@indiatimes.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Timmie Pietruszewicz', '(224) 1692548', 'tpietruszewiczax@ustream.tv');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Mathew Reeday', '(158) 9096707', 'mreedayay@blog.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Angelo Mc Carrick', '(518) 9714846', 'amcaz@cbsnews.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Lita Colnet', '(117) 1599805', 'lcolnetb0@hud.gov');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Lemmie Rhoddie', '(982) 9280445', 'lrhoddieb1@photobucket.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Devina Woolveridge', '(796) 7219396', 'dwoolveridgeb2@scribd.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Liz Wickstead', '(831) 6836980', 'lwicksteadb3@cargocollective.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Amelina Growy', '(434) 6356444', 'agrowyb4@php.net');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Lorine Callow', '(649) 8001120', 'lcallowb5@wsj.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Wilburt Jeffries', '(914) 7684557', 'wjeffriesb6@apache.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Clea Beals', '(630) 7057354', 'cbealsb7@etsy.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Gunar Lytton', '(922) 8331791', 'glyttonb8@pinterest.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Clarke Cocozza', '(882) 9529538', 'ccocozzab9@stanford.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Malvin Pickrill', '(720) 6211119', 'mpickrillba@ehow.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Ansel Sinclaire', '(960) 1141294', 'asinclairebb@live.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Morena Dutch', '(675) 5922292', 'mdutchbc@seattletimes.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Bernelle Addinall', '(821) 3039108', 'baddinallbd@oakley.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Toby Fyall', '(366) 9840260', 'tfyallbe@cdbaby.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Eddi Trudgion', '(355) 2980228', 'etrudgionbf@google.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Agretha D''Alesco', '(687) 4512754', 'adalescobg@unc.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Madel Pharro', '(717) 4186051', 'mpharrobh@ftc.gov');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Reinaldos Farge', '(268) 9060198', 'rfargebi@facebook.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Kaylil Lambole', '(833) 7588523', 'klambolebj@netscape.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Alonzo Ellaway', '(642) 9263094', 'aellawaybk@123-reg.co.uk');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Henri Busse', '(655) 8444883', 'hbussebl@trellian.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Fonsie Sketch', '(587) 9851725', 'fsketchbm@is.gd');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Elspeth Norrie', '(181) 7873814', 'enorriebn@desdev.cn');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Danielle Boosey', '(998) 8547146', 'dbooseybo@cmu.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Wally Phettis', '(284) 8614371', 'wphettisbp@shareasale.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Dosi Champney', '(712) 5593841', 'dchampneybq@technorati.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Torey Sidney', '(472) 1347834', 'tsidneybr@uiuc.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Lay Caron', '(758) 4598138', 'lcaronbs@linkedin.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Merola Kencott', '(540) 4021472', 'mkencottbt@paginegialle.it');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Karol Bambery', '(358) 6029337', 'kbamberybu@phoca.cz');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Burt Deverock', '(175) 2987944', 'bdeverockbv@instagram.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Rinaldo Dutteridge', '(770) 9935611', 'rdutteridgebw@taobao.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Felicia Balogun', '(280) 8531138', 'fbalogunbx@clickbank.net');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Wileen Thal', '(110) 1394760', 'wthalby@delicious.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Tim Olivet', '(502) 1904517', 'tolivetbz@ft.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Carlota Burdett', '(151) 2056597', 'cburdettc0@youku.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Robyn Calan', '(981) 7933243', 'rcalanc1@edublogs.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Neils Keyme', '(578) 2287867', 'nkeymec2@newyorker.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Adelina Tagg', '(195) 7670013', 'ataggc3@pbs.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Chilton Frany', '(702) 3474156', 'cfranyc4@tmall.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Lorne Dickinson', '(165) 6326254', 'ldickinsonc5@zdnet.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Florencia Witheridge', '(818) 9294814', 'fwitheridgec6@thetimes.co.uk');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Ed Bradnock', '(769) 3844001', 'ebradnockc7@independent.co.uk');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Fabien Philimore', '(906) 4310558', 'fphilimorec8@creativecommons.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Gladys Schollick', '(347) 5387041', 'gschollickc9@dagondesign.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Xenos Maggs', '(445) 4508615', 'xmaggsca@zimbio.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Prentiss Iiannoni', '(470) 4978760', 'piiannonicb@prlog.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Jourdan Jarman', '(588) 9685076', 'jjarmancc@craigslist.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Christian Mullineux', '(922) 7508654', 'cmullineuxcd@vinaora.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Kev Vater', '(370) 4738762', 'kvaterce@cnet.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Salomi Louw', '(309) 8272665', 'slouwcf@artisteer.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Griffith Tarborn', '(547) 1952716', 'gtarborncg@ycombinator.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Boote Videan', '(465) 8426032', 'bvideanch@paginegialle.it');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Cheryl Trace', '(728) 4628956', 'ctraceci@addthis.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Nike Tapton', '(757) 4276884', 'ntaptoncj@mlb.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Rustin Bonniface', '(276) 9152089', 'rbonnifaceck@wikimedia.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Sonya McVey', '(583) 2011598', 'smcveycl@ning.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Nap Ketch', '(394) 9576378', 'nketchcm@indiegogo.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Dimitri Stookes', '(326) 7570238', 'dstookescn@bravesites.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Imogen Geharke', '(782) 8795453', 'igeharkeco@usgs.gov');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Nikolaus Wenzel', '(413) 1504938', 'nwenzelcp@google.ca');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Carine Duffil', '(683) 7024583', 'cduffilcq@bbb.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Katherina Blundel', '(323) 9037796', 'kblundelcr@nbcnews.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Neddy Jurczak', '(999) 5495203', 'njurczakcs@liveinternet.ru');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Bay Teers', '(736) 4658175', 'bteersct@clickbank.net');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Angelo Vizard', '(194) 1528218', 'avizardcu@e-recht24.de');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Godfry Castellino', '(125) 7780307', 'gcastellinocv@cbsnews.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Alyosha Jellard', '(550) 7729714', 'ajellardcw@aboutads.info');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Candi McTaggart', '(229) 7481011', 'cmctaggartcx@google.co.jp');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Waly Samuel', '(234) 9982387', 'wsamuelcy@de.vu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Kellby Derdes', '(421) 6798479', 'kderdescz@va.gov');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Gaven Rosenkrantz', '(314) 1466207', 'grosenkrantzd0@webnode.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Joline Hurt', '(530) 7152588', 'jhurtd1@moonfruit.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Arlin Canny', '(847) 8032002', 'acannyd2@comcast.net');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Rivi Amorts', '(298) 7970324', 'ramortsd3@bizjournals.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Bendix Bleasby', '(698) 9149200', 'bbleasbyd4@ox.ac.uk');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Leonelle Ragbourn', '(603) 2035954', 'lragbournd5@examiner.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Esmeralda O''Scollee', '(773) 7668023', 'eoscolleed6@vimeo.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Katalin Graeber', '(542) 8615512', 'kgraeberd7@prlog.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Rossie Marling', '(237) 3354858', 'rmarlingd8@posterous.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Lesli Wantling', '(327) 7713471', 'lwantlingd9@skype.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Janka Waterhouse', '(214) 6542394', 'jwaterhouseda@imdb.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'North Jeaneau', '(925) 7969522', 'njeaneaudb@ibm.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Wendy Preddle', '(829) 7005806', 'wpreddledc@nyu.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Frasier Hucklesby', '(643) 9534222', 'fhucklesbydd@themeforest.net');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Al Benettolo', '(454) 6900884', 'abenettolode@whitehouse.gov');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Rosalinde Krause', '(115) 3925671', 'rkrausedf@salon.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Malinde England', '(786) 2069909', 'menglanddg@dyndns.org');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Phaedra Cowderoy', '(920) 1702698', 'pcowderoydh@chicagotribune.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Lindy Pudner', '(162) 7428292', 'lpudnerdi@yellowpages.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Evangeline Cordsen', '(814) 1502913', 'ecordsendj@php.net');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Halsey Juschke', '(893) 8032802', 'hjuschkedk@xrea.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Tim Marcome', '(190) 4071446', 'tmarcomedl@blog.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Lira Swaddle', '(261) 1789934', 'lswaddledm@msu.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Lucienne Farrears', '(646) 9743402', 'lfarrearsdn@smh.com.au');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Eddie Menezes', '(500) 7654072', 'emenezesdo@yale.edu');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Aubrette Yekel', '(276) 9885037', 'ayekeldp@google.it');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Jan Bryning', '(519) 8323065', 'jbryningdq@cafepress.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Anette O''Mullally', '(889) 4189089', 'aomullallydr@aol.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Moishe Richardsson', '(676) 9328438', 'mrichardssonds@networksolutions.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (2, 'Katlin Gabbatt', '(786) 6597662', 'kgabbattdt@trellian.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (3, 'Laurence Simonson', '(750) 4633132', 'lsimonsondu@sohu.com');
insert into Customers (Type_ID, Contact_Name, Phone_Number, Email) values (1, 'Darla Lambertz', '(406) 4626238', 'dlambertzdv@sfgate.com');


-----------Insert Orders Table--------------------------------------------

INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(100,' 484','7252939','1','2019-05-15');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(101,' 81','9585301','2','2019-01-12');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(102,' 340','5894565','3','2020-04-25');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(103,' 219','8273795','3','2018-12-15');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(104,' 191','6290280','3','2019-10-19');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(105,' 338','6183835','2','2020-08-06');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(106,' 268','5635583','3','2019-09-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(107,' 108','2238453','1','2020-04-06');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(108,' 245','2722641','3','2019-01-06');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(109,' 107','5635583','4','2020-08-25');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(110,' 281','7183069','1','2020-07-15');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(111,' 273','3775413','1','2020-09-01');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(112,' 335','6183835','1','2019-04-24');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(113,' 376','7220969','1','2019-10-01');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(114,' 244','8273795','4','2020-03-02');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(115,' 271','7183069','3','2019-02-15');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(116,' 488','7252939','1','2019-03-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(117,' 252','9585301','3','2020-01-18');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(118,' 453','5635583','2','2019-02-17');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(119,' 233','5894565','2','2020-07-07');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(120,' 54','2557362','4','2019-03-13');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(121,' 348','5635583','4','2020-11-03');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(122,' 331','5894565','4','2019-09-15');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(123,' 42','9469107','4','2020-04-27');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(124,' 384','2722641','1','2019-05-30');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(125,' 452','2557362','3','2020-08-09');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(126,' 230','8273795','4','2020-03-05');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(127,' 258','6290280','2','2020-05-17');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(128,' 358','7220969','4','2020-03-01');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(129,' 296','2238453','1','2018-12-20');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(130,' 261','9469107','1','2020-03-11');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(131,' 22','7449234','4','2018-11-20');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(132,' 212','2557362','3','2018-11-23');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(133,' 65','6290280','1','2020-02-25');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(134,' 266','6936499','1','2019-03-07');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(135,' 232','7252939','2','2020-05-25');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(136,' 497','3775413','1','2019-07-12');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(137,' 26','7252939','4','2020-05-28');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(138,' 121','6653876','2','2018-12-01');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(139,' 328','9469107','1','2020-06-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(140,' 15','5635583','1','2020-10-27');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(141,' 237','6290280','2','2020-11-06');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(142,' 464','7183069','2','2020-05-11');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(143,' 367','5894565','3','2018-11-14');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(144,' 299','5894565','2','2019-05-07');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(145,' 224','5334556','4','2019-12-04');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(146,' 96','7220969','1','2020-05-12');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(147,' 76','6183835','2','2019-11-15');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(148,' 66','2722641','4','2018-12-18');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(149,' 498','5635583','4','2019-12-06');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(150,' 289','7183069','4','2018-11-13');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(151,' 180','7183069','3','2020-07-18');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(152,' 427','6183835','2','2018-12-15');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(153,' 329','7183069','3','2019-03-19');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(154,' 184','2238453','3','2019-09-03');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(155,' 326','3775413','3','2020-06-26');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(156,' 267','3775413','3','2019-10-12');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(157,' 351','8273795','1','2020-09-30');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(158,' 338','8273795','1','2019-06-22');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(159,' 49','5894565','1','2020-10-26');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(160,' 61','7220969','2','2020-10-15');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(161,' 154','8273795','3','2020-03-26');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(162,' 161','9469107','3','2019-08-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(163,' 498','9469107','1','2018-12-09');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(164,' 495','3775413','4','2020-10-29');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(165,' 131','2557362','1','2020-03-09');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(166,' 14','6936499','4','2020-07-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(167,' 31','6653876','3','2020-03-15');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(168,' 425','7183069','1','2019-02-19');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(169,' 470','6936499','2','2019-10-27');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(170,' 355','2722641','4','2020-03-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(171,' 202','5894565','2','2020-01-31');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(172,' 256','5894565','1','2019-04-25');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(173,' 86','5894565','2','2020-03-30');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(174,' 263','6653876','2','2020-08-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(175,' 98','7220969','4','2020-09-08');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(176,' 62','7252939','4','2020-04-13');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(177,' 63','8273795','3','2019-05-05');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(178,' 168','7449234','3','2018-12-31');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(179,' 225','6653876','2','2019-01-11');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(180,' 443','6653876','4','2020-05-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(181,' 180','7183069','1','2019-02-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(182,' 243','3775413','2','2019-05-30');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(183,' 69','5334556','1','2020-03-08');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(184,' 133','7449234','2','2020-10-28');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(185,' 181','7183069','3','2019-08-08');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(186,' 355','9469107','4','2020-10-26');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(187,' 182','5334556','4','2019-10-23');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(188,' 118','6936499','2','2020-06-10');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(189,' 113','8273795','4','2020-03-15');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(190,' 179','7220969','3','2019-06-12');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(191,' 56','3775413','3','2020-05-17');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(192,' 228','2557362','1','2019-06-11');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(193,' 397','2238453','2','2019-03-06');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(194,' 61','9585301','4','2020-03-03');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(195,' 222','2238453','1','2019-01-16');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(196,' 254','2238453','3','2019-03-06');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(197,' 307','9469107','4','2020-06-07');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(198,' 456','5334556','4','2020-09-15');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(199,' 75','7183069','2','2020-08-30');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(200,' 21','6183835','4','2018-12-13');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(201,' 58','6653876','3','2020-09-19');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(202,' 322','5635583','2','2020-09-22');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(203,' 426','2238453','3','2019-07-05');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(204,' 145','6183835','2','2020-05-12');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(205,' 378','2722641','4','2019-05-30');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(206,' 56','7220969','3','2019-11-14');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(207,' 277','5894565','4','2019-10-13');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(208,' 300','7449234','2','2019-10-14');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(209,' 230','6183835','2','2019-10-06');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(210,' 26','6183835','4','2020-10-31');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(211,' 419','7183069','3','2019-10-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(212,' 320','7449234','1','2020-10-09');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(213,' 243','2722641','2','2019-05-09');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(214,' 361','7183069','4','2019-11-26');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(215,' 416','3775413','3','2019-03-08');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(216,' 399','2238453','3','2019-08-28');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(217,' 3','7252939','1','2019-08-10');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(218,' 191','5894565','2','2019-12-20');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(219,' 286','2238453','2','2018-11-28');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(220,' 210','3775413','2','2019-08-17');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(221,' 378','6290280','1','2020-07-26');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(222,' 199','6290280','4','2019-07-12');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(223,' 466','5334556','1','2020-03-01');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(224,' 115','3775413','3','2019-03-15');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(225,' 121','6183835','1','2020-05-12');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(226,' 133','8273795','3','2020-11-02');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(227,' 486','7220969','1','2019-04-26');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(228,' 168','5334556','3','2019-12-10');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(229,' 287','9469107','2','2019-07-24');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(230,' 480','7449234','2','2020-08-31');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(231,' 461','6183835','3','2018-12-03');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(232,' 101','6936499','1','2019-01-30');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(233,' 356','5334556','3','2020-06-10');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(234,' 233','5894565','2','2019-06-01');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(235,' 302','3775413','1','2020-06-07');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(236,' 267','5894565','4','2020-05-03');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(237,' 311','2238453','1','2020-10-10');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(238,' 311','9469107','1','2019-08-13');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(239,' 167','6183835','3','2019-08-10');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(240,' 91','7220969','3','2020-06-24');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(241,' 387','7183069','4','2020-06-11');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(242,' 321','5635583','1','2020-05-09');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(243,' 62','2238453','3','2019-02-18');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(244,' 126','2238453','4','2019-07-16');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(245,' 492','6936499','3','2019-07-09');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(246,' 145','5334556','2','2020-09-19');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(247,' 408','2238453','3','2018-12-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(248,' 34','5635583','1','2020-09-02');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(249,' 195','6936499','4','2019-04-02');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(250,' 442','6653876','4','2020-03-07');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(251,' 23','7252939','3','2019-01-07');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(252,' 143','2557362','4','2020-05-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(253,' 439','6936499','2','2019-12-23');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(254,' 291','9469107','3','2019-05-11');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(255,' 387','8273795','4','2020-01-02');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(256,' 168','6936499','2','2019-08-28');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(257,' 239','9585301','3','2020-01-15');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(258,' 181','6936499','4','2019-12-15');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(259,' 156','6290280','4','2019-01-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(260,' 94','7449234','4','2019-06-13');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(261,' 434','6183835','1','2020-01-11');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(262,' 166','7252939','1','2020-05-20');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(263,' 414','8273795','3','2019-12-12');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(264,' 105','7449234','4','2019-10-03');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(265,' 119','6653876','1','2020-03-01');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(266,' 476','8273795','2','2020-07-01');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(267,' 482','6290280','1','2020-02-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(268,' 148','2238453','4','2019-01-31');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(269,' 190','2557362','4','2018-12-13');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(270,' 242','2722641','1','2020-09-02');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(271,' 113','9469107','3','2019-07-19');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(272,' 484','5894565','2','2019-05-06');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(273,' 216','5334556','4','2020-08-12');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(274,' 479','3775413','3','2020-10-27');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(275,' 208','6183835','2','2019-10-08');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(276,' 312','7183069','2','2019-07-27');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(277,' 83','2557362','1','2020-09-03');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(278,' 215','5635583','3','2019-08-22');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(279,' 333','5894565','4','2020-04-24');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(280,' 331','6653876','3','2018-11-16');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(281,' 409','5334556','4','2020-10-12');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(282,' 91','7183069','4','2019-04-01');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(283,' 155','6653876','1','2019-09-28');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(284,' 473','2238453','2','2020-01-16');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(285,' 421','2722641','4','2020-01-31');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(286,' 413','5334556','1','2020-04-19');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(287,' 86','2557362','4','2019-03-28');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(288,' 467','5635583','3','2020-05-11');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(289,' 218','2557362','3','2020-08-26');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(290,' 429','6290280','2','2019-05-05');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(291,' 373','9585301','4','2019-09-03');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(292,' 354','7183069','3','2019-11-23');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(293,' 41','6936499','4','2019-06-06');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(294,' 452','6183835','2','2020-02-02');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(295,' 404','6183835','2','2020-01-24');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(296,' 40','6653876','2','2019-09-07');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(297,' 142','6183835','3','2019-04-18');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(298,' 109','7183069','2','2020-03-07');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(299,' 442','6290280','4','2020-03-26');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(300,' 423','9585301','1','2020-01-25');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(301,' 166','6936499','1','2019-09-05');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(302,' 267','5635583','4','2020-04-04');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(303,' 122','5635583','2','2020-04-03');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(304,' 429','5894565','3','2020-09-06');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(305,' 21','5635583','3','2019-11-19');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(306,' 472','2722641','3','2019-06-07');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(307,' 99','6653876','3','2019-08-03');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(308,' 160','8273795','3','2020-07-07');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(309,' 479','7449234','2','2019-12-05');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(310,' 338','7220969','2','2020-04-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(311,' 203','9585301','1','2020-10-19');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(312,' 341','8273795','4','2020-10-22');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(313,' 40','7220969','4','2020-05-06');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(314,' 306','9585301','4','2019-07-25');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(315,' 32','7183069','4','2020-03-30');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(316,' 381','2557362','2','2020-06-26');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(317,' 466','5334556','2','2019-11-09');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(318,' 447','5894565','1','2019-11-28');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(319,' 218','5334556','2','2020-01-11');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(320,' 131','2238453','4','2020-07-09');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(321,' 467','9469107','4','2019-01-09');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(322,' 71','8273795','3','2019-01-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(323,' 354','7220969','1','2019-08-13');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(324,' 495','8273795','2','2019-10-15');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(325,' 265','7252939','2','2019-12-18');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(326,' 399','9469107','1','2019-05-06');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(327,' 199','3775413','3','2020-01-04');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(328,' 41','9469107','3','2020-09-19');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(329,' 286','6183835','3','2020-11-02');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(330,' 406','2557362','3','2018-11-26');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(331,' 71','2722641','4','2019-06-03');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(332,' 302','9585301','1','2020-10-17');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(333,' 413','2722641','1','2020-03-02');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(334,' 417','6183835','2','2020-07-12');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(335,' 314','7183069','2','2019-08-18');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(336,' 177','7183069','3','2019-08-13');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(337,' 11','7449234','3','2019-01-13');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(338,' 92','2557362','1','2018-12-05');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(339,' 200','5334556','2','2020-10-11');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(340,' 84','7183069','2','2020-04-27');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(341,' 30','7449234','4','2019-12-19');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(342,' 340','2557362','2','2020-05-28');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(343,' 249','2557362','1','2019-02-02');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(344,' 269','8273795','1','2020-10-17');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(345,' 28','5635583','2','2020-10-22');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(346,' 43','7220969','4','2019-12-04');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(347,' 493','7449234','3','2019-08-22');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(348,' 467','6183835','1','2020-01-22');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(349,' 397','7183069','4','2020-02-01');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(350,' 281','9585301','4','2020-10-19');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(351,' 197','6653876','4','2020-03-18');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(352,' 57','7449234','2','2019-07-15');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(353,' 296','5334556','2','2019-12-12');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(354,' 117','8273795','1','2019-11-13');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(355,' 225','9585301','4','2019-12-15');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(356,' 151','3775413','4','2019-10-25');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(357,' 465','9469107','3','2019-03-29');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(358,' 250','6653876','4','2020-04-13');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(359,' 284','7183069','3','2019-04-02');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(360,' 98','5894565','4','2020-06-10');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(361,' 111','9469107','3','2020-08-17');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(362,' 308','5894565','3','2019-11-20');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(363,' 150','2557362','3','2019-11-16');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(364,' 458','7449234','1','2020-04-23');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(365,' 406','2557362','3','2019-11-02');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(366,' 284','9585301','4','2020-08-13');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(367,' 470','8273795','3','2019-07-11');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(368,' 325','7252939','4','2020-07-16');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(369,' 454','6290280','1','2019-08-24');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(370,' 272','6936499','4','2020-04-26');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(371,' 369','9585301','3','2020-07-12');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(372,' 357','6653876','4','2020-07-19');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(373,' 362','7252939','1','2019-02-09');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(374,' 15','9585301','3','2020-07-26');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(375,' 312','6653876','4','2020-05-18');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(376,' 279','5334556','1','2020-07-17');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(377,' 272','2557362','1','2020-05-25');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(378,' 316','8273795','4','2020-10-01');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(379,' 359','2238453','1','2020-03-19');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(380,' 161','5894565','2','2019-03-16');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(381,' 385','5635583','1','2020-01-29');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(382,' 346','7183069','1','2020-06-26');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(383,' 130','9585301','2','2018-12-10');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(384,' 417','9585301','4','2019-01-10');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(385,' 248','7183069','3','2019-11-17');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(386,' 80','5334556','1','2019-01-31');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(387,' 222','3775413','1','2019-12-16');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(388,' 420','3775413','2','2019-03-28');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(389,' 226','3775413','3','2019-12-14');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(390,' 26','5894565','2','2019-08-05');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(391,' 40','5635583','3','2020-05-14');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(392,' 499','6653876','4','2020-02-14');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(393,' 365','2557362','1','2019-10-12');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(394,' 394','3775413','2','2020-05-20');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(395,' 57','8273795','4','2019-01-15');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(396,' 355','9585301','1','2019-08-04');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(397,' 428','2557362','1','2019-06-20');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(398,' 382','2722641','2','2019-10-20');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(399,' 310','9585301','1','2018-12-04');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(400,' 229','8273795','1','2020-09-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(401,' 337','6936499','4','2019-09-28');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(402,' 417','8273795','2','2019-02-07');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(403,' 23','7183069','4','2019-07-11');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(404,' 98','9585301','2','2020-05-31');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(405,' 186','6936499','1','2019-05-08');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(406,' 206','5635583','3','2020-09-11');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(407,' 155','9469107','3','2020-05-03');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(408,' 154','7220969','3','2019-02-01');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(409,' 158','9469107','4','2019-05-22');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(410,' 491','8273795','1','2020-09-17');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(411,' 120','7449234','3','2020-08-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(412,' 395','7252939','3','2018-12-10');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(413,' 58','2557362','2','2020-09-08');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(414,' 88','5334556','4','2018-11-26');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(415,' 387','7220969','3','2019-07-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(416,' 462','7220969','3','2018-11-09');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(417,' 195','9469107','2','2020-09-08');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(418,' 8','7252939','4','2019-06-07');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(419,' 204','6653876','2','2019-10-24');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(420,' 342','6290280','1','2019-08-02');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(421,' 458','6653876','3','2019-03-29');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(422,' 297','8273795','2','2019-12-13');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(423,' 61','5894565','1','2019-05-11');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(424,' 289','6183835','3','2019-06-18');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(425,' 136','2722641','2','2019-02-17');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(426,' 224','2238453','3','2020-09-06');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(427,' 488','7449234','4','2019-07-19');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(428,' 206','2722641','4','2018-12-11');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(429,' 392','7220969','3','2019-05-17');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(430,' 405','9585301','1','2020-05-11');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(431,' 203','7220969','2','2020-09-28');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(432,' 447','5894565','4','2020-02-09');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(433,' 278','5894565','3','2020-10-12');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(434,' 94','5334556','4','2019-05-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(435,' 426','7183069','1','2018-12-26');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(436,' 140','7449234','3','2020-03-03');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(437,' 447','6183835','2','2019-09-03');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(438,' 240','8273795','3','2020-06-13');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(439,' 298','9585301','3','2020-11-06');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(440,' 75','3775413','3','2019-03-14');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(441,' 421','5635583','1','2019-12-14');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(442,' 13','7449234','3','2020-05-18');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(443,' 494','8273795','1','2020-05-15');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(444,' 3','8273795','2','2019-10-23');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(445,' 205','3775413','1','2020-11-07');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(446,' 208','5635583','4','2019-06-09');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(447,' 193','6183835','3','2020-07-31');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(448,' 158','6653876','4','2020-10-31');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(449,' 404','6936499','2','2020-02-27');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(450,' 206','6936499','3','2019-06-26');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(451,' 346','2238453','2','2019-01-30');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(452,' 402','9469107','1','2019-11-09');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(453,' 413','3775413','1','2019-07-11');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(454,' 332','6290280','4','2019-09-16');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(455,' 229','6653876','1','2019-12-07');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(456,' 398','5635583','3','2019-07-15');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(457,' 348','6183835','2','2019-11-04');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(458,' 251','2238453','4','2020-03-27');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(459,' 145','8273795','4','2019-01-13');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(460,' 475','5894565','3','2019-09-13');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(461,' 397','7252939','1','2019-06-07');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(462,' 24','7449234','1','2018-12-16');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(463,' 440','6936499','1','2020-10-22');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(464,' 129','9585301','4','2019-02-06');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(465,' 87','9585301','1','2019-12-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(466,' 434','7252939','3','2020-04-30');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(467,' 292','3775413','2','2019-08-06');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(468,' 499','7183069','4','2019-10-28');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(469,' 130','5635583','2','2019-06-22');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(470,' 480','6290280','1','2019-08-04');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(471,' 390','2722641','1','2020-08-02');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(472,' 218','7449234','2','2020-06-16');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(473,' 165','5334556','1','2020-06-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(474,' 51','9585301','1','2019-06-16');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(475,' 251','7183069','2','2019-04-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(476,' 339','2238453','2','2020-06-26');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(477,' 83','7252939','2','2020-05-28');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(478,' 253','6183835','2','2020-03-31');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(479,' 21','7220969','3','2019-01-20');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(480,' 313','6183835','2','2020-07-10');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(481,' 24','5635583','1','2020-06-16');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(482,' 267','2557362','3','2020-02-22');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(483,' 17','2238453','4','2019-08-17');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(484,' 29','6183835','2','2020-04-30');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(485,' 417','8273795','2','2019-12-10');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(486,' 241','5894565','4','2018-12-06');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(487,' 359','2557362','2','2020-01-04');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(488,' 51','7183069','2','2020-05-12');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(489,' 72','9469107','3','2020-09-11');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(490,' 454','2557362','2','2020-01-24');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(491,' 376','5894565','4','2019-09-25');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(492,' 460','9585301','1','2019-06-03');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(493,' 469','6653876','3','2020-04-04');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(494,' 210','7183069','1','2020-08-22');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(495,' 268','2238453','3','2019-07-24');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(496,' 24','7252939','2','2019-03-17');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(497,' 460','7252939','2','2020-07-13');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(498,' 87','6183835','2','2020-09-12');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(499,' 295','6290280','4','2020-09-03');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(500,' 201','7252939','2','2019-10-20');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(501,' 140','2238453','4','2020-04-09');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(502,' 117','5894565','1','2019-10-24');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(503,' 404','6290280','4','2020-07-30');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(504,' 258','7183069','2','2019-06-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(505,' 12','2722641','2','2020-04-05');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(506,' 184','9469107','3','2019-08-11');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(507,' 11','5894565','4','2019-04-28');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(508,' 96','2557362','4','2019-05-11');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(509,' 159','5334556','2','2019-03-07');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(510,' 86','7183069','3','2019-11-30');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(511,' 441','2722641','1','2018-11-25');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(512,' 99','6183835','2','2020-11-01');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(513,' 489','2722641','3','2018-12-22');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(514,' 84','7183069','4','2020-06-05');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(515,' 33','5894565','2','2020-07-08');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(516,' 359','9585301','3','2019-04-08');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(517,' 281','6936499','3','2019-10-12');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(518,' 246','2238453','4','2019-06-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(519,' 267','7449234','4','2020-07-20');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(520,' 86','7252939','3','2019-04-24');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(521,' 358','2238453','2','2019-01-05');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(522,' 25','3775413','1','2019-02-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(523,' 134','5635583','1','2019-10-23');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(524,' 234','9585301','3','2020-04-09');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(525,' 230','9469107','4','2019-07-20');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(526,' 230','9469107','1','2020-01-07');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(527,' 162','5334556','1','2019-02-09');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(528,' 74','7183069','4','2018-11-24');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(529,' 67','2557362','4','2020-07-07');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(530,' 261','9469107','3','2020-02-16');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(531,' 105','6290280','3','2020-04-27');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(532,' 258','9585301','1','2020-01-15');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(533,' 148','6936499','2','2020-04-13');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(534,' 89','7183069','2','2019-09-02');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(535,' 479','3775413','2','2019-02-20');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(536,' 317','2238453','4','2019-03-19');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(537,' 21','2722641','1','2019-03-29');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(538,' 221','2722641','2','2020-04-09');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(539,' 448','3775413','3','2020-05-13');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(540,' 473','3775413','3','2019-12-27');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(541,' 92','5635583','3','2019-05-19');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(542,' 429','6653876','4','2019-03-01');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(543,' 307','7183069','1','2018-11-21');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(544,' 16','6936499','1','2020-10-28');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(545,' 404','7252939','3','2019-02-17');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(546,' 13','7252939','2','2020-09-03');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(547,' 339','9585301','2','2019-10-16');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(548,' 203','7183069','3','2019-02-26');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(549,' 396','6653876','1','2019-01-13');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(550,' 178','5635583','4','2019-04-12');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(551,' 458','7183069','3','2019-07-14');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(552,' 406','5635583','2','2020-02-05');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(553,' 370','2238453','2','2020-03-30');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(554,' 484','7449234','1','2019-08-22');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(555,' 269','7183069','4','2019-01-26');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(556,' 13','3775413','2','2019-01-15');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(557,' 55','7252939','2','2020-09-22');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(558,' 410','9469107','2','2019-04-10');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(559,' 199','2722641','4','2020-02-20');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(560,' 91','7449234','3','2019-02-22');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(561,' 179','5635583','4','2020-04-05');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(562,' 109','5635583','3','2020-07-10');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(563,' 273','2722641','4','2019-03-12');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(564,' 345','9585301','2','2019-12-25');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(565,' 156','6653876','3','2019-07-10');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(566,' 2','6936499','2','2019-12-24');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(567,' 363','6936499','3','2020-09-01');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(568,' 483','9585301','3','2019-07-25');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(569,' 301','3775413','3','2019-04-19');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(570,' 273','5635583','1','2020-10-24');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(571,' 375','2238453','4','2020-11-05');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(572,' 234','5894565','4','2020-04-03');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(573,' 62','7220969','3','2020-10-29');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(574,' 406','3775413','4','2020-02-22');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(575,' 244','5334556','4','2020-07-22');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(576,' 46','5894565','4','2020-04-09');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(577,' 405','2557362','3','2019-07-14');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(578,' 127','2557362','1','2020-09-16');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(579,' 273','7449234','3','2019-09-07');
INSERT INTO Orders([Order_ID],[Cust_ID],[Driver],[Branch_ID],[Order_Date]) VALUES(580,' 294','7183069','1','2020-06-09');

-----------Insert Discounts Table--------------------------------------------

INSERT INTO Discounts
VALUES ('Full Price',0),
       ('Standart',0.10),
       ('Premium',0.20),
       ('Extra Premium',0.25),
       ('Elite',0.35)

-----------Insert Order Details Table--------------------------------------------

INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(100,'1138091',499,1,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(101,'8967993',138,6,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(102,'8395402',428,1,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(103,'6588756',385,3,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(104,'3110704',417,7,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(105,'6185248',515,5,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(106,'9720383',246,4,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(107,'2827133',388,9,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(108,'9337299',296,4,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(109,'4618504',306,4,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(110,'3110704',493,8,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(111,'4891233',392,5,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(112,'4494707',407,1,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(113,'4891233',205,1,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(114,'5145824',138,1,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(115,'8529283',213,10,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(116,'3110704',435,3,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(117,'9720383',389,4,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(118,'5823074',89,6,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(119,'4725602',219,3,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(120,'4961095',106,5,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(121,'1138091',157,9,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(122,'4754874',205,3,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(123,'4961095',375,1,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(124,'9161930',318,9,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(125,'5145824',426,2,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(126,'8529283',192,7,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(127,'4754874',131,1,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(128,'4891233',85,7,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(129,'6404858',165,4,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(130,'4437281',352,7,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(131,'4884496',224,5,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(132,'6404858',314,10,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(133,'8395402',78,1,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(134,'9929300',229,8,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(135,'8937732',402,5,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(136,'3330923',316,8,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(137,'4437281',124,7,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(138,'9161930',458,10,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(139,'8933435',370,7,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(140,'8395402',446,7,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(141,'4618504',301,2,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(142,'6588756',179,9,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(143,'8395402',311,5,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(144,'3110704',288,5,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(145,'1191297',454,6,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(146,'4494707',309,2,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(147,'8933435',111,2,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(148,'4494707',458,3,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(149,'9337299',158,5,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(150,'9720383',251,5,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(151,'9720383',491,10,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(152,'3110704',488,7,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(153,'1138091',89,10,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(154,'4437281',115,1,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(155,'4437281',79,1,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(156,'3330923',242,6,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(157,'6963858',328,1,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(158,'4494707',284,2,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(159,'8933435',423,7,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(160,'4884496',238,6,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(161,'8395402',151,10,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(162,'8469520',193,9,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(163,'4961095',194,1,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(164,'4725602',462,1,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(165,'4884496',100,2,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(166,'8933435',493,1,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(167,'4754874',442,6,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(168,'8469520',250,1,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(169,'8529283',261,6,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(170,'8933435',282,8,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(171,'1191297',434,3,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(172,'4891233',144,2,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(173,'9720383',191,3,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(174,'3330923',335,1,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(175,'4891233',345,9,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(176,'6185248',339,2,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(177,'1191297',398,2,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(178,'9337299',204,5,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(179,'8529283',469,2,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(180,'2265318',63,3,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(181,'8967993',366,9,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(182,'8937732',260,5,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(183,'8967993',363,10,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(184,'4891233',423,2,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(185,'1191297',64,10,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(186,'4891233',221,3,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(187,'2359220',297,5,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(188,'2265318',241,3,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(189,'4961095',245,6,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(190,'6963858',81,4,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(191,'6404858',505,9,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(192,'2965644',372,3,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(193,'2359220',40,2,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(194,'4437281',427,8,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(195,'2359220',72,8,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(196,'6963858',170,8,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(197,'3110704',249,5,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(198,'1895168',220,3,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(199,'8937732',352,1,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(200,'9204991',259,2,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(201,'4618504',289,8,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(202,'8469520',500,7,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(203,'4754874',464,5,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(204,'1138091',280,2,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(205,'4437281',86,9,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(206,'8395402',487,3,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(207,'8395402',276,7,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(208,'6185248',127,1,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(209,'3110704',397,8,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(210,'8967993',71,2,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(211,'5145824',414,8,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(212,'6404858',435,2,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(213,'1191297',139,10,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(214,'4437281',163,4,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(215,'9929300',442,2,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(216,'6185248',510,8,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(217,'4413901',258,5,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(218,'8395402',268,3,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(219,'9720383',340,8,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(220,'4961095',157,6,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(221,'6960930',373,9,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(222,'5145824',464,3,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(223,'9720383',355,6,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(224,'8469520',464,8,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(225,'4618504',440,8,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(226,'6185248',259,8,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(227,'4725602',88,7,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(228,'8469520',315,6,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(229,'6960930',64,10,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(230,'8967993',205,6,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(231,'9204991',112,8,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(232,'2965644',298,7,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(233,'4774886',247,5,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(234,'2359220',375,1,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(235,'4961095',346,3,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(236,'4884496',104,1,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(237,'4774886',253,6,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(238,'6185248',127,1,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(239,'8529283',224,8,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(240,'2965644',483,3,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(241,'9204991',319,10,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(242,'9337299',67,3,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(243,'8529283',206,3,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(244,'4413901',281,9,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(245,'9929300',367,7,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(246,'7938727',133,4,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(247,'4725602',242,2,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(248,'8933435',190,2,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(249,'2965644',374,5,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(250,'2965644',194,8,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(251,'8529283',253,2,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(252,'9204991',70,7,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(253,'4884496',135,2,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(254,'5823074',87,4,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(255,'4618504',391,7,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(256,'9204991',330,5,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(257,'4413901',133,5,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(258,'1138091',276,4,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(259,'2265318',416,5,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(260,'8469520',67,2,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(261,'1191297',295,7,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(262,'7203149',115,10,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(263,'9720383',375,3,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(264,'4961095',279,2,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(265,'4437281',168,9,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(266,'7938727',241,1,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(267,'6185248',380,10,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(268,'9204991',136,7,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(269,'2265318',251,4,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(270,'4754874',69,6,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(271,'1191297',446,6,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(272,'9161930',371,9,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(273,'6588756',477,7,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(274,'6185248',427,3,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(275,'4413901',429,1,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(276,'3330923',300,5,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(277,'1895168',38,7,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(278,'4437281',136,4,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(279,'9161930',242,1,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(280,'1895168',416,2,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(281,'4774886',223,3,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(282,'9720383',34,10,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(283,'4618504',373,10,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(284,'4961095',424,2,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(285,'7938727',289,8,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(286,'1138091',88,5,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(287,'4494707',106,8,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(288,'4884496',66,6,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(289,'7203149',323,6,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(290,'4884496',152,6,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(291,'8395402',424,5,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(292,'4891233',373,3,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(293,'4437281',401,5,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(294,'5823074',75,8,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(295,'4891233',347,7,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(296,'9204991',148,2,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(297,'6960930',314,7,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(298,'7938727',353,8,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(299,'3330923',366,9,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(300,'8529283',319,8,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(301,'6960930',391,9,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(302,'1138091',350,7,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(303,'9161930',518,6,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(304,'4754874',434,10,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(305,'9204991',254,4,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(306,'9204991',59,9,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(307,'3110704',226,5,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(308,'8933435',485,2,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(309,'9161930',419,8,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(310,'9204991',409,2,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(311,'6588756',496,3,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(312,'4725602',368,10,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(313,'4437281',215,6,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(314,'1191297',506,4,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(315,'2965644',64,9,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(316,'3330923',380,1,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(317,'5303644',138,5,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(318,'5823074',488,3,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(319,'3110704',459,10,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(320,'4413901',46,1,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(321,'1138091',83,7,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(322,'2965644',97,10,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(323,'1191297',163,7,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(324,'1191297',191,7,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(325,'8937732',208,4,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(326,'4754874',359,2,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(327,'4437281',466,5,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(328,'1138091',433,3,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(329,'9204991',344,2,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(330,'1191297',94,4,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(331,'8395402',299,8,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(332,'4891233',235,10,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(333,'2965644',514,3,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(334,'6404858',476,8,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(335,'9204991',93,5,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(336,'9161930',91,1,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(337,'8937732',131,2,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(338,'6588756',339,5,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(339,'2265318',63,5,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(340,'6960930',424,6,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(341,'9337299',507,7,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(342,'6960930',97,8,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(343,'6588756',510,3,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(344,'4494707',385,1,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(345,'8937732',342,3,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(346,'2827133',63,2,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(347,'5145824',245,7,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(348,'7938727',110,4,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(349,'4725602',68,1,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(350,'4725602',416,9,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(351,'4754874',381,4,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(352,'4437281',245,10,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(353,'6404858',191,5,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(354,'8469520',476,10,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(355,'9161930',122,4,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(356,'4891233',491,5,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(357,'8395402',402,5,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(358,'4725602',136,1,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(359,'1191297',516,10,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(360,'4891233',300,4,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(361,'4884496',345,6,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(362,'5145824',306,9,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(363,'6185248',461,6,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(364,'4774886',60,3,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(365,'2827133',174,3,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(366,'8469520',450,4,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(367,'4884496',104,5,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(368,'4437281',508,10,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(369,'4961095',312,4,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(370,'6404858',77,9,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(371,'6588756',222,4,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(372,'4884496',51,10,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(373,'5145824',423,1,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(374,'9929300',343,7,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(375,'9204991',371,1,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(376,'6960930',179,2,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(377,'6963858',80,8,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(378,'9204991',304,6,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(379,'4413901',116,10,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(380,'3330923',86,1,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(381,'6404858',443,3,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(382,'6185248',78,5,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(383,'1895168',165,7,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(384,'4725602',252,4,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(385,'6404858',91,10,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(386,'8967993',508,4,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(387,'5823074',469,10,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(388,'4618504',197,9,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(389,'6404858',130,4,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(390,'9929300',449,1,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(391,'2265318',178,8,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(392,'8529283',111,8,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(393,'2965644',373,1,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(394,'4961095',504,10,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(395,'6588756',129,2,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(396,'1138091',291,10,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(397,'8933435',195,10,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(398,'7203149',179,6,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(399,'6588756',60,5,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(400,'6185248',45,6,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(401,'7938727',229,10,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(402,'5823074',491,10,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(403,'5145824',448,9,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(404,'7938727',110,10,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(405,'2965644',454,6,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(406,'5303644',156,9,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(407,'8933435',520,3,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(408,'2965644',270,8,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(409,'9720383',47,3,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(410,'6404858',265,8,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(411,'1138091',339,9,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(412,'6185248',97,8,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(413,'6404858',274,9,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(414,'4725602',467,10,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(415,'9720383',441,4,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(416,'1191297',489,4,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(417,'9204991',92,1,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(418,'4884496',186,9,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(419,'2359220',301,8,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(420,'9161930',390,8,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(421,'4891233',419,6,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(422,'4774886',50,10,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(423,'6185248',113,9,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(424,'8937732',255,6,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(425,'5823074',214,5,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(426,'2827133',170,8,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(427,'2965644',348,9,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(428,'5823074',306,3,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(429,'6588756',237,4,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(430,'4413901',364,3,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(431,'9337299',134,8,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(432,'8933435',40,1,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(433,'2265318',187,9,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(434,'4494707',79,7,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(435,'4413901',472,7,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(436,'6963858',401,2,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(437,'1191297',31,3,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(438,'6588756',383,1,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(439,'6185248',32,8,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(440,'4961095',464,9,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(441,'3330923',468,5,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(442,'6960930',184,5,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(443,'8967993',53,4,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(444,'6963858',359,9,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(445,'6960930',364,9,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(446,'8933435',500,1,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(447,'4754874',348,8,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(448,'4725602',96,8,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(449,'9204991',207,10,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(450,'4961095',403,1,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(451,'4774886',345,6,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(452,'4754874',54,1,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(453,'4774886',249,9,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(454,'4754874',475,3,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(455,'9204991',242,9,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(456,'8933435',489,3,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(457,'9161930',309,3,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(458,'4437281',87,7,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(459,'5303644',488,10,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(460,'9204991',365,1,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(461,'9161930',511,9,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(462,'2827133',105,1,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(463,'4774886',35,6,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(464,'8395402',331,4,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(465,'8529283',470,4,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(466,'9337299',137,7,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(467,'5303644',281,8,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(468,'6588756',454,10,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(469,'6404858',342,9,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(470,'4618504',474,8,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(471,'4725602',222,1,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(472,'6588756',131,8,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(473,'8395402',251,2,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(474,'4494707',426,8,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(475,'4754874',195,3,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(476,'5823074',146,1,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(477,'4774886',84,8,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(478,'6960930',346,2,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(479,'2265318',396,10,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(480,'4754874',194,2,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(481,'8967993',419,9,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(482,'4725602',461,4,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(483,'4961095',255,7,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(484,'9204991',127,5,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(485,'8937732',227,2,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(486,'9720383',448,6,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(487,'2265318',34,6,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(488,'4961095',457,1,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(489,'1191297',315,7,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(490,'9161930',418,3,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(491,'2965644',195,8,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(492,'5145824',509,10,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(493,'6185248',461,6,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(494,'4725602',302,9,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(495,'4618504',260,3,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(496,'4884496',158,3,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(497,'8469520',132,1,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(498,'6404858',285,4,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(499,'4754874',448,6,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(500,'9720383',336,6,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(501,'5303644',140,7,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(502,'2965644',448,5,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(503,'6963858',46,6,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(504,'9204991',447,7,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(505,'9929300',301,9,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(506,'4884496',58,6,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(507,'6588756',356,2,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(508,'9929300',151,10,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(509,'6404858',73,8,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(510,'4725602',427,1,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(511,'4413901',35,9,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(512,'2827133',127,9,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(513,'4494707',459,6,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(514,'7203149',129,2,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(515,'2965644',335,6,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(516,'7938727',80,10,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(517,'4774886',31,1,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(518,'9161930',38,1,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(519,'8469520',421,10,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(520,'5823074',35,5,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(521,'4437281',236,1,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(522,'9337299',416,3,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(523,'4884496',506,3,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(524,'7938727',358,3,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(525,'1895168',215,7,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(526,'4413901',198,6,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(527,'6404858',273,3,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(528,'4413901',500,1,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(529,'5145824',361,1,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(530,'9929300',473,1,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(531,'8529283',61,9,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(532,'1895168',207,7,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(533,'4884496',100,5,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(534,'2965644',179,10,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(535,'4725602',376,9,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(536,'2265318',302,2,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(537,'4494707',260,5,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(538,'3330923',50,9,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(539,'9161930',259,8,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(540,'4891233',78,2,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(541,'6185248',302,2,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(542,'3330923',234,8,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(543,'4618504',45,7,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(544,'4891233',388,9,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(545,'6404858',381,10,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(546,'6963858',105,3,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(547,'5823074',270,9,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(548,'9204991',256,1,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(549,'6404858',460,6,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(550,'8395402',383,5,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(551,'5303644',363,3,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(552,'9204991',147,1,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(553,'8933435',283,8,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(554,'5145824',389,6,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(555,'1895168',386,1,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(556,'3110704',274,2,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(557,'7938727',443,2,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(558,'4884496',133,9,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(559,'5823074',173,6,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(560,'4494707',339,1,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(561,'4725602',158,2,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(562,'4754874',505,1,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(563,'3330923',447,7,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(564,'5145824',514,8,'2');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(565,'1895168',321,1,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(566,'3110704',195,6,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(567,'1191297',452,7,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(568,'5303644',102,9,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(569,'4725602',359,7,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(570,'8395402',128,4,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(571,'1895168',72,8,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(572,'9337299',377,7,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(573,'8395402',340,5,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(574,'1138091',327,2,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(575,'2265318',334,7,'1');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(576,'4725602',509,8,'3');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(577,'4774886',254,9,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(578,'7203149',223,10,'5');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(579,'2827133',295,3,'4');
INSERT INTO Order_Details([Order_ID],[Car_ID],[Distance_KM],[Price_per_KM],[Discount_Type]) VALUES(580,'8933435',65,6,'5');

	 
	  