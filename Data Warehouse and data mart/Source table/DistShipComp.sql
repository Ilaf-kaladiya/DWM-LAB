-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DistShipComp
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DistShipComp
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DistShipComp` DEFAULT CHARACTER SET utf8 ;
USE `DistShipComp` ;

-- -----------------------------------------------------
-- Table `DistShipComp`.`Dim_Time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DistShipComp`.`Dim_Time` (
  `TimeID` VARCHAR(50) NOT NULL,
  `DispatchTime` TIMESTAMP NOT NULL,
  `ReceivingTime` TIMESTAMP NULL,
  `WeekNumber` INT NULL,
  `Month` CHAR(20) NULL DEFAULT '',
  `Year` YEAR NOT NULL,
  `Date` DATE NOT NULL,
  PRIMARY KEY (`TimeID`),
  UNIQUE INDEX `TimeID_UNIQUE` (`TimeID` ASC)  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DistShipComp`.`Dim_ShipFrom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DistShipComp`.`Dim_ShipFrom` (
  `ShipFromID` VARCHAR(50) NOT NULL,
  `AgentName` CHAR(70) NOT NULL,
  `OrganizationName` CHAR(100) NOT NULL,
  `AgentContact` VARCHAR(15) NOT NULL,
  `OrganizationContact` VARCHAR(15) NOT NULL,
  `OrganizationDetails` TEXT NULL,
  `ShippingDetails` TEXT NULL,
  `WareHouseAddress` TEXT NULL,
  PRIMARY KEY (`ShipFromID`),
  UNIQUE INDEX `ShipFromID_UNIQUE` (`ShipFromID` ASC)  ,
  UNIQUE INDEX `AgentContact_UNIQUE` (`AgentContact` ASC)  ,
  UNIQUE INDEX `OrganizationContact_UNIQUE` (`OrganizationContact` ASC)  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DistShipComp`.`Dim_ModeOfShipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DistShipComp`.`Dim_ModeOfShipment` (
  `ModeOfShipmentID` VARCHAR(50) NOT NULL,
  `TransportationType` VARCHAR(50) NOT NULL,
  `WayBillNo` VARCHAR(60) NOT NULL,
  `ShippingCost` FLOAT(2) NOT NULL,
  PRIMARY KEY (`ModeOfShipmentID`),
  UNIQUE INDEX `ModeOfShipmentID_UNIQUE` (`ModeOfShipmentID` ASC)  ,
  UNIQUE INDEX `WayBillNo_UNIQUE` (`WayBillNo` ASC)  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DistShipComp`.`Dim_CustShipTo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DistShipComp`.`Dim_CustShipTo` (
  `CustShipToID` VARCHAR(50) NOT NULL,
  `Name` CHAR(50) NOT NULL,
  `Address` TEXT NOT NULL,
  `Contact` VARCHAR(15) NOT NULL,
  `Email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`CustShipToID`),
  UNIQUE INDEX `CustShipToID_UNIQUE` (`CustShipToID` ASC)  ,
  UNIQUE INDEX `Contact_UNIQUE` (`Contact` ASC)  ,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC)  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DistShipComp`.`Dim_TypeOfDeal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DistShipComp`.`Dim_TypeOfDeal` (
  `TypeOfDealID` VARCHAR(50) NOT NULL,
  `PaymentStatus` CHAR(30) NOT NULL,
  `PaymentMode` CHAR(50) NOT NULL,
  `DealDesc` TEXT NULL,
  `TermsDesc` TEXT NULL,
  `TermsType` TEXT NULL,
  `AllowanceDesc` TEXT NULL,
  `AllowanceTypeDesc` TEXT NULL,
  `SpecialIncentiveDesc` TEXT NULL,
  `SpecialIncentiveTypeDesc` TEXT NULL,
  PRIMARY KEY (`TypeOfDealID`),
  UNIQUE INDEX `TypeOfDealID_UNIQUE` (`TypeOfDealID` ASC)  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DistShipComp`.`Dim_Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DistShipComp`.`Dim_Product` (
  `ProductID` VARCHAR(50) NOT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `Code` VARCHAR(60) NOT NULL,
  `ModelNumber` VARCHAR(60) NOT NULL,
  `Desc` TEXT NULL,
  `VendorID` INT NOT NULL,
  `VendorName` CHAR(20) NOT NULL,
  `VendorAddress` TEXT NULL,
  `Contact` VARCHAR(15) NOT NULL,
  `Sku_Number` INT NOT NULL,
  `Weight` FLOAT(2) NULL,
  `CostPrice` FLOAT(2) NOT NULL,
  `Category` VARCHAR(50) NULL,
  `DateofManufacture` DATE NOT NULL,
  `BatchNo` VARCHAR(50) NOT NULL,
  `SalePrice` FLOAT(2) NOT NULL,
  PRIMARY KEY (`ProductID`),
  UNIQUE INDEX `ProductID_UNIQUE` (`ProductID` ASC)  ,
  UNIQUE INDEX `Code_UNIQUE` (`Code` ASC)  ,
  UNIQUE INDEX `VendorID_UNIQUE` (`VendorID` ASC)  ,
  UNIQUE INDEX `Sku_Number_UNIQUE` (`Sku_Number` ASC)  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DistShipComp`.`Fact_Sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DistShipComp`.`Fact_Sales` (
  `TimeID` VARCHAR(50) NOT NULL,
  `CustShipToID` VARCHAR(50) NOT NULL,
  `ShipFromID` VARCHAR(50) NOT NULL,
  `ProductID` VARCHAR(50) NOT NULL,
  `TypeOfDealID` VARCHAR(50) NOT NULL,
  `ModeOfShipmentID` VARCHAR(50) NOT NULL,
  `NoOfDays` INT NOT NULL,
  `ProductQuantity` INT NULL,
  `IncomeGenerated` INT NOT NULL,
  `TransportationCost` INT NULL,
  `NumberOfCustomer` INT NULL,
  `NumberOfVendors` INT NULL,
  INDEX `fk_Fact_Sales_Dim_Time_idx` (`TimeID` ASC)  ,
  INDEX `fk_Fact_Sales_Dim_CustShipTo1_idx` (`CustShipToID` ASC)  ,
  INDEX `fk_Fact_Sales_Dim_ShipFrom1_idx` (`ShipFromID` ASC)  ,
  INDEX `fk_Fact_Sales_Dim_Product1_idx` (`ProductID` ASC)  ,
  INDEX `fk_Fact_Sales_Dim_TypeOfDeal1_idx` (`TypeOfDealID` ASC)  ,
  INDEX `fk_Fact_Sales_Dim_ModeOfShipment1_idx` (`ModeOfShipmentID` ASC)  ,
  CONSTRAINT `fk_Fact_Sales_Dim_Time`
    FOREIGN KEY (`TimeID`)
    REFERENCES `DistShipComp`.`Dim_Time` (`TimeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fact_Sales_Dim_CustShipTo1`
    FOREIGN KEY (`CustShipToID`)
    REFERENCES `DistShipComp`.`Dim_CustShipTo` (`CustShipToID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fact_Sales_Dim_ShipFrom1`
    FOREIGN KEY (`ShipFromID`)
    REFERENCES `DistShipComp`.`Dim_ShipFrom` (`ShipFromID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fact_Sales_Dim_Product1`
    FOREIGN KEY (`ProductID`)
    REFERENCES `DistShipComp`.`Dim_Product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fact_Sales_Dim_TypeOfDeal1`
    FOREIGN KEY (`TypeOfDealID`)
    REFERENCES `DistShipComp`.`Dim_TypeOfDeal` (`TypeOfDealID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fact_Sales_Dim_ModeOfShipment1`
    FOREIGN KEY (`ModeOfShipmentID`)
    REFERENCES `DistShipComp`.`Dim_ModeOfShipment` (`ModeOfShipmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DistShipComp`.`Fact_Shipping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DistShipComp`.`Fact_Shipping` (
  `CustShipToID` VARCHAR(50) NOT NULL,
  `ShipFromID` VARCHAR(50) NOT NULL,
  `ModeOfShipmentID` VARCHAR(50) NOT NULL,
  `TimeID` VARCHAR(50) NOT NULL,
  `TotalShippingDuration` INT NOT NULL,
  `TotalShippingCount` INT NOT NULL,
  `TotalShippingCost` FLOAT(2) NULL,
  `AgentShippingCount` INT NULL,
  `NumberOfSuccessfulShipping` INT NOT NULL,
  `NumberOfUnsuccessfulShipping` INT NULL,
  `OrganizationShippingCount` INT NULL,
  INDEX `fk_Fact_Shipping_Dim_CustShipTo1_idx` (`CustShipToID` ASC)  ,
  INDEX `fk_Fact_Shipping_Dim_ShipFrom1_idx` (`ShipFromID` ASC)  ,
  INDEX `fk_Fact_Shipping_Dim_ModeOfShipment1_idx` (`ModeOfShipmentID` ASC)  ,
  INDEX `fk_Fact_Shipping_Dim_Time1_idx` (`TimeID` ASC)  ,
  CONSTRAINT `fk_Fact_Shipping_Dim_CustShipTo1`
    FOREIGN KEY (`CustShipToID`)
    REFERENCES `DistShipComp`.`Dim_CustShipTo` (`CustShipToID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fact_Shipping_Dim_ShipFrom1`
    FOREIGN KEY (`ShipFromID`)
    REFERENCES `DistShipComp`.`Dim_ShipFrom` (`ShipFromID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fact_Shipping_Dim_ModeOfShipment1`
    FOREIGN KEY (`ModeOfShipmentID`)
    REFERENCES `DistShipComp`.`Dim_ModeOfShipment` (`ModeOfShipmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fact_Shipping_Dim_Time1`
    FOREIGN KEY (`TimeID`)
    REFERENCES `DistShipComp`.`Dim_Time` (`TimeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DistShipComp`.`Fact_Transport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DistShipComp`.`Fact_Transport` (
  `ShipFromID` VARCHAR(50) NOT NULL,
  `ModeOfShipmentID` VARCHAR(50) NOT NULL,
  `TransportByRoadWaysCount` INT NULL,
  `TransportByRailWaysCount` INT NULL,
  `TransportByAirWaysCount` INT NULL,
  `TransportByWaterWaysCount` INT NULL,
  INDEX `fk_Fact_Transport_Dim_ShipFrom1_idx` (`ShipFromID` ASC)  ,
  INDEX `fk_Fact_Transport_Dim_ModeOfShipment1_idx` (`ModeOfShipmentID` ASC)  ,
  CONSTRAINT `fk_Fact_Transport_Dim_ShipFrom1`
    FOREIGN KEY (`ShipFromID`)
    REFERENCES `DistShipComp`.`Dim_ShipFrom` (`ShipFromID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fact_Transport_Dim_ModeOfShipment1`
    FOREIGN KEY (`ModeOfShipmentID`)
    REFERENCES `DistShipComp`.`Dim_ModeOfShipment` (`ModeOfShipmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `DistShipComp`.`Dim_Time`
-- -----------------------------------------------------
START TRANSACTION;
USE `DistShipComp`;
INSERT INTO `DistShipComp`.`Dim_Time` (`TimeID`, `DispatchTime`, `ReceivingTime`, `WeekNumber`, `Month`, `Year`, `Date`) VALUES ('Time1001', '2019-02-12 12:00:00', '2019-02-14 12:00:00', 3, 'Feb', 2019, '2019-02-12');

COMMIT;


-- -----------------------------------------------------
-- Data for table `DistShipComp`.`Dim_ShipFrom`
-- -----------------------------------------------------
START TRANSACTION;
USE `DistShipComp`;
INSERT INTO `DistShipComp`.`Dim_ShipFrom` (`ShipFromID`, `AgentName`, `OrganizationName`, `AgentContact`, `OrganizationContact`, `OrganizationDetails`, `ShippingDetails`, `WareHouseAddress`) VALUES ('Ship1001', 'Adnan', 'DataMart', '+917208577656', '+919892327169', 'Reliable Logistic Solution', 'Shipping from Delhi to mumbai via Railways', 'Gwalior,Delhi');

COMMIT;


-- -----------------------------------------------------
-- Data for table `DistShipComp`.`Dim_ModeOfShipment`
-- -----------------------------------------------------
START TRANSACTION;
USE `DistShipComp`;
INSERT INTO `DistShipComp`.`Dim_ModeOfShipment` (`ModeOfShipmentID`, `TransportationType`, `WayBillNo`, `ShippingCost`) VALUES ('ShipD1001', 'Railways', '1337153004714', 12.0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `DistShipComp`.`Dim_CustShipTo`
-- -----------------------------------------------------
START TRANSACTION;
USE `DistShipComp`;
INSERT INTO `DistShipComp`.`Dim_CustShipTo` (`CustShipToID`, `Name`, `Address`, `Contact`, `Email`) VALUES ('Shad1001', 'Shadab', 'Kalina,Shastrinagar,Santacruz(E),Mum-29', '+917506455707', 'shaikhshadabali2@gmail.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `DistShipComp`.`Dim_TypeOfDeal`
-- -----------------------------------------------------
START TRANSACTION;
USE `DistShipComp`;
INSERT INTO `DistShipComp`.`Dim_TypeOfDeal` (`TypeOfDealID`, `PaymentStatus`, `PaymentMode`, `DealDesc`, `TermsDesc`, `TermsType`, `AllowanceDesc`, `AllowanceTypeDesc`, `SpecialIncentiveDesc`, `SpecialIncentiveTypeDesc`) VALUES ('Typ1001', 'Successful', 'CashOnDelivery', 'Buying related products with 50% discount', '1 year contract', 'Pobation', '10 rs per week', 'Probation', '50 % off for each 10 item of delivery', 'probation');

COMMIT;


-- -----------------------------------------------------
-- Data for table `DistShipComp`.`Dim_Product`
-- -----------------------------------------------------
START TRANSACTION;
USE `DistShipComp`;
INSERT INTO `DistShipComp`.`Dim_Product` (`ProductID`, `Name`, `Code`, `ModelNumber`, `Desc`, `VendorID`, `VendorName`, `VendorAddress`, `Contact`, `Sku_Number`, `Weight`, `CostPrice`, `Category`, `DateofManufacture`, `BatchNo`, `SalePrice`) VALUES ('1001', 'PulseCandyJar', 'M0163A', '10012021000219', 'Raw Mango with tangy twist', 2014COI001, 'DharmPal', '96, Okhla industrial, page 3, New delhi, 110020 India', '7208337377', 3118275816848, 4.01, 50.0, 'Candy', '2019-02-10', 'B321B', 70.0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `DistShipComp`.`Fact_Sales`
-- -----------------------------------------------------
START TRANSACTION;
USE `DistShipComp`;
INSERT INTO `DistShipComp`.`Fact_Sales` (`TimeID`, `CustShipToID`, `ShipFromID`, `ProductID`, `TypeOfDealID`, `ModeOfShipmentID`, `NoOfDays`, `ProductQuantity`, `IncomeGenerated`, `TransportationCost`, `NumberOfCustomer`, `NumberOfVendors`) VALUES ('Time1001', 'Shad1001', 'Ship1001', '1001', 'Typ1001', 'ShipD1001', 2, 100, 7000, 12, 4, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `DistShipComp`.`Fact_Shipping`
-- -----------------------------------------------------
START TRANSACTION;
USE `DistShipComp`;
INSERT INTO `DistShipComp`.`Fact_Shipping` (`CustShipToID`, `ShipFromID`, `ModeOfShipmentID`, `TimeID`, `TotalShippingDuration`, `TotalShippingCount`, `TotalShippingCost`, `AgentShippingCount`, `NumberOfSuccessfulShipping`, `NumberOfUnsuccessfulShipping`, `OrganizationShippingCount`) VALUES ('Shad1001', 'Ship1001', 'ShipD1001', 'Time1001', 2, 1, 1200, 1, 4, 0, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `DistShipComp`.`Fact_Transport`
-- -----------------------------------------------------
START TRANSACTION;
USE `DistShipComp`;
INSERT INTO `DistShipComp`.`Fact_Transport` (`ShipFromID`, `ModeOfShipmentID`, `TransportByRoadWaysCount`, `TransportByRailWaysCount`, `TransportByAirWaysCount`, `TransportByWaterWaysCount`) VALUES ('Ship1001', 'ShipD1001', 0, 1, 0, 0);

COMMIT;

