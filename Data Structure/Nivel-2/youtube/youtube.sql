-- MySQL Workbench Synchronization
-- Generated: 2022-03-13 20:51
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: jeffe otto

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `youtube` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `youtube`.`user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `password` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `birth_date` DATE NULL DEFAULT NULL,
  `sex` VARCHAR(2) NULL DEFAULT NULL,
  `country` VARCHAR(45) NULL DEFAULT NULL,
  `zip` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`video` (
  `id` INT(11) NOT NULL,
  `title` VARCHAR(155) NULL DEFAULT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `size` VARCHAR(45) NULL DEFAULT NULL,
  `video_name` VARCHAR(45) NULL DEFAULT NULL,
  `duration` TIME NULL DEFAULT NULL,
  `thumbnail` VARCHAR(45) NULL DEFAULT NULL,
  `reproductions` INT(11) NULL DEFAULT NULL,
  `playlist_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  `video_state` TINYINT(4) NULL DEFAULT NULL,
  `video_col` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_video_playlist1_idx` (`playlist_id` ASC),
  INDEX `fk_video_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_video_playlist1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `youtube`.`playlist` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_video_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`tags` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `video_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tags_video_idx` (`video_id` ASC),
  CONSTRAINT `fk_tags_video`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`video` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`chanel` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `date` DATE NULL DEFAULT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_chanel_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_chanel_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`subscription` (
  `id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_subscription_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_subscription_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`likes` (
  `id` INT(11) NOT NULL,
  `video_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  `date` DATETIME NULL DEFAULT NULL,
  INDEX `fk_likes_video1_idx` (`video_id` ASC),
  INDEX `fk_likes_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_likes_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`video` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_likes_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`deslikes` (
  `id` INT(11) NOT NULL,
  `video_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  `date` DATETIME NULL DEFAULT NULL,
  INDEX `fk_deslikes_video1_idx` (`video_id` ASC),
  INDEX `fk_deslikes_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_deslikes_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`video` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_deslikes_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`playlist` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `date_creation` DATE NULL DEFAULT NULL,
  `public` TINYINT(4) NULL DEFAULT NULL,
  `chanel_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_playlist_chanel1_idx` (`chanel_id` ASC),
  INDEX `fk_playlist_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_playlist_chanel1`
    FOREIGN KEY (`chanel_id`)
    REFERENCES `youtube`.`chanel` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlist_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`comments` (
  `id` INT(11) NOT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`video_has_comments` (
  `video_id` INT(11) NOT NULL,
  `comments_id` INT(11) NOT NULL,
  PRIMARY KEY (`video_id`, `comments_id`),
  INDEX `fk_video_has_comments_comments1_idx` (`comments_id` ASC),
  INDEX `fk_video_has_comments_video1_idx` (`video_id` ASC),
  CONSTRAINT `fk_video_has_comments_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`video` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_video_has_comments_comments1`
    FOREIGN KEY (`comments_id`)
    REFERENCES `youtube`.`comments` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`comments_has_user` (
  `comments_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`comments_id`, `user_id`),
  INDEX `fk_comments_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_comments_has_user_comments1_idx` (`comments_id` ASC),
  CONSTRAINT `fk_comments_has_user_comments1`
    FOREIGN KEY (`comments_id`)
    REFERENCES `youtube`.`comments` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comments_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
