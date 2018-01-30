-- MySQL Script generated by MySQL Workbench
-- mar 30 ene 2018 22:33:37 CET
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema miod
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema miod
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `miod` DEFAULT CHARACTER SET utf8 ;
USE `miod` ;

-- -----------------------------------------------------
-- Table `miod`.`Microindel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `miod`.`Microindel` (
  `idMicroindel` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Info` VARCHAR(45) NULL,
  PRIMARY KEY (`idMicroindel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `miod`.`Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `miod`.`Location` (
  `idLocation` INT NOT NULL,
  `StartGRCh38` VARCHAR(45) NULL,
  `EndGRCh38` VARCHAR(45) NULL,
  `CythogeneticLocation` INT NULL,
  `Strand` CHAR(1) NULL,
  `Microindel_idMicroindel` INT NOT NULL,
  PRIMARY KEY (`idLocation`, `Microindel_idMicroindel`),
  INDEX `fk_Location_Variant1_idx` (`Microindel_idMicroindel` ASC),
  CONSTRAINT `fk_Location_Variant1`
    FOREIGN KEY (`Microindel_idMicroindel`)
    REFERENCES `miod`.`Microindel` (`idMicroindel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `miod`.`Gene`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `miod`.`Gene` (
  `idGene` INT NOT NULL AUTO_INCREMENT,
  `GeneName` VARCHAR(45) NULL,
  `EnsmblID` VARCHAR(45) NULL,
  `Location_idLocation` INT NOT NULL,
  PRIMARY KEY (`idGene`, `Location_idLocation`),
  INDEX `fk_Gene_Location_idx` (`Location_idLocation` ASC),
  CONSTRAINT `fk_Gene_Location`
    FOREIGN KEY (`Location_idLocation`)
    REFERENCES `miod`.`Location` (`idLocation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `miod`.`ClinicalSignificance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `miod`.`ClinicalSignificance` (
  `idClinicalSignificance` INT NOT NULL,
  `Value` VARCHAR(45) NULL,
  PRIMARY KEY (`idClinicalSignificance`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `miod`.`Disease`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `miod`.`Disease` (
  `idDisease` INT NOT NULL,
  `DiseaseName` VARCHAR(45) NULL,
  `idMIM` VARCHAR(45) NULL,
  PRIMARY KEY (`idDisease`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `miod`.`References`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `miod`.`References` (
  `idReferences` INT NOT NULL,
  `Reference` INT(11) NULL,
  `Database` VARCHAR(45) NULL,
  PRIMARY KEY (`idReferences`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `miod`.`Microindel_has_References`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `miod`.`Microindel_has_References` (
  `Microindel_idMicroindel` INT NOT NULL,
  `References_idReferences` INT NOT NULL,
  PRIMARY KEY (`Microindel_idMicroindel`, `References_idReferences`),
  INDEX `fk_Variant_has_References_References1_idx` (`References_idReferences` ASC),
  INDEX `fk_Variant_has_References_Variant1_idx` (`Microindel_idMicroindel` ASC),
  CONSTRAINT `fk_Variant_has_References_Variant1`
    FOREIGN KEY (`Microindel_idMicroindel`)
    REFERENCES `miod`.`Microindel` (`idMicroindel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Variant_has_References_References1`
    FOREIGN KEY (`References_idReferences`)
    REFERENCES `miod`.`References` (`idReferences`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `miod`.`Microindel_has_ClinicalSignificance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `miod`.`Microindel_has_ClinicalSignificance` (
  `Microindel_idMicroindel` INT NOT NULL,
  `ClinicalSignificance_idClinicalSignificance` INT NOT NULL,
  PRIMARY KEY (`Microindel_idMicroindel`, `ClinicalSignificance_idClinicalSignificance`),
  INDEX `fk_Variant_has_ClinicalSignificance_ClinicalSignificance1_idx` (`ClinicalSignificance_idClinicalSignificance` ASC),
  INDEX `fk_Variant_has_ClinicalSignificance_Variant1_idx` (`Microindel_idMicroindel` ASC),
  CONSTRAINT `fk_Variant_has_ClinicalSignificance_Variant1`
    FOREIGN KEY (`Microindel_idMicroindel`)
    REFERENCES `miod`.`Microindel` (`idMicroindel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Variant_has_ClinicalSignificance_ClinicalSignificance1`
    FOREIGN KEY (`ClinicalSignificance_idClinicalSignificance`)
    REFERENCES `miod`.`ClinicalSignificance` (`idClinicalSignificance`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `miod`.`Microindel_has_Disease`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `miod`.`Microindel_has_Disease` (
  `Variant_idVariant` INT NOT NULL,
  `Disease_idDisease` INT NOT NULL,
  PRIMARY KEY (`Variant_idVariant`, `Disease_idDisease`),
  INDEX `fk_Variant_has_Disease_Disease1_idx` (`Disease_idDisease` ASC),
  INDEX `fk_Variant_has_Disease_Variant1_idx` (`Variant_idVariant` ASC),
  CONSTRAINT `fk_Variant_has_Disease_Variant1`
    FOREIGN KEY (`Variant_idVariant`)
    REFERENCES `miod`.`Microindel` (`idMicroindel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Variant_has_Disease_Disease1`
    FOREIGN KEY (`Disease_idDisease`)
    REFERENCES `miod`.`Disease` (`idDisease`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
