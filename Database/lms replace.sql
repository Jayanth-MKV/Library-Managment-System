-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lms` DEFAULT CHARACTER SET utf8 ;
USE `lms` ;

-- -----------------------------------------------------
-- Table `mydb`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lms`.`Department` (
  `Department_Id` INT NOT NULL,
  `Department_Name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Department_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Student_Details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lms`.`Student_Details` (
  `Student_Id` VARCHAR(20) NOT NULL,
  `Student_Name` VARCHAR(45) NOT NULL,
  `Gender` VARCHAR(10) NULL,
  `Date_Of_Birth` DATE NULL,
  `Email_Id` VARCHAR(45) NOT NULL,
  `Borrower_Id` INT NOT NULL,
  `Department` INT NOT NULL,
  `Contact_Number` VARCHAR(15) NULL,
  `Active_Status` BINARY NULL,
  PRIMARY KEY ( `Borrower_Id`,`Student_Id`, `Email_Id`),
  INDEX `Department_idx` (`Department` ASC) VISIBLE,
  CONSTRAINT `Department`
    FOREIGN KEY (`Department`)
    REFERENCES `lms`.`Department` (`Department_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Category_Details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lms`.`Category_Details` (
  `Category_Id` INT NOT NULL,
  `Category_Name` VARCHAR(45) NULL,
  PRIMARY KEY (`Category_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Book_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lms`.`Book_details` (
  `Book_Id` INT NOT NULL,
  `Book_Title` VARCHAR(80) NULL,
  `Author1` VARCHAR(45) NULL,
  `Author2` VARCHAR(45) NULL,
  `Language` VARCHAR(10) NULL,
  `Category_Id` INT NULL,
  `Publication_Year` INT NULL,
  `No_Copies_Actual` INT NULL,
  `No_Copies_Current` INT NULL,
  `Book_Pages` INT NULL,
  `Book_Price` INT NULL,
  PRIMARY KEY (`Book_Id`),
  INDEX `Book_Category_idx` (`Category_Id` ASC) VISIBLE,
  CONSTRAINT `Book_Category`
    FOREIGN KEY (`Category_Id`)
    REFERENCES `lms`.`Category_Details` (`Category_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Library_staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lms`.`Library_staff` (
  `Library_Staff_Id` INT NOT NULL,
  `Staff_Name` VARCHAR(50) NULL,
  `Password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `Is_Admin` BINARY NULL,
  `Contact` VARCHAR(15) NULL,
  `Gender` VARCHAR(10) NULL,
  `Active_Status` BINARY NULL,
  PRIMARY KEY (`Library_Staff_Id`))
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lms`.`user` (
  `Id` VARCHAR(20) NULL,
  `Email` VARCHAR(100) NOT NULL,
  `Password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `Student_Id_idx` (`Id` ASC, `Email` ASC) VISIBLE,
  CONSTRAINT `Student_Id`
    FOREIGN KEY (`Id` , `Email`)
    REFERENCES `lms`.`Student_Details` (`Student_Id` , `Email_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Staff_Details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lms`.`Staff_Details` (
  `Staff_Id` VARCHAR(20) NOT NULL,
  `Staff_Name` VARCHAR(45) NOT NULL,
  `Gender` VARCHAR(10) NULL,
  `Date_Of_Birth` DATE NULL,
  `Email_Id` VARCHAR(45) NOT NULL,
  `Borrower_Id` INT NOT NULL,
  `Contact_Number` VARCHAR(15) NULL,
  `Active_Status` BINARY NULL,
  `Department` INT NOT NULL,
  PRIMARY KEY (`Staff_Id`, `Email_Id`, `Borrower_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`News`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lms`.`News` (
  `News_Id` INT NOT NULL,
  `Announcement` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`News_Id`))
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `mydb`.`Borrower_Details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lms`.`Borrower_Details` (
  `Borrower_Id` INT NOT NULL REFERENCES `lms`.`Student_Details` (`Borrower_Id`),
  `Department` INT NULL,
  `Book_Id` INT NULL,
  `Borrowed_From` DATE NULL,
  `Borrowed_To` DATE NULL,
  `Actual_Return_Date` DATE NULL,
  `Issued_By` INT NULL,
  `User_Type` VARCHAR(20) NULL,
   INDEX `Borrower_Id_idx` (`Borrower_Id` ASC) VISIBLE,
   INDEX `Department1_idx` (`Department` ASC) VISIBLE,
   INDEX `Book_Id_idx` (`Book_Id` ASC) VISIBLE,
   INDEX `Issued_By_idx` (`Issued_By` ASC) VISIBLE,
    -- CONSTRAINT `Borrower_Id`
--     FOREIGN KEY (`Borrower_Id`)
--     REFERENCES `lms`.`Student_Details` (`Borrower_Id`)
   --  ON DELETE NO ACTION
--     ON UPDATE NO ACTION,
     CONSTRAINT `Department1`
    FOREIGN KEY (`Department`)
    REFERENCES `lms`.`department` ( `Department_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
     CONSTRAINT `Book_Id`
    FOREIGN KEY (`Book_Id`)
    REFERENCES `lms`.`Book_details` (`Book_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `Issued_By`
    FOREIGN KEY (`Issued_By`)
    REFERENCES `lms`.`Library_staff` (`Library_Staff_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
