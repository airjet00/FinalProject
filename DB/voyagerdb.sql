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
DROP USER IF EXISTS user;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'user' IDENTIFIED BY 'user';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'user';

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
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (14, 'Vietnam', 'Description of Vietnam', 'https://cdn.passporthealthusa.com/wp-content/uploads/2018/05/vietnam-visa-info.jpg?x90101', 'VN');

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
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (7, 2, 'https://www.planetware.com/wpimages/2019/12/united-arab-emirates-in-pictures-beautiful-places-to-photograph-the-palm-jumeirah.jpg');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (8, 2, 'https://i0.wp.com/alabamanewscenter.com/wp-content/uploads/2019/09/DubaiFeature.jpg?fit=640%2C360&ssl=1');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (9, 2, 'https://media2.s-nbcnews.com/j/newscms/2020_45/3426709/201107-uae-al-1038_ca8ebdc5a9c541f45c38e3318dab6e37.fit-1000w.jpg');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (10, 2, 'https://live-production.wcms.abc-cdn.net.au/919e8e4468ebee476c2d591adee1e006?impolicy=wcms_crop_resize&cropH=1988&cropW=2991&xPos=0&yPos=0&width=862&height=575');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (11, 2, 'https://www.thoughtco.com/thmb/37uiTnpLpaqMckMIGGQcnx0NvIM=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-167895517-5a0099a4482c52001a19be4c.jpg');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (12, 3, 'https://www.planetware.com/wpimages/2020/02/sweden-in-pictures-beautiful-places-to-photograph.jpg');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (13, 3, 'https://www.planetware.com/wpimages/2020/02/sweden-in-pictures-beautiful-places-to-photograph-marstrand.jpg');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (14, 3, 'https://www.planetware.com/wpimages/2020/02/sweden-in-pictures-beautiful-places-to-photograph-skansen.jpg');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (15, 3, 'https://www.planetware.com/wpimages/2020/02/sweden-in-pictures-beautiful-places-to-photograph-oland.jpg');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (16, 3, 'https://www.planetware.com/wpimages/2020/02/sweden-in-pictures-beautiful-places-to-photograph-kiruna.jpg');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (17, 4, 'https://studyabroad.sit.edu/wp-content/themes/ssa-sit-2019/assets/images/program-hero/ARH-hero.jpg');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (18, 4, 'https://www.omfif.org/wp-content/uploads/2020/10/buenos-aires-newweb-oct20.jpg');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (19, 4, 'https://www.abercrombiekent.com/-/media/ak/media-for-prod/destinations/mastheads/americas-argentina-perito-moreno-glacier-mh.jpg?sc=0.4&hash=72D952F37D7B505D06E4B86BDFBA1A22');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (20, 4, 'https://lp-cms-production.imgix.net/2019-06/63845515.jpg?auto=format&fit=crop&ixlib=react-8.6.4&h=520&w=1312&q=50&dpr=2');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (21, 5, 'https://images.unsplash.com/photo-1552465011-b4e21bf6e79a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dGhhaWxhbmR8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (22, 5, 'https://images.unsplash.com/photo-1528181304800-259b08848526?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (23, 5, 'https://images.unsplash.com/photo-1490077476659-095159692ab5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1466&q=80');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (24, 5, 'https://images.unsplash.com/photo-1508009603885-50cf7c579365?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=947&q=80');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (25, 6, 'https://media.istockphoto.com/photos/zocalo-square-and-mexico-city-cathedral-mexico-city-mexico-picture-id1132330190?k=6&m=1132330190&s=612x612&w=0&h=RSrGf1Obbrx5kgkCJ9mRWpyx_4SglWpSYPw_hr4xqT0=');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (26, 6, 'https://specials-images.forbesimg.com/imageserve/1086671738/960x0.jpg?fit=scale');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (27, 6, 'https://k9h2z2w9.stackpathcdn.com/wp-content/uploads/Colonial-Center-Mexico-NBS-750x375.jpg');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (28, 6, 'https://dynaimage.cdn.cnn.com/cnn/q_auto,w_763,c_fill,g_auto,h_429,ar_16:9/http%3A%2F%2Fcdn.cnn.com%2Fcnnnext%2Fdam%2Fassets%2F200525090601-05-mexico-tourism-coronavirus-chichen-itza.jpg');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (29, 7, 'http://www.r744.com/images/690_450/Botswana_1600955790.jpg');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (30, 7, 'https://www.responsiblevacation.com/imagesClient/S_171461.jpg');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (31, 7, 'https://abs-sustainabledevelopment.net/wp-content/uploads/2018/04/Botswana-Main-Image-1200x600.jpg');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (32, 7, 'https://static.dw.com/image/35918673_303.jpg');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (33, 8, 'https://www.studyandgoabroad.com/wp-content/uploads/2018/10/studyspain-740x357.jpg');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (34, 8, 'https://www.topdeck.travel/sites/default/files/styles/hero_image/public/2018-09/HERO%201920x540-Europe-Spain.webp?itok=hk0NC5IC');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (35, 8, 'https://uceap.universityofcalifornia.edu/sites/default/files/marketing-images/program-page-images/contemporary-spain-glance.jpg');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (36, 9, 'https://images.unsplash.com/photo-1499856871958-5b9627545d1a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZnJhbmNlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (37, 9, 'https://images.unsplash.com/photo-1520939817895-060bdaf4fe1b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8ZnJhbmNlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (38, 9, 'https://images.unsplash.com/photo-1532465614-6cc8d45f647f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8ZnJhbmNlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (39, 10, 'https://images.unsplash.com/photo-1518639192441-8fce0a366e2e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YnJhemlsfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (40, 10, 'https://images.unsplash.com/photo-1483729558449-99ef09a8c325?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YnJhemlsfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (41, 10, 'https://images.unsplash.com/photo-1515898698999-18f625d67499?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8YnJhemlsfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (42, 10, 'https://images.unsplash.com/photo-1551529489-5c97b567c760?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8YnJhemlsfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (43, 11, 'https://images.unsplash.com/photo-1474181487882-5abf3f0ba6c2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Y2hpbmF8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (44, 11, 'https://images.unsplash.com/photo-1513781050488-6dd358209a1b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y2hpbmF8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (45, 11, 'https://images.unsplash.com/photo-1516545595035-b494dd0161e4?ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8Y2hpbmF8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60');

COMMIT;


-- -----------------------------------------------------
-- Data for table `trip`
-- -----------------------------------------------------
START TRANSACTION;
USE `voyagerdb`;
INSERT INTO `trip` (`id`, `name`, `start_date`, `end_date`, `completed`, `enabled`, `user_id`, `create_date`, `description`) VALUES (5, 'Southeast Asia Fall 2021', '2021-09-01', '2021-10-25', 1, 1, 3, NULL, 'A whirlwind tour of the opposite side of the globe.');
INSERT INTO `trip` (`id`, `name`, `start_date`, `end_date`, `completed`, `enabled`, `user_id`, `create_date`, `description`) VALUES (2, 'Brazil Vacation', '2022-02-11', '2022-02-25', 0, 1, 3, NULL, 'Should be a nice beach vacation while it\'s winter up north!');
INSERT INTO `trip` (`id`, `name`, `start_date`, `end_date`, `completed`, `enabled`, `user_id`, `create_date`, `description`) VALUES (3, 'Trip to London for work', '2020-05-09', '2020-05-16', 1, 1, 3, NULL, 'All reimbursement received');
INSERT INTO `trip` (`id`, `name`, `start_date`, `end_date`, `completed`, `enabled`, `user_id`, `create_date`, `description`) VALUES (4, 'Visiting the in-laws', '2019-12-23', '2019-12-30', 0, 1, 3, NULL, '');
INSERT INTO `trip` (`id`, `name`, `start_date`, `end_date`, `completed`, `enabled`, `user_id`, `create_date`, `description`) VALUES (1, 'Bucket List', NULL, NULL, 0, 1, 3, NULL, NULL);

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
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (2, 'Visa Requirements', 'Not required for tourist stays under 90 days.', NULL);
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (3, 'Medical Needs', NULL, NULL);
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (4, 'Visa Requirements', 'Not required for tourist stays under 30 days', NULL);
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (5, 'Visa Requirements', NULL, 'http://vietnamembassy-usa.org/content/visa-application-process');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (6, 'Covid-Related', '', 'https://vn.usembassy.gov/u-s-citizen-services/covid-19-information/');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (7, 'Safety Advice', NULL, 'https://travel.state.gov/content/travel/en/traveladvisories/traveladvisories/vietnam-travel-advisory.html');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (8, 'Customs Requirements', 'No additional requirements', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `country_advice_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `voyagerdb`;
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (1, 1);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (2, 1);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (3, 1);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (4, 2);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (5, 14);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (6, 14);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (7, 14);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (8, 14);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
