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
-- Table `country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `country` ;

CREATE TABLE IF NOT EXISTS `country` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(450) NULL,
  `description` TEXT NULL,
  `default_image` VARCHAR(4500) NULL,
  `country_code` VARCHAR(2) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
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
-- Table `picture`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `picture` ;

CREATE TABLE IF NOT EXISTS `picture` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `country_id` INT NOT NULL,
  `image_url` VARCHAR(4500) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_picture_country`
    FOREIGN KEY (`country_id`)
    REFERENCES `country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_picture_country_idx` ON `picture` (`country_id` ASC);


-- -----------------------------------------------------
-- Table `trip`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trip` ;

CREATE TABLE IF NOT EXISTS `trip` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(450) NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `completed` TINYINT NULL,
  `enabled` TINYINT NULL,
  `user_id` INT NOT NULL,
  `create_date` DATETIME NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_trip_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_trip_user1_idx` ON `trip` (`user_id` ASC);


-- -----------------------------------------------------
-- Table `itinerary_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `itinerary_item` ;

CREATE TABLE IF NOT EXISTS `itinerary_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `trip_id` INT NOT NULL,
  `country_id` INT NOT NULL,
  `sequence_num` INT NULL,
  `notes` TEXT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_trip_has_country_trip1`
    FOREIGN KEY (`trip_id`)
    REFERENCES `trip` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trip_has_country_country1`
    FOREIGN KEY (`country_id`)
    REFERENCES `country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_trip_has_country_country1_idx` ON `itinerary_item` (`country_id` ASC);

CREATE INDEX `fk_trip_has_country_trip1_idx` ON `itinerary_item` (`trip_id` ASC);


-- -----------------------------------------------------
-- Table `comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comment` ;

CREATE TABLE IF NOT EXISTS `comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(600) NULL,
  `create_date` DATETIME NULL,
  `update_date` DATETIME NULL,
  `enabled` TINYINT NULL,
  `country_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `in_reply_to_id` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_comment_country1`
    FOREIGN KEY (`country_id`)
    REFERENCES `country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_comment1`
    FOREIGN KEY (`in_reply_to_id`)
    REFERENCES `comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_comment_country1_idx` ON `comment` (`country_id` ASC);

CREATE INDEX `fk_comment_user1_idx` ON `comment` (`user_id` ASC);

CREATE INDEX `fk_comment_comment1_idx` ON `comment` (`in_reply_to_id` ASC);


-- -----------------------------------------------------
-- Table `advice_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `advice_type` ;

