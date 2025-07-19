-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ev_cars
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ev_cars` ;

-- -----------------------------------------------------
-- Schema ev_cars
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ev_cars` DEFAULT CHARACTER SET utf8mb3 ;
USE `ev_cars` ;

-- -----------------------------------------------------
-- Table `ev_cars`.`electric_utility`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ev_cars`.`electric_utility` ;

CREATE TABLE IF NOT EXISTS `ev_cars`.`electric_utility` (
  `ele_util_id` INT UNSIGNED NOT NULL,
  `name_ele_util` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`ele_util_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ev_cars`.`ev_vehicle_descrp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ev_cars`.`ev_vehicle_descrp` ;

CREATE TABLE IF NOT EXISTS `ev_cars`.`ev_vehicle_descrp` (
  `ev_veh_id` INT UNSIGNED NOT NULL,
  `ev_type` VARCHAR(50) NULL DEFAULT NULL,
  `clean_veh_fuel_elig` VARCHAR(100) NULL DEFAULT NULL,
  `electric_range` INT NULL DEFAULT NULL,
  PRIMARY KEY (`ev_veh_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ev_cars`.`legislative_districts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ev_cars`.`legislative_districts` ;

CREATE TABLE IF NOT EXISTS `ev_cars`.`legislative_districts` (
  `legislative_id` INT UNSIGNED NOT NULL,
  `leg_district` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`legislative_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ev_cars`.`models`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ev_cars`.`models` ;

CREATE TABLE IF NOT EXISTS `ev_cars`.`models` (
  `model_id` INT UNSIGNED NOT NULL COMMENT 'Primary key - must be unsigned (goes positive nums only)',
  `model` VARCHAR(45) NOT NULL,
  `model_year` YEAR NOT NULL,
  `make` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`model_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ev_cars`.`registration_location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ev_cars`.`registration_location` ;

CREATE TABLE IF NOT EXISTS `ev_cars`.`registration_location` (
  `location_id` INT UNSIGNED NOT NULL,
  `DOL` CHAR(9) NOT NULL,
  `vehicle_location` VARCHAR(50) NOT NULL COMMENT 'Aka vehicle coordinates',
  `county` VARCHAR(30) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `postal_code` CHAR(5) NOT NULL,
  PRIMARY KEY (`location_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ev_cars`.`vehicle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ev_cars`.`vehicle` ;

CREATE TABLE IF NOT EXISTS `ev_cars`.`vehicle` (
  `ve_reg_id` INT UNSIGNED NOT NULL COMMENT 'VIN is UNIQUE\\n',
  `VIN` VARCHAR(45) NOT NULL,
  `model_id` INT UNSIGNED NOT NULL,
  `ev_veh_id` INT UNSIGNED NOT NULL,
  `location_id` INT UNSIGNED NOT NULL,
  `legislative_id` INT UNSIGNED NOT NULL COMMENT 'All keys have to be unsigned. The VIN is the UNIQUE.',
  PRIMARY KEY (`ve_reg_id`),
  INDEX `fk_model_id_idx` (`model_id` ASC) VISIBLE,
  INDEX `fk_location_id_idx` (`location_id` ASC) VISIBLE,
  INDEX `fk_legislative_id_idx` (`legislative_id` ASC) VISIBLE,
  INDEX `fk_ev_veh_id` (`ev_veh_id` ASC) VISIBLE,
  CONSTRAINT `fk_ev_veh_id`
    FOREIGN KEY (`ev_veh_id`)
    REFERENCES `ev_cars`.`ev_vehicle_descrp` (`ev_veh_id`),
  CONSTRAINT `fk_legislative_id`
    FOREIGN KEY (`legislative_id`)
    REFERENCES `ev_cars`.`legislative_districts` (`legislative_id`),
  CONSTRAINT `fk_location_id`
    FOREIGN KEY (`location_id`)
    REFERENCES `ev_cars`.`registration_location` (`location_id`),
  CONSTRAINT `fk_model_id`
    FOREIGN KEY (`model_id`)
    REFERENCES `ev_cars`.`models` (`model_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 56
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ev_cars`.`vehicle_electric_utility`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ev_cars`.`vehicle_electric_utility` ;

CREATE TABLE IF NOT EXISTS `ev_cars`.`vehicle_electric_utility` (
  `ele_util_id` INT UNSIGNED NOT NULL,
  `ve_reg_id` INT UNSIGNED NOT NULL COMMENT 'Both keys have to be UNIQUE cause linking relationship.',
  PRIMARY KEY (`ele_util_id`, `ve_reg_id`),
  INDEX `fk_ve_reg_id` (`ve_reg_id` ASC) VISIBLE,
  CONSTRAINT `fk_ele_util_id`
    FOREIGN KEY (`ele_util_id`)
    REFERENCES `ev_cars`.`electric_utility` (`ele_util_id`),
  CONSTRAINT `fk_ve_reg_id`
    FOREIGN KEY (`ve_reg_id`)
    REFERENCES `ev_cars`.`vehicle` (`ve_reg_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
