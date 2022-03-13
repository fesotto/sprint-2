-- MySQL Workbench Synchronization
-- Generated: 2022-03-13 14:07
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: jeffe otto

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `cul_d_ampolla` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`provedor` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `adress` VARCHAR(255) NULL DEFAULT NULL,
  `city` VARCHAR(40) NULL DEFAULT NULL,
  `zip_code` VARCHAR(10) NULL DEFAULT NULL,
  `country` VARCHAR(45) NULL DEFAULT NULL,
  `phone` VARCHAR(25) NULL DEFAULT NULL,
  `fax` VARCHAR(20) NULL DEFAULT NULL,
  `nif` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`gafas` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(45) NULL DEFAULT NULL,
  `grado_iz` FLOAT(11) NULL DEFAULT NULL,
  `grado_dr` FLOAT(11) NULL DEFAULT NULL,
  `precio` VARCHAR(45) NULL DEFAULT NULL,
  `marca_id` INT(11) NOT NULL,
  `monturas_gafas_id` INT(11) NOT NULL,
  `gafas_lentes_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `marca_idx` (`marca_id` ASC) VISIBLE,
  INDEX `gafas_monturas_idx` (`monturas_gafas_id` ASC) VISIBLE,
  INDEX `gafas_lentes_idx` (`gafas_lentes_id` ASC) VISIBLE,
  CONSTRAINT `marca_id`
    FOREIGN KEY (`marca_id`)
    REFERENCES `cul_d_ampolla`.`marca` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `monturas_id`
    FOREIGN KEY (`monturas_gafas_id`)
    REFERENCES `cul_d_ampolla`.`monturas_gafas` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `lentes_id`
    FOREIGN KEY (`gafas_lentes_id`)
    REFERENCES `cul_d_ampolla`.`gafas_lentes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`client` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `address` VARCHAR(255) NULL DEFAULT NULL,
  `zip_code` VARCHAR(10) NULL DEFAULT NULL,
  `phone` VARCHAR(20) NULL DEFAULT NULL,
  `e_mail` VARCHAR(45) NOT NULL,
  `client_since` DATETIME NOT NULL,
  `client_refereed_id` INT(11) NULL DEFAULT NULL,
  `client_id` INT(11) NOT NULL,
  `client_client_refereed_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `client_refereed_id`),
  INDEX `fk_client_client1_idx` (`client_id` ASC, `client_client_refereed_id` ASC) VISIBLE,
  CONSTRAINT `client_id`
    FOREIGN KEY (`client_id` , `client_client_refereed_id`)
    REFERENCES `cul_d_ampolla`.`client` (`id` , `client_refereed_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`order` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `client_id` INT(11) NOT NULL,
  `client_client_refereed_id` INT(11) NOT NULL,
  `gafas_id` INT(11) NOT NULL,
  `employee_orders_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `client_idx` (`client_id` ASC, `client_client_refereed_id` ASC) VISIBLE,
  INDEX `gafas_idx` (`gafas_id` ASC) VISIBLE,
  CONSTRAINT `order_client_id`
    FOREIGN KEY (`client_id` , `client_client_refereed_id`)
    REFERENCES `cul_d_ampolla`.`client` (`id` , `client_refereed_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `order_gafas_id`
    FOREIGN KEY (`gafas_id`)
    REFERENCES `cul_d_ampolla`.`gafas` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `employee_id`
    FOREIGN KEY ()
    REFERENCES `cul_d_ampolla`.`employee_orders` ()
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`employee_orders` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`marca` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `provedor_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `marca_provedor_idx` (`provedor_id` ASC) VISIBLE,
  CONSTRAINT `provedor_id`
    FOREIGN KEY (`provedor_id`)
    REFERENCES `cul_d_ampolla`.`provedor` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`monturas_gafas` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `type_montura` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`gafas_lentes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `color` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`monturas_color` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `color_name` VARCHAR(45) NULL DEFAULT NULL,
  `gafas_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_monturas_color_gafas1_idx` (`gafas_id` ASC) VISIBLE,
  CONSTRAINT `gafas_id`
    FOREIGN KEY (`gafas_id`)
    REFERENCES `cul_d_ampolla`.`gafas` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