CREATE TABLE IF NOT EXISTS `advice_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` TEXT NULL,
  `advice_url` VARCHAR(4500) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `country_advice_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `country_advice_type` ;

CREATE TABLE IF NOT EXISTS `country_advice_type` (
  `advice_type_id` INT NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`advice_type_id`, `country_id`),
  CONSTRAINT `fk_advice_type_has_country_advice_type1`
    FOREIGN KEY (`advice_type_id`)
    REFERENCES `advice_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_advice_type_has_country_country1`
    FOREIGN KEY (`country_id`)
    REFERENCES `country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_advice_type_has_country_country1_idx` ON `country_advice_type` (`country_id` ASC);

CREATE INDEX `fk_advice_type_has_country_advice_type1_idx` ON `country_advice_type` (`advice_type_id` ASC);

SET SQL_MODE = '';
DROP USER IF EXISTS ambersparkles@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'ambersparkles'@'localhost' IDENTIFIED BY 'user';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'ambersparkles'@'localhost';

-- -----------------------------------------------------
-- Data for table `country`
-- -----------------------------------------------------
START TRANSACTION;
USE `voyagerdb`;
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (1, 'Singapore', 'A place of wonders where one cannot chew gum.', 'https://images.idgesg.net/images/article/2018/05/singapore-100758969-large.jpg', 'SG');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (2, 'United Arab Emirates', 'A sandy place, I have heard.', 'https://www.planetware.com/wpimages/2019/12/united-arab-emirates-in-pictures-beautiful-places-to-photograph-the-palm-jumeirah.jpg', 'AE');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (3, 'Sweden', 'Cold', 'https://specials-images.forbesimg.com/imageserve/1154990774/960x0.jpg?fit=scale', 'SE');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (4, 'Argentina', 'Amazin\'', 'https://www.planetware.com/wpimages/2020/02/argentina-in-pictures-beautiful-places-to-photograph-perito-moreno-glacier.jpg', 'AR');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (5, 'Thailand', 'Thai stuff', 'http://ttgasia.2017.ttgasia.com/wp-content/uploads/sites/2/2020/06/Bangkok-1.jpg', 'TH');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (6, 'Mexico', 'Description of Mexico', 'https://www.ktchnrebel.com/wp-content/uploads/2019/03/Working-in-Mexico-City-KTCHNrebel-copyright-Fotolia-javarman.jpg', 'MX');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (7, 'Botswana', 'Description of Botswana', 'https://isthatplacesafe.com/wp-content/uploads/2018/06/is-botswana-safe-to-visit.jpg', 'BW');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (8, 'Spain', 'Description of Spain', 'https://study-eu.s3.amazonaws.com/uploads/image/path/431/wide_fullhd_spain-barcelona.jpg', 'ES');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (9, 'France', 'Description of France', 'https://www.planetware.com/wpimages/2020/02/france-in-pictures-beautiful-places-to-photograph-eiffel-tower.jpg', 'FR');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (10, 'Brazil', 'Description of Brazil', 'https://www.internationaltaxreview.com/Media/images/international-tax-review/anjana-haines/october-2020/AdobeStock_243289561_Brazil.jpg', 'BR');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (11, 'China', 'Description of China', 'https://www.thedrinksbusiness.com/content/uploads/2016/04/china-05-350x350.jpg', 'CN');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (12, 'Australia', 'Description of Australia', 'https://www.australia.com/content/australia/en/places/south-australia/jcr:content/hero/desktop.adapt.1920.high.jpg', 'AU');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (13, 'United Kingdom', 'Description of England', 'https://d3dqioy2sca31t.cloudfront.net/Projects/cms/production/000/024/811/slideshow/c56bd725101bef2aaef43b0def6a24c7/england-london-big-ben-river-night.jpg', 'GB');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `voyagerdb`;
INSERT INTO `user` (`id`, `role`, `username`, `email`, `password`, `first_name`, `middle_name`, `last_name`, `suffix`, `dob`, `enabled`, `create_date`, `update_date`) VALUES (1, 'user', 'user', 'user@user.com', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL);
INSERT INTO `user` (`id`, `role`, `username`, `email`, `password`, `first_name`, `middle_name`, `last_name`, `suffix`, `dob`, `enabled`, `create_date`, `update_date`) VALUES (2, 'test', 'test', 'test@test.com', NULL, 'Jane', NULL, 'Doe', 'IV', NULL, 1, NULL, NULL);
INSERT INTO `user` (`id`, `role`, `username`, `email`, `password`, `first_name`, `middle_name`, `last_name`, `suffix`, `dob`, `enabled`, `create_date`, `update_date`) VALUES (3, 'user', 'shaun', 'hi@w.com', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', 'Shaun', 'of the', 'Dead', 'Jr.', NULL, 1, NULL, NULL);
INSERT INTO `user` (`id`, `role`, `username`, `email`, `password`, `first_name`, `middle_name`, `last_name`, `suffix`, `dob`, `enabled`, `create_date`, `update_date`) VALUES (4, 'admin', 'admin', 'admin@admin.io', '$2a$10$lpwg8s8sPB9FhF34Ly49/uWWp7TJ6AliIxPvWwJC7yOrC.hsPMYxa', 'Admin', 'Adamson', NULL, NULL, NULL, 1, NULL, NULL);
INSERT INTO `user` (`id`, `role`, `username`, `email`, `password`, `first_name`, `middle_name`, `last_name`, `suffix`, `dob`, `enabled`, `create_date`, `update_date`) VALUES (5, 'hi', 'hi', 'hi@hi.com', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `picture`
-- -----------------------------------------------------
START TRANSACTION;
USE `voyagerdb`;
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (1, 1, 'http://cdn.cnn.com/cnnnext/dam/assets/191212182124-04-singapore-buildings.jpg');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (5, 1, 'https://bsmedia.business-standard.com/_media/bs/img/article/2020-12/15/full/1608011089-8994.jpg');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (6, 1, 'https://www.bolopakistan.pk/wp-content/uploads/2020/07/visit-singapore-with-saudi-arabian-airlines-flights.jpg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `trip`
-- -----------------------------------------------------
START TRANSACTION;
USE `voyagerdb`;
INSERT INTO `trip` (`id`, `name`, `start_date`, `end_date`, `completed`, `enabled`, `user_id`, `create_date`, `description`) VALUES (1, 'Southeast Asia Fall 2021', '2021-09-01', '2021-10-25', 1, 1, 3, NULL, 'A whirlwind tour of the opposite side of the globe.');
INSERT INTO `trip` (`id`, `name`, `start_date`, `end_date`, `completed`, `enabled`, `user_id`, `create_date`, `description`) VALUES (2, 'Brazil Vacation', '2022-02-11', '2022-02-25', 0, 1, 3, NULL, 'Should be a nice beach vacation while it\'s winter up north!');
INSERT INTO `trip` (`id`, `name`, `start_date`, `end_date`, `completed`, `enabled`, `user_id`, `create_date`, `description`) VALUES (3, 'Trip to London for work', '2020-05-09', '2020-05-16', 1, 1, 3, NULL, 'All reimbursement received');
INSERT INTO `trip` (`id`, `name`, `start_date`, `end_date`, `completed`, `enabled`, `user_id`, `create_date`, `description`) VALUES (4, 'Visiting the in-laws', '2019-12-23', '2019-12-30', 0, 1, 3, NULL, '');

COMMIT;


-- -----------------------------------------------------
-- Data for table `itinerary_item`
-- -----------------------------------------------------
START TRANSACTION;
USE `voyagerdb`;
INSERT INTO `itinerary_item` (`id`, `trip_id`, `country_id`, `sequence_num`, `notes`) VALUES (1, 1, 5, 1, 'I am so excited!!!');
INSERT INTO `itinerary_item` (`id`, `trip_id`, `country_id`, `sequence_num`, `notes`) VALUES (2, 1, 1, 2, NULL);
INSERT INTO `itinerary_item` (`id`, `trip_id`, `country_id`, `sequence_num`, `notes`) VALUES (3, 1, 11, 3, NULL);
INSERT INTO `itinerary_item` (`id`, `trip_id`, `country_id`, `sequence_num`, `notes`) VALUES (4, 3, 13, 1, 'Great trip');

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `voyagerdb`;
INSERT INTO `comment` (`id`, `content`, `create_date`, `update_date`, `enabled`, `country_id`, `user_id`, `in_reply_to_id`) VALUES (1, 'Singapore. Not for the fainthearted. The customs agent chewed all my gum.', NULL, NULL, 1, 1, 1, 2);
INSERT INTO `comment` (`id`, `content`, `create_date`, `update_date`, `enabled`, `country_id`, `user_id`, `in_reply_to_id`) VALUES (2, 'Singapore is great!!!!!!!!!!!! <3', NULL, NULL, 1, 1, 1, NULL);
INSERT INTO `comment` (`id`, `content`, `create_date`, `update_date`, `enabled`, `country_id`, `user_id`, `in_reply_to_id`) VALUES (3, 'Singapore is ok', NULL, NULL, 1, 1, 2, 2);
INSERT INTO `comment` (`id`, `content`, `create_date`, `update_date`, `enabled`, `country_id`, `user_id`, `in_reply_to_id`) VALUES (4, 'Singapore has been taken over by a zombie horde', NULL, NULL, 1, 1, 3, 2);
INSERT INTO `comment` (`id`, `content`, `create_date`, `update_date`, `enabled`, `country_id`, `user_id`, `in_reply_to_id`) VALUES (5, 'I give UAE an 8 out of 10', NULL, NULL, 1, 2, 3, NULL);
INSERT INTO `comment` (`id`, `content`, `create_date`, `update_date`, `enabled`, `country_id`, `user_id`, `in_reply_to_id`) VALUES (6, 'There was sand in my shoes', NULL, NULL, 1, 2, 2, 5);
INSERT INTO `comment` (`id`, `content`, `create_date`, `update_date`, `enabled`, `country_id`, `user_id`, `in_reply_to_id`) VALUES (7, 'Remember to bring a water bottle', NULL, NULL, 1, 2, 1, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `advice_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `voyagerdb`;
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (1, 'Covid-Related', 'Precautions for Covid-19 pandemic', 'www.cdc.gov');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (2, 'Visa Requirements', NULL, NULL);
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (3, 'Medical Needs', NULL, NULL);
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (4, 'Tips', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `country_advice_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `voyagerdb`;
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (1, 1);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (2, 1);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (3, 1);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (4, 1);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (1, 2);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (2, 2);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (3, 2);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (4, 2);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
