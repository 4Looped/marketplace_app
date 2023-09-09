/*
Author: Jeffrey Cheng & Colin Maloney
OSU Email: chengjef@oregonstate.edu, maloncol@oregonstate.edu
Course: CS340 - Introduction to Databases
Assignment: Project Step 3 Draft Version: Design HTML Interface + DML SQL
Due Date: 08MAY2023 @ 11:59 PM PST
Description: Data Manipulation Queries.
*/

/*
    SELECT Queries for each Page
*/

SELECT * FROM marketplaces;
SELECT * FROM sales;
SELECT * FROM buyers;
SELECT * FROM sellers;
SELECT * FROM categories;
SELECT * FROM products;

/* 

    SELECT query to show all of the markets and associated buyers.

*/

SELECT marketplaces.id_marketplace, marketplaces.market_name, buyers.buyer_name, buyers.buyer_country FROM marketplaces
INNER JOIN sales ON marketplaces.id_marketplace = sales.id_marketplace
INNER JOIN buyers ON sales.id_buyer = buyers.id_buyer;

/* 

    SELECT query to show all of the markets and associated sellers.

*/

SELECT marketplaces.id_marketplace, marketplaces.market_name, sellers.seller_name, sellers.seller_country FROM marketplaces
INNER JOIN sales ON marketplaces.id_marketplace = sales.id_marketplace
INNER JOIN sellers ON sales.id_seller = sellers.id_seller;

/* 

    SELECT query to show all of the products and associated categories.

*/

SELECT products.id_product, products.product_description, categories.category_name FROM products
RIGHT JOIN categories_have_products ON categories_have_products.id_product = products.id_product
INNER JOIN categories ON categories.id_category = categories_have_products.id_category
ORDER BY products.id_product asc;

/* 

    INSERT operators for each entity.

*/

INSERT INTO `marketplaces` (`market_name`, `online`)
VALUES (:market_name_from_add_textbox, :online);

INSERT INTO `sales` (`date`, `price`, `id_marketplace`, `id_product`, `id_buyer`, `id_seller`)
VALUES (:date_from_add_textbox, :price_from_add_textbox, :id_marketplace_from_add_number, :id_product_from_add_number, :id_buyer_from_add_number, :id_seller_from_add_number);

INSERT INTO `buyers` (`buyer_name`, `buyer_country`)
VALUES (:buyer_name_from_add_textbox, :buyer_country_from_add_textbox);

INSERT INTO `sellers` (`seller_name`, `seller_country`)
VALUES (:seller_name_from_add_textbox, :seller_country_from_add_textbox);

INSERT INTO `categories` (`category_name`)
VALUES (:category_name_from_add_textbox);

INSERT INTO `products` (`product_description`)
VALUES (:product_description_from_add_textbox);


/* 

    UPDATE operators for each entity.

*/

UPDATE marketplaces 
	SET marketplaces.market_name = :market_name_input, marketplaces.online = :online_input
    WHERE id_marketplace = :id_marketplace_from_form;
UPDATE sales 
	SET sales.date = :date_input, sales.price = :price_input
    WHERE id_sale = :id_sale_from_form;
UPDATE buyers 
	SET buyers.buyer_name = :buyer_name_input, buyer.buyer_country = :buyer_country_input
    WHERE id_buyer = :id_buyer_from_form;
UPDATE sellers 
	SET sellers.seller_name = :seller_name_input, seller.seller_country = :seller_country_input
    WHERE id_seller = :id_seller_from_form;
UPDATE categories 
	SET categories.category_name = :category_name_input
    WHERE id_category = :id_category_from_form;
UPDATE products
	SET products.product_description = :product_description_input
    WHERE id_product = :id_product_from_form;

/* 

    DELETE operators for each entity.

*/
DELETE FROM marketplaces WHERE marketplaces.id_marketplace = :id_marketplace_from_delete_textbox
DELETE FROM sales WHERE sales.id_sale = :id_sale_from_delete_textbox
DELETE FROM buyers WHERE buyers.id_buyer = :id_buyer_from_delete_textbox
DELETE FROM sellers WHERE sellers.id_seller = :id_seller_from_delete_textbox
DELETE FROM categories WHERE categories.id_category = :id_category_from_delete_textbox
DELETE FROM products WHERE products.id_product = :id_product_from_delete_textbox



