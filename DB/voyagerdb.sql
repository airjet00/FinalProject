-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema voyagerdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `voyagerdb` ;

-- -----------------------------------------------------
-- Schema voyagerdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `voyagerdb` DEFAULT CHARACTER SET utf8 ;
USE `voyagerdb` ;

-- -----------------------------------------------------
-- Table `voyagerdb`.`country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `voyagerdb`.`country` ;

CREATE TABLE IF NOT EXISTS `voyagerdb`.`country` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(450) NULL,
  `description` TEXT NULL,
  `default_image` VARCHAR(4500) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `voyagerdb`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `voyagerdb`.`user` ;

CREATE TABLE IF NOT EXISTS `voyagerdb`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(45) NULL,
  `username` VARCHAR(45) NULL,
  `email` VARCHAR(200) NULL,
  `password` VARCHAR(4500) NULL,
  `first_name` VARCHAR(100) NULL,
  `middle_name` VARCHAR(100) NULL,
  `last_name` VARCHAR(100) NULL,
  `suffix` VARCHAR(20) NULL,
  `dob` DATE NULL,
  `enabled` TINYINT NULL,
  `create_date` DATETIME NULL,
  `update_date` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `voyagerdb`.`picture`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `voyagerdb`.`picture` ;

CREATE TABLE IF NOT EXISTS `voyagerdb`.`picture` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `country_id` INT NOT NULL,
  `image_url` VARCHAR(4500) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE INDEX `fk_picture_country_idx` ON `voyagerdb`.`picture` (`country_id` ASC);


-- -----------------------------------------------------
-- Table `voyagerdb`.`trip`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `voyagerdb`.`trip` ;

CREATE TABLE IF NOT EXISTS `voyagerdb`.`trip` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(450) NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `completed` TINYINT NULL,
  `enabled` TINYINT NULL,
  `user_id` INT NOT NULL,
  `create_date` DATETIME NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE INDEX `fk_trip_user1_idx` ON `voyagerdb`.`trip` (`user_id` ASC);


-- -----------------------------------------------------
-- Table `voyagerdb`.`itinerary_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `voyagerdb`.`itinerary_item` ;

CREATE TABLE IF NOT EXISTS `voyagerdb`.`itinerary_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `trip_id` INT NOT NULL,
  `country_id` INT NOT NULL,
  `sequence_num` INT NULL,
  `notes` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE INDEX `fk_trip_has_country_country1_idx` ON `voyagerdb`.`itinerary_item` (`country_id` ASC);

CREATE INDEX `fk_trip_has_country_trip1_idx` ON `voyagerdb`.`itinerary_item` (`trip_id` ASC);


-- -----------------------------------------------------
-- Table `voyagerdb`.`comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `voyagerdb`.`comment` ;

CREATE TABLE IF NOT EXISTS `voyagerdb`.`comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(600) NULL,
  `create_date` DATETIME NULL,
  `update_date` DATETIME NULL,
  `enabled` TINYINT NULL,
  `country_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `in_reply_to_id` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE INDEX `fk_comment_country1_idx` ON `voyagerdb`.`comment` (`country_id` ASC);

CREATE INDEX `fk_comment_user1_idx` ON `voyagerdb`.`comment` (`user_id` ASC);

CREATE INDEX `fk_comment_comment1_idx` ON `voyagerdb`.`comment` (`in_reply_to_id` ASC);


-- -----------------------------------------------------
-- Table `voyagerdb`.`advice_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `voyagerdb`.`advice_type` ;

CREATE TABLE IF NOT EXISTS `voyagerdb`.`advice_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` TEXT NULL,
  `advice_url` VARCHAR(4500) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `voyagerdb`.`country_advice_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `voyagerdb`.`country_advice_type` ;

CREATE TABLE IF NOT EXISTS `voyagerdb`.`country_advice_type` (
  `advice_type_id` INT NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`advice_type_id`, `country_id`))
ENGINE = InnoDB;

CREATE INDEX `fk_advice_type_has_country_country1_idx` ON `voyagerdb`.`country_advice_type` (`country_id` ASC);

CREATE INDEX `fk_advice_type_has_country_advice_type1_idx` ON `voyagerdb`.`country_advice_type` (`advice_type_id` ASC);

