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
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (1, 'Singapore', 'A city-island-nation that is known for its mixture of modern and historic buildings as well as its cleanliness. Singapore blends Malay, Chinese, Arab, Indian and English cultures, cuisine and religions.', 'https://images.idgesg.net/images/article/2018/05/singapore-100758969-large.jpg', 'SG');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (2, 'United Arab Emirates', 'A country located in the Arabian Peninsula that is well-known for the Burj Khalifa tower and other world-class structures. The UAE is also famous for its picturesque sceneries, shopping centers, and beaches.', 'https://www.planetware.com/wpimages/2019/12/united-arab-emirates-in-pictures-beautiful-places-to-photograph-the-palm-jumeirah.jpg', 'AE');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (3, 'Sweden', 'Sweden is famous for its abundant forests and lakes. It’s a nation of keen recyclers, hikers and Fika takers, and it’s the Pop Music Capital of the World.', 'https://specials-images.forbesimg.com/imageserve/1154990774/960x0.jpg?fit=scale', 'SE');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (4, 'Argentina', 'A diverse country that encompasses everything from harsh deserts to humid jungles, and long ocean beaches to the soaring Andes mountains. It is also known for its amazing cuisine and wine.', 'https://www.planetware.com/wpimages/2020/02/argentina-in-pictures-beautiful-places-to-photograph-perito-moreno-glacier.jpg', 'AR');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (5, 'Thailand', 'Located in southern Asia it is known for great eats, martial arts, beaches, and many temples. Thailand also has many islands that are well known that have numerous resorts for tourists.', 'http://ttgasia.2017.ttgasia.com/wp-content/uploads/sites/2/2020/06/Bangkok-1.jpg', 'TH');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (6, 'Mexico', 'Mexico is known for its food and drink culture (tacos, tortillas, burritos, tequila) and for being the origin of chocolate. It is also famous for Mayan temples, cenotes, mariachi bands, beaches, and the \'day of the dead\' festival.', 'https://www.ktchnrebel.com/wp-content/uploads/2019/03/Working-in-Mexico-City-KTCHNrebel-copyright-Fotolia-javarman.jpg', 'MX');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (7, 'Botswana', 'A country well known for having some of the best wilderness and wildlife areas on the African continent. 38% of its total land area are devoted to national parks and reserves, including stunning deserts and deltas.', 'https://isthatplacesafe.com/wp-content/uploads/2018/06/is-botswana-safe-to-visit.jpg', 'BW');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (8, 'Spain', 'A country known for its spectacular natural beauty, rich history and culture, and amazing food. It has cozy villages, spectacular medieval cities, tranquil white sand beaches and bustling metropolitan areas.', 'https://study-eu.s3.amazonaws.com/uploads/image/path/431/wide_fullhd_spain-barcelona.jpg', 'ES');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (9, 'France', 'A country famous for the Eiffel Tower in Paris and sweet-scented lavender fields in Provence. It offers museums, art galleries and fine cuisine. France also has a varied geography: from the mountains of the Alps to dazzling beaches.', 'https://www.planetware.com/wpimages/2020/02/france-in-pictures-beautiful-places-to-photograph-eiffel-tower.jpg', 'FR');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (10, 'Brazil', 'A country famous for its iconic carnival festival and soccer. Brazil is also known for its tropical beaches, exquisite waterfalls, and the Amazon rainforest.', 'https://www.internationaltaxreview.com/Media/images/international-tax-review/anjana-haines/october-2020/AdobeStock_243289561_Brazil.jpg', 'BR');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (11, 'China', 'A country known for its architectural wonders such as the Great Wall and Forbidden City, its staggering variety of delicious food, its martial arts, and its long history of invention. China is a mix of the ultra-modern and the very ancient.', 'https://www.thedrinksbusiness.com/content/uploads/2016/04/china-05-350x350.jpg', 'CN');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (12, 'Australia', 'Globally famous for its natural wonders, wide-open spaces, beaches, deserts, \"The Bush\", and \"The Outback\". It’s also well known for its attractive mega cities such as Sydney, Melbourne, Brisbane, and Perth.', 'https://www.australia.com/content/australia/en/places/south-australia/jcr:content/hero/desktop.adapt.1920.high.jpg', 'AU');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (13, 'United Kingdom', 'A country known for its pubs, history, bustling cities, and rich cultural traditions. The UK has historic sites are at every turn, from prehistoric megaliths and ancient Roman sites to centuries-old castles. ', 'https://d3dqioy2sca31t.cloudfront.net/Projects/cms/production/000/024/811/slideshow/c56bd725101bef2aaef43b0def6a24c7/england-london-big-ben-river-night.jpg', 'GB');
INSERT INTO `country` (`id`, `name`, `description`, `default_image`, `country_code`) VALUES (14, 'Vietnam', 'A popular tourist destination because of its beautiful beaches, it’s culture, amazing food (like pho), and friendly people. Vietnam is also famous for the Vietnam War, motorbikes, Vietnamese coffee, floating markets and rice terraces.', 'https://cdn.passporthealthusa.com/wp-content/uploads/2018/05/vietnam-visa-info.jpg?x90101', 'VN');

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
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (1, 1, 'https://images.unsplash.com/photo-1565967511849-76a60a516170?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1502&q=80');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (5, 1, 'https://images.unsplash.com/photo-1525625293386-3f8f99389edd?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1298&q=80');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (6, 1, 'https://images.unsplash.com/photo-1558289675-f8a783516e7b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80');
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
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (18, 4, 'https://images.unsplash.com/photo-1520637438573-ee1ba80b2a7f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (19, 4, 'https://images.unsplash.com/photo-1528231843764-7ab0490b6676?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1404&q=80');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (20, 4, 'https://lp-cms-production.imgix.net/2019-06/63845515.jpg?auto=format&fit=crop&ixlib=react-8.6.4&h=520&w=1312&q=50&dpr=2');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (21, 5, 'https://images.unsplash.com/photo-1552465011-b4e21bf6e79a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dGhhaWxhbmR8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (22, 5, 'https://images.unsplash.com/photo-1528181304800-259b08848526?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (23, 5, 'https://images.unsplash.com/photo-1490077476659-095159692ab5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1466&q=80');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (24, 5, 'https://images.unsplash.com/photo-1508009603885-50cf7c579365?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=947&q=80');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (25, 6, 'https://media.istockphoto.com/photos/zocalo-square-and-mexico-city-cathedral-mexico-city-mexico-picture-id1132330190?k=6&m=1132330190&s=612x612&w=0&h=RSrGf1Obbrx5kgkCJ9mRWpyx_4SglWpSYPw_hr4xqT0=');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (26, 6, 'https://specials-images.forbesimg.com/imageserve/1086671738/960x0.jpg?fit=scale');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (27, 6, 'https://k9h2z2w9.stackpathcdn.com/wp-content/uploads/Colonial-Center-Mexico-NBS-750x375.jpg');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (28, 6, 'https://dynaimage.cdn.cnn.com/cnn/q_auto,w_763,c_fill,g_auto,h_429,ar_16:9/http%3A%2F%2Fcdn.cnn.com%2Fcnnnext%2Fdam%2Fassets%2F200525090601-05-mexico-tourism-coronavirus-chichen-itza.jpg');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (29, 7, 'https://images.unsplash.com/photo-1596174621919-3cd8eedaa316?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2089&q=80');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (30, 7, 'https://images.unsplash.com/photo-1612434140886-cc27133e4bd8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80');
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
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (46, 14, 'https://images.unsplash.com/photo-1504457047772-27faf1c00561?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1634&q=80');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (47, 14, 'https://images.unsplash.com/photo-1533497394934-b33cd9695ba9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (48, 14, 'https://images.unsplash.com/photo-1516484681091-7d83961805f4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1822&q=80');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (49, 14, 'https://images.unsplash.com/photo-1569271532956-3fb81a207115?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (50, 14, 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1600&q=80');
INSERT INTO `picture` (`id`, `country_id`, `image_url`) VALUES (51, 4, 'https://images.unsplash.com/photo-1610703624127-34449fde2b86?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1540&q=80');

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
INSERT INTO `trip` (`id`, `name`, `start_date`, `end_date`, `completed`, `enabled`, `user_id`, `create_date`, `description`) VALUES (5, 'wishlist', NULL, NULL, 0, 1, 3, NULL, NULL);

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
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (1, 'Covid-Related', 'U.S. citizens seeking to enter Singapore as short-term visitors will generally not be permitted to enter Singapore unless they have been issued a Safe Travel Pass', 'https://safetravel.ica.gov.sg/arriving/overview');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (2, 'Visa Requirements', 'Not required for tourist stays under 90 days.', '');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (3, 'Safety Advisory', 'Level 2 - Exercise Increased Caution', 'https://travel.state.gov/content/travel/en/traveladvisories/traveladvisories/singapore-travel-advisory.html');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (4, 'Medical Requirements', 'Yellow fever for travelers from certain countries.', 'https://wwwnc.cdc.gov/travel/destinations/traveler/none/singapore');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (5, 'Entry Requirements', 'Passport that is valid for at least 6 months with 2 blank pages for stamps, proof of sufficient funds for the length of your intended stay, a submitted SG Arrival Card, a confirmed onward or return ticket, evidence you can enter your next destination (visa if required), Yellow Fever Vaccination Certificate (if applicable)', 'https://www.ica.gov.sg/enter-depart/entry_requirements');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (6, 'Prohibited Goods', 'Chewing gum (except dental and medicated gum); chewing tobacco and imitation tobacco products (for example, electronic cigarettes); cigarette lighters in the shape of a pistol or revolver; controlled drugs and psychotropic substances; firecrackers; obscene articles, publications, videotapes, videodiscs and software; reproductions of copyright publications, videotapes, videodiscs and laser discs, records and cassettes; seditious and treasonable materials.\n\n\n\n', 'https://www.ica.gov.sg/enter-depart/before-your-arrival/what-you-can-bring');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (7, 'Covid-Related', 'All travelers must present a negative COVID-19 PCR test result within 96 hours prior to their flight departure. Some airlines require test results be presented within 72 hours. Children under the age of 12 and those with severe and moderate disabilities may be exempted from the test requirement. Travelers should consult with the airline regarding testing and travel requirements.', 'https://ae.usembassy.gov/u-s-citizen-services/covid-19-information/');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (8, 'Visa Requirements', 'Not required for tourist stays under 30 days', '');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (9, 'Safety Advisory', 'Level 4 - Do Not Travel', 'https://travel.state.gov/content/travel/en/traveladvisories/traveladvisories/united-arab-emirates-travel-advisory.html');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (10, 'Medical Requirements', 'Routine vaccinations recommended', 'https://wwwnc.cdc.gov/travel/destinations/traveler/none/united-arab-emirates?s_cid=ncezid-dgmq-travel-single-001');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (11, 'Entry Requirements', 'Passport that is valid for at least 6 months with 1 blank page for entry stamp', '');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (12, 'Prohibited Goods', 'Weapon and law enforcement equipment (including ammunition, handcuffs, tools, body armor), pornographic material, non-Islamic religious pamphlets for missionary activities, e-cigarettes, fireworks, ivory, chemical and organic fertilizers, laser pointers, radar jammers/other unauthorized communication devices, products and medications containing cannabidiol (CBD), endangered animal species, and any objects, sculptures, paintings, books or magazines which do not adhere to the religious and moral values of the UAE. Possession of any of these items can lead to detention and lengthy jail sentences.', 'https://u.ae/en/information-and-services/finance-and-investment/clearing-the-customs-and-paying-customs-duty');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (13, 'Covid-Related', 'The Vietnamese government continues to allow pre-approved foreigners and their families in exempted categories, including diplomats, officials, experts, business managers, foreign investors, high-tech workers, and other business travelers to enter Vietnam.  Please note that these individuals will be subject to mandatory COVID-19 testing and quarantine upon arrival.', 'https://vn.usembassy.gov/u-s-citizen-services/covid-19-information/');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (14, 'Visa Requirements', 'Tourist Visa is required for US citizens', 'http://vietnamembassy-usa.org/content/visa-application-process');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (15, 'Safety Advisory', 'Level 2 - Exercise Increased Caution', 'https://travel.state.gov/content/travel/en/traveladvisories/traveladvisories/vietnam-travel-advisory.html');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (16, 'Medical Requirements', 'Routine vaccinations recommended', 'https://wwwnc.cdc.gov/travel/destinations/traveler/none/vietnam?s_cid=ncezid-dgmq-travel-single-001');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (17, 'Entry Requirements', 'Passport that is valid for at least 6 months with 1 blank page for entry stamp. Note, if you plan to travel to Laos from Vietnam by land you must ask for an adhesive visa rather than detachable one. Additionally, crossing borders by land in much of Southeast Asia incurs “stamp fees” at border control. These are small, unofficial “fees” that are a couple of dollars but it is recommended to have some local currency or US dollars available to prevent getting held up by border control and stranded at the border (your bus will not wait for you).', '');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (18, 'Prohibited Goods', 'Weapon, ammunition, explosives and inflammable objects; military technical equipment; drugs, opium, and other narcotics; anti-government literature; pornographic literature; antiques, some precious stones, wild animals, precious plants listed in Vietnam’s red-book.', 'https://www.vietnamonline.com/visa/customs-regulations.html');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (19, 'Covid-Related', 'Per the latest Argentine government policy, most foreigners who are not a resident in Argentina, including U.S. citizens, will not be permitted to enter Argentina; the U.S. Embassy is not aware of an estimated end date for this travel ban.', 'https://ar.usembassy.gov/covid-19/');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (20, 'Visa Requirements', 'Not required for stays of 90 days or less', '');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (21, 'Safety Advisory', 'Level 4 - Do Not Travel', 'https://travel.state.gov/content/travel/en/traveladvisories/traveladvisories/argentina-travel-advisory.html');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (22, 'Medical Requirements', 'Routine vaccinations recommended', 'https://wwwnc.cdc.gov/travel/destinations/traveler/none/argentina?s_cid=ncezid-dgmq-travel-single-001');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (23, 'Entry Requirements', 'Passport must be valid at time of entry with 1 blank page for entry stamp.', '');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (24, 'Prohibited Goods', 'Archaeological and cultural material, merchandise for commercial or industrial purposes, narcotic drugs, weapons, explosives (unless authorized by ANMAC)', 'http://www.afip.gob.ar/viajeros/ayuda/objetos.asp');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (25, 'Covid-Related', 'All travelers are required to present a negative COVID-19 PCR test valid within 72 hours of their departure for Botswana. Testing regulations are often not clearly published or enforced: expect inconsistent application of rules or sudden unexplained changes in enforcement. Note movement restrictions/curfews are also currently in place.\n', 'https://bw.usembassy.gov/covid-19-information/');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (26, 'Visa Requirements', 'Not required for stays of 90 days or less', '');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (27, 'Safety Advisory', 'Level 4 - Do Not Travel', 'https://travel.state.gov/content/travel/en/traveladvisories/traveladvisories/botswana-travel-advisory.html');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (28, 'Medical Requirements', 'Yellow fever for travelers from certain countries.', 'https://wwwnc.cdc.gov/travel/destinations/traveler/none/botswana?s_cid=ncezid-dgmq-travel-single-001');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (29, 'Entry Requirements', 'Passport that is valid for at least 6 months with 3 blank pages for stamps. Note, travelers are advised to carry a photocopy of the photo/bio information page of their passport and keep it in a location separate from their passport.', '');
INSERT INTO `advice_type` (`id`, `name`, `description`, `advice_url`) VALUES (30, 'Prohibited Goods', 'Narcotic, habit forming drugs and related substances in any form; firearms, ammunition and explosives; indecent and obscene material such as pornographic books, magazines, films, videos, DVDs and software.\n', 'https://www.botswanatourism.co.bw/info/importation-goods');

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
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (5, 1);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (6, 1);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (7, 2);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (8, 2);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (9, 2);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (10, 2);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (11, 2);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (12, 2);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (13, 14);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (14, 14);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (15, 14);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (16, 14);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (17, 14);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (18, 14);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (19, 4);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (20, 4);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (21, 4);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (22, 4);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (23, 4);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (24, 4);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (25, 7);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (26, 7);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (27, 7);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (28, 7);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (29, 7);
INSERT INTO `country_advice_type` (`advice_type_id`, `country_id`) VALUES (30, 7);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
