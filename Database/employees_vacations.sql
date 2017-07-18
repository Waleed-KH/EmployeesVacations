/*
Navicat MySQL Data Transfer

Source Server         : Localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : employees_vacations

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-07-18 21:58:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for aspnetroleclaims
-- ----------------------------
DROP TABLE IF EXISTS `aspnetroleclaims`;
CREATE TABLE `aspnetroleclaims` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ClaimType` longtext,
  `ClaimValue` longtext,
  `RoleId` varchar(127) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_AspNetRoleClaims_RoleId` (`RoleId`),
  CONSTRAINT `FK_AspNetRoleClaims_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `aspnetroles` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of aspnetroleclaims
-- ----------------------------

-- ----------------------------
-- Table structure for aspnetroles
-- ----------------------------
DROP TABLE IF EXISTS `aspnetroles`;
CREATE TABLE `aspnetroles` (
  `Id` varchar(127) NOT NULL,
  `ConcurrencyStamp` longtext,
  `Name` varchar(256) DEFAULT NULL,
  `NormalizedName` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `RoleNameIndex` (`NormalizedName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of aspnetroles
-- ----------------------------

-- ----------------------------
-- Table structure for aspnetuserclaims
-- ----------------------------
DROP TABLE IF EXISTS `aspnetuserclaims`;
CREATE TABLE `aspnetuserclaims` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ClaimType` longtext,
  `ClaimValue` longtext,
  `UserId` varchar(127) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_AspNetUserClaims_UserId` (`UserId`),
  CONSTRAINT `FK_AspNetUserClaims_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of aspnetuserclaims
-- ----------------------------

-- ----------------------------
-- Table structure for aspnetuserlogins
-- ----------------------------
DROP TABLE IF EXISTS `aspnetuserlogins`;
CREATE TABLE `aspnetuserlogins` (
  `LoginProvider` varchar(127) NOT NULL,
  `ProviderKey` varchar(127) NOT NULL,
  `ProviderDisplayName` longtext,
  `UserId` varchar(127) NOT NULL,
  PRIMARY KEY (`LoginProvider`,`ProviderKey`),
  KEY `IX_AspNetUserLogins_UserId` (`UserId`),
  CONSTRAINT `FK_AspNetUserLogins_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of aspnetuserlogins
-- ----------------------------

-- ----------------------------
-- Table structure for aspnetuserroles
-- ----------------------------
DROP TABLE IF EXISTS `aspnetuserroles`;
CREATE TABLE `aspnetuserroles` (
  `UserId` varchar(127) NOT NULL,
  `RoleId` varchar(127) NOT NULL,
  PRIMARY KEY (`UserId`,`RoleId`),
  KEY `IX_AspNetUserRoles_RoleId` (`RoleId`),
  CONSTRAINT `FK_AspNetUserRoles_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `aspnetroles` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_AspNetUserRoles_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of aspnetuserroles
-- ----------------------------

-- ----------------------------
-- Table structure for aspnetusers
-- ----------------------------
DROP TABLE IF EXISTS `aspnetusers`;
CREATE TABLE `aspnetusers` (
  `Id` varchar(127) NOT NULL,
  `AccessFailedCount` int(11) NOT NULL,
  `ConcurrencyStamp` longtext,
  `Email` varchar(256) DEFAULT NULL,
  `EmailConfirmed` bit(1) NOT NULL,
  `LockoutEnabled` bit(1) NOT NULL,
  `LockoutEnd` datetime(6) DEFAULT NULL,
  `NormalizedEmail` varchar(256) DEFAULT NULL,
  `NormalizedUserName` varchar(256) DEFAULT NULL,
  `PasswordHash` longtext,
  `PhoneNumber` longtext,
  `PhoneNumberConfirmed` bit(1) NOT NULL,
  `SecurityStamp` longtext,
  `TwoFactorEnabled` bit(1) NOT NULL,
  `UserName` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UserNameIndex` (`NormalizedUserName`),
  KEY `EmailIndex` (`NormalizedEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of aspnetusers
-- ----------------------------
INSERT INTO `aspnetusers` VALUES ('4b07b351-7e4c-40d9-a95e-cbe99ebe6965', '0', 'a9c28075-d924-457c-b229-e95a5acb7bc0', 'waleed1kh@yahoo.com', '\0', '', null, 'WALEED1KH@YAHOO.COM', 'WALEED', 'AQAAAAEAACcQAAAAEFsgBSa8655CcbKcO3C8ed1S6aS9rQj4WviaC6Hz3IvUPT4vXQlyiRwtcFBFVZHwsQ==', null, '\0', '2125ed42-f73a-434d-8058-4f5e244fb877', '\0', 'Waleed');

-- ----------------------------
-- Table structure for aspnetusertokens
-- ----------------------------
DROP TABLE IF EXISTS `aspnetusertokens`;
CREATE TABLE `aspnetusertokens` (
  `UserId` varchar(127) NOT NULL,
  `LoginProvider` varchar(127) NOT NULL,
  `Name` varchar(127) NOT NULL,
  `Value` longtext,
  PRIMARY KEY (`UserId`,`LoginProvider`,`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of aspnetusertokens
-- ----------------------------

-- ----------------------------
-- Table structure for employees
-- ----------------------------
DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees` (
  `EmployeeId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` longtext NOT NULL,
  `Gender` int(11) NOT NULL,
  `Birthdate` datetime(6) NOT NULL,
  `Email` longtext,
  `Address` longtext,
  PRIMARY KEY (`EmployeeId`)
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employees
-- ----------------------------
INSERT INTO `employees` VALUES ('1', 'Francklyn Laffranconi', '0', '1954-12-19 00:00:00.000000', 'flaffranconi0@fc2.com', '2270 Lindbergh Alley');
INSERT INTO `employees` VALUES ('2', 'Poul Mahaddie', '0', '1967-07-13 00:00:00.000000', 'pmahaddie1@craigslist.org', '5 Moose Hill');
INSERT INTO `employees` VALUES ('3', 'Quinn Fallowes', '0', '1971-01-14 00:00:00.000000', 'qfallowes2@taobao.com', '17653 Mallard Terrace');
INSERT INTO `employees` VALUES ('4', 'Leese Dawtry', '0', '1953-09-20 00:00:00.000000', 'ldawtry3@hud.gov', '8 Ridgeway Terrace');
INSERT INTO `employees` VALUES ('5', 'Ginni Dorn', '0', '1956-06-28 00:00:00.000000', 'gdorn4@cloudflare.com', '43 Tomscot Lane');
INSERT INTO `employees` VALUES ('6', 'Dona Roizn', '0', '1976-11-25 00:00:00.000000', 'droizn5@latimes.com', '2 Stoughton Crossing');
INSERT INTO `employees` VALUES ('7', 'Nelia Naisby', '0', '1952-08-18 00:00:00.000000', 'nnaisby6@kickstarter.com', '9369 Havey Place');
INSERT INTO `employees` VALUES ('8', 'Urson Sines', '0', '1977-12-10 00:00:00.000000', 'usines7@mashable.com', '25736 Crownhardt Circle');
INSERT INTO `employees` VALUES ('9', 'Pierette Ronnay', '1', '1962-06-08 00:00:00.000000', 'pronnay8@unblog.fr', '1 Kim Hill');
INSERT INTO `employees` VALUES ('10', 'Florance Rwat', '1', '1965-06-08 00:00:00.000000', 'frowat9@gimodo.com', '8 Valley Edge Point');
INSERT INTO `employees` VALUES ('11', 'Danielle Pepperd', '0', '1982-11-18 00:00:00.000000', 'dpepperda@mysql.com', '3 Sage Junction');
INSERT INTO `employees` VALUES ('12', 'Cassi Hainning', '0', '1974-01-09 00:00:00.000000', 'chainningb@goo.ne.jp', '43911 Upham Junction');
INSERT INTO `employees` VALUES ('13', 'Peirce Skeldon', '1', '1961-04-24 00:00:00.000000', 'pskeldonc@vk.com', '0 Sachtjen Plaza');
INSERT INTO `employees` VALUES ('14', 'Morganne Caron', '0', '1997-06-08 00:00:00.000000', 'mcarond@gmpg.org', '3478 Luster Court');
INSERT INTO `employees` VALUES ('15', 'Evita Goodlud', '1', '1999-10-18 00:00:00.000000', 'egoodlude@tripadvisor.com', '3 Knutson Way');
INSERT INTO `employees` VALUES ('16', 'Garrett Conen', '0', '1983-07-02 00:00:00.000000', 'gconenf@comcast.net', '5361 Meadow Valley Pass');
INSERT INTO `employees` VALUES ('17', 'Adair Blazeby', '1', '1997-06-11 00:00:00.000000', 'ablazebyg@twitter.com', '90 Canary Park');
INSERT INTO `employees` VALUES ('18', 'Mari Shear', '1', '1984-05-11 00:00:00.000000', 'mshearh@tripod.com', '90460 Clyde Gallagher Circle');
INSERT INTO `employees` VALUES ('19', 'Ruthie Castree', '1', '1953-03-15 00:00:00.000000', 'rcastreei@oracle.com', '46521 Dawn Circle');
INSERT INTO `employees` VALUES ('20', 'Iona Troughton', '1', '1983-04-14 00:00:00.000000', 'itroughtonj@gizmodo.com', '5 Lakewood Way');
INSERT INTO `employees` VALUES ('21', 'Brander Jolliff', '1', '1991-01-20 00:00:00.000000', 'bjolliffk@army.mil', '92123 Orin Place');
INSERT INTO `employees` VALUES ('22', 'Cherianne Glanville', '1', '1996-08-13 00:00:00.000000', 'cglanvillel@sakura.ne.jp', '283 Petterle Plaza');
INSERT INTO `employees` VALUES ('23', 'Sharia Giorgione', '0', '1958-01-08 00:00:00.000000', 'sgiorgionem@about.me', '2106 Main Circle');
INSERT INTO `employees` VALUES ('24', 'Ingelbert Shakespear', '0', '1962-06-13 00:00:00.000000', 'ishakespearn@slate.com', '979 Kinsman Road');
INSERT INTO `employees` VALUES ('25', 'Quentin Stennes', '0', '1970-05-07 00:00:00.000000', 'qstenneso@usda.gov', '4 Susan Trail');
INSERT INTO `employees` VALUES ('26', 'Jeannie GiacobbiniJacob', '1', '1951-02-23 00:00:00.000000', 'jgiacobbinijacobp@last.fm', '2680 Surrey Hill');
INSERT INTO `employees` VALUES ('27', 'Artus Huyton', '0', '1988-09-24 00:00:00.000000', 'ahuytonq@usa.gov', '86 Independence Park');
INSERT INTO `employees` VALUES ('28', 'Shaughn Odde', '1', '1991-11-01 00:00:00.000000', 'sodder@ft.com', '255 Crowley Point');
INSERT INTO `employees` VALUES ('29', 'Hermann Oki', '0', '1984-08-22 00:00:00.000000', 'hokis@google.com.hk', '0 Oakridge Avenue');
INSERT INTO `employees` VALUES ('30', 'Neille Pawelczyk', '0', '1997-01-23 00:00:00.000000', 'npawelczykt@ycombinator.com', '088 Elka Drive');
INSERT INTO `employees` VALUES ('31', 'Lorilyn O\'Dogherty', '0', '1970-05-19 00:00:00.000000', 'lodoghertyu@hexun.com', '49728 Cordelia Street');
INSERT INTO `employees` VALUES ('32', 'Korey Lorek', '1', '1998-06-22 00:00:00.000000', 'klorekv@51.la', '4 Ridgeview Trail');
INSERT INTO `employees` VALUES ('33', 'Dacia Navarro', '0', '1981-05-29 00:00:00.000000', 'dnavarrow@gmpg.org', '6 Daystar Pass');
INSERT INTO `employees` VALUES ('34', 'Kerby Risborough', '0', '1986-07-31 00:00:00.000000', 'krisboroughx@blogspot.com', '8903 Canary Avenue');
INSERT INTO `employees` VALUES ('35', 'Lilian Schelle', '0', '1956-01-15 00:00:00.000000', 'lschelley@godaddy.com', '918 Pine View Pass');
INSERT INTO `employees` VALUES ('36', 'Murry Chaudhry', '0', '1974-05-27 00:00:00.000000', 'mchaudhryz@slate.com', '12103 Truax Court');
INSERT INTO `employees` VALUES ('37', 'Valina Geck', '1', '1989-03-17 00:00:00.000000', 'vgeck10@usnews.com', '58936 Warbler Terrace');
INSERT INTO `employees` VALUES ('38', 'Dionis Valencia', '1', '1966-04-21 00:00:00.000000', 'dvalencia11@youtube.com', '514 Ridgeway Way');
INSERT INTO `employees` VALUES ('39', 'Maxine Warrell', '1', '1978-10-16 00:00:00.000000', 'mwarrell12@psu.edu', '7 Hazelcrest Junction');
INSERT INTO `employees` VALUES ('40', 'Mattie Heggadon', '0', '1957-09-14 00:00:00.000000', 'mheggadon13@sourceforge.net', '290 Drewry Avenue');
INSERT INTO `employees` VALUES ('41', 'Thorny Pardi', '0', '1952-03-24 00:00:00.000000', 'tpardi14@mayoclinic.com', '7 Fuller Avenue');
INSERT INTO `employees` VALUES ('42', 'Chane McCadden', '0', '1961-07-12 00:00:00.000000', 'cmccadden15@dropbox.com', '94210 Colorado Drive');
INSERT INTO `employees` VALUES ('43', 'Edee Rydzynski', '0', '1955-02-11 00:00:00.000000', 'erydzynski16@patch.com', '9 Fairview Pass');
INSERT INTO `employees` VALUES ('44', 'Stevena Broomer', '1', '1969-01-07 00:00:00.000000', 'sbroomer17@miitbeian.gov.cn', '9813 Florence Court');
INSERT INTO `employees` VALUES ('45', 'Nessa Carding', '1', '1990-07-11 00:00:00.000000', 'ncarding18@purevolume.com', '0 Becker Parkway');
INSERT INTO `employees` VALUES ('46', 'Delia Isaaksohn', '0', '1976-11-11 00:00:00.000000', 'disaaksohn19@narod.ru', '16164 Kim Circle');
INSERT INTO `employees` VALUES ('47', 'Oates Ducker', '1', '1961-05-29 00:00:00.000000', 'oducker1a@house.gov', '497 Rieder Avenue');
INSERT INTO `employees` VALUES ('48', 'Donica Picford', '0', '1965-05-13 00:00:00.000000', 'dpicford1b@usatoday.com', '372 4th Road');
INSERT INTO `employees` VALUES ('49', 'Bay Touret', '1', '1967-05-13 00:00:00.000000', 'btouret1c@wikipedia.org', '39356 Scofield Place');
INSERT INTO `employees` VALUES ('50', 'Zola Goodband', '0', '1997-09-12 00:00:00.000000', 'zgoodband1d@blogtalkradio.com', '3649 Red Cloud Circle');
INSERT INTO `employees` VALUES ('51', 'Gertruda Clery', '0', '1977-05-18 00:00:00.000000', 'gclery1e@deviantart.com', '92 Towne Court');
INSERT INTO `employees` VALUES ('52', 'Eloisa Boath', '0', '1960-04-13 00:00:00.000000', 'eboath1f@surveymonkey.com', '076 Crest Line Road');
INSERT INTO `employees` VALUES ('53', 'Noll Stenet', '0', '1978-04-07 00:00:00.000000', 'nstenet1g@yellowbook.com', '5526 Montana Road');
INSERT INTO `employees` VALUES ('54', 'Raoul Itscowics', '1', '1996-07-29 00:00:00.000000', 'ritscowics1h@behance.net', '6 Melody Avenue');
INSERT INTO `employees` VALUES ('55', 'Leone Inns', '1', '1995-07-26 00:00:00.000000', 'linns1i@psu.edu', '90085 Susan Crossing');
INSERT INTO `employees` VALUES ('56', 'Salomon Hiddsley', '0', '1963-04-12 00:00:00.000000', 'shiddsley1j@va.gov', '009 Oriole Road');
INSERT INTO `employees` VALUES ('57', 'Thatch Ziemecki', '0', '1958-02-03 00:00:00.000000', 'tziemecki1k@sohu.com', '2 Loomis Crossing');
INSERT INTO `employees` VALUES ('58', 'Conchita Marrow', '1', '1964-04-16 00:00:00.000000', 'cmarrow1l@example.com', '71512 Brown Crossing');
INSERT INTO `employees` VALUES ('59', 'Talya Hallard', '1', '1952-05-06 00:00:00.000000', 'thallard1m@freewebs.com', '64099 Katie Terrace');
INSERT INTO `employees` VALUES ('60', 'Briant Pechold', '0', '1950-04-24 00:00:00.000000', 'bpechold1n@amazon.com', '523 Arrowood Hill');
INSERT INTO `employees` VALUES ('61', 'Sherline Pedrielli', '0', '1959-11-18 00:00:00.000000', 'spedrielli1o@timesonline.co.uk', '02 Canary Circle');
INSERT INTO `employees` VALUES ('62', 'Rebecka Ambler', '0', '1981-12-20 00:00:00.000000', 'rambler1p@earthlink.net', '68279 Rutledge Park');
INSERT INTO `employees` VALUES ('63', 'Donalt Huglin', '0', '1987-03-10 00:00:00.000000', 'dhuglin1q@columbia.edu', '91 Waywood Park');
INSERT INTO `employees` VALUES ('64', 'Quintilla Huyge', '0', '1992-05-30 00:00:00.000000', 'qhuyge1r@youtu.be', '895 Center Court');
INSERT INTO `employees` VALUES ('65', 'Trish Roe', '0', '1967-05-15 00:00:00.000000', 'troe1s@netlog.com', '79 Macpherson Crossing');
INSERT INTO `employees` VALUES ('66', 'Chrotoem Everard', '0', '1970-04-11 00:00:00.000000', 'ceverard1t@1688.com', '6 Hallows Terrace');
INSERT INTO `employees` VALUES ('67', 'Willy Petegrew', '0', '1973-09-15 00:00:00.000000', 'wpetegrew1u@time.com', '797 Welch Court');
INSERT INTO `employees` VALUES ('68', 'Agnola Sandall', '1', '1979-04-18 00:00:00.000000', 'asandall1v@house.gov', '6079 Fordem Center');
INSERT INTO `employees` VALUES ('69', 'Enrico Minnette', '0', '1951-08-11 00:00:00.000000', 'eminnette1w@123-reg.co.uk', '4 Bluestem Street');
INSERT INTO `employees` VALUES ('70', 'Willie Ramard', '0', '1976-01-18 00:00:00.000000', 'wramard1x@sogou.com', '934 Loeprich Lane');
INSERT INTO `employees` VALUES ('71', 'Chris Johnston', '0', '1990-03-26 00:00:00.000000', 'cjohnston1y@mlb.com', '21854 Dakota Road');
INSERT INTO `employees` VALUES ('72', 'Bella Pargiter', '0', '1965-09-04 00:00:00.000000', 'bpargiter1z@acquirethisname.com', '3 Northland Alley');
INSERT INTO `employees` VALUES ('73', 'Jayme Lanceter', '1', '1991-08-18 00:00:00.000000', 'jlanceter20@youku.com', '4 Shoshone Trail');
INSERT INTO `employees` VALUES ('74', 'Sisile Woodger', '1', '1951-02-24 00:00:00.000000', 'swoodger21@ted.com', '55 Tony Way');
INSERT INTO `employees` VALUES ('75', 'Roth Trevor', '1', '1954-09-11 00:00:00.000000', 'rtrevor22@qq.com', '383 Alpine Trail');
INSERT INTO `employees` VALUES ('76', 'Moishe Lipp', '0', '1957-09-05 00:00:00.000000', 'mlipp23@paginegialle.it', '85 Packers Lane');
INSERT INTO `employees` VALUES ('77', 'Charita Claeskens', '1', '1953-12-21 00:00:00.000000', 'cclaeskens24@upenn.edu', '6872 Mallard Point');
INSERT INTO `employees` VALUES ('78', 'Carlen Syder', '0', '1951-12-23 00:00:00.000000', 'csyder25@ycombinator.com', '66956 Kings Terrace');
INSERT INTO `employees` VALUES ('79', 'Hyacinth Martynikhin', '1', '1974-12-04 00:00:00.000000', 'hmartynikhin26@chronoengine.com', '073 Cordelia Way');
INSERT INTO `employees` VALUES ('80', 'Montgomery Edington', '1', '1958-09-22 00:00:00.000000', 'medington27@typepad.com', '3283 Butternut Crossing');
INSERT INTO `employees` VALUES ('81', 'Hillery Brodeau', '1', '1957-08-27 00:00:00.000000', 'hbrodeau28@squarespace.com', '14 Hooker Crossing');
INSERT INTO `employees` VALUES ('82', 'Perren Abbys', '0', '1999-05-14 00:00:00.000000', 'pabbys29@sitemeter.com', '0933 Schiller Circle');
INSERT INTO `employees` VALUES ('83', 'Tannie Vlahos', '0', '1980-11-17 00:00:00.000000', 'tvlahos2a@guardian.co.uk', '2528 Dennis Way');
INSERT INTO `employees` VALUES ('84', 'Den Pierrepont', '0', '1952-12-10 00:00:00.000000', 'dpierrepont2b@facebook.com', '0484 Corscot Terrace');
INSERT INTO `employees` VALUES ('85', 'Anna-diana Beningfield', '1', '1987-06-18 00:00:00.000000', 'abeningfield2c@typepad.com', '7 Pankratz Court');
INSERT INTO `employees` VALUES ('86', 'Marilyn De Simone', '0', '1966-10-24 00:00:00.000000', 'mde2d@imdb.com', '469 Utah Pass');
INSERT INTO `employees` VALUES ('87', 'Wrennie Orr', '1', '1952-01-10 00:00:00.000000', 'worr2e@answers.com', '363 Graceland Pass');
INSERT INTO `employees` VALUES ('88', 'Pat Morecombe', '1', '1997-04-06 00:00:00.000000', 'pmorecombe2f@about.com', '9 Birchwood Drive');
INSERT INTO `employees` VALUES ('89', 'Mahala Dourin', '1', '1995-02-14 00:00:00.000000', 'mdourin2g@cdc.gov', '726 Claremont Terrace');
INSERT INTO `employees` VALUES ('90', 'Page Dearle', '1', '1950-12-02 00:00:00.000000', 'pdearle2h@diigo.com', '87 Oak Plaza');
INSERT INTO `employees` VALUES ('91', 'Katerina Ferfulle', '0', '1965-02-27 00:00:00.000000', 'kferfulle2i@opera.com', '5 Division Point');
INSERT INTO `employees` VALUES ('92', 'Debee Amos', '1', '1950-09-21 00:00:00.000000', 'damos2j@lulu.com', '3 Declaration Drive');
INSERT INTO `employees` VALUES ('93', 'Caryl Oakwood', '0', '1968-06-13 00:00:00.000000', 'coakwood2k@devhub.com', '77910 Jenna Center');
INSERT INTO `employees` VALUES ('94', 'Sidonnie Liddall', '1', '1998-05-21 00:00:00.000000', 'sliddall2l@netlog.com', '871 Straubel Way');
INSERT INTO `employees` VALUES ('95', 'Natasha Bossom', '0', '1983-08-19 00:00:00.000000', 'nbossom2m@cpanel.net', '84 Veith Avenue');
INSERT INTO `employees` VALUES ('96', 'Jacquenette Petrushanko', '1', '1960-01-13 00:00:00.000000', 'jpetrushanko2n@imdb.com', '79077 Rigney Avenue');
INSERT INTO `employees` VALUES ('97', 'Denise Otteridge', '1', '1996-11-25 00:00:00.000000', 'dotteridge2o@istockphoto.com', '9 Haas Junction');
INSERT INTO `employees` VALUES ('98', 'Lara Sopper', '0', '1965-04-30 00:00:00.000000', 'lsopper2p@uiuc.edu', '2705 Sutherland Center');
INSERT INTO `employees` VALUES ('99', 'Carlotta Billham', '0', '1984-02-20 00:00:00.000000', 'cbillham2q@java.com', '20684 Eggendart Way');
INSERT INTO `employees` VALUES ('100', 'Murial Spadelli', '1', '1964-02-20 00:00:00.000000', 'mspadelli2r@redcross.org', '8 Lukken Court');
INSERT INTO `employees` VALUES ('101', 'Adel Verzey', '1', '1969-07-31 00:00:00.000000', 'averzey2s@gnu.org', '39 Vidon Point');
INSERT INTO `employees` VALUES ('102', 'Aurlie Snasdell', '0', '1981-04-26 00:00:00.000000', 'asnasdell2t@elpais.com', '48702 Luster Place');
INSERT INTO `employees` VALUES ('103', 'Vinita Gerlack', '0', '1993-03-27 00:00:00.000000', 'vgerlack2u@youku.com', '7614 1st Way');
INSERT INTO `employees` VALUES ('104', 'Nolly Sive', '0', '1979-11-12 00:00:00.000000', 'nsive2v@who.int', '239 Hayes Crossing');
INSERT INTO `employees` VALUES ('105', 'Merrily Edgecombe', '1', '1976-10-23 00:00:00.000000', 'medgecombe2w@zdnet.com', '5451 Heath Terrace');
INSERT INTO `employees` VALUES ('106', 'Adrian Mc Ilory', '0', '1989-08-30 00:00:00.000000', 'amc2x@constantcontact.com', '0 Pine View Street');
INSERT INTO `employees` VALUES ('107', 'Garrik Semble', '0', '1956-07-20 00:00:00.000000', 'gsemble2y@newyorker.com', '70884 Cody Way');
INSERT INTO `employees` VALUES ('108', 'Alisun Bleddon', '1', '1955-03-10 00:00:00.000000', 'ableddon2z@yahoo.com', '7 Schiller Street');
INSERT INTO `employees` VALUES ('109', 'Carlyn Penna', '0', '1966-07-27 00:00:00.000000', 'cpenna30@mysql.com', '105 Scoville Circle');
INSERT INTO `employees` VALUES ('110', 'Merle Considine', '1', '1953-01-12 00:00:00.000000', 'mconsidine31@cloudflare.com', '465 Dakota Park');
INSERT INTO `employees` VALUES ('111', 'Fulton Prise', '0', '1969-06-28 00:00:00.000000', 'fprise32@devhub.com', '07 Bartelt Avenue');
INSERT INTO `employees` VALUES ('112', 'Min Beechcraft', '0', '1969-11-24 00:00:00.000000', 'mbeechcraft33@newyorker.com', '34997 Donald Plaza');
INSERT INTO `employees` VALUES ('113', 'Ezra Tappor', '1', '1969-01-28 00:00:00.000000', 'etappor34@aol.com', '914 Waubesa Center');
INSERT INTO `employees` VALUES ('114', 'Jyoti Lavin', '1', '1958-03-13 00:00:00.000000', 'jlavin35@elegantthemes.com', '2 Stone Corner Road');
INSERT INTO `employees` VALUES ('115', 'Klara Darthe', '1', '1990-08-25 00:00:00.000000', 'kdarthe36@people.com.cn', '956 Corben Parkway');
INSERT INTO `employees` VALUES ('116', 'Cointon Crook', '1', '1987-03-03 00:00:00.000000', 'ccrook37@icq.com', '1988 Bunker Hill Park');
INSERT INTO `employees` VALUES ('117', 'Becky Iglesias', '1', '1976-11-26 00:00:00.000000', 'biglesias38@unc.edu', '19 Bay Street');
INSERT INTO `employees` VALUES ('118', 'Casie Luckings', '1', '1970-12-04 00:00:00.000000', 'cluckings39@dmoz.org', '4 Eagle Crest Parkway');
INSERT INTO `employees` VALUES ('119', 'Marys Hendrix', '0', '1987-10-09 00:00:00.000000', 'mhendrix3a@vkontakte.ru', '1481 Bayside Terrace');
INSERT INTO `employees` VALUES ('120', 'Jocelyne Gatty', '1', '1994-04-14 00:00:00.000000', 'jgatty3b@dell.com', '48782 John Wall Pass');
INSERT INTO `employees` VALUES ('121', 'Tracee Pedden', '0', '1997-05-28 00:00:00.000000', 'tpedden3c@themeforest.net', '1 Express Trail');
INSERT INTO `employees` VALUES ('122', 'Genvieve Rocco', '0', '1999-03-28 00:00:00.000000', 'grocco3d@google.com.hk', '69 Holmberg Way');
INSERT INTO `employees` VALUES ('123', 'Archer Dahl', '0', '1981-12-27 00:00:00.000000', 'adahl3e@arstechnica.com', '5003 Bunting Center');
INSERT INTO `employees` VALUES ('124', 'Arni Heskey', '1', '1975-03-17 00:00:00.000000', 'aheskey3f@dailymail.co.uk', '16049 Dwight Avenue');
INSERT INTO `employees` VALUES ('125', 'Lilah Lucas', '1', '1976-02-02 00:00:00.000000', 'llucas3g@mozilla.com', '00261 Moulton Road');
INSERT INTO `employees` VALUES ('126', 'Meier Evers', '0', '1981-12-28 00:00:00.000000', 'mevers3h@multiply.com', '3157 Armistice Plaza');
INSERT INTO `employees` VALUES ('127', 'Aubrette Domek', '1', '1956-03-03 00:00:00.000000', 'adomek3i@deliciousdays.com', '526 Graedel Terrace');
INSERT INTO `employees` VALUES ('128', 'Christoph Solon', '0', '1986-01-24 00:00:00.000000', 'csolon3j@livejournal.com', '93718 Bluestem Plaza');
INSERT INTO `employees` VALUES ('129', 'Terrence Dutnall', '0', '1973-02-14 00:00:00.000000', 'tdutnall3k@addthis.com', '15441 Maywood Road');
INSERT INTO `employees` VALUES ('130', 'Harriott Pinyon', '0', '1984-12-19 00:00:00.000000', 'hpinyon3l@state.tx.us', '3631 Judy Way');
INSERT INTO `employees` VALUES ('131', 'Toni Tibbetts', '1', '1951-12-29 00:00:00.000000', 'ttibbetts3m@hc360.com', '83180 Namekagon Court');
INSERT INTO `employees` VALUES ('132', 'Felicdad Hugueville', '1', '1951-08-23 00:00:00.000000', 'fhugueville3n@newsvine.com', '256 Karstens Drive');
INSERT INTO `employees` VALUES ('133', 'Lurette Mackison', '0', '1957-07-25 00:00:00.000000', 'lmackison3o@jugem.jp', '9 Paget Parkway');
INSERT INTO `employees` VALUES ('134', 'Elaine Lukianovich', '0', '1961-06-16 00:00:00.000000', 'elukianovich3p@thetimes.co.uk', '0863 Porter Street');
INSERT INTO `employees` VALUES ('135', 'Madeline Emerine', '1', '1977-09-22 00:00:00.000000', 'memerine3q@rambler.ru', '43 Sunfield Alley');
INSERT INTO `employees` VALUES ('136', 'Culver Sharrocks', '1', '1999-01-04 00:00:00.000000', 'csharrocks3r@github.com', '99 Jay Pass');
INSERT INTO `employees` VALUES ('137', 'Brew Powland', '0', '1960-06-12 00:00:00.000000', 'bpowland3s@behance.net', '4856 Esker Center');
INSERT INTO `employees` VALUES ('138', 'Marcelia Cargo', '0', '1998-09-08 00:00:00.000000', 'mcargo3t@bloomberg.com', '651 Village Trail');
INSERT INTO `employees` VALUES ('139', 'Zitella Gahagan', '1', '1952-05-26 00:00:00.000000', 'zgahagan3u@upenn.edu', '3903 3rd Center');
INSERT INTO `employees` VALUES ('140', 'Nathalia Pashba', '0', '1960-09-05 00:00:00.000000', 'npashba3v@microsoft.com', '441 Sugar Drive');
INSERT INTO `employees` VALUES ('141', 'Anne-corinne Stygall', '0', '1950-11-05 00:00:00.000000', 'astygall3w@miitbeian.gov.cn', '3554 Hudson Parkway');
INSERT INTO `employees` VALUES ('142', 'Nicoline Izsak', '0', '1962-09-07 00:00:00.000000', 'nizsak3x@4shared.com', '702 Waxwing Avenue');
INSERT INTO `employees` VALUES ('143', 'Riccardo Willows', '1', '1961-08-03 00:00:00.000000', 'rwillows3y@engadget.com', '8013 Golf Street');
INSERT INTO `employees` VALUES ('144', 'Burnard Orwin', '1', '1995-05-20 00:00:00.000000', 'borwin3z@nps.gov', '6674 Troy Trail');
INSERT INTO `employees` VALUES ('145', 'Dugald Jagiello', '0', '1953-04-16 00:00:00.000000', 'djagiello40@nydailynews.com', '9 Hooker Terrace');
INSERT INTO `employees` VALUES ('146', 'Meggi Neubigging', '0', '1972-03-24 00:00:00.000000', 'mneubigging41@blinklist.com', '0 Melvin Way');
INSERT INTO `employees` VALUES ('147', 'Myer Trevascus', '0', '1969-04-06 00:00:00.000000', 'mtrevascus42@bloglines.com', '4 Brickson Park Junction');
INSERT INTO `employees` VALUES ('148', 'Cynthie Costard', '1', '1967-06-24 00:00:00.000000', 'ccostard43@vkontakte.ru', '109 Goodland Circle');
INSERT INTO `employees` VALUES ('149', 'Heloise Skerme', '0', '1957-07-11 00:00:00.000000', 'hskerme44@tripod.com', '6 Sage Pass');
INSERT INTO `employees` VALUES ('150', 'Odey Munkley', '1', '1988-09-24 00:00:00.000000', 'omunkley45@lulu.com', '736 Bartillon Drive');
INSERT INTO `employees` VALUES ('151', 'Thomasine Emig', '0', '1963-08-26 00:00:00.000000', 'temig46@disqus.com', '46701 Shopko Hill');
INSERT INTO `employees` VALUES ('152', 'Mallory O\'Brien', '1', '1950-07-25 00:00:00.000000', 'mobrien47@apache.org', '90387 Lindbergh Circle');
INSERT INTO `employees` VALUES ('153', 'Bianca Nannini', '0', '1982-02-10 00:00:00.000000', 'bnannini48@wikia.com', '3 Kensington Drive');
INSERT INTO `employees` VALUES ('154', 'Roldan Barnhart', '1', '1952-03-05 00:00:00.000000', 'rbarnhart49@nih.gov', '17 Caliangt Circle');
INSERT INTO `employees` VALUES ('155', 'Drud Teasdale', '0', '1967-04-18 00:00:00.000000', 'dteasdale4a@amazon.co.jp', '2 Declaration Drive');
INSERT INTO `employees` VALUES ('156', 'Heriberto Sparway', '0', '1980-08-10 00:00:00.000000', 'hsparway4b@princeton.edu', '7 Donald Parkway');
INSERT INTO `employees` VALUES ('157', 'Ira Allabarton', '1', '1976-08-09 00:00:00.000000', 'iallabarton4c@foxnews.com', '50 Butterfield Center');
INSERT INTO `employees` VALUES ('158', 'Bancroft Halversen', '0', '1975-01-06 00:00:00.000000', 'bhalversen4d@webnode.com', '0667 Thackeray Parkway');
INSERT INTO `employees` VALUES ('159', 'Harris Hutt', '0', '1982-12-26 00:00:00.000000', 'hhutt4e@bloglovin.com', '2 Hooker Alley');
INSERT INTO `employees` VALUES ('160', 'Bliss Bertomieu', '0', '1960-10-27 00:00:00.000000', 'bbertomieu4f@ameblo.jp', '04943 Coolidge Alley');
INSERT INTO `employees` VALUES ('161', 'Gabriell Origin', '0', '1981-06-18 00:00:00.000000', 'gorigin4g@hc360.com', '782 Rockefeller Circle');
INSERT INTO `employees` VALUES ('162', 'Marketa Duckerin', '0', '1978-08-28 00:00:00.000000', 'mduckerin4h@salon.com', '36 Muir Crossing');
INSERT INTO `employees` VALUES ('163', 'Dyan Fogg', '0', '1950-05-21 00:00:00.000000', 'dfogg4i@nydailynews.com', '8 East Pass');
INSERT INTO `employees` VALUES ('164', 'Far Bockmann', '0', '1974-08-12 00:00:00.000000', 'fbockmann4j@youku.com', '8 Monument Parkway');
INSERT INTO `employees` VALUES ('165', 'Trix Simonelli', '0', '1977-07-17 00:00:00.000000', 'tsimonelli4k@gmpg.org', '172 Shopko Park');
INSERT INTO `employees` VALUES ('166', 'Quintana O\' Meara', '0', '1977-01-07 00:00:00.000000', 'qo4l@wunderground.com', '9865 Manufacturers Point');
INSERT INTO `employees` VALUES ('167', 'Hannah Pickett', '1', '1953-10-07 00:00:00.000000', 'hpickett4m@fda.gov', '1473 Commercial Junction');
INSERT INTO `employees` VALUES ('168', 'Siward Romayn', '0', '1966-02-07 00:00:00.000000', 'sromayn4n@unc.edu', '2385 Warbler Trail');
INSERT INTO `employees` VALUES ('169', 'Kim Byrch', '0', '1972-04-08 00:00:00.000000', 'kbyrch4o@friendfeed.com', '164 Westerfield Pass');
INSERT INTO `employees` VALUES ('170', 'Umberto Studdard', '0', '1989-09-05 00:00:00.000000', 'ustuddard4p@ehow.com', '75 Buhler Drive');
INSERT INTO `employees` VALUES ('171', 'Reggi Snadden', '0', '1973-04-26 00:00:00.000000', 'rsnadden4q@privacy.gov.au', '74 High Crossing Crossing');
INSERT INTO `employees` VALUES ('172', 'Florina Bodle', '1', '1995-07-11 00:00:00.000000', 'fbodle4r@naver.com', '5448 Johnson Center');
INSERT INTO `employees` VALUES ('173', 'Sarena Gudge', '1', '1992-08-15 00:00:00.000000', 'sgudge4s@hao123.com', '92786 Shoshone Crossing');
INSERT INTO `employees` VALUES ('174', 'Elwood Gainsboro', '1', '1995-07-10 00:00:00.000000', 'egainsboro4t@bbb.org', '87 Jackson Point');
INSERT INTO `employees` VALUES ('175', 'Elliot Varah', '1', '1989-07-18 00:00:00.000000', 'evarah4u@istockphoto.com', '873 Colorado Point');
INSERT INTO `employees` VALUES ('176', 'Godfree Whitfeld', '1', '1982-05-07 00:00:00.000000', 'gwhitfeld4v@weather.com', '09 Lukken Point');
INSERT INTO `employees` VALUES ('177', 'Nola Heselwood', '1', '1985-12-02 00:00:00.000000', 'nheselwood4w@vkontakte.ru', '558 Mandrake Lane');
INSERT INTO `employees` VALUES ('178', 'Shela Upson', '1', '1984-08-02 00:00:00.000000', 'supson4x@google.pl', '69886 Nobel Circle');
INSERT INTO `employees` VALUES ('179', 'Lizzie McSkin', '0', '1996-03-19 00:00:00.000000', 'lmcskin4y@sakura.ne.jp', '2 Mesta Alley');
INSERT INTO `employees` VALUES ('180', 'Glendon Morgan', '0', '1964-11-08 00:00:00.000000', 'gmorgan4z@telegraph.co.uk', '6299 Thackeray Lane');
INSERT INTO `employees` VALUES ('181', 'Serena Tremelling', '1', '1962-03-17 00:00:00.000000', 'stremelling50@whitehouse.gov', '837 Waxwing Pass');
INSERT INTO `employees` VALUES ('182', 'Corbin Lansdale', '0', '1955-09-23 00:00:00.000000', 'clansdale51@theguardian.com', '27566 Nobel Hill');
INSERT INTO `employees` VALUES ('183', 'Pace Handrik', '1', '1955-04-02 00:00:00.000000', 'phandrik52@bravesites.com', '5 Westridge Lane');
INSERT INTO `employees` VALUES ('184', 'Koralle Minihane', '1', '1954-03-31 00:00:00.000000', 'kminihane53@studiopress.com', '670 Morningstar Way');
INSERT INTO `employees` VALUES ('185', 'Ninnetta Bakewell', '1', '1994-09-24 00:00:00.000000', 'nbakewell54@admin.ch', '849 Sullivan Lane');
INSERT INTO `employees` VALUES ('186', 'Antons Barstowk', '1', '1981-09-08 00:00:00.000000', 'abarstowk55@sfgate.com', '47 Dixon Trail');
INSERT INTO `employees` VALUES ('187', 'Waylin Hurdis', '0', '1973-09-02 00:00:00.000000', 'whurdis56@epa.gov', '0123 Carpenter Way');
INSERT INTO `employees` VALUES ('188', 'Xever Hadlow', '1', '1986-03-03 00:00:00.000000', 'xhadlow57@merriam-webster.com', '48670 Dottie Lane');
INSERT INTO `employees` VALUES ('189', 'Bobina Knowlys', '1', '1978-10-18 00:00:00.000000', 'bknowlys58@amazon.co.jp', '64 John Wall Parkway');
INSERT INTO `employees` VALUES ('190', 'Sandye Bythell', '0', '1953-05-04 00:00:00.000000', 'sbythell59@friendfeed.com', '24080 Pierstorff Road');
INSERT INTO `employees` VALUES ('191', 'Paulo MacFarlane', '1', '1986-02-08 00:00:00.000000', 'pmacfarlane5a@chron.com', '989 Pond Trail');
INSERT INTO `employees` VALUES ('192', 'Roshelle Mathivet', '1', '1989-06-27 00:00:00.000000', 'rmathivet5b@prlog.org', '3174 Dayton Way');
INSERT INTO `employees` VALUES ('193', 'Terri-jo Edler', '1', '1968-08-15 00:00:00.000000', 'tedler5c@google.de', '2 Anthes Crossing');
INSERT INTO `employees` VALUES ('194', 'Sophie Alvarado', '0', '1958-06-09 00:00:00.000000', 'salvarado5d@independent.co.uk', '3 East Way');
INSERT INTO `employees` VALUES ('195', 'Samantha Carne', '1', '1966-04-29 00:00:00.000000', 'scarne5e@dmoz.org', '15 Fieldstone Pass');
INSERT INTO `employees` VALUES ('196', 'Gerti Cerie', '0', '1966-06-14 00:00:00.000000', 'gcerie5f@odnoklassniki.ru', '75 Golf Course Street');
INSERT INTO `employees` VALUES ('197', 'Nedi Blakeslee', '1', '1978-10-06 00:00:00.000000', 'nblakeslee5g@noaa.gov', '17880 Hoffman Parkway');
INSERT INTO `employees` VALUES ('198', 'Sondra Cottee', '0', '1954-03-23 00:00:00.000000', 'scottee5h@msu.edu', '4013 Fair Oaks Drive');
INSERT INTO `employees` VALUES ('199', 'Yasmeen Scalia', '0', '1987-07-05 00:00:00.000000', 'yscalia5i@multiply.com', '8346 Fuller Circle');
INSERT INTO `employees` VALUES ('200', 'Sam Bearham', '1', '1984-10-23 00:00:00.000000', 'sbearham5j@liveinternet.ru', '16699 Stone Corner Parkway');

-- ----------------------------
-- Table structure for vacations
-- ----------------------------
DROP TABLE IF EXISTS `vacations`;
CREATE TABLE `vacations` (
  `VacationId` int(11) NOT NULL AUTO_INCREMENT,
  `Type` int(11) NOT NULL,
  `StartDate` date NOT NULL,
  `EndDate` date NOT NULL,
  `EmployeeId` int(11) NOT NULL,
  PRIMARY KEY (`VacationId`),
  KEY `IX_Vacations_EmployeeId` (`EmployeeId`),
  CONSTRAINT `FK_Vacations_Employees_EmployeeId` FOREIGN KEY (`EmployeeId`) REFERENCES `employees` (`EmployeeId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=852 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vacations
-- ----------------------------
INSERT INTO `vacations` VALUES ('1', '0', '2015-11-26', '2015-12-11', '109');
INSERT INTO `vacations` VALUES ('2', '1', '2013-06-16', '2013-06-26', '130');
INSERT INTO `vacations` VALUES ('3', '0', '2012-12-25', '2012-12-30', '162');
INSERT INTO `vacations` VALUES ('4', '1', '2015-03-09', '2015-04-08', '134');
INSERT INTO `vacations` VALUES ('5', '2', '2014-03-11', '2014-03-28', '145');
INSERT INTO `vacations` VALUES ('6', '0', '2012-08-01', '2012-08-29', '63');
INSERT INTO `vacations` VALUES ('7', '2', '2015-11-13', '2015-11-27', '162');
INSERT INTO `vacations` VALUES ('8', '0', '2014-05-30', '2014-06-10', '26');
INSERT INTO `vacations` VALUES ('9', '0', '2016-03-13', '2016-03-27', '154');
INSERT INTO `vacations` VALUES ('10', '1', '2014-06-28', '2014-07-20', '148');
INSERT INTO `vacations` VALUES ('11', '1', '2016-06-20', '2016-06-29', '53');
INSERT INTO `vacations` VALUES ('12', '1', '2014-04-19', '2014-05-17', '13');
INSERT INTO `vacations` VALUES ('13', '0', '2015-03-18', '2015-03-30', '168');
INSERT INTO `vacations` VALUES ('14', '1', '2017-04-20', '2017-04-29', '62');
INSERT INTO `vacations` VALUES ('15', '2', '2015-11-28', '2015-12-15', '187');
INSERT INTO `vacations` VALUES ('16', '1', '2015-06-11', '2015-07-08', '77');
INSERT INTO `vacations` VALUES ('17', '2', '2014-05-16', '2014-05-26', '189');
INSERT INTO `vacations` VALUES ('18', '0', '2013-07-20', '2013-08-12', '25');
INSERT INTO `vacations` VALUES ('19', '2', '2016-03-11', '2016-03-19', '56');
INSERT INTO `vacations` VALUES ('20', '2', '2015-12-26', '2016-01-25', '4');
INSERT INTO `vacations` VALUES ('21', '0', '2014-05-18', '2014-06-03', '125');
INSERT INTO `vacations` VALUES ('22', '1', '2016-05-01', '2016-05-14', '92');
INSERT INTO `vacations` VALUES ('23', '0', '2015-01-03', '2015-01-19', '111');
INSERT INTO `vacations` VALUES ('24', '0', '2016-05-23', '2016-06-18', '50');
INSERT INTO `vacations` VALUES ('25', '1', '2015-11-28', '2015-12-13', '151');
INSERT INTO `vacations` VALUES ('26', '1', '2012-07-30', '2012-08-13', '199');
INSERT INTO `vacations` VALUES ('27', '0', '2014-09-18', '2014-10-07', '66');
INSERT INTO `vacations` VALUES ('28', '2', '2014-01-21', '2014-02-07', '78');
INSERT INTO `vacations` VALUES ('29', '2', '2016-06-20', '2016-07-17', '144');
INSERT INTO `vacations` VALUES ('30', '2', '2014-05-05', '2014-05-21', '168');
INSERT INTO `vacations` VALUES ('31', '2', '2016-06-24', '2016-07-23', '192');
INSERT INTO `vacations` VALUES ('32', '2', '2016-04-20', '2016-04-27', '193');
INSERT INTO `vacations` VALUES ('33', '1', '2014-01-28', '2014-02-10', '173');
INSERT INTO `vacations` VALUES ('34', '2', '2016-01-03', '2016-01-26', '90');
INSERT INTO `vacations` VALUES ('35', '1', '2014-10-20', '2014-11-04', '83');
INSERT INTO `vacations` VALUES ('36', '2', '2013-01-07', '2013-01-23', '4');
INSERT INTO `vacations` VALUES ('37', '0', '2017-06-29', '2017-07-14', '22');
INSERT INTO `vacations` VALUES ('38', '2', '2015-08-29', '2015-09-03', '22');
INSERT INTO `vacations` VALUES ('39', '1', '2014-10-12', '2014-11-06', '135');
INSERT INTO `vacations` VALUES ('40', '1', '2015-06-28', '2015-07-17', '132');
INSERT INTO `vacations` VALUES ('41', '2', '2015-04-02', '2015-04-18', '148');
INSERT INTO `vacations` VALUES ('42', '1', '2012-10-12', '2012-11-01', '181');
INSERT INTO `vacations` VALUES ('43', '0', '2017-02-12', '2017-03-05', '12');
INSERT INTO `vacations` VALUES ('44', '2', '2015-08-08', '2015-08-29', '145');
INSERT INTO `vacations` VALUES ('45', '0', '2012-11-17', '2012-12-13', '187');
INSERT INTO `vacations` VALUES ('46', '2', '2013-04-02', '2013-04-27', '47');
INSERT INTO `vacations` VALUES ('47', '2', '2014-02-23', '2014-03-09', '97');
INSERT INTO `vacations` VALUES ('48', '1', '2012-08-07', '2012-09-03', '23');
INSERT INTO `vacations` VALUES ('49', '2', '2015-11-26', '2015-12-16', '4');
INSERT INTO `vacations` VALUES ('50', '2', '2012-07-21', '2012-08-19', '51');
INSERT INTO `vacations` VALUES ('51', '2', '2016-10-09', '2016-10-29', '1');
INSERT INTO `vacations` VALUES ('52', '2', '2015-12-05', '2015-12-13', '121');
INSERT INTO `vacations` VALUES ('53', '2', '2013-03-10', '2013-03-15', '53');
INSERT INTO `vacations` VALUES ('54', '1', '2016-12-14', '2017-01-03', '3');
INSERT INTO `vacations` VALUES ('55', '0', '2013-02-16', '2013-02-26', '160');
INSERT INTO `vacations` VALUES ('56', '1', '2014-02-18', '2014-03-03', '87');
INSERT INTO `vacations` VALUES ('57', '2', '2015-08-22', '2015-08-29', '17');
INSERT INTO `vacations` VALUES ('58', '0', '2013-10-15', '2013-11-14', '53');
INSERT INTO `vacations` VALUES ('59', '2', '2014-11-12', '2014-11-23', '79');
INSERT INTO `vacations` VALUES ('60', '0', '2013-10-24', '2013-11-05', '45');
INSERT INTO `vacations` VALUES ('61', '1', '2017-03-17', '2017-04-06', '5');
INSERT INTO `vacations` VALUES ('62', '1', '2017-03-14', '2017-03-29', '142');
INSERT INTO `vacations` VALUES ('63', '0', '2014-01-14', '2014-02-12', '28');
INSERT INTO `vacations` VALUES ('64', '2', '2013-12-25', '2014-01-21', '153');
INSERT INTO `vacations` VALUES ('65', '2', '2014-11-12', '2014-11-28', '125');
INSERT INTO `vacations` VALUES ('66', '1', '2014-01-30', '2014-02-12', '36');
INSERT INTO `vacations` VALUES ('67', '2', '2014-11-15', '2014-11-29', '156');
INSERT INTO `vacations` VALUES ('68', '2', '2013-09-05', '2013-09-25', '148');
INSERT INTO `vacations` VALUES ('69', '0', '2016-04-17', '2016-05-01', '7');
INSERT INTO `vacations` VALUES ('70', '2', '2013-09-03', '2013-09-19', '30');
INSERT INTO `vacations` VALUES ('71', '2', '2013-08-16', '2013-08-24', '78');
INSERT INTO `vacations` VALUES ('72', '0', '2014-04-16', '2014-05-03', '117');
INSERT INTO `vacations` VALUES ('73', '0', '2016-02-23', '2016-03-17', '164');
INSERT INTO `vacations` VALUES ('74', '1', '2015-02-26', '2015-03-21', '3');
INSERT INTO `vacations` VALUES ('75', '1', '2015-11-30', '2015-12-18', '154');
INSERT INTO `vacations` VALUES ('76', '2', '2015-07-19', '2015-07-31', '65');
INSERT INTO `vacations` VALUES ('77', '0', '2012-09-22', '2012-10-06', '167');
INSERT INTO `vacations` VALUES ('78', '0', '2016-06-14', '2016-06-29', '90');
INSERT INTO `vacations` VALUES ('79', '0', '2014-06-10', '2014-06-29', '160');
INSERT INTO `vacations` VALUES ('80', '0', '2014-01-09', '2014-01-26', '62');
INSERT INTO `vacations` VALUES ('81', '2', '2013-02-06', '2013-03-04', '126');
INSERT INTO `vacations` VALUES ('82', '0', '2012-11-29', '2012-12-08', '67');
INSERT INTO `vacations` VALUES ('83', '2', '2013-06-04', '2013-06-29', '71');
INSERT INTO `vacations` VALUES ('84', '0', '2014-01-29', '2014-02-16', '185');
INSERT INTO `vacations` VALUES ('85', '2', '2014-09-02', '2014-09-12', '169');
INSERT INTO `vacations` VALUES ('86', '1', '2016-03-10', '2016-03-28', '153');
INSERT INTO `vacations` VALUES ('87', '2', '2014-06-03', '2014-06-26', '143');
INSERT INTO `vacations` VALUES ('88', '0', '2016-12-13', '2017-01-07', '180');
INSERT INTO `vacations` VALUES ('89', '1', '2015-04-21', '2015-05-21', '68');
INSERT INTO `vacations` VALUES ('90', '1', '2014-12-23', '2015-01-10', '132');
INSERT INTO `vacations` VALUES ('91', '1', '2015-01-28', '2015-02-19', '195');
INSERT INTO `vacations` VALUES ('92', '1', '2015-06-22', '2015-07-07', '35');
INSERT INTO `vacations` VALUES ('93', '0', '2013-05-18', '2013-05-28', '64');
INSERT INTO `vacations` VALUES ('94', '0', '2016-11-28', '2016-12-03', '170');
INSERT INTO `vacations` VALUES ('95', '0', '2014-11-07', '2014-11-20', '187');
INSERT INTO `vacations` VALUES ('96', '2', '2014-09-26', '2014-10-22', '136');
INSERT INTO `vacations` VALUES ('97', '0', '2014-02-18', '2014-02-27', '165');
INSERT INTO `vacations` VALUES ('98', '0', '2014-08-22', '2014-09-11', '28');
INSERT INTO `vacations` VALUES ('99', '1', '2017-01-16', '2017-01-23', '164');
INSERT INTO `vacations` VALUES ('100', '0', '2013-05-13', '2013-05-21', '185');
INSERT INTO `vacations` VALUES ('101', '0', '2013-07-09', '2013-07-26', '153');
INSERT INTO `vacations` VALUES ('102', '2', '2013-10-02', '2013-11-01', '151');
INSERT INTO `vacations` VALUES ('103', '1', '2013-01-03', '2013-01-31', '183');
INSERT INTO `vacations` VALUES ('104', '2', '2014-11-06', '2014-11-11', '39');
INSERT INTO `vacations` VALUES ('105', '1', '2013-01-11', '2013-02-09', '51');
INSERT INTO `vacations` VALUES ('106', '1', '2014-10-13', '2014-10-18', '76');
INSERT INTO `vacations` VALUES ('107', '0', '2015-09-02', '2015-09-20', '46');
INSERT INTO `vacations` VALUES ('108', '1', '2015-06-26', '2015-07-08', '1');
INSERT INTO `vacations` VALUES ('109', '0', '2013-11-05', '2013-12-04', '171');
INSERT INTO `vacations` VALUES ('110', '0', '2016-03-07', '2016-03-28', '177');
INSERT INTO `vacations` VALUES ('111', '2', '2016-10-16', '2016-11-09', '64');
INSERT INTO `vacations` VALUES ('112', '1', '2013-08-18', '2013-08-30', '109');
INSERT INTO `vacations` VALUES ('113', '1', '2013-11-14', '2013-12-06', '194');
INSERT INTO `vacations` VALUES ('114', '1', '2014-01-04', '2014-01-30', '36');
INSERT INTO `vacations` VALUES ('115', '0', '2014-01-01', '2014-01-21', '58');
INSERT INTO `vacations` VALUES ('116', '0', '2016-09-14', '2016-09-27', '62');
INSERT INTO `vacations` VALUES ('117', '0', '2015-12-29', '2016-01-27', '70');
INSERT INTO `vacations` VALUES ('118', '0', '2015-05-18', '2015-06-04', '114');
INSERT INTO `vacations` VALUES ('119', '1', '2016-02-28', '2016-03-27', '74');
INSERT INTO `vacations` VALUES ('120', '0', '2016-07-18', '2016-07-26', '55');
INSERT INTO `vacations` VALUES ('121', '0', '2014-06-30', '2014-07-26', '153');
INSERT INTO `vacations` VALUES ('122', '2', '2017-01-09', '2017-01-24', '121');
INSERT INTO `vacations` VALUES ('123', '2', '2014-02-18', '2014-02-25', '127');
INSERT INTO `vacations` VALUES ('124', '2', '2014-01-06', '2014-01-17', '136');
INSERT INTO `vacations` VALUES ('125', '0', '2015-05-23', '2015-05-30', '75');
INSERT INTO `vacations` VALUES ('126', '0', '2012-07-17', '2012-07-25', '129');
INSERT INTO `vacations` VALUES ('127', '2', '2014-10-13', '2014-10-23', '93');
INSERT INTO `vacations` VALUES ('128', '0', '2016-10-13', '2016-11-04', '8');
INSERT INTO `vacations` VALUES ('129', '0', '2017-04-10', '2017-05-02', '29');
INSERT INTO `vacations` VALUES ('130', '1', '2015-03-13', '2015-03-23', '160');
INSERT INTO `vacations` VALUES ('131', '0', '2013-04-26', '2013-05-06', '49');
INSERT INTO `vacations` VALUES ('132', '1', '2017-06-24', '2017-07-09', '194');
INSERT INTO `vacations` VALUES ('133', '0', '2017-03-26', '2017-04-06', '70');
INSERT INTO `vacations` VALUES ('134', '1', '2015-09-26', '2015-10-22', '24');
INSERT INTO `vacations` VALUES ('135', '2', '2013-05-22', '2013-06-03', '67');
INSERT INTO `vacations` VALUES ('136', '1', '2014-04-07', '2014-04-26', '137');
INSERT INTO `vacations` VALUES ('137', '2', '2013-12-01', '2013-12-22', '15');
INSERT INTO `vacations` VALUES ('138', '0', '2014-08-14', '2014-08-30', '23');
INSERT INTO `vacations` VALUES ('139', '0', '2012-08-25', '2012-09-18', '198');
INSERT INTO `vacations` VALUES ('140', '1', '2015-02-14', '2015-03-03', '142');
INSERT INTO `vacations` VALUES ('141', '1', '2012-12-29', '2013-01-09', '34');
INSERT INTO `vacations` VALUES ('142', '1', '2016-06-30', '2016-07-23', '83');
INSERT INTO `vacations` VALUES ('143', '2', '2016-06-08', '2016-06-17', '199');
INSERT INTO `vacations` VALUES ('144', '2', '2012-10-11', '2012-10-23', '97');
INSERT INTO `vacations` VALUES ('145', '0', '2016-03-16', '2016-04-09', '179');
INSERT INTO `vacations` VALUES ('146', '1', '2013-05-04', '2013-05-15', '95');
INSERT INTO `vacations` VALUES ('147', '1', '2014-07-05', '2014-07-27', '87');
INSERT INTO `vacations` VALUES ('148', '0', '2013-12-29', '2014-01-08', '99');
INSERT INTO `vacations` VALUES ('149', '2', '2014-04-11', '2014-05-05', '64');
INSERT INTO `vacations` VALUES ('150', '0', '2015-09-06', '2015-10-02', '175');
INSERT INTO `vacations` VALUES ('151', '0', '2015-08-29', '2015-09-04', '93');
INSERT INTO `vacations` VALUES ('152', '1', '2012-10-11', '2012-11-05', '181');
INSERT INTO `vacations` VALUES ('153', '0', '2012-12-15', '2013-01-01', '192');
INSERT INTO `vacations` VALUES ('154', '2', '2017-01-01', '2017-01-19', '78');
INSERT INTO `vacations` VALUES ('155', '1', '2016-05-21', '2016-06-16', '100');
INSERT INTO `vacations` VALUES ('156', '2', '2015-12-04', '2015-12-25', '109');
INSERT INTO `vacations` VALUES ('157', '2', '2016-02-27', '2016-03-27', '132');
INSERT INTO `vacations` VALUES ('158', '1', '2012-07-26', '2012-08-21', '154');
INSERT INTO `vacations` VALUES ('159', '2', '2015-07-20', '2015-08-08', '167');
INSERT INTO `vacations` VALUES ('160', '2', '2017-04-01', '2017-04-08', '113');
INSERT INTO `vacations` VALUES ('161', '1', '2014-12-20', '2015-01-18', '103');
INSERT INTO `vacations` VALUES ('162', '1', '2012-07-16', '2012-07-25', '157');
INSERT INTO `vacations` VALUES ('163', '2', '2013-01-28', '2013-02-21', '50');
INSERT INTO `vacations` VALUES ('164', '1', '2013-07-13', '2013-08-10', '40');
INSERT INTO `vacations` VALUES ('165', '2', '2016-08-03', '2016-08-20', '67');
INSERT INTO `vacations` VALUES ('166', '2', '2012-10-23', '2012-11-12', '72');
INSERT INTO `vacations` VALUES ('167', '1', '2015-01-12', '2015-02-09', '57');
INSERT INTO `vacations` VALUES ('168', '2', '2012-07-15', '2012-08-02', '121');
INSERT INTO `vacations` VALUES ('169', '2', '2015-09-29', '2015-10-04', '78');
INSERT INTO `vacations` VALUES ('170', '1', '2015-12-27', '2016-01-07', '107');
INSERT INTO `vacations` VALUES ('171', '1', '2017-06-05', '2017-06-12', '110');
INSERT INTO `vacations` VALUES ('172', '1', '2014-06-08', '2014-06-21', '191');
INSERT INTO `vacations` VALUES ('173', '2', '2014-05-22', '2014-06-05', '96');
INSERT INTO `vacations` VALUES ('174', '2', '2016-05-22', '2016-06-07', '52');
INSERT INTO `vacations` VALUES ('175', '2', '2012-07-17', '2012-08-13', '110');
INSERT INTO `vacations` VALUES ('176', '1', '2016-10-13', '2016-11-08', '141');
INSERT INTO `vacations` VALUES ('177', '1', '2013-03-13', '2013-03-23', '98');
INSERT INTO `vacations` VALUES ('178', '0', '2016-02-08', '2016-03-09', '51');
INSERT INTO `vacations` VALUES ('179', '1', '2015-10-12', '2015-10-27', '184');
INSERT INTO `vacations` VALUES ('180', '0', '2013-09-09', '2013-10-08', '150');
INSERT INTO `vacations` VALUES ('181', '2', '2013-09-26', '2013-10-23', '66');
INSERT INTO `vacations` VALUES ('182', '1', '2013-05-05', '2013-05-30', '176');
INSERT INTO `vacations` VALUES ('183', '0', '2015-09-02', '2015-09-12', '46');
INSERT INTO `vacations` VALUES ('184', '1', '2015-02-21', '2015-03-21', '159');
INSERT INTO `vacations` VALUES ('185', '2', '2013-09-10', '2013-09-25', '87');
INSERT INTO `vacations` VALUES ('186', '0', '2013-09-05', '2013-10-02', '158');
INSERT INTO `vacations` VALUES ('187', '2', '2014-05-29', '2014-06-15', '144');
INSERT INTO `vacations` VALUES ('188', '0', '2015-01-24', '2015-02-13', '141');
INSERT INTO `vacations` VALUES ('189', '0', '2016-06-07', '2016-06-14', '97');
INSERT INTO `vacations` VALUES ('190', '2', '2016-07-03', '2016-07-25', '176');
INSERT INTO `vacations` VALUES ('191', '0', '2016-04-09', '2016-04-18', '74');
INSERT INTO `vacations` VALUES ('192', '2', '2012-11-28', '2012-12-10', '183');
INSERT INTO `vacations` VALUES ('193', '0', '2012-08-14', '2012-09-01', '52');
INSERT INTO `vacations` VALUES ('194', '0', '2016-07-13', '2016-07-29', '141');
INSERT INTO `vacations` VALUES ('195', '0', '2012-11-24', '2012-11-29', '4');
INSERT INTO `vacations` VALUES ('196', '1', '2015-10-11', '2015-10-19', '53');
INSERT INTO `vacations` VALUES ('197', '0', '2016-08-05', '2016-08-18', '39');
INSERT INTO `vacations` VALUES ('198', '2', '2015-07-25', '2015-08-04', '46');
INSERT INTO `vacations` VALUES ('199', '2', '2016-02-10', '2016-02-23', '106');
INSERT INTO `vacations` VALUES ('200', '1', '2013-06-27', '2013-07-08', '53');
INSERT INTO `vacations` VALUES ('201', '2', '2013-09-30', '2013-10-09', '182');
INSERT INTO `vacations` VALUES ('202', '0', '2017-04-12', '2017-04-21', '137');
INSERT INTO `vacations` VALUES ('203', '2', '2016-12-07', '2016-12-12', '145');
INSERT INTO `vacations` VALUES ('204', '1', '2013-02-28', '2013-03-20', '42');
INSERT INTO `vacations` VALUES ('205', '0', '2017-04-12', '2017-04-27', '31');
INSERT INTO `vacations` VALUES ('206', '0', '2014-09-25', '2014-10-07', '70');
INSERT INTO `vacations` VALUES ('207', '0', '2013-11-12', '2013-11-20', '175');
INSERT INTO `vacations` VALUES ('208', '1', '2016-04-01', '2016-04-12', '149');
INSERT INTO `vacations` VALUES ('209', '2', '2014-06-08', '2014-06-16', '154');
INSERT INTO `vacations` VALUES ('210', '2', '2014-07-05', '2014-08-03', '185');
INSERT INTO `vacations` VALUES ('211', '2', '2015-10-06', '2015-11-01', '68');
INSERT INTO `vacations` VALUES ('212', '0', '2015-01-23', '2015-01-31', '120');
INSERT INTO `vacations` VALUES ('213', '2', '2012-09-01', '2012-09-23', '21');
INSERT INTO `vacations` VALUES ('214', '0', '2013-11-25', '2013-12-06', '18');
INSERT INTO `vacations` VALUES ('215', '2', '2015-03-09', '2015-03-28', '163');
INSERT INTO `vacations` VALUES ('216', '0', '2015-12-16', '2016-01-14', '113');
INSERT INTO `vacations` VALUES ('217', '2', '2015-06-24', '2015-07-12', '178');
INSERT INTO `vacations` VALUES ('218', '1', '2015-07-09', '2015-07-21', '170');
INSERT INTO `vacations` VALUES ('219', '2', '2015-12-21', '2016-01-15', '79');
INSERT INTO `vacations` VALUES ('220', '1', '2013-03-25', '2013-04-09', '122');
INSERT INTO `vacations` VALUES ('221', '2', '2014-01-21', '2014-02-04', '11');
INSERT INTO `vacations` VALUES ('222', '1', '2015-08-25', '2015-09-11', '142');
INSERT INTO `vacations` VALUES ('223', '1', '2013-07-12', '2013-08-10', '5');
INSERT INTO `vacations` VALUES ('224', '2', '2015-12-17', '2016-01-11', '117');
INSERT INTO `vacations` VALUES ('225', '2', '2015-08-16', '2015-08-23', '24');
INSERT INTO `vacations` VALUES ('226', '0', '2014-09-16', '2014-10-10', '69');
INSERT INTO `vacations` VALUES ('227', '0', '2014-12-29', '2015-01-24', '9');
INSERT INTO `vacations` VALUES ('228', '2', '2015-01-05', '2015-01-12', '171');
INSERT INTO `vacations` VALUES ('229', '2', '2013-04-23', '2013-05-05', '180');
INSERT INTO `vacations` VALUES ('230', '2', '2013-06-03', '2013-06-26', '82');
INSERT INTO `vacations` VALUES ('231', '2', '2014-01-23', '2014-02-02', '188');
INSERT INTO `vacations` VALUES ('232', '1', '2016-11-22', '2016-12-21', '55');
INSERT INTO `vacations` VALUES ('233', '2', '2014-10-12', '2014-10-24', '12');
INSERT INTO `vacations` VALUES ('234', '2', '2015-05-29', '2015-06-21', '90');
INSERT INTO `vacations` VALUES ('235', '1', '2015-07-03', '2015-07-18', '58');
INSERT INTO `vacations` VALUES ('236', '2', '2014-06-15', '2014-07-14', '121');
INSERT INTO `vacations` VALUES ('237', '0', '2015-07-22', '2015-08-09', '93');
INSERT INTO `vacations` VALUES ('238', '0', '2015-05-14', '2015-06-02', '138');
INSERT INTO `vacations` VALUES ('239', '2', '2013-06-04', '2013-07-04', '140');
INSERT INTO `vacations` VALUES ('240', '0', '2012-09-02', '2012-09-18', '187');
INSERT INTO `vacations` VALUES ('241', '0', '2015-09-06', '2015-09-24', '65');
INSERT INTO `vacations` VALUES ('242', '1', '2012-10-30', '2012-11-27', '35');
INSERT INTO `vacations` VALUES ('243', '2', '2015-02-06', '2015-02-17', '183');
INSERT INTO `vacations` VALUES ('244', '1', '2013-11-13', '2013-12-11', '79');
INSERT INTO `vacations` VALUES ('245', '1', '2014-03-17', '2014-04-15', '123');
INSERT INTO `vacations` VALUES ('246', '1', '2017-05-17', '2017-05-25', '159');
INSERT INTO `vacations` VALUES ('247', '0', '2013-09-12', '2013-09-18', '153');
INSERT INTO `vacations` VALUES ('248', '1', '2014-02-14', '2014-02-27', '145');
INSERT INTO `vacations` VALUES ('249', '0', '2013-10-23', '2013-11-21', '123');
INSERT INTO `vacations` VALUES ('250', '1', '2017-02-05', '2017-02-27', '165');
INSERT INTO `vacations` VALUES ('251', '2', '2013-07-15', '2013-08-01', '34');
INSERT INTO `vacations` VALUES ('252', '1', '2013-03-09', '2013-03-23', '61');
INSERT INTO `vacations` VALUES ('253', '2', '2013-06-09', '2013-07-01', '195');
INSERT INTO `vacations` VALUES ('254', '2', '2012-08-30', '2012-09-12', '30');
INSERT INTO `vacations` VALUES ('255', '2', '2013-08-21', '2013-09-18', '136');
INSERT INTO `vacations` VALUES ('256', '1', '2015-11-26', '2015-12-22', '61');
INSERT INTO `vacations` VALUES ('257', '2', '2016-11-13', '2016-11-21', '29');
INSERT INTO `vacations` VALUES ('258', '2', '2017-01-18', '2017-01-31', '1');
INSERT INTO `vacations` VALUES ('259', '2', '2013-03-13', '2013-03-20', '15');
INSERT INTO `vacations` VALUES ('260', '2', '2014-10-10', '2014-11-02', '127');
INSERT INTO `vacations` VALUES ('261', '2', '2013-08-30', '2013-09-06', '27');
INSERT INTO `vacations` VALUES ('262', '1', '2015-02-07', '2015-02-19', '55');
INSERT INTO `vacations` VALUES ('263', '0', '2015-05-04', '2015-06-02', '151');
INSERT INTO `vacations` VALUES ('264', '0', '2013-03-15', '2013-03-20', '65');
INSERT INTO `vacations` VALUES ('265', '2', '2015-11-20', '2015-12-08', '141');
INSERT INTO `vacations` VALUES ('266', '1', '2012-11-06', '2012-11-12', '43');
INSERT INTO `vacations` VALUES ('267', '0', '2014-10-04', '2014-11-02', '128');
INSERT INTO `vacations` VALUES ('268', '1', '2014-01-16', '2014-02-13', '151');
INSERT INTO `vacations` VALUES ('269', '0', '2017-01-04', '2017-01-14', '6');
INSERT INTO `vacations` VALUES ('270', '1', '2017-05-23', '2017-06-15', '141');
INSERT INTO `vacations` VALUES ('271', '0', '2014-05-29', '2014-06-03', '139');
INSERT INTO `vacations` VALUES ('272', '0', '2012-10-20', '2012-11-10', '16');
INSERT INTO `vacations` VALUES ('273', '2', '2015-01-19', '2015-01-29', '131');
INSERT INTO `vacations` VALUES ('274', '2', '2015-07-08', '2015-07-18', '167');
INSERT INTO `vacations` VALUES ('275', '1', '2013-02-16', '2013-03-17', '29');
INSERT INTO `vacations` VALUES ('276', '2', '2016-04-20', '2016-05-13', '181');
INSERT INTO `vacations` VALUES ('277', '0', '2017-03-04', '2017-03-14', '78');
INSERT INTO `vacations` VALUES ('278', '1', '2012-11-13', '2012-11-25', '82');
INSERT INTO `vacations` VALUES ('279', '2', '2013-04-23', '2013-05-04', '166');
INSERT INTO `vacations` VALUES ('280', '0', '2012-10-06', '2012-10-25', '24');
INSERT INTO `vacations` VALUES ('281', '0', '2013-03-30', '2013-04-18', '3');
INSERT INTO `vacations` VALUES ('282', '0', '2014-10-31', '2014-11-10', '93');
INSERT INTO `vacations` VALUES ('283', '1', '2017-01-10', '2017-01-31', '102');
INSERT INTO `vacations` VALUES ('284', '2', '2013-03-05', '2013-03-31', '110');
INSERT INTO `vacations` VALUES ('285', '0', '2013-01-30', '2013-02-24', '192');
INSERT INTO `vacations` VALUES ('286', '0', '2014-03-21', '2014-03-29', '125');
INSERT INTO `vacations` VALUES ('287', '1', '2015-12-05', '2016-01-03', '68');
INSERT INTO `vacations` VALUES ('288', '1', '2013-12-22', '2014-01-18', '87');
INSERT INTO `vacations` VALUES ('289', '1', '2013-09-22', '2013-10-14', '62');
INSERT INTO `vacations` VALUES ('290', '2', '2013-10-29', '2013-11-18', '80');
INSERT INTO `vacations` VALUES ('291', '1', '2014-06-04', '2014-06-27', '98');
INSERT INTO `vacations` VALUES ('292', '2', '2014-10-11', '2014-11-05', '47');
INSERT INTO `vacations` VALUES ('293', '1', '2012-07-14', '2012-07-28', '160');
INSERT INTO `vacations` VALUES ('294', '2', '2013-03-18', '2013-04-01', '45');
INSERT INTO `vacations` VALUES ('295', '0', '2015-01-26', '2015-02-11', '154');
INSERT INTO `vacations` VALUES ('296', '2', '2014-01-18', '2014-02-08', '10');
INSERT INTO `vacations` VALUES ('297', '1', '2017-01-09', '2017-01-22', '65');
INSERT INTO `vacations` VALUES ('298', '0', '2013-02-16', '2013-03-18', '122');
INSERT INTO `vacations` VALUES ('299', '0', '2015-12-22', '2016-01-06', '191');
INSERT INTO `vacations` VALUES ('300', '0', '2017-06-11', '2017-07-04', '112');
INSERT INTO `vacations` VALUES ('301', '2', '2016-07-18', '2016-07-30', '186');
INSERT INTO `vacations` VALUES ('302', '0', '2013-02-19', '2013-03-16', '144');
INSERT INTO `vacations` VALUES ('303', '1', '2015-09-18', '2015-10-13', '2');
INSERT INTO `vacations` VALUES ('304', '2', '2016-09-29', '2016-10-21', '102');
INSERT INTO `vacations` VALUES ('305', '2', '2016-11-08', '2016-11-30', '193');
INSERT INTO `vacations` VALUES ('306', '0', '2012-09-16', '2012-09-29', '99');
INSERT INTO `vacations` VALUES ('307', '1', '2013-11-06', '2013-12-03', '68');
INSERT INTO `vacations` VALUES ('308', '1', '2014-10-01', '2014-10-23', '117');
INSERT INTO `vacations` VALUES ('309', '0', '2015-08-19', '2015-08-30', '107');
INSERT INTO `vacations` VALUES ('310', '1', '2014-04-25', '2014-05-18', '154');
INSERT INTO `vacations` VALUES ('311', '0', '2016-11-20', '2016-12-03', '118');
INSERT INTO `vacations` VALUES ('312', '1', '2016-03-28', '2016-04-08', '137');
INSERT INTO `vacations` VALUES ('313', '1', '2015-07-02', '2015-07-27', '192');
INSERT INTO `vacations` VALUES ('314', '1', '2014-07-30', '2014-08-22', '139');
INSERT INTO `vacations` VALUES ('315', '1', '2016-06-13', '2016-07-13', '70');
INSERT INTO `vacations` VALUES ('316', '0', '2015-08-16', '2015-09-08', '187');
INSERT INTO `vacations` VALUES ('317', '2', '2015-09-01', '2015-09-11', '1');
INSERT INTO `vacations` VALUES ('318', '0', '2015-02-07', '2015-03-04', '115');
INSERT INTO `vacations` VALUES ('319', '0', '2014-06-10', '2014-06-28', '97');
INSERT INTO `vacations` VALUES ('320', '2', '2017-01-10', '2017-02-05', '188');
INSERT INTO `vacations` VALUES ('321', '1', '2015-10-26', '2015-11-02', '128');
INSERT INTO `vacations` VALUES ('322', '0', '2012-09-24', '2012-10-15', '87');
INSERT INTO `vacations` VALUES ('323', '2', '2012-09-23', '2012-10-21', '129');
INSERT INTO `vacations` VALUES ('324', '1', '2014-06-27', '2014-07-05', '8');
INSERT INTO `vacations` VALUES ('325', '1', '2014-02-18', '2014-03-19', '179');
INSERT INTO `vacations` VALUES ('326', '0', '2016-06-09', '2016-06-15', '115');
INSERT INTO `vacations` VALUES ('327', '2', '2013-08-26', '2013-09-17', '154');
INSERT INTO `vacations` VALUES ('328', '2', '2016-12-18', '2016-12-24', '178');
INSERT INTO `vacations` VALUES ('329', '2', '2015-08-04', '2015-08-15', '78');
INSERT INTO `vacations` VALUES ('330', '2', '2013-04-15', '2013-05-07', '13');
INSERT INTO `vacations` VALUES ('331', '0', '2016-01-29', '2016-02-24', '60');
INSERT INTO `vacations` VALUES ('332', '0', '2016-11-27', '2016-12-22', '115');
INSERT INTO `vacations` VALUES ('333', '1', '2013-12-25', '2014-01-22', '60');
INSERT INTO `vacations` VALUES ('334', '1', '2014-02-20', '2014-02-25', '144');
INSERT INTO `vacations` VALUES ('335', '0', '2013-04-18', '2013-05-16', '192');
INSERT INTO `vacations` VALUES ('336', '0', '2016-05-25', '2016-06-10', '13');
INSERT INTO `vacations` VALUES ('337', '0', '2013-11-23', '2013-12-17', '50');
INSERT INTO `vacations` VALUES ('338', '0', '2015-11-08', '2015-11-15', '183');
INSERT INTO `vacations` VALUES ('339', '2', '2013-12-20', '2014-01-08', '14');
INSERT INTO `vacations` VALUES ('340', '2', '2014-04-30', '2014-05-23', '197');
INSERT INTO `vacations` VALUES ('341', '0', '2017-03-01', '2017-03-27', '161');
INSERT INTO `vacations` VALUES ('342', '2', '2016-12-03', '2016-12-28', '149');
INSERT INTO `vacations` VALUES ('343', '1', '2012-11-26', '2012-12-04', '78');
INSERT INTO `vacations` VALUES ('344', '2', '2014-05-09', '2014-05-24', '112');
INSERT INTO `vacations` VALUES ('345', '2', '2012-08-28', '2012-09-16', '121');
INSERT INTO `vacations` VALUES ('346', '0', '2015-09-27', '2015-10-08', '99');
INSERT INTO `vacations` VALUES ('347', '2', '2016-12-30', '2017-01-24', '156');
INSERT INTO `vacations` VALUES ('348', '2', '2016-07-11', '2016-07-19', '146');
INSERT INTO `vacations` VALUES ('349', '2', '2017-03-11', '2017-04-04', '20');
INSERT INTO `vacations` VALUES ('350', '2', '2016-09-22', '2016-09-30', '137');
INSERT INTO `vacations` VALUES ('351', '0', '2014-12-30', '2015-01-22', '137');
INSERT INTO `vacations` VALUES ('352', '0', '2014-03-14', '2014-03-21', '104');
INSERT INTO `vacations` VALUES ('353', '2', '2014-05-02', '2014-05-08', '11');
INSERT INTO `vacations` VALUES ('354', '2', '2014-03-14', '2014-03-19', '62');
INSERT INTO `vacations` VALUES ('355', '0', '2012-11-08', '2012-11-24', '160');
INSERT INTO `vacations` VALUES ('356', '0', '2013-09-26', '2013-10-03', '19');
INSERT INTO `vacations` VALUES ('357', '0', '2015-11-20', '2015-11-25', '97');
INSERT INTO `vacations` VALUES ('358', '2', '2015-05-12', '2015-06-06', '111');
INSERT INTO `vacations` VALUES ('359', '2', '2012-12-27', '2013-01-17', '158');
INSERT INTO `vacations` VALUES ('360', '1', '2013-04-06', '2013-05-01', '97');
INSERT INTO `vacations` VALUES ('361', '0', '2016-10-17', '2016-11-16', '59');
INSERT INTO `vacations` VALUES ('362', '1', '2014-06-25', '2014-06-30', '135');
INSERT INTO `vacations` VALUES ('363', '0', '2014-08-01', '2014-08-14', '183');
INSERT INTO `vacations` VALUES ('364', '1', '2012-11-23', '2012-12-01', '19');
INSERT INTO `vacations` VALUES ('365', '1', '2015-08-02', '2015-08-20', '50');
INSERT INTO `vacations` VALUES ('366', '2', '2016-05-14', '2016-06-07', '113');
INSERT INTO `vacations` VALUES ('367', '1', '2013-04-17', '2013-05-15', '169');
INSERT INTO `vacations` VALUES ('368', '0', '2017-05-01', '2017-05-20', '77');
INSERT INTO `vacations` VALUES ('369', '0', '2017-03-27', '2017-04-20', '186');
INSERT INTO `vacations` VALUES ('370', '2', '2015-11-23', '2015-12-03', '196');
INSERT INTO `vacations` VALUES ('371', '2', '2014-11-02', '2014-12-02', '171');
INSERT INTO `vacations` VALUES ('372', '0', '2017-01-24', '2017-02-11', '87');
INSERT INTO `vacations` VALUES ('373', '2', '2013-05-23', '2013-06-12', '18');
INSERT INTO `vacations` VALUES ('374', '0', '2016-12-07', '2016-12-19', '148');
INSERT INTO `vacations` VALUES ('375', '1', '2014-10-23', '2014-10-30', '130');
INSERT INTO `vacations` VALUES ('376', '1', '2015-03-25', '2015-04-06', '27');
INSERT INTO `vacations` VALUES ('377', '1', '2015-11-02', '2015-11-24', '106');
INSERT INTO `vacations` VALUES ('378', '2', '2013-12-25', '2014-01-02', '15');
INSERT INTO `vacations` VALUES ('379', '2', '2015-03-01', '2015-03-25', '101');
INSERT INTO `vacations` VALUES ('380', '0', '2012-09-13', '2012-10-13', '198');
INSERT INTO `vacations` VALUES ('381', '2', '2015-12-08', '2015-12-29', '63');
INSERT INTO `vacations` VALUES ('382', '2', '2016-02-25', '2016-03-11', '16');
INSERT INTO `vacations` VALUES ('383', '0', '2013-02-12', '2013-02-25', '17');
INSERT INTO `vacations` VALUES ('384', '2', '2015-09-10', '2015-09-24', '127');
INSERT INTO `vacations` VALUES ('385', '1', '2014-11-22', '2014-12-14', '65');
INSERT INTO `vacations` VALUES ('386', '1', '2015-04-08', '2015-04-23', '34');
INSERT INTO `vacations` VALUES ('387', '1', '2015-11-25', '2015-12-10', '141');
INSERT INTO `vacations` VALUES ('388', '1', '2013-01-02', '2013-01-10', '107');
INSERT INTO `vacations` VALUES ('389', '2', '2017-05-01', '2017-05-07', '158');
INSERT INTO `vacations` VALUES ('390', '2', '2013-07-18', '2013-08-04', '27');
INSERT INTO `vacations` VALUES ('391', '2', '2017-07-04', '2017-07-09', '109');
INSERT INTO `vacations` VALUES ('392', '1', '2016-01-18', '2016-02-11', '50');
INSERT INTO `vacations` VALUES ('393', '0', '2013-05-18', '2013-05-27', '87');
INSERT INTO `vacations` VALUES ('394', '0', '2015-01-07', '2015-01-12', '36');
INSERT INTO `vacations` VALUES ('395', '0', '2015-01-23', '2015-02-13', '53');
INSERT INTO `vacations` VALUES ('396', '0', '2014-08-02', '2014-08-30', '50');
INSERT INTO `vacations` VALUES ('397', '2', '2016-08-21', '2016-09-20', '57');
INSERT INTO `vacations` VALUES ('398', '2', '2015-03-21', '2015-04-15', '48');
INSERT INTO `vacations` VALUES ('399', '0', '2013-01-29', '2013-02-18', '94');
INSERT INTO `vacations` VALUES ('400', '1', '2013-09-02', '2013-09-14', '189');
INSERT INTO `vacations` VALUES ('401', '2', '2015-10-20', '2015-11-04', '52');
INSERT INTO `vacations` VALUES ('402', '2', '2016-04-26', '2016-05-20', '24');
INSERT INTO `vacations` VALUES ('403', '1', '2016-07-24', '2016-08-21', '181');
INSERT INTO `vacations` VALUES ('404', '0', '2016-08-14', '2016-09-06', '162');
INSERT INTO `vacations` VALUES ('405', '1', '2014-11-25', '2014-12-11', '28');
INSERT INTO `vacations` VALUES ('406', '1', '2017-07-11', '2017-07-21', '173');
INSERT INTO `vacations` VALUES ('407', '2', '2015-07-01', '2015-07-23', '114');
INSERT INTO `vacations` VALUES ('408', '0', '2013-07-24', '2013-08-13', '39');
INSERT INTO `vacations` VALUES ('409', '1', '2014-12-01', '2014-12-07', '59');
INSERT INTO `vacations` VALUES ('410', '1', '2016-05-21', '2016-06-10', '150');
INSERT INTO `vacations` VALUES ('411', '0', '2014-06-21', '2014-07-12', '183');
INSERT INTO `vacations` VALUES ('412', '1', '2013-10-09', '2013-11-07', '23');
INSERT INTO `vacations` VALUES ('413', '0', '2015-10-13', '2015-10-29', '14');
INSERT INTO `vacations` VALUES ('414', '1', '2017-03-30', '2017-04-09', '184');
INSERT INTO `vacations` VALUES ('415', '2', '2015-10-02', '2015-10-21', '70');
INSERT INTO `vacations` VALUES ('416', '0', '2015-07-14', '2015-08-06', '54');
INSERT INTO `vacations` VALUES ('417', '0', '2015-02-01', '2015-02-18', '110');
INSERT INTO `vacations` VALUES ('418', '0', '2012-09-30', '2012-10-23', '138');
INSERT INTO `vacations` VALUES ('419', '1', '2014-11-18', '2014-12-05', '129');
INSERT INTO `vacations` VALUES ('420', '0', '2015-09-03', '2015-09-18', '87');
INSERT INTO `vacations` VALUES ('421', '1', '2016-10-02', '2016-10-10', '71');
INSERT INTO `vacations` VALUES ('422', '2', '2013-05-26', '2013-06-18', '117');
INSERT INTO `vacations` VALUES ('423', '0', '2012-09-21', '2012-10-14', '193');
INSERT INTO `vacations` VALUES ('424', '1', '2014-10-06', '2014-10-21', '26');
INSERT INTO `vacations` VALUES ('425', '2', '2014-02-20', '2014-03-19', '166');
INSERT INTO `vacations` VALUES ('426', '0', '2013-05-10', '2013-06-04', '93');
INSERT INTO `vacations` VALUES ('427', '2', '2014-07-11', '2014-07-17', '184');
INSERT INTO `vacations` VALUES ('428', '1', '2013-09-03', '2013-09-14', '57');
INSERT INTO `vacations` VALUES ('429', '1', '2014-02-09', '2014-02-20', '182');
INSERT INTO `vacations` VALUES ('430', '1', '2016-11-22', '2016-12-06', '161');
INSERT INTO `vacations` VALUES ('431', '2', '2013-09-13', '2013-10-12', '8');
INSERT INTO `vacations` VALUES ('432', '0', '2017-05-03', '2017-05-11', '157');
INSERT INTO `vacations` VALUES ('433', '2', '2013-05-07', '2013-05-31', '181');
INSERT INTO `vacations` VALUES ('434', '2', '2013-03-02', '2013-03-11', '99');
INSERT INTO `vacations` VALUES ('435', '1', '2015-09-19', '2015-10-09', '126');
INSERT INTO `vacations` VALUES ('436', '2', '2014-01-23', '2014-01-30', '89');
INSERT INTO `vacations` VALUES ('437', '1', '2014-04-18', '2014-05-07', '122');
INSERT INTO `vacations` VALUES ('438', '2', '2016-03-14', '2016-04-10', '142');
INSERT INTO `vacations` VALUES ('439', '1', '2015-03-01', '2015-03-30', '13');
INSERT INTO `vacations` VALUES ('440', '1', '2015-07-12', '2015-07-17', '147');
INSERT INTO `vacations` VALUES ('441', '1', '2012-11-05', '2012-11-14', '180');
INSERT INTO `vacations` VALUES ('442', '1', '2015-02-07', '2015-02-13', '161');
INSERT INTO `vacations` VALUES ('443', '1', '2017-04-06', '2017-05-06', '164');
INSERT INTO `vacations` VALUES ('444', '1', '2016-04-19', '2016-05-18', '174');
INSERT INTO `vacations` VALUES ('445', '2', '2016-04-02', '2016-04-18', '57');
INSERT INTO `vacations` VALUES ('446', '0', '2013-09-16', '2013-10-02', '182');
INSERT INTO `vacations` VALUES ('447', '0', '2014-06-14', '2014-06-29', '59');
INSERT INTO `vacations` VALUES ('448', '2', '2017-03-14', '2017-03-23', '194');
INSERT INTO `vacations` VALUES ('449', '2', '2012-11-08', '2012-11-30', '77');
INSERT INTO `vacations` VALUES ('450', '0', '2013-09-11', '2013-09-30', '52');
INSERT INTO `vacations` VALUES ('451', '1', '2013-10-24', '2013-11-11', '40');
INSERT INTO `vacations` VALUES ('452', '2', '2015-04-23', '2015-05-16', '88');
INSERT INTO `vacations` VALUES ('453', '0', '2013-03-29', '2013-04-11', '82');
INSERT INTO `vacations` VALUES ('454', '0', '2016-10-06', '2016-10-21', '194');
INSERT INTO `vacations` VALUES ('455', '0', '2013-07-20', '2013-08-13', '67');
INSERT INTO `vacations` VALUES ('456', '1', '2014-08-17', '2014-08-25', '153');
INSERT INTO `vacations` VALUES ('457', '1', '2014-11-06', '2014-12-05', '119');
INSERT INTO `vacations` VALUES ('458', '2', '2014-05-24', '2014-05-30', '7');
INSERT INTO `vacations` VALUES ('459', '0', '2013-01-23', '2013-02-18', '53');
INSERT INTO `vacations` VALUES ('460', '1', '2016-05-12', '2016-05-29', '152');
INSERT INTO `vacations` VALUES ('461', '2', '2014-01-25', '2014-02-24', '185');
INSERT INTO `vacations` VALUES ('462', '2', '2014-08-20', '2014-09-01', '118');
INSERT INTO `vacations` VALUES ('463', '2', '2015-05-14', '2015-06-12', '96');
INSERT INTO `vacations` VALUES ('464', '2', '2012-08-24', '2012-09-02', '156');
INSERT INTO `vacations` VALUES ('465', '2', '2016-07-01', '2016-07-25', '36');
INSERT INTO `vacations` VALUES ('466', '1', '2012-08-12', '2012-08-27', '170');
INSERT INTO `vacations` VALUES ('467', '0', '2014-03-04', '2014-03-29', '154');
INSERT INTO `vacations` VALUES ('468', '0', '2016-09-25', '2016-10-12', '154');
INSERT INTO `vacations` VALUES ('469', '0', '2014-01-31', '2014-02-10', '54');
INSERT INTO `vacations` VALUES ('470', '2', '2014-11-11', '2014-11-19', '95');
INSERT INTO `vacations` VALUES ('471', '1', '2017-06-08', '2017-06-16', '45');
INSERT INTO `vacations` VALUES ('472', '0', '2016-09-02', '2016-09-18', '166');
INSERT INTO `vacations` VALUES ('473', '1', '2013-05-03', '2013-06-01', '148');
INSERT INTO `vacations` VALUES ('474', '1', '2015-06-06', '2015-06-23', '74');
INSERT INTO `vacations` VALUES ('475', '2', '2014-11-23', '2014-12-06', '85');
INSERT INTO `vacations` VALUES ('476', '0', '2015-02-12', '2015-02-17', '17');
INSERT INTO `vacations` VALUES ('477', '0', '2012-10-11', '2012-10-16', '30');
INSERT INTO `vacations` VALUES ('478', '0', '2017-03-10', '2017-04-05', '16');
INSERT INTO `vacations` VALUES ('479', '2', '2014-05-29', '2014-06-28', '21');
INSERT INTO `vacations` VALUES ('480', '2', '2017-01-23', '2017-02-17', '77');
INSERT INTO `vacations` VALUES ('481', '0', '2014-05-21', '2014-05-31', '14');
INSERT INTO `vacations` VALUES ('482', '1', '2014-01-12', '2014-02-06', '168');
INSERT INTO `vacations` VALUES ('483', '1', '2013-10-03', '2013-10-29', '91');
INSERT INTO `vacations` VALUES ('484', '1', '2013-07-08', '2013-07-16', '138');
INSERT INTO `vacations` VALUES ('485', '2', '2015-12-24', '2015-12-31', '167');
INSERT INTO `vacations` VALUES ('486', '2', '2016-05-29', '2016-06-19', '44');
INSERT INTO `vacations` VALUES ('487', '2', '2016-12-28', '2017-01-12', '19');
INSERT INTO `vacations` VALUES ('488', '1', '2013-12-23', '2014-01-17', '66');
INSERT INTO `vacations` VALUES ('489', '1', '2012-11-09', '2012-11-14', '148');
INSERT INTO `vacations` VALUES ('490', '2', '2015-01-03', '2015-01-14', '184');
INSERT INTO `vacations` VALUES ('491', '2', '2013-02-24', '2013-03-16', '53');
INSERT INTO `vacations` VALUES ('492', '0', '2013-06-27', '2013-07-16', '19');
INSERT INTO `vacations` VALUES ('493', '1', '2014-05-13', '2014-05-21', '82');
INSERT INTO `vacations` VALUES ('494', '2', '2014-10-04', '2014-10-13', '168');
INSERT INTO `vacations` VALUES ('495', '1', '2016-09-01', '2016-09-23', '65');
INSERT INTO `vacations` VALUES ('496', '2', '2015-12-18', '2015-12-24', '18');
INSERT INTO `vacations` VALUES ('497', '1', '2015-04-18', '2015-04-26', '193');
INSERT INTO `vacations` VALUES ('498', '2', '2015-02-03', '2015-02-15', '79');
INSERT INTO `vacations` VALUES ('499', '1', '2015-12-10', '2016-01-08', '20');
INSERT INTO `vacations` VALUES ('500', '1', '2012-12-03', '2012-12-08', '178');
INSERT INTO `vacations` VALUES ('501', '1', '2012-12-10', '2013-01-04', '22');
INSERT INTO `vacations` VALUES ('502', '1', '2017-05-18', '2017-06-15', '146');
INSERT INTO `vacations` VALUES ('503', '1', '2013-01-27', '2013-02-13', '151');
INSERT INTO `vacations` VALUES ('504', '1', '2014-04-01', '2014-04-27', '100');
INSERT INTO `vacations` VALUES ('505', '1', '2017-06-04', '2017-06-28', '171');
INSERT INTO `vacations` VALUES ('506', '1', '2017-05-10', '2017-06-04', '177');
INSERT INTO `vacations` VALUES ('507', '2', '2017-03-27', '2017-04-03', '128');
INSERT INTO `vacations` VALUES ('508', '1', '2012-10-16', '2012-11-15', '122');
INSERT INTO `vacations` VALUES ('509', '2', '2012-10-01', '2012-10-24', '143');
INSERT INTO `vacations` VALUES ('510', '1', '2016-08-18', '2016-09-04', '168');
INSERT INTO `vacations` VALUES ('511', '2', '2016-11-08', '2016-11-28', '96');
INSERT INTO `vacations` VALUES ('512', '2', '2015-02-19', '2015-03-20', '53');
INSERT INTO `vacations` VALUES ('513', '1', '2014-08-16', '2014-09-08', '130');
INSERT INTO `vacations` VALUES ('514', '0', '2016-11-24', '2016-12-04', '182');
INSERT INTO `vacations` VALUES ('515', '2', '2017-02-07', '2017-02-26', '116');
INSERT INTO `vacations` VALUES ('516', '1', '2015-04-25', '2015-05-23', '166');
INSERT INTO `vacations` VALUES ('517', '2', '2017-02-05', '2017-02-28', '139');
INSERT INTO `vacations` VALUES ('518', '0', '2013-11-19', '2013-12-14', '83');
INSERT INTO `vacations` VALUES ('519', '2', '2015-12-02', '2015-12-29', '60');
INSERT INTO `vacations` VALUES ('520', '0', '2016-11-27', '2016-12-07', '10');
INSERT INTO `vacations` VALUES ('521', '1', '2012-11-29', '2012-12-15', '43');
INSERT INTO `vacations` VALUES ('522', '0', '2013-05-22', '2013-06-14', '178');
INSERT INTO `vacations` VALUES ('523', '2', '2015-11-05', '2015-11-18', '123');
INSERT INTO `vacations` VALUES ('524', '0', '2013-05-01', '2013-05-10', '137');
INSERT INTO `vacations` VALUES ('525', '1', '2015-03-20', '2015-04-09', '133');
INSERT INTO `vacations` VALUES ('526', '1', '2015-05-22', '2015-06-17', '24');
INSERT INTO `vacations` VALUES ('527', '1', '2014-05-11', '2014-06-04', '153');
INSERT INTO `vacations` VALUES ('528', '1', '2016-02-13', '2016-02-20', '161');
INSERT INTO `vacations` VALUES ('529', '2', '2016-06-29', '2016-07-26', '58');
INSERT INTO `vacations` VALUES ('530', '2', '2016-02-11', '2016-03-09', '1');
INSERT INTO `vacations` VALUES ('531', '2', '2014-07-24', '2014-08-11', '40');
INSERT INTO `vacations` VALUES ('532', '2', '2014-05-24', '2014-06-23', '11');
INSERT INTO `vacations` VALUES ('533', '0', '2014-12-08', '2015-01-06', '176');
INSERT INTO `vacations` VALUES ('534', '0', '2014-10-23', '2014-11-06', '148');
INSERT INTO `vacations` VALUES ('535', '0', '2014-04-19', '2014-05-16', '103');
INSERT INTO `vacations` VALUES ('536', '1', '2016-09-23', '2016-10-11', '123');
INSERT INTO `vacations` VALUES ('537', '1', '2014-05-19', '2014-05-27', '25');
INSERT INTO `vacations` VALUES ('538', '2', '2013-03-15', '2013-03-20', '3');
INSERT INTO `vacations` VALUES ('539', '0', '2016-08-31', '2016-09-05', '118');
INSERT INTO `vacations` VALUES ('540', '2', '2014-08-02', '2014-08-22', '8');
INSERT INTO `vacations` VALUES ('541', '0', '2012-10-20', '2012-11-01', '25');
INSERT INTO `vacations` VALUES ('542', '1', '2013-01-01', '2013-01-21', '13');
INSERT INTO `vacations` VALUES ('543', '0', '2016-01-10', '2016-01-19', '76');
INSERT INTO `vacations` VALUES ('544', '1', '2017-01-30', '2017-02-22', '171');
INSERT INTO `vacations` VALUES ('545', '0', '2016-02-04', '2016-03-05', '192');
INSERT INTO `vacations` VALUES ('546', '1', '2015-01-12', '2015-02-04', '38');
INSERT INTO `vacations` VALUES ('547', '2', '2015-01-26', '2015-02-06', '72');
INSERT INTO `vacations` VALUES ('548', '0', '2013-11-24', '2013-12-03', '54');
INSERT INTO `vacations` VALUES ('549', '0', '2013-08-04', '2013-08-19', '6');
INSERT INTO `vacations` VALUES ('550', '1', '2015-10-15', '2015-11-11', '86');
INSERT INTO `vacations` VALUES ('551', '2', '2014-03-20', '2014-04-19', '127');
INSERT INTO `vacations` VALUES ('552', '0', '2013-03-31', '2013-04-07', '26');
INSERT INTO `vacations` VALUES ('553', '0', '2016-09-16', '2016-09-22', '139');
INSERT INTO `vacations` VALUES ('554', '0', '2016-01-14', '2016-01-19', '134');
INSERT INTO `vacations` VALUES ('555', '1', '2015-05-16', '2015-06-07', '44');
INSERT INTO `vacations` VALUES ('556', '2', '2014-02-14', '2014-03-04', '95');
INSERT INTO `vacations` VALUES ('557', '2', '2014-03-08', '2014-04-05', '90');
INSERT INTO `vacations` VALUES ('558', '1', '2012-11-29', '2012-12-23', '107');
INSERT INTO `vacations` VALUES ('559', '1', '2013-07-19', '2013-08-17', '92');
INSERT INTO `vacations` VALUES ('560', '0', '2016-07-16', '2016-07-28', '59');
INSERT INTO `vacations` VALUES ('561', '2', '2017-02-02', '2017-02-17', '93');
INSERT INTO `vacations` VALUES ('562', '2', '2014-05-01', '2014-05-28', '150');
INSERT INTO `vacations` VALUES ('563', '2', '2016-11-19', '2016-11-27', '124');
INSERT INTO `vacations` VALUES ('564', '0', '2014-03-16', '2014-04-15', '132');
INSERT INTO `vacations` VALUES ('565', '1', '2017-02-18', '2017-03-13', '112');
INSERT INTO `vacations` VALUES ('566', '0', '2012-12-27', '2013-01-21', '50');
INSERT INTO `vacations` VALUES ('567', '2', '2016-04-07', '2016-05-06', '144');
INSERT INTO `vacations` VALUES ('568', '2', '2013-12-14', '2013-12-31', '89');
INSERT INTO `vacations` VALUES ('569', '1', '2013-03-22', '2013-04-21', '180');
INSERT INTO `vacations` VALUES ('570', '0', '2013-05-13', '2013-06-11', '158');
INSERT INTO `vacations` VALUES ('571', '0', '2016-09-17', '2016-09-29', '158');
INSERT INTO `vacations` VALUES ('572', '1', '2012-11-05', '2012-11-10', '66');
INSERT INTO `vacations` VALUES ('573', '2', '2014-06-17', '2014-07-17', '80');
INSERT INTO `vacations` VALUES ('574', '2', '2016-07-29', '2016-08-16', '31');
INSERT INTO `vacations` VALUES ('575', '1', '2015-07-22', '2015-08-18', '93');
INSERT INTO `vacations` VALUES ('576', '2', '2016-11-27', '2016-12-17', '199');
INSERT INTO `vacations` VALUES ('577', '2', '2016-12-23', '2017-01-21', '175');
INSERT INTO `vacations` VALUES ('578', '2', '2016-08-21', '2016-09-10', '11');
INSERT INTO `vacations` VALUES ('579', '0', '2014-09-08', '2014-09-21', '47');
INSERT INTO `vacations` VALUES ('580', '2', '2016-07-19', '2016-07-25', '83');
INSERT INTO `vacations` VALUES ('581', '1', '2016-09-19', '2016-10-06', '157');
INSERT INTO `vacations` VALUES ('582', '1', '2015-07-17', '2015-08-11', '68');
INSERT INTO `vacations` VALUES ('583', '1', '2014-11-19', '2014-12-09', '32');
INSERT INTO `vacations` VALUES ('584', '0', '2016-03-17', '2016-04-06', '54');
INSERT INTO `vacations` VALUES ('585', '2', '2012-12-15', '2012-12-29', '149');
INSERT INTO `vacations` VALUES ('586', '0', '2012-09-30', '2012-10-25', '39');
INSERT INTO `vacations` VALUES ('587', '1', '2015-03-11', '2015-04-04', '107');
INSERT INTO `vacations` VALUES ('588', '1', '2017-03-19', '2017-03-24', '37');
INSERT INTO `vacations` VALUES ('589', '2', '2017-06-16', '2017-07-12', '129');
INSERT INTO `vacations` VALUES ('590', '2', '2013-11-11', '2013-11-20', '36');
INSERT INTO `vacations` VALUES ('591', '2', '2015-10-11', '2015-10-29', '106');
INSERT INTO `vacations` VALUES ('592', '2', '2015-10-25', '2015-11-17', '44');
INSERT INTO `vacations` VALUES ('593', '0', '2017-03-28', '2017-04-15', '195');
INSERT INTO `vacations` VALUES ('594', '2', '2014-10-11', '2014-10-29', '75');
INSERT INTO `vacations` VALUES ('595', '2', '2015-05-01', '2015-05-21', '8');
INSERT INTO `vacations` VALUES ('596', '0', '2014-09-06', '2014-10-02', '150');
INSERT INTO `vacations` VALUES ('597', '0', '2012-12-28', '2013-01-07', '101');
INSERT INTO `vacations` VALUES ('598', '0', '2014-10-19', '2014-10-27', '185');
INSERT INTO `vacations` VALUES ('599', '0', '2015-08-05', '2015-08-16', '98');
INSERT INTO `vacations` VALUES ('600', '0', '2017-03-30', '2017-04-05', '57');
INSERT INTO `vacations` VALUES ('601', '1', '2014-12-12', '2015-01-03', '169');
INSERT INTO `vacations` VALUES ('602', '2', '2017-05-18', '2017-05-27', '114');
INSERT INTO `vacations` VALUES ('603', '2', '2016-05-29', '2016-06-10', '145');
INSERT INTO `vacations` VALUES ('604', '0', '2016-01-24', '2016-02-07', '186');
INSERT INTO `vacations` VALUES ('605', '1', '2012-09-17', '2012-10-17', '77');
INSERT INTO `vacations` VALUES ('606', '0', '2012-10-10', '2012-11-05', '80');
INSERT INTO `vacations` VALUES ('607', '1', '2016-11-03', '2016-11-09', '63');
INSERT INTO `vacations` VALUES ('608', '0', '2012-12-16', '2012-12-25', '184');
INSERT INTO `vacations` VALUES ('609', '1', '2014-12-05', '2014-12-25', '141');
INSERT INTO `vacations` VALUES ('610', '2', '2015-07-09', '2015-08-03', '48');
INSERT INTO `vacations` VALUES ('611', '2', '2013-11-24', '2013-12-17', '101');
INSERT INTO `vacations` VALUES ('612', '1', '2015-01-07', '2015-01-31', '144');
INSERT INTO `vacations` VALUES ('613', '1', '2017-04-13', '2017-05-09', '105');
INSERT INTO `vacations` VALUES ('614', '2', '2013-05-17', '2013-06-06', '141');
INSERT INTO `vacations` VALUES ('615', '1', '2016-11-02', '2016-11-21', '73');
INSERT INTO `vacations` VALUES ('616', '2', '2013-02-02', '2013-02-13', '85');
INSERT INTO `vacations` VALUES ('617', '0', '2013-11-18', '2013-12-03', '78');
INSERT INTO `vacations` VALUES ('618', '2', '2014-04-06', '2014-04-28', '145');
INSERT INTO `vacations` VALUES ('619', '2', '2014-03-16', '2014-04-09', '118');
INSERT INTO `vacations` VALUES ('620', '0', '2015-01-07', '2015-01-16', '159');
INSERT INTO `vacations` VALUES ('621', '1', '2015-12-08', '2015-12-21', '97');
INSERT INTO `vacations` VALUES ('622', '0', '2015-06-10', '2015-07-01', '153');
INSERT INTO `vacations` VALUES ('623', '1', '2014-02-08', '2014-03-06', '10');
INSERT INTO `vacations` VALUES ('624', '1', '2015-01-25', '2015-02-08', '78');
INSERT INTO `vacations` VALUES ('625', '2', '2013-10-10', '2013-11-09', '140');
INSERT INTO `vacations` VALUES ('626', '1', '2013-08-22', '2013-09-19', '48');
INSERT INTO `vacations` VALUES ('627', '0', '2015-08-10', '2015-08-23', '16');
INSERT INTO `vacations` VALUES ('628', '2', '2014-07-09', '2014-08-08', '168');
INSERT INTO `vacations` VALUES ('629', '1', '2016-06-20', '2016-07-11', '128');
INSERT INTO `vacations` VALUES ('630', '0', '2015-10-06', '2015-10-16', '3');
INSERT INTO `vacations` VALUES ('631', '2', '2016-03-16', '2016-04-02', '51');
INSERT INTO `vacations` VALUES ('632', '0', '2014-03-14', '2014-03-25', '152');
INSERT INTO `vacations` VALUES ('633', '0', '2012-10-19', '2012-11-15', '137');
INSERT INTO `vacations` VALUES ('634', '2', '2016-11-18', '2016-12-16', '83');
INSERT INTO `vacations` VALUES ('635', '0', '2013-08-25', '2013-09-06', '59');
INSERT INTO `vacations` VALUES ('636', '0', '2015-06-06', '2015-06-15', '167');
INSERT INTO `vacations` VALUES ('637', '1', '2014-04-07', '2014-04-16', '111');
INSERT INTO `vacations` VALUES ('638', '2', '2016-12-16', '2017-01-15', '196');
INSERT INTO `vacations` VALUES ('639', '0', '2016-07-31', '2016-08-08', '162');
INSERT INTO `vacations` VALUES ('640', '1', '2017-02-27', '2017-03-19', '15');
INSERT INTO `vacations` VALUES ('641', '2', '2015-12-13', '2016-01-05', '142');
INSERT INTO `vacations` VALUES ('642', '0', '2016-01-24', '2016-02-15', '156');
INSERT INTO `vacations` VALUES ('643', '2', '2017-02-25', '2017-03-17', '189');
INSERT INTO `vacations` VALUES ('644', '0', '2014-03-15', '2014-04-06', '45');
INSERT INTO `vacations` VALUES ('645', '0', '2012-11-29', '2012-12-25', '111');
INSERT INTO `vacations` VALUES ('646', '0', '2014-07-30', '2014-08-13', '113');
INSERT INTO `vacations` VALUES ('647', '1', '2014-08-15', '2014-08-28', '80');
INSERT INTO `vacations` VALUES ('648', '1', '2013-01-25', '2013-02-10', '168');
INSERT INTO `vacations` VALUES ('649', '0', '2014-09-03', '2014-09-13', '99');
INSERT INTO `vacations` VALUES ('650', '1', '2016-08-05', '2016-08-17', '197');
INSERT INTO `vacations` VALUES ('651', '2', '2015-11-17', '2015-12-03', '178');
INSERT INTO `vacations` VALUES ('652', '2', '2014-05-02', '2014-06-01', '77');
INSERT INTO `vacations` VALUES ('653', '0', '2012-09-24', '2012-10-08', '160');
INSERT INTO `vacations` VALUES ('654', '2', '2014-08-25', '2014-09-06', '187');
INSERT INTO `vacations` VALUES ('655', '2', '2016-08-14', '2016-09-12', '35');
INSERT INTO `vacations` VALUES ('656', '0', '2014-09-06', '2014-09-13', '188');
INSERT INTO `vacations` VALUES ('657', '0', '2014-07-12', '2014-07-23', '174');
INSERT INTO `vacations` VALUES ('658', '2', '2016-02-24', '2016-03-18', '120');
INSERT INTO `vacations` VALUES ('659', '1', '2017-02-28', '2017-03-29', '149');
INSERT INTO `vacations` VALUES ('660', '1', '2015-06-07', '2015-06-23', '17');
INSERT INTO `vacations` VALUES ('661', '1', '2013-01-04', '2013-01-26', '191');
INSERT INTO `vacations` VALUES ('662', '2', '2016-03-29', '2016-04-18', '132');
INSERT INTO `vacations` VALUES ('663', '1', '2013-12-01', '2013-12-28', '134');
INSERT INTO `vacations` VALUES ('664', '1', '2016-03-02', '2016-03-17', '140');
INSERT INTO `vacations` VALUES ('665', '1', '2013-01-10', '2013-02-04', '65');
INSERT INTO `vacations` VALUES ('666', '2', '2014-05-17', '2014-06-07', '25');
INSERT INTO `vacations` VALUES ('667', '1', '2014-12-13', '2015-01-08', '16');
INSERT INTO `vacations` VALUES ('668', '2', '2013-09-06', '2013-09-26', '99');
INSERT INTO `vacations` VALUES ('669', '1', '2015-01-10', '2015-01-31', '166');
INSERT INTO `vacations` VALUES ('670', '0', '2017-01-02', '2017-01-10', '152');
INSERT INTO `vacations` VALUES ('671', '1', '2016-09-24', '2016-09-29', '54');
INSERT INTO `vacations` VALUES ('672', '2', '2013-02-12', '2013-02-25', '135');
INSERT INTO `vacations` VALUES ('673', '2', '2014-11-20', '2014-11-28', '167');
INSERT INTO `vacations` VALUES ('674', '2', '2012-09-22', '2012-10-07', '27');
INSERT INTO `vacations` VALUES ('675', '1', '2012-11-20', '2012-12-08', '180');
INSERT INTO `vacations` VALUES ('676', '2', '2013-01-18', '2013-01-29', '56');
INSERT INTO `vacations` VALUES ('677', '2', '2017-07-01', '2017-07-30', '162');
INSERT INTO `vacations` VALUES ('678', '0', '2015-02-10', '2015-03-06', '96');
INSERT INTO `vacations` VALUES ('679', '0', '2014-08-26', '2014-09-16', '169');
INSERT INTO `vacations` VALUES ('680', '0', '2016-05-11', '2016-05-25', '31');
INSERT INTO `vacations` VALUES ('681', '1', '2016-08-14', '2016-08-21', '101');
INSERT INTO `vacations` VALUES ('682', '2', '2015-01-18', '2015-02-04', '68');
INSERT INTO `vacations` VALUES ('683', '2', '2014-04-12', '2014-04-19', '125');
INSERT INTO `vacations` VALUES ('684', '0', '2017-03-08', '2017-03-27', '30');
INSERT INTO `vacations` VALUES ('685', '0', '2017-06-28', '2017-07-09', '182');
INSERT INTO `vacations` VALUES ('686', '0', '2013-05-17', '2013-05-29', '133');
INSERT INTO `vacations` VALUES ('687', '2', '2013-06-27', '2013-07-22', '126');
INSERT INTO `vacations` VALUES ('688', '0', '2017-02-21', '2017-03-12', '67');
INSERT INTO `vacations` VALUES ('689', '1', '2013-12-25', '2014-01-18', '23');
INSERT INTO `vacations` VALUES ('690', '0', '2016-02-15', '2016-03-11', '35');
INSERT INTO `vacations` VALUES ('691', '0', '2014-05-04', '2014-05-26', '94');
INSERT INTO `vacations` VALUES ('692', '2', '2017-05-06', '2017-05-12', '15');
INSERT INTO `vacations` VALUES ('693', '0', '2015-09-20', '2015-10-01', '35');
INSERT INTO `vacations` VALUES ('694', '1', '2014-07-23', '2014-08-14', '97');
INSERT INTO `vacations` VALUES ('695', '1', '2014-02-22', '2014-03-24', '110');
INSERT INTO `vacations` VALUES ('696', '2', '2017-04-02', '2017-05-02', '186');
INSERT INTO `vacations` VALUES ('697', '1', '2015-05-14', '2015-06-06', '98');
INSERT INTO `vacations` VALUES ('698', '0', '2017-04-21', '2017-05-20', '28');
INSERT INTO `vacations` VALUES ('699', '1', '2012-11-04', '2012-12-02', '148');
INSERT INTO `vacations` VALUES ('700', '0', '2016-09-19', '2016-10-19', '198');
INSERT INTO `vacations` VALUES ('701', '0', '2013-04-01', '2013-05-01', '164');
INSERT INTO `vacations` VALUES ('702', '1', '2014-07-07', '2014-07-12', '116');
INSERT INTO `vacations` VALUES ('703', '2', '2016-03-30', '2016-04-04', '152');
INSERT INTO `vacations` VALUES ('704', '1', '2013-09-15', '2013-10-04', '198');
INSERT INTO `vacations` VALUES ('705', '0', '2016-06-30', '2016-07-27', '43');
INSERT INTO `vacations` VALUES ('706', '0', '2015-04-14', '2015-04-30', '172');
INSERT INTO `vacations` VALUES ('707', '0', '2016-03-22', '2016-04-14', '145');
INSERT INTO `vacations` VALUES ('708', '0', '2016-06-30', '2016-07-21', '174');
INSERT INTO `vacations` VALUES ('709', '0', '2013-07-07', '2013-08-02', '178');
INSERT INTO `vacations` VALUES ('710', '0', '2015-12-15', '2015-12-24', '80');
INSERT INTO `vacations` VALUES ('711', '0', '2012-10-16', '2012-10-22', '22');
INSERT INTO `vacations` VALUES ('712', '1', '2013-02-22', '2013-03-10', '43');
INSERT INTO `vacations` VALUES ('713', '0', '2013-07-31', '2013-08-16', '118');
INSERT INTO `vacations` VALUES ('714', '1', '2012-08-12', '2012-09-10', '136');
INSERT INTO `vacations` VALUES ('715', '2', '2017-04-19', '2017-05-05', '90');
INSERT INTO `vacations` VALUES ('716', '0', '2014-11-27', '2014-12-24', '107');
INSERT INTO `vacations` VALUES ('717', '2', '2016-09-08', '2016-09-30', '67');
INSERT INTO `vacations` VALUES ('718', '0', '2015-12-15', '2015-12-25', '113');
INSERT INTO `vacations` VALUES ('719', '2', '2016-12-29', '2017-01-17', '191');
INSERT INTO `vacations` VALUES ('720', '2', '2013-12-21', '2014-01-09', '139');
INSERT INTO `vacations` VALUES ('721', '1', '2016-09-25', '2016-10-14', '21');
INSERT INTO `vacations` VALUES ('722', '2', '2012-08-11', '2012-09-04', '186');
INSERT INTO `vacations` VALUES ('723', '0', '2012-08-30', '2012-09-04', '28');
INSERT INTO `vacations` VALUES ('724', '0', '2017-05-26', '2017-06-05', '110');
INSERT INTO `vacations` VALUES ('725', '0', '2015-10-18', '2015-11-09', '104');
INSERT INTO `vacations` VALUES ('726', '0', '2012-12-29', '2013-01-12', '136');
INSERT INTO `vacations` VALUES ('727', '2', '2016-06-25', '2016-07-09', '5');
INSERT INTO `vacations` VALUES ('728', '2', '2013-11-21', '2013-12-05', '5');
INSERT INTO `vacations` VALUES ('729', '0', '2015-10-17', '2015-10-26', '141');
INSERT INTO `vacations` VALUES ('730', '0', '2016-04-04', '2016-04-19', '170');
INSERT INTO `vacations` VALUES ('731', '1', '2016-02-15', '2016-03-07', '9');
INSERT INTO `vacations` VALUES ('732', '1', '2017-02-08', '2017-02-20', '25');
INSERT INTO `vacations` VALUES ('733', '2', '2013-10-13', '2013-11-06', '163');
INSERT INTO `vacations` VALUES ('734', '1', '2013-08-16', '2013-08-23', '139');
INSERT INTO `vacations` VALUES ('735', '2', '2016-03-07', '2016-03-22', '136');
INSERT INTO `vacations` VALUES ('736', '2', '2014-09-09', '2014-10-06', '152');
INSERT INTO `vacations` VALUES ('737', '1', '2012-10-15', '2012-10-21', '22');
INSERT INTO `vacations` VALUES ('738', '2', '2014-12-22', '2015-01-18', '161');
INSERT INTO `vacations` VALUES ('739', '1', '2012-11-13', '2012-11-20', '73');
INSERT INTO `vacations` VALUES ('740', '2', '2016-04-13', '2016-04-28', '187');
INSERT INTO `vacations` VALUES ('741', '1', '2016-03-23', '2016-04-21', '177');
INSERT INTO `vacations` VALUES ('742', '1', '2015-04-11', '2015-04-20', '158');
INSERT INTO `vacations` VALUES ('743', '0', '2015-07-31', '2015-08-11', '24');
INSERT INTO `vacations` VALUES ('744', '1', '2016-01-28', '2016-02-11', '55');
INSERT INTO `vacations` VALUES ('745', '2', '2017-03-29', '2017-04-14', '21');
INSERT INTO `vacations` VALUES ('746', '2', '2013-11-28', '2013-12-16', '32');
INSERT INTO `vacations` VALUES ('747', '2', '2016-02-18', '2016-03-06', '34');
INSERT INTO `vacations` VALUES ('748', '2', '2015-04-05', '2015-04-21', '152');
INSERT INTO `vacations` VALUES ('749', '2', '2013-06-08', '2013-07-02', '130');
INSERT INTO `vacations` VALUES ('750', '2', '2017-04-24', '2017-05-20', '100');
INSERT INTO `vacations` VALUES ('751', '1', '2015-05-10', '2015-06-02', '93');
INSERT INTO `vacations` VALUES ('752', '2', '2017-05-03', '2017-05-21', '64');
INSERT INTO `vacations` VALUES ('753', '2', '2014-01-12', '2014-02-08', '178');
INSERT INTO `vacations` VALUES ('754', '1', '2016-05-04', '2016-06-03', '121');
INSERT INTO `vacations` VALUES ('755', '1', '2015-06-03', '2015-06-12', '150');
INSERT INTO `vacations` VALUES ('756', '0', '2015-08-26', '2015-09-04', '86');
INSERT INTO `vacations` VALUES ('757', '1', '2012-10-23', '2012-11-03', '117');
INSERT INTO `vacations` VALUES ('758', '2', '2013-10-05', '2013-10-13', '20');
INSERT INTO `vacations` VALUES ('759', '1', '2016-05-11', '2016-05-24', '180');
INSERT INTO `vacations` VALUES ('760', '1', '2014-09-06', '2014-09-29', '135');
INSERT INTO `vacations` VALUES ('761', '0', '2014-03-22', '2014-04-13', '31');
INSERT INTO `vacations` VALUES ('762', '0', '2012-10-05', '2012-10-12', '108');
INSERT INTO `vacations` VALUES ('763', '1', '2013-02-01', '2013-02-17', '195');
INSERT INTO `vacations` VALUES ('764', '1', '2016-01-24', '2016-02-10', '21');
INSERT INTO `vacations` VALUES ('765', '0', '2015-05-10', '2015-06-02', '133');
INSERT INTO `vacations` VALUES ('766', '2', '2012-07-30', '2012-08-05', '31');
INSERT INTO `vacations` VALUES ('767', '2', '2013-08-22', '2013-09-12', '198');
INSERT INTO `vacations` VALUES ('768', '1', '2015-08-31', '2015-09-25', '9');
INSERT INTO `vacations` VALUES ('769', '1', '2016-10-27', '2016-11-20', '118');
INSERT INTO `vacations` VALUES ('770', '0', '2013-08-18', '2013-09-01', '80');
INSERT INTO `vacations` VALUES ('771', '2', '2012-08-19', '2012-09-16', '158');
INSERT INTO `vacations` VALUES ('772', '0', '2015-07-29', '2015-08-19', '177');
INSERT INTO `vacations` VALUES ('773', '2', '2016-02-16', '2016-03-04', '27');
INSERT INTO `vacations` VALUES ('774', '2', '2013-05-19', '2013-06-17', '72');
INSERT INTO `vacations` VALUES ('775', '2', '2016-11-20', '2016-11-27', '129');
INSERT INTO `vacations` VALUES ('776', '0', '2014-08-05', '2014-08-30', '60');
INSERT INTO `vacations` VALUES ('777', '2', '2014-11-11', '2014-11-26', '198');
INSERT INTO `vacations` VALUES ('778', '1', '2016-12-05', '2016-12-13', '116');
INSERT INTO `vacations` VALUES ('779', '2', '2016-11-30', '2016-12-18', '171');
INSERT INTO `vacations` VALUES ('780', '0', '2015-08-25', '2015-09-17', '195');
INSERT INTO `vacations` VALUES ('781', '0', '2015-08-13', '2015-08-25', '41');
INSERT INTO `vacations` VALUES ('782', '1', '2015-05-07', '2015-05-25', '32');
INSERT INTO `vacations` VALUES ('783', '2', '2015-07-08', '2015-07-25', '193');
INSERT INTO `vacations` VALUES ('784', '0', '2012-10-23', '2012-11-02', '140');
INSERT INTO `vacations` VALUES ('785', '0', '2014-10-19', '2014-11-18', '70');
INSERT INTO `vacations` VALUES ('786', '0', '2013-06-06', '2013-06-13', '76');
INSERT INTO `vacations` VALUES ('787', '0', '2016-09-16', '2016-10-02', '67');
INSERT INTO `vacations` VALUES ('788', '2', '2016-04-07', '2016-04-14', '125');
INSERT INTO `vacations` VALUES ('789', '1', '2015-05-01', '2015-05-18', '96');
INSERT INTO `vacations` VALUES ('790', '1', '2015-05-23', '2015-06-13', '99');
INSERT INTO `vacations` VALUES ('791', '1', '2016-04-14', '2016-04-30', '102');
INSERT INTO `vacations` VALUES ('792', '0', '2017-07-12', '2017-07-19', '92');
INSERT INTO `vacations` VALUES ('793', '0', '2014-08-26', '2014-09-14', '82');
INSERT INTO `vacations` VALUES ('794', '1', '2016-04-04', '2016-04-14', '81');
INSERT INTO `vacations` VALUES ('795', '1', '2013-05-10', '2013-05-20', '121');
INSERT INTO `vacations` VALUES ('796', '2', '2012-11-18', '2012-12-13', '154');
INSERT INTO `vacations` VALUES ('797', '1', '2015-05-14', '2015-05-20', '196');
INSERT INTO `vacations` VALUES ('798', '2', '2013-12-03', '2013-12-30', '70');
INSERT INTO `vacations` VALUES ('799', '0', '2016-03-12', '2016-04-06', '182');
INSERT INTO `vacations` VALUES ('800', '2', '2014-11-17', '2014-11-25', '20');
INSERT INTO `vacations` VALUES ('801', '1', '2016-09-28', '2016-10-17', '94');
INSERT INTO `vacations` VALUES ('802', '2', '2015-06-25', '2015-07-19', '28');
INSERT INTO `vacations` VALUES ('803', '1', '2013-02-28', '2013-03-17', '17');
INSERT INTO `vacations` VALUES ('804', '1', '2014-10-31', '2014-11-29', '104');
INSERT INTO `vacations` VALUES ('805', '0', '2015-11-14', '2015-12-06', '32');
INSERT INTO `vacations` VALUES ('806', '2', '2014-04-17', '2014-04-26', '79');
INSERT INTO `vacations` VALUES ('807', '0', '2013-09-29', '2013-10-05', '25');
INSERT INTO `vacations` VALUES ('808', '2', '2017-02-14', '2017-03-13', '187');
INSERT INTO `vacations` VALUES ('809', '2', '2014-02-21', '2014-03-21', '24');
INSERT INTO `vacations` VALUES ('810', '0', '2012-08-24', '2012-09-08', '151');
INSERT INTO `vacations` VALUES ('811', '0', '2016-07-26', '2016-08-10', '27');
INSERT INTO `vacations` VALUES ('812', '2', '2013-06-28', '2013-07-12', '19');
INSERT INTO `vacations` VALUES ('813', '0', '2015-05-11', '2015-05-18', '194');
INSERT INTO `vacations` VALUES ('814', '0', '2014-05-16', '2014-05-26', '47');
INSERT INTO `vacations` VALUES ('815', '2', '2014-02-24', '2014-03-09', '75');
INSERT INTO `vacations` VALUES ('816', '2', '2012-12-23', '2013-01-11', '165');
INSERT INTO `vacations` VALUES ('817', '0', '2014-04-13', '2014-05-10', '170');
INSERT INTO `vacations` VALUES ('818', '2', '2013-06-23', '2013-07-13', '113');
INSERT INTO `vacations` VALUES ('819', '0', '2017-06-19', '2017-07-06', '142');
INSERT INTO `vacations` VALUES ('820', '1', '2016-10-22', '2016-11-15', '93');
INSERT INTO `vacations` VALUES ('821', '0', '2016-05-31', '2016-06-18', '14');
INSERT INTO `vacations` VALUES ('822', '2', '2015-03-03', '2015-03-28', '128');
INSERT INTO `vacations` VALUES ('823', '2', '2013-03-07', '2013-03-20', '103');
INSERT INTO `vacations` VALUES ('824', '1', '2015-09-15', '2015-09-28', '73');
INSERT INTO `vacations` VALUES ('825', '0', '2013-12-23', '2014-01-05', '82');
INSERT INTO `vacations` VALUES ('826', '0', '2015-04-12', '2015-05-08', '128');
INSERT INTO `vacations` VALUES ('827', '1', '2017-01-14', '2017-02-03', '158');
INSERT INTO `vacations` VALUES ('828', '0', '2016-04-10', '2016-04-23', '97');
INSERT INTO `vacations` VALUES ('829', '0', '2014-01-24', '2014-02-01', '38');
INSERT INTO `vacations` VALUES ('830', '0', '2013-02-23', '2013-03-19', '12');
INSERT INTO `vacations` VALUES ('831', '0', '2016-07-16', '2016-07-27', '177');
INSERT INTO `vacations` VALUES ('832', '2', '2016-12-23', '2017-01-19', '41');
INSERT INTO `vacations` VALUES ('833', '2', '2016-03-13', '2016-03-30', '189');
INSERT INTO `vacations` VALUES ('834', '1', '2016-10-29', '2016-11-14', '188');
INSERT INTO `vacations` VALUES ('835', '2', '2015-02-03', '2015-02-11', '127');
INSERT INTO `vacations` VALUES ('836', '2', '2015-12-18', '2015-12-24', '58');
INSERT INTO `vacations` VALUES ('837', '2', '2012-08-21', '2012-09-17', '155');
INSERT INTO `vacations` VALUES ('838', '1', '2015-08-06', '2015-08-12', '117');
INSERT INTO `vacations` VALUES ('839', '1', '2016-01-30', '2016-02-08', '187');
INSERT INTO `vacations` VALUES ('840', '1', '2014-12-08', '2015-01-01', '95');
INSERT INTO `vacations` VALUES ('841', '1', '2016-11-10', '2016-11-19', '38');
INSERT INTO `vacations` VALUES ('842', '1', '2014-10-03', '2014-10-08', '155');
INSERT INTO `vacations` VALUES ('843', '0', '2016-07-29', '2016-08-27', '189');
INSERT INTO `vacations` VALUES ('844', '2', '2013-11-30', '2013-12-25', '79');
INSERT INTO `vacations` VALUES ('845', '2', '2014-03-21', '2014-03-30', '166');
INSERT INTO `vacations` VALUES ('846', '1', '2016-04-22', '2016-04-27', '29');
INSERT INTO `vacations` VALUES ('847', '2', '2014-05-26', '2014-06-07', '112');
INSERT INTO `vacations` VALUES ('848', '0', '2015-11-17', '2015-12-07', '34');
INSERT INTO `vacations` VALUES ('849', '0', '2016-10-21', '2016-10-31', '23');
INSERT INTO `vacations` VALUES ('850', '0', '2017-03-06', '2017-03-28', '163');

-- ----------------------------
-- Table structure for __efmigrationshistory
-- ----------------------------
DROP TABLE IF EXISTS `__efmigrationshistory`;
CREATE TABLE `__efmigrationshistory` (
  `MigrationId` varchar(95) NOT NULL,
  `ProductVersion` varchar(32) NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of __efmigrationshistory
-- ----------------------------
INSERT INTO `__efmigrationshistory` VALUES ('20170716111602_FirstMigration', '1.1.2');
SET FOREIGN_KEY_CHECKS=1;