SET SQL_MODE = '';
DROP USER IF EXISTS user;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'user' IDENTIFIED BY 'user';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `voyagerdb`.* TO 'user';

-- -----------------------------------------------------
-- Data for table `voyagerdb`.`country`
-- -----------------------------------------------------
START TRANSACTION;
USE `voyagerdb`;
INSERT INTO `voyagerdb`.`country` (`id`, `name`, `description`, `default_image`) VALUES (1, 'Singapore', 'A place of wonders where one cannot chew gum.', 'singapore.jpg');
INSERT INTO `voyagerdb`.`country` (`id`, `name`, `description`, `default_image`) VALUES (2, 'United Arab Emirates', 'A sandy place, I have heard.', 'uae.jpg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `voyagerdb`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `voyagerdb`;
INSERT INTO `voyagerdb`.`user` (`id`, `role`, `username`, `email`, `password`, `first_name`, `middle_name`, `last_name`, `suffix`, `dob`, `enabled`, `create_date`, `update_date`) VALUES (1, 'user', 'user', 'user@user.com', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL);
INSERT INTO `voyagerdb`.`user` (`id`, `role`, `username`, `email`, `password`, `first_name`, `middle_name`, `last_name`, `suffix`, `dob`, `enabled`, `create_date`, `update_date`) VALUES (2, 'test', 'test', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL);
INSERT INTO `voyagerdb`.`user` (`id`, `role`, `username`, `email`, `password`, `first_name`, `middle_name`, `last_name`, `suffix`, `dob`, `enabled`, `create_date`, `update_date`) VALUES (3, 'user', 'shaun', 'hi@w.com', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `voyagerdb`.`picture`
-- -----------------------------------------------------
START TRANSACTION;
USE `voyagerdb`;
INSERT INTO `voyagerdb`.`picture` (`id`, `country_id`, `image_url`) VALUES (1, 1, 'singapore-sightseeing-1.jpg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `voyagerdb`.`trip`
-- -----------------------------------------------------
START TRANSACTION;
USE `voyagerdb`;
INSERT INTO `voyagerdb`.`trip` (`id`, `name`, `start_date`, `end_date`, `completed`, `enabled`, `user_id`, `create_date`, `description`) VALUES (1, 'Southeast Asia Fall 2021', NULL, NULL, 0, 1, 1, NULL, 'A whirlwind tour of the opposite side of the globe.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `voyagerdb`.`itinerary_item`
-- -----------------------------------------------------
START TRANSACTION;
USE `voyagerdb`;
INSERT INTO `voyagerdb`.`itinerary_item` (`id`, `trip_id`, `country_id`, `sequence_num`, `notes`) VALUES (1, 1, 1, 1, 'I am so excited!!!');

COMMIT;


-- -----------------------------------------------------
-- Data for table `voyagerdb`.`comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `voyagerdb`;
INSERT INTO `voyagerdb`.`comment` (`id`, `content`, `create_date`, `update_date`, `enabled`, `country_id`, `user_id`, `in_reply_to_id`) VALUES (1, 'Singapore. Not for the fainthearted. The customs agent chewed all my gum.', NULL, NULL, 1, 1, 1, 2);
INSERT INTO `voyagerdb`.`comment` (`id`, `content`, `create_date`, `update_date`, `enabled`, `country_id`, `user_id`, `in_reply_to_id`) VALUES (2, 'Singapore is great!!!!!!!!!!!! <3', NULL, NULL, 1, 1, 1, NULL);
INSERT INTO `voyagerdb`.`comment` (`id`, `content`, `create_date`, `update_date`, `enabled`, `country_id`, `user_id`, `in_reply_to_id`) VALUES (3, 'Singapore is ok', NULL, NULL, 1, 1, 2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `voyagerdb`.`advice_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `voyagerdb`;
INSERT INTO `voyagerdb`.`advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (1, 'Covid-Related', 'Precautions for Covid-19 pandemic', 'www.cdc.gov');

COMMIT;


-- -----------------------------------------------------
-- Data for table `voyagerdb`.`country_advice_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `voyagerdb`;
INSERT INTO `voyagerdb`.`country_advice_type` (`advice_type_id`, `country_id`) VALUES (1, 1);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
