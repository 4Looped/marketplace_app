-- Colin Maloney and Jeffrey Cheng, Group 12
-- DDL and insert statements

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Table `marketplaces`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `marketplaces`;
CREATE TABLE IF NOT EXISTS `marketplaces` (
  `id_marketplace` INT NOT NULL AUTO_INCREMENT,
  `market_name` VARCHAR(45) NOT NULL,
  `online` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_marketplace`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id_product` INT AUTO_INCREMENT,
  `product_description` VARCHAR(45),
  PRIMARY KEY (`id_product`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `buyers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `buyers`;
CREATE TABLE IF NOT EXISTS `buyers` (
  `id_buyer` INT NOT NULL AUTO_INCREMENT,
  `buyer_name` VARCHAR(45) NOT NULL,
  `buyer_country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_buyer`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `sellers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sellers`;
CREATE TABLE IF NOT EXISTS `sellers` (
  `id_seller` INT NOT NULL AUTO_INCREMENT,
  `seller_name` VARCHAR(45) NOT NULL,
  `seller_country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_seller`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `sales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sales`;
CREATE TABLE IF NOT EXISTS `sales` (
  `id_sale` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `price` DECIMAL(2) NOT NULL,
  `id_marketplace` INT NOT NULL,
  `id_product` INT NOT NULL,
  `id_buyer` INT NOT NULL,
  `id_seller` INT NOT NULL,
  PRIMARY KEY (`id_sale`, `id_marketplace`, `id_buyer`, `id_seller`, `id_product`),
  INDEX `fk_sales_marketplaces_idx` (`id_marketplace` ASC) VISIBLE,
  INDEX `fk_sales_products1_idx` (`id_product` ASC) VISIBLE,
  INDEX `fk_sales_buyers1_idx` (`id_buyer` ASC) VISIBLE,
  INDEX `fk_sales_sellers1_idx` (`id_seller` ASC) VISIBLE,
  CONSTRAINT `fk_sales_marketplaces`
    FOREIGN KEY (`id_marketplace`)
    REFERENCES `marketplaces` (`id_marketplace`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_products1`
    FOREIGN KEY (`id_product`)
    REFERENCES `products` (`id_product`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_buyers1`
    FOREIGN KEY (`id_buyer`)
    REFERENCES `buyers` (`id_buyer`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_sellers1`
    FOREIGN KEY (`id_seller`)
    REFERENCES `sellers` (`id_seller`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id_category` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_category`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `categories_have_products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `categories_have_products`;
CREATE TABLE IF NOT EXISTS `categories_have_products` (
  `id_category` INT NOT NULL,
  `id_product` INT,
  PRIMARY KEY (`id_category`, `id_product`),
  INDEX `fk_categories_has_products_products1_idx` (`id_product` ASC) VISIBLE,
  INDEX `fk_categories_has_products_categories1_idx` (`id_category` ASC) VISIBLE,
  CONSTRAINT `fk_categories_has_products_categories1`
    FOREIGN KEY (`id_category`)
    REFERENCES `categories` (`id_category`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_categories_has_products_products1`
    FOREIGN KEY (`id_product`)
    REFERENCES `products` (`id_product`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Insert marketplaces
-- -----------------------------------------------------
INSERT INTO `marketplaces` (
    `market_name`,
    `online`
)
VALUES 
(
    'Ebay',
    1
),
(
    'NY Auction House',
    0
),
(
    'Amazon',
    1
);

-- -----------------------------------------------------
-- Insert categories
-- -----------------------------------------------------
INSERT INTO `categories` (
    `category_name`
)
VALUES 
(
    'technology'
),
(
    'cooking'
),
(
    'sports'
);

-- -----------------------------------------------------
-- Insert products
-- -----------------------------------------------------
INSERT INTO `products` (
    `product_description`
)
VALUES 
(
    'iPhone'
),
(
    'Blender'
),
(
    'Soccer Ball'
);

-- -----------------------------------------------------
-- Insert sellers
-- -----------------------------------------------------
INSERT INTO `sellers` (
    `seller_name`,
    `seller_country`
)
VALUES 
(
    'John Smith',
    'USA'
),
(
    'Edgar Lawrence',
    'Wales'
),
(
    'Jenny Jones',
    'Canada'
);

-- -----------------------------------------------------
-- Insert buyers
-- -----------------------------------------------------
INSERT INTO `buyers` (
    `buyer_name`,
    `buyer_country`
)
VALUES 
(
    'David Allen',
    'England'
),
(
    'Colin Maloney',
    'Ireland'
),
(
    'Jamie Phillips',
    'Australia'
);

-- -----------------------------------------------------
-- Create intersection table
-- -----------------------------------------------------
INSERT INTO `categories_have_products` (
    `id_category`,
    `id_product`
)
VALUES 
(
    1,
    1
),
(
    1,
    2
),
(
    2,
    2
),
(
    3,
    3
);

-- -----------------------------------------------------
-- Insert sales
-- -----------------------------------------------------
INSERT INTO `sales` (
    `date`,
    `price`,
    `id_marketplace`,
    `id_product`,
    `id_buyer`,
    `id_seller`
)
VALUES 
(
    '2019-01-05',
    200.00,
    1,
    1,
    1,
    1
),
(
    '2021-02-12',
    75.00,
    2,
    2,
    2,
    2
),
(
    '2022-03-16',
    50.00,
    3,
    3,
    3,
    3
);
