-- MySQL Workbench Synchronization
-- Generated: 2022-03-13 19:56
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: jeffe otto

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`client` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `given_name` VARCHAR(45) NULL DEFAULT NULL,
  `address` VARCHAR(255) NULL DEFAULT NULL,
  `zip` VARCHAR(10) NULL DEFAULT NULL,
  `phone` VARCHAR(20) NULL DEFAULT NULL,
  `local_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_client_local1_idx` (`local_id` ASC),
  CONSTRAINT `fk_client_local1`
    FOREIGN KEY (`local_id`)
    REFERENCES `pizzeria`.`local` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`local` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `province_id` INT(11) NOT NULL,
  `shop_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_local_province1_idx` (`province_id` ASC),
  INDEX `fk_local_shop1_idx` (`shop_id` ASC),
  CONSTRAINT `fk_local_province1`
    FOREIGN KEY (`province_id`)
    REFERENCES `pizzeria`.`province` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_local_shop1`
    FOREIGN KEY (`shop_id`)
    REFERENCES `pizzeria`.`shop` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`province` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`order` (
  `id` INT(11) NOT NULL,
  `order_date` DATE NULL DEFAULT NULL,
  `order_type` VARCHAR(20) NULL DEFAULT NULL,
  `client_id` INT(11) NOT NULL,
  `employee_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_order_client_idx` (`client_id` ASC),
  INDEX `fk_order_employee1_idx` (`employee_id` ASC),
  CONSTRAINT `fk_order_client`
    FOREIGN KEY (`client_id`)
    REFERENCES `pizzeria`.`client` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `pizzeria`.`employee` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`shop` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`employee` (
  `id` INT(11) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`pizza` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(155) NULL DEFAULT NULL,
  `image_url` VARCHAR(255) NULL DEFAULT NULL,
  `price` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`pizza_category` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `pizza_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pizza_category_pizza1_idx` (`pizza_id` ASC),
  CONSTRAINT `fk_pizza_category_pizza1`
    FOREIGN KEY (`pizza_id`)
    REFERENCES `pizzeria`.`pizza` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`burger` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(155) NULL DEFAULT NULL,
  `image_url` VARCHAR(255) NULL DEFAULT NULL,
  `price` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`drink` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(155) NULL DEFAULT NULL,
  `image_url` VARCHAR(255) NULL DEFAULT NULL,
  `price` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`order_has_drink` (
  `order_id` INT(11) NOT NULL,
  `drink_id` INT(11) NOT NULL,
  PRIMARY KEY (`order_id`, `drink_id`),
  INDEX `fk_order_has_drink_drink1_idx` (`drink_id` ASC),
  INDEX `fk_order_has_drink_order1_idx` (`order_id` ASC),
  CONSTRAINT `fk_order_has_drink_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `pizzeria`.`order` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_has_drink_drink1`
    FOREIGN KEY (`drink_id`)
    REFERENCES `pizzeria`.`drink` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`order_has_burger` (
  `order_id` INT(11) NOT NULL,
  `burger_id` INT(11) NOT NULL,
  PRIMARY KEY (`order_id`, `burger_id`),
  INDEX `fk_order_has_burger_burger1_idx` (`burger_id` ASC),
  INDEX `fk_order_has_burger_order1_idx` (`order_id` ASC),
  CONSTRAINT `fk_order_has_burger_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `pizzeria`.`order` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_has_burger_burger1`
    FOREIGN KEY (`burger_id`)
    REFERENCES `pizzeria`.`burger` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`order_has_pizza` (
  `order_id` INT(11) NOT NULL,
  `pizza_id` INT(11) NOT NULL,
  PRIMARY KEY (`order_id`, `pizza_id`),
  INDEX `fk_order_has_pizza_pizza1_idx` (`pizza_id` ASC),
  INDEX `fk_order_has_pizza_order1_idx` (`order_id` ASC),
  CONSTRAINT `fk_order_has_pizza_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `pizzeria`.`order` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_has_pizza_pizza1`
    FOREIGN KEY (`pizza_id`)
    REFERENCES `pizzeria`.`pizza` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
